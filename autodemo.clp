;;;======================================================
;;;	Automotive Expert System
;;;
;;;		This expert system diagnoses some simple
;;;		problems with a car.
;;;
;;;		CLIPS Version 6.3 Example
;;;
;;;		For use with the Auto Demo Example
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
	(slot id (default-dynamic (gensym*)))
	(slot title)
	(slot relation-asserted (default none))
	(slot response (default none))
	(multislot valid-answers)
	(multislot cars)
	(slot state (default middle))
)

(deftemplate state-list
	(slot current)
	(multislot sequence)
)

(deffacts startup
	(state-list)
)
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""
	=>
	(assert (app-title "Classic Cars"))
	(assert (UI-state
		(title "What classic car should i buy?")
		(relation-asserted start)
		(state initial)
		(valid-answers)
	))
)
;;;***************
;;;* QUERY RULES *
;;;***************

(defrule determine-why-do-you-want-a-classic ""
	(logical (start))
	=>
	(assert (UI-state (title "Why do you want a classic?")
							(relation-asserted why-do-you-want-a-classic)
							(response reliability_and_convenience_bore_me)
							(valid-answers reliability_and_convenience_bore_me i_guess_im_making_some_kind_of_statement_about_something new_cars_have_no_soul i_prefer_the_style love_speed_hate_safety))))

(defrule determine-oh-yeah-why-that ""
	(logical (why-do-you-want-a-classic reliability_and_convenience_bore_me))
	=>
	(assert (UI-state (title "Oh yeah why is that?")
							(relation-asserted oh-yeah-why-that)
							(response i_want_to_know_how_cars_work)
							(valid-answers i_want_to_know_how_cars_work im_erotically_drawn_to_tow_trucks_and_freeway_shoulders))))

(defrule determine-so-something-really-simple ""
	(logical (oh-yeah-why-that i_want_to_know_how_cars_work))
	=>
	(assert (UI-state (title "So, something really simple?")
							(relation-asserted so-something-really-simple)
							(response sounds_good)
							(valid-answers sounds_good more_archaic not_that_archaic))))

(defrule conclusions-so-something-really-simple-soundsgood ""
	(logical (so-something-really-simple sounds_good))
	=>
	(assert (UI-state (cars "Citroen 2CV" "VW Thing" "Willys Jeep" "Honda Civic")
							(state final))))

(defrule conclusions-so-something-really-simple-morearchaic ""
	(logical (so-something-really-simple more_archaic))
	=>
	(assert (UI-state (cars "Ford Model T")
							(state final))))

(defrule conclusions-so-something-really-simple-notthatarchaic ""
	(logical (so-something-really-simple not_that_archaic))
	=>
	(assert (UI-state (cars "Ford Model A")
							(state final))))

(defrule determine-ok-should-it-be-pretty-quick ""
	(logical (oh-yeah-why-that im_erotically_drawn_to_tow_trucks_and_freeway_shoulders))
	=>
	(assert (UI-state (title "Ok, should it be pretty quick?")
							(relation-asserted ok-should-it-be-pretty-quick)
							(response yes)
							(valid-answers yes also_really_lovely))))

(defrule conclusions-ok-should-it-be-pretty-quick-lovely ""
	(logical (ok-should-it-be-pretty-quick also_really_lovely))
	=>
	(assert (UI-state (cars "Alfa Romeo Giulia Super")
							(state final))))

(defrule conclusions-ok-should-it-be-pretty-quick-yes ""
	(logical (ok-should-it-be-pretty-quick yes))
	=>
	(assert (UI-state (cars "Lotus Elan")
							(state final))))

