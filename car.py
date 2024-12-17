import wx
import wx.adv

from clips import Environment
from clips.facts import TemplateFact


def translate_string(s: str) -> str:
    s = s.replace("_", " ")
    s = s.replace("im", "I'm")
    s = s.replace("i ", "I ")
    s = s[0].upper() + s[1:]
    return s


def show_ui(env: Environment) -> bool:
    # fetch all facts
    facts: list[TemplateFact] = list(env.facts())
    for fact in facts:
        print(fact)

    # find the app-title fact
    app_title = next(fact for fact in facts if fact.template.name == "app-title")

    # find the state-list fact
    state_list = next(fact for fact in facts if fact.template.name == "state-list")
    current_id = state_list["current"]

    # find the UI-state fact
    ui_state = next(
        fact
        for fact in facts
        if fact.template.name == "UI-state" and fact["id"] == current_id
    )

    # create a dialog window
    wizard = wx.adv.Wizard(None)
    page = wx.adv.WizardPageSimple(wizard)
    sizer = wx.BoxSizer(wx.VERTICAL)
    page.SetSizer(sizer)
    wizard.ShowPage(page)
    width, height = wizard.GetSize()
    wizard.SetSize(640, 480)
    x, y = wizard.GetPosition()
    wizard.SetPosition((x - (640 - width) // 2, y - (480 - height) // 2))
    # find Prev/Next buttons
    btn_prev: wx.Button = wizard.FindWindowById(wx.ID_BACKWARD)
    btn_prev.Bind(wx.EVT_BUTTON, lambda *_: wizard.EndModal(wx.ID_BACKWARD))
    btn_next: wx.Button = wizard.FindWindowById(wx.ID_FORWARD)
    btn_next.SetLabel("< &Back")
    # create a text label and radio buttons
    label = wx.StaticText()
    sizer.Add(label, flag=wx.EXPAND)
    radio = wx.RadioBox()
    sizer.Add(radio, proportion=1, flag=wx.EXPAND)

    # rename valid responses
    choices = [translate_string(s) for s in ui_state["valid-answers"]]

    # present the UI state
    match ui_state["state"]:
        case "initial":
            btn_prev.Enable(False)
            btn_next.SetLabel("&Next >")
        case "final":
            btn_prev.Enable(True)
            btn_next.SetLabel("&Restart")
        case _:
            btn_prev.Enable(True)
            btn_next.SetLabel("&Next >")
    wizard.SetTitle(app_title[0])
    label.Create(page, label=ui_state["title"])
    radio.Create(
        page,
        choices=choices or [""],
        style=wx.RA_SPECIFY_ROWS,
    )
    radio.Show(bool(ui_state["valid-answers"]))
    radio.SetStringSelection(translate_string(ui_state["response"]))

    # show the dialog
    button = wizard.ShowModal()
    if ui_state["valid-answers"]:
        choice = ui_state["valid-answers"][radio.GetSelection()]
    else:
        choice = None
    wizard.DestroyChildren()
    wizard.Destroy()
    # check which button was pressed
    match button:
        case wx.ID_BACKWARD:
            env.assert_string(f"(prev {current_id})")

        case wx.ID_FORWARD | wx.ID_OK:
            if ui_state["state"] == "final":
                env.reset()
            elif not ui_state["valid-answers"]:
                env.assert_string(f"(next {current_id})")
            else:
                env.assert_string(f"(next {current_id} {choice})")

        case _:  # incl. wx.ID_CANCEL
            return False
    return True


def main():
    env = Environment()
    env.load("autodemo.clp")
    env.reset()

    app = wx.App()
    while True:
        env.run()
        if not show_ui(env):
            break
    app.Destroy()


if __name__ == "__main__":
    main()