(defrule determine-great-what-statement ""
	(logical (why-do-you-want-a-classic i_guess_im_making_some_kind_of_statement_about_something))
	=>
	(assert (UI-state (title "Great, what statement?")
							(relation-asserted great-what-statement)
							(response im_really_rich_but_like_to_pretend_im_still_a_hippie)
							(valid-answers im_really_rich_but_like_to_pretend_im_still_a_hippie the_mothership_left_me_in_paris i_run_an_nyc-_themed_diner_in_las_vegas i_live_dangerously_and_nader_can_suck_it i_will_only_drive_vehicles_with_two_distinct_luggage_areas im_a_kook_an_american_kook i_take_driving_seriously_and_have_the_gloves_to_prove_it my_wallet_is_on_chain im_a_refugeee_from_an_alternate_future_with_zeppelins_and_shit i_like_being_part_of_a_massive_automotive_subculture i_hate_people_knowing_what_i_drive i_kinda_wanted_a_motorcycle_but_i_have_no_balance))))

(defrule determine-is-vw-type-fast-enough ""
	(logical (great-what-statement i_will_only_drive_vehicles_with_two_distinct_luggage_areas))
	=>
	(assert (UI-state (title "Is VW Type III fast enough for you?")
							(relation-asserted is-vw-type-fast-enough)
							(response yes)
							(valid-answers yes something_faster))))

(defrule determine-is-porsche-fast-enough ""
	(logical (is-vw-type-fast-enough something_faster))
	=>
	(assert (UI-state (title "Is Porsche 914 fast enough for you?")
							(relation-asserted is-porsche-fast-enough)
							(response yes)
							(valid-answers yes something_faster))))

(defrule conclusions-is-vw-type-fast-enough-yes ""
	(logical (is-vw-type-fast-enough yes))
	=>
	(assert (UI-state (cars "VW Type III")
							(state final))))

(defrule conclusions-is-porsche-fast-enough-yes ""
	(logical (is-porsche-fast-enough yes))
	=>
	(assert (UI-state (cars "Porsche 914")
							(state final))))

(defrule conclusions-is-porsche-fast-enough-no ""
	(logical (is-porsche-fast-enough something_faster))
	=>
	(assert (UI-state (cars "De Tomaso Mangusta")
							(state final))))

(defrule conclusions-great-what-statement-reallyrich ""
	(logical (great-what-statement im_really_rich_but_like_to_pretend_im_still_a_hippie))
	=>
	(assert (UI-state (cars "VW Type 2 Microbus")
							(state final))))

(defrule conclusions-great-what-statement-mothership ""
	(logical (great-what-statement the_mothership_left_me_in_paris))
	=>
	(assert (UI-state (cars "Citroen SM")
							(state final))))

(defrule conclusions-great-what-statement-dinerinlasvegas ""
	(logical (great-what-statement i_run_an_nyc-_themed_diner_in_las_vegas))
	=>
	(assert (UI-state (cars "Checker Marathon")
							(state final))))

(defrule conclusions-great-what-statement-dangerandnader ""
	(logical (great-what-statement i_live_dangerously_and_nader_can_suck_it))
	=>
	(assert (UI-state (cars "Chevy Corvair")
							(state final))))

(defrule conclusions-great-what-statement-americankook ""
	(logical (great-what-statement im_a_kook_an_american_kook))
	=>
	(assert (UI-state (cars "AMC Pacer" "AMC Gremlin")
							(state final))))

(defrule conclusions-great-what-statement-drivingseriously ""
	(logical (great-what-statement i_take_driving_seriously_and_have_the_gloves_to_prove_it))
	=>
	(assert (UI-state (cars "BMW E30" "Porsche 911")
							(state final))))

(defrule conclusions-great-what-statement-refugee ""
	(logical (great-what-statement im_a_refugeee_from_an_alternate_future_with_zeppelins_and_shit))
	=>
	(assert (UI-state (cars "Tatra TB7")
							(state final))))

(defrule conclusions-great-what-statement-massivesubculture ""
	(logical (great-what-statement i_like_being_part_of_a_massive_automotive_subculture))
	=>
	(assert (UI-state (cars "VW Beetle")
							(state final))))

(defrule conclusions-great-what-statement-hatepeople ""
	(logical (great-what-statement i_hate_people_knowing_what_i_drive))
	=>
	(assert (UI-state (cars "Sterling B25" "Mitsubishi Starion" "Isuzu I-MARK")
							(state final))))

(defrule conclusions-great-what-statement-kindawanted ""
	(logical (great-what-statement i_kinda_wanted_a_motorcycle_but_i_have_no_balance))
	=>
	(assert (UI-state (cars "Lotus 7")
							(state final))))

(defrule conclusions-great-what-statement-wallet ""
	(logical (great-what-statement my_wallet_is_on_chain))
	=>
	(assert (UI-state (cars "Ford Falcon" "Plymouth Valiant" "Rambler American")
							(state final))))

(defrule determine-what-does-soul-mean-to-you ""
	(logical (why-do-you-want-a-classic new_cars_have_no_soul))
	=>
	(assert (UI-state (title "What does soul mean to you?")
							(relation-asserted what-does-soul-mean-to-you)
							(response easy_ability_to_drive_offa_pier_into_an_estuary)
							(valid-answers easy_ability_to_drive_offa_pier_into_an_estuary synonym_for_weird technically_novel soul_means_the_car_had_an_honest_job_like_a_cop_or_cabbie it_means_riding_in_it_is_like_sitting_on_a_sofa it_means_the_car_is_often_starring_in_movies it_could_mean_pure_evil soul_is_the_spirits_of43_dead_clowns_haunting_the_car sould_is_the_ability_to_go_a_million_miles_with_su_carbs_and_lucas_electrics))))

(defrule conclusions-easy-ability ""
	(logical (what-does-soul-mean-to-you easy_ability_to_drive_offa_pier_into_an_estuary))
	=>
	(assert (UI-state (cars "Amphicar")
							(state final))))

(defrule conclusions-synonym-weird ""
	(logical (what-does-soul-mean-to-you synonym_for_weird))
	=>
	(assert (UI-state (cars "BMW Isetta" "Messerschmidt Kabinroller")
							(state final))))

(defrule determine-like-what ""
	(logical (what-does-soul-mean-to-you technically_novel))
	=>
	(assert (UI-state (title "Like what?")
							(relation-asserted like-what)
							(response instead_of_pistons_some_metal_hamantaschen)
							(valid-answers instead_of_pistons_some_metal_hamantaschen can_burn_booking_oil engine_in_the_wrong_place they_thought_they_were_building_a_plane))))

(defrule conclusions-intead-of-pistons ""
	(logical (like-what instead_of_pistons_some_metal_hamantaschen))
	=>
	(assert (UI-state (cars "Mazda RX7")
							(state final))))

(defrule conclusions-can-burn-oil ""
	(logical (like-what can_burn_booking_oil))
	=>
	(assert (UI-state (cars "Mercedes-Benz 300 TD")
							(state final))))

(defrule conclusions-engine-in-wrong-place ""
	(logical (like-what engine_in_the_wrong_place))
	=>
	(assert (UI-state (cars "Porsche 912" "Renault Alpine")
							(state final))))

(defrule conclusions-they-thought ""
	(logical (like-what they_thought_they_were_building_a_plane))
	=>
	(assert (UI-state (cars "SAAB 96")
							(state final))))

(defrule conclusions-honest-job-like-cop ""
	(logical (what-does-soul-mean-to-you soul_means_the_car_had_an_honest_job_like_a_cop_or_cabbie))
	=>
	(assert (UI-state (cars "Chevy Caprice" "Dodge Monaco" "Ford Crown Vic")
							(state final))))

(defrule determine-huge-fast-sofa ""
	(logical (what-does-soul-mean-to-you it_means_riding_in_it_is_like_sitting_on_a_sofa))
	=>
	(assert (UI-state (title "It means riding in it is like sitting on a sofa?")
							(relation-asserted huge-fast-sofa)
							(response yes)
							(valid-answers yes no))))

(defrule conclusions-huge-fast-sofa-yes ""
	(logical (huge-fast-sofa yes))
	=>
	(assert (UI-state (cars "Olds Toronado")
							(state final))))

(defrule conclusions-huge-fast-sofa-no ""
	(logical (huge-fast-sofa no))
	=>
	(assert (UI-state (cars "Lincoln Town Car")
							(state final))))

(defrule conclusions-means-starring-movies ""
	(logical (what-does-soul-mean-to-you it_means_the_car_is_often_starring_in_movies))
	=>
	(assert (UI-state (cars "Delorean DMC-12")
							(state final))))

(defrule conclusions-pure-evil ""
	(logical (what-does-soul-mean-to-you it_could_mean_pure_evil))
	=>
	(assert (UI-state (cars "Buick GNX" "Plymouth Fury")
							(state final))))

(defrule conclusions-dead-clowns ""
	(logical (what-does-soul-mean-to-you soul_is_the_spirits_of_43_dead_clowns_haunting_the_car))
	=>
	(assert (UI-state (cars "Nash Metropolitan")
							(state final))))

(defrule conclusions-million-miles ""
	(logical (what-does-soul-mean-to-you soul_is_the_ability_to_go_a_million_miles_with_su_carbs_and_lucas_electrics))
	=>
	(assert (UI-state (cars "Volvo P1800")
							(state final))))

(defrule determine-ok-what-kind-of-style ""
	(logical (why-do-you-want-a-classic i_prefer_the_style))
	=>
	(assert (UI-state (title "OK, what kind of style?")
							(relation-asserted ok-what-kind-of-style)
							(response african_dictator)
							(valid-answers african_dictator i_love_corvairs_but_live_in_a34_scale_universe like_buck_bogers_bosss_dad i_love_chrome_and_loud_shirts really_slow_cars_that_look_fast i_love_brass_and_lanters i_can_only_drive_cars_that_are_museum_worthy working_class_hero_also_beer classic_german_with_a_touch_of_pedal_confusion))))

(defrule conclusions-african-dictator ""
	(logical (ok-what-kind-of-style african_dictator))
	=>
	(assert (UI-state (cars "Mercedes-Benz 600")
							(state final))))

(defrule conclusions-scale-34-universe ""
	(logical (ok-what-kind-of-style i_love_corvairs_but_live_in_a34_scale_universe))
	=>
	(assert (UI-state (cars "NSU Prinz")
							(state final))))

(defrule conclusions-like-buck-rogers ""
	(logical (ok-what-kind-of-style like_buck_bogers_bosss_dad))
	=>
	(assert (UI-state (cars "'59 Cadillac Eldorado")
							(state final))))

(defrule conclusions-love-chrome-loud ""
	(logical (ok-what-kind-of-style i_love_chrome_and_loud_shirts))
	=>
	(assert (UI-state (cars "'57 Chevy Bel Air")
							(state final))))

(defrule conclusions-slow-look-fast ""
	(logical (ok-what-kind-of-style really_slow_cars_that_look_fast))
	=>
	(assert (UI-state (cars "Opel GT" "VW Karmann Ghia" "Renault Floride")
							(state final))))

(defrule conclusions-brass-lanterns ""
	(logical (ok-what-kind-of-style i_love_brass_and_lanters))
	=>
	(assert (UI-state (cars "Anything pre-WW II, Maybe a Packard?")
							(state final))))

(defrule conclusions-museum-worthy ""
	(logical (ok-what-kind-of-style i_can_only_drive_cars_that_are_museum_worthy))
	=>
	(assert (UI-state (cars "Citroen DS" "Lamborghini Miura" "Cord 812")
							(state final))))

(defrule determine-working-class-hero ""
	(logical (ok-what-kind-of-style working_class_hero_also_beer))
	=>
	(assert (UI-state (title "Working class hero also beer?")
							(relation-asserted working-class-hero)
							(response does_your_hat_say_youd_rather_push_a_chevy)
							(valid-answers does_your_hat_say_youd_rather_push_a_chevy ford_mustang))))

(defrule determine-what-do-you-want-from-tires ""
	(logical (working-class-hero ford_mustang))
	=>
	(assert (UI-state (title "What do you want from tires?")
							(relation-asserted what-do-you-want-from-tires)
							(response noise_and_smoke)
							(valid-answers noise_and_smoke noise_smoke_and_the_trailer_parks_undying_respect))))

(defrule conclusions-what-do-you-want-from-tires ""
	(logical (what-do-you-want-from-tires noise_and_smoke))
	=>
	(assert (UI-state (cars "Ford Mustang Mach I" "Chevy C3 Corvette")
							(state final))))

(defrule conclusions-what-do-you-want-from-tires-rest ""
	(logical (what-do-you-want-from-tires noise_smoke_and_the_trailer_parks_undying_respect))
	=>
	(assert (UI-state (cars "Fox Body Mustang")
							(state final))))

(defrule determine-hat-says ""
	(logical (working-class-hero does_your_hat_say_youd_rather_push_a_chevy))
	=>
	(assert (UI-state (title "Does your hat say youd rather push a chevy?")
							(relation-asserted hat-says)
							(response so_it_does_friend)
							(valid-answers so_it_does_friend dammit_i_lost_my_hat))))

(defrule conclusions-hat-says-yes ""
	(logical (hat-says so_it_does_friend))
	=>
	(assert (UI-state (cars "Chevy Camaro")
							(state final))))

(defrule conclusions-hat-says-no ""
	(logical (hat-says dammit_i_lost_my_hat))
	=>
	(assert (UI-state (cars "AMC AMX")
							(state final))))

(defrule conclusions-pedal-confusion ""
	(logical (ok-what-kind-of-style classic_german_with_a_touch_of_pedal_confusion))
	=>
	(assert (UI-state (cars "Audi 100")
							(state final))))

(defrule determine-real-speed-or-just-feels-speedy ""
	(logical (why-do-you-want-a-classic love_speed_hate_safety))
	=>
	(assert (UI-state (title "Real speed or just feels speedy?")
							(relation-asserted real-speed-or-just-feels-speedy)
							(response i_love_speed_and_money)
							(valid-answers i_love_speed_and_money i_have_a_death_wish fast_and_cheap fake_is_fine))))

(defrule determine-great-who-are-you ""
	(logical (real-speed-or-just-feels-speedy i_love_speed_and_money))
	=>
	(assert (UI-state (title "Great who are you?")
							(relation-asserted who-are-you)
							(response some_kind_of_duke_and_i_rally)
							(valid-answers some_kind_of_duke_and_i_rally my_goal_is_to_drive_m_y_childhood_bedroom_posters i_have_a_weird_fetish_where_i_like_people_asking_is_it_replica))))

(defrule conclusions-kind-duke ""
	(logical (who-are-you some_kind_of_duke_and_i_rally))
	=>
	(assert (UI-state (cars "Lancia Stratos")
							(state final))))

(defrule conclusions-childhood-dream ""
	(logical (who-are-you my_goal_is_to_drive_m_y_childhood_bedroom_posters))
	=>
	(assert (UI-state (cars "Lamborghini Countach" "Ferrari 250 GTO")
							(state final))))

(defrule conclusions-weird-fetish ""
	(logical (who-are-you i_have_a_weird_fetish_where_i_like_people_asking_is_it_replica))
	=>
	(assert (UI-state (cars "AC Cobra" "Porsche 356 Speedster")
							(state final))))

(defrule determine-how-to-go ""
	(logical (real-speed-or-just-feels-speedy i_have_a_death_wish))
	=>
	(assert (UI-state (title "How do you want to go?")
							(relation-asserted how-to-go)
							(response electrocuted_by_wiper_switch)
							(valid-answers electrocuted_by_wiper_switch crushed_by_v8_in_tiny_space blaze_of_glory car_tree run_out_of_talent_off_cliff))))

(defrule conclusions-crushed-by-v8 ""
	(logical (how-to-go crushed_by_v8_in_tiny_space))
	=>
	(assert (UI-state (cars "Sunbeam Tiger")
							(state final))))

(defrule conclusions-electrocuted ""
	(logical (how-to-go electrocuted_by_wiper_switch))
	=>
	(assert (UI-state (cars "Jaguar E-Type")
							(state final))))

(defrule conclusions-blaze-of-glory ""
	(logical (how-to-go blaze_of_glory))
	=>
	(assert (UI-state (cars "Ferrari Testarossa")
							(state final))))

(defrule conclusions-car-tree ""
	(logical (how-to-go car_tree))
	=>
	(assert (UI-state (cars "Camaro Iroc-Z" "Plymouth Road Runner")
							(state final))))

(defrule conclusions-run-talent ""
	(logical (how-to-go run_out_of_talent_off_cliff))
	=>
	(assert (UI-state (cars "Porsche Spyder")
							(state final))))

(defrule conclusions-fast-cheap ""
	(logical (real-speed-or-just-feels-speedy fast_and_cheap))
	=>
	(assert (UI-state (cars "Dodge OMNI GLH")
							(state final))))

(defrule conclusions-fake-is-fine ""
	(logical (real-speed-or-just-feels-speedy fake_is_fine))
	=>
	(assert (UI-state (cars "Datsun 510" "Mini Cooper" "Mk1 VW Golf GTI" "Honda CRX")
							(state final))))
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question
	(declare (salience 5))
	(UI-state
		(id ?id)
	)
	?f <- (state-list
		(sequence $?s&:(not (member$ ?id ?s)))
	)
	=>
	(modify ?f (current ?id) (sequence ?id ?s))
	(halt)
)

(defrule handle-next-no-change-none-middle-of-chain
	(declare (salience 10))
	?f1 <- (next ?id)
	?f2 <- (state-list
		(current ?id)
		(sequence $? ?nid ?id $?)
	)
	=>
	(retract ?f1)
	(modify ?f2 (current ?nid))
	(halt)
)

(defrule handle-next-response-none-end-of-chain
	(declare (salience 10))
	?f <- (next ?id)
	(state-list
		(sequence ?id $?)
	)
	(UI-state
		(id ?id)
		(relation-asserted ?relation)
	)
	=>
	(retract ?f)
	(assert (add-response ?id))
)

(defrule handle-next-no-change-middle-of-chain
	(declare (salience 10))
	?f1 <- (next ?id ?response)
	?f2 <- (state-list
		(current ?id)
		(sequence $? ?nid ?id $?)
	)
	(UI-state
		(id ?id)
		(response ?response)
	)
	=>
	(retract ?f1)
	(modify ?f2 (current ?nid))
	(halt)
)

(defrule handle-next-change-middle-of-chain
	(declare (salience 10))
	(next ?id ?response)
	?f1 <- (state-list
		(current ?id)
		(sequence ?nid $?b ?id $?e)
	)
	(UI-state
		(id ?id)
		(response ~?response)
	)
	?f2 <- (UI-state
		(id ?nid)
	)
	=>
	(modify ?f1 (sequence ?b ?id ?e))
	(retract ?f2)
)

(defrule handle-next-response-end-of-chain
	(declare (salience 10))
	?f1 <- (next ?id ?response)
	(state-list
		(sequence ?id $?)
	)
	?f2 <- (UI-state
		(id ?id)
		(response ?expected)
		(relation-asserted ?relation)
	)
	=>
	(retract ?f1)
	(if
		(neq ?response ?expected)
		then
		(modify ?f2 (response ?response))
	)
	(assert (add-response ?id ?response))
)

(defrule handle-add-response
	(declare (salience 10))
	(logical (UI-state
		(id ?id)
		(relation-asserted ?relation)
	))
	?f1 <- (add-response ?id ?response)
	=>
	(str-assert (str-cat "(" ?relation " " ?response ")"))
	(retract ?f1)
)

(defrule handle-add-response-none
	(declare (salience 10))
	(logical (UI-state
		(id ?id)
		(relation-asserted ?relation)
	))
	?f1 <- (add-response ?id)
	=>
	(str-assert (str-cat "(" ?relation ")"))
	(retract ?f1)
)

(defrule handle-prev
	(declare (salience 10))
	?f1 <- (prev ?id)
	?f2 <- (state-list
		(sequence $?b ?id ?p $?e)
	)
	=>
	(retract ?f1)
	(modify ?f2 (current ?p))
	(halt)
)
