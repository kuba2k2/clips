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

   (assert (UI-state (title StartQuestion)
                     (relation-asserted why-do-you-want-a-classic)
                     (response ReliabilityAndConvenience)
                     (valid-answers ReliabilityAndConvenience IGuessImMakingSomeKindOfStatementAboutSomething NewCarsHaveNoSoul IPreferTheStyle LoveSpeedHateSafety))))

(defrule determine-oh-yeah-why-that ""

   (logical (why-do-you-want-a-classic ReliabilityAndConvenience))

   =>

   (assert (UI-state (title OhYeahWhyIsThat)
                     (relation-asserted oh-yeah-why-that)
                     (response IWantToKnowHowCarsWork)
                     (valid-answers IWantToKnowHowCarsWork ImEroticallyDrawnToTowTrucksAndFreewayShoulders))))

(defrule determine-so-something-really-simple ""

   (logical (oh-yeah-why-that IWantToKnowHowCarsWork))

   =>

   (assert (UI-state (title SoSomethingReallySimple)
                     (relation-asserted so-something-really-simple)
                     (response SoundsGood)
                     (valid-answers SoundsGood MoreArchaic NotThatArchaic))))

(defrule conclusions-so-something-really-simple-soundsgood ""

   (logical (so-something-really-simple SoundsGood))

   =>

   (assert (UI-state (title AnswerCitroen2CV)
                     (state final))))

(defrule conclusions-so-something-really-simple-morearchaic ""

   (logical (so-something-really-simple MoreArchaic))

   =>

   (assert (UI-state (title AnswerFordModelT)
                     (state final))))

(defrule conclusions-so-something-really-simple-notthatarchaic ""

   (logical (so-something-really-simple NotThatArchaic))

   =>

   (assert (UI-state (title AnswerFordModelA)
                     (state final))))




(defrule determine-ok-should-it-be-pretty-quick ""

   (logical (oh-yeah-why-that ImEroticallyDrawnToTowTrucksAndFreewayShoulders))

   =>

   (assert (UI-state (title OkShouldItBePrettyQuick)
                     (relation-asserted ok-should-it-be-pretty-quick)
                     (response AlsoReallyLovely)
                     (valid-answers AlsoReallyLovely Yes))))

(defrule conclusions-ok-should-it-be-pretty-quick-lovely ""

   (logical (ok-should-it-be-pretty-quick AlsoReallyLovely))

   =>

   (assert (UI-state (title AnswerAlfaRomeoGiuliaSuper)
                     (state final))))

(defrule conclusions-ok-should-it-be-pretty-quick-yes ""

   (logical (ok-should-it-be-pretty-quick Yes))

   =>

   (assert (UI-state (title AnswerLotusElan)
                     (state final))))




(defrule determine-great-what-statement ""

   (logical (why-do-you-want-a-classic IGuessImMakingSomeKindOfStatementAboutSomething))

   =>

   (assert (UI-state (title GreatWhatStatement)
                     (relation-asserted great-what-statement)
                     (response ImReallyRichButLikeToPretendImStillAHippie)
                     (valid-answers ImReallyRichButLikeToPretendImStillAHippie TheMothershipLeftMeInParis IRunAnNyc-ThemedDinerInLasVegas ILiveDangerouslyAndNaderCanSuckIt IWillOnlyDriveVehiclesWithTwoDistinctLuggageAreas ImAKookAnAmericanKook ITakeDrivingSeriouslyAndHaveTheGlovesToProveIt MyWalletIsOnChain ImARefugeeeFromAnAlternateFutureWithZeppelinsAndShit ILikeBeingPartOfAMassiveAutomotiveSubculture IHatePeopleKnowingWhatIDrive IKindaWantedAMotorcycleButIHaveNoBalance))))

(defrule determine-is-vw-type-fast-enough ""

   (logical (great-what-statement IWillOnlyDriveVehiclesWithTwoDistinctLuggageAreas))

   =>

   (assert (UI-state (title IsVwTypeIIIFastEnoughForYou)
                     (relation-asserted is-vw-type-fast-enough)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule determine-is-porshe-fast-enough ""

   (logical (is-vw-type-fast-enough No))

   =>

   (assert (UI-state (title IsPorshe914FastEnoughForYou)
                     (relation-asserted is-porshe-fast-enough)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule conclusions-is-vw-type-fast-enough-yes ""
   (logical (is-vw-type-fast-enough Yes))

   =>

   (assert (UI-state (title AnswerVwTypeIII)
                     (state final))))


(defrule conclusions-is-porshe-fast-enough-yes ""
   (logical (is-porshe-fast-enough Yes))

   =>

   (assert (UI-state (title AnswerPorshe914)
                     (state final))))

(defrule conclusions-is-porshe-fast-enough-no ""
   (logical (is-porshe-fast-enough No))

   =>

   (assert (UI-state (title AnswerDeTomasoMangusta)
                     (state final))))


(defrule conclusions-great-what-statement-reallyrich ""

   (logical (great-what-statement ImReallyRichButLikeToPretendImStillAHippie))

   =>

   (assert (UI-state (title AnswerVWType2Microbus)
                     (state final))))


(defrule conclusions-great-what-statement-mothership ""

   (logical (great-what-statement TheMothershipLeftMeInParis))

   =>

   (assert (UI-state (title AnswerCitreonSM)
                     (state final))))

(defrule conclusions-great-what-statement-dinerinlasvegas ""

   (logical (great-what-statement IRunAnNyc-ThemedDinerInLasVegas))

   =>

   (assert (UI-state (title AnswerCheckerMarathon)
                     (state final))))


(defrule conclusions-great-what-statement-dangerandnader ""

   (logical (great-what-statement ILiveDangerouslyAndNaderCanSuckIt))

   =>

   (assert (UI-state (title AnswerChevyCorvair)
                     (state final))))


(defrule conclusions-great-what-statement-americankook ""

   (logical (great-what-statement ImAKookAnAmericanKook))

   =>

   (assert (UI-state (title AnswerAmcAmx )
                     (state final))))


(defrule conclusions-great-what-statement-drivingseriously ""

   (logical (great-what-statement ITakeDrivingSeriouslyAndHaveTheGlovesToProveIt))

   =>

   (assert (UI-state (title AnswerBmwE30)
                     (state final))))


(defrule conclusions-great-what-statement-refugee ""

   (logical (great-what-statement ImARefugeeeFromAnAlternateFutureWithZeppelinsAndShit))

   =>

   (assert (UI-state (title AnswerTatraTb7)
                     (state final))))

(defrule conclusions-great-what-statement-massivesubculture ""

   (logical (great-what-statement ILikeBeingPartOfAMassiveAutomotiveSubculture))

   =>

   (assert (UI-state (title AnswerVWBeetle)
                     (state final))))


(defrule conclusions-great-what-statement-hatepeople ""

   (logical (great-what-statement IHatePeopleKnowingWhatIDrive))

   =>

   (assert (UI-state (title AnswerSterlingB25)
                     (state final))))

(defrule conclusions-great-what-statement-kindawanted ""
   (logical (great-what-statement IKindaWantedAMotorcycleButIHaveNoBalance))

   =>

   (assert (UI-state (title AnswerLotus7)
                     (state final))))


(defrule conclusions-great-what-statement-wallet ""

   (logical (great-what-statement MyWalletIsOnChain))

   =>

   (assert (UI-state (title AnswerFordFalcon)
                     (state final))))



(defrule determine-what-does-soul-mean-to-you ""

   (logical (why-do-you-want-a-classic NewCarsHaveNoSoul))

   =>

   (assert (UI-state (title WhatDoesSoulMeanToYou)
                     (relation-asserted what-does-soul-mean-to-you)
                     (response EasyAbilityToDriveOffaPierIntoAnEstuary)
                     (valid-answers EasyAbilityToDriveOffaPierIntoAnEstuary SynonymForWeird TechnicallyNovel SoulMeansTheCarHadAnHonestJobLikeACopOrCabbie ItMeansRidingInItIsLikeSittingOnASofa ItMeansTheCarIsOftenStarringInMovies ItCouldMeanPureEvil SoulIsTheSpiritsOf43DeadClownsHauntingTheCar SouldIsTheAbilityToGoAMillionMilesWithSuCarbsAndLucasElectrics))))

(defrule conclusions-easy-ability ""

   (logical (what-does-soul-mean-to-you EasyAbilityToDriveOffaPierIntoAnEstuary))

   =>

   (assert (UI-state (title AnswerAmphicar)
                     (state final))))


(defrule conclusions-synonym-weird ""

   (logical (what-does-soul-mean-to-you SynonymForWeird))

   =>

   (assert (UI-state (title AnswerBMWISetta)
                     (state final))))


(defrule determine-like-what ""

   (logical (what-does-soul-mean-to-you TechnicallyNovel))

   =>

   (assert (UI-state (title LikeWhat)
                     (relation-asserted like-what)
                     (response InsteadOfPistonsSomeMetalHamantaschen)
                     (valid-answers InsteadOfPistonsSomeMetalHamantaschen CanBurnBookingOil EngineInTheWrongPlace TheyThoughtTheyWereBuildingAPlane))))

(defrule conclusions-intead-of-pistons ""

   (logical (like-what InsteadOfPistonsSomeMetalHamantaschen))

   =>

   (assert (UI-state (title AnswerMazdaRX7)
                     (state final))))

(defrule conclusions-can-burn-oil ""

   (logical (like-what CanBurnBookingOil))

   =>

   (assert (UI-state (title AnswerMercedesBezn300TD)
                     (state final))))

(defrule conclusions-engine-in-wrong-place ""

   (logical (like-what EngineInTheWrongPlace))

   =>

   (assert (UI-state (title AnswerPorsche912)
                     (state final))))

(defrule conclusions-they-thought ""
   (logical (like-what TheyThoughtTheyWereBuildingAPlane))

   =>

   (assert (UI-state (title AnswerSaab96)
                     (state final))))

(defrule conclusions-honest-job-like-cop ""

   (logical (what-does-soul-mean-to-you SoulMeansTheCarHadAnHonestJobLikeACopOrCabbie))

   =>

   (assert (UI-state (title AnswerChevyCaprice)
                     (state final))))



(defrule determine-huge-fast-sofa ""

   (logical (what-does-soul-mean-to-you ItMeansRidingInItIsLikeSittingOnASofa))

   =>

   (assert (UI-state (title ItMeansRidingInItIsLikeSittingOnASofa)
                     (relation-asserted huge-fast-sofa)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule conclusions-huge-fast-sofa-yes ""

   (logical (huge-fast-sofa Yes))

   =>

   (assert (UI-state (title AnswerOldsToronado)
                     (state final))))

(defrule conclusions-huge-fast-sofa-no ""

   (logical (huge-fast-sofa No))

   =>

   (assert (UI-state (title AnswerLincolnTownCar)
                     (state final))))


(defrule conclusions-means-starring-movies ""

   (logical (what-does-soul-mean-to-you ItMeansTheCarIsOftenStarringInMovies))

   =>

   (assert (UI-state (title AnswerDelorean)
                     (state final))))

(defrule conclusions-pure-evil ""

   (logical (what-does-soul-mean-to-you ItCouldMeanPureEvil))

   =>

   (assert (UI-state (title AnswerBuickGNX)
                     (state final))))

(defrule conclusions-dead-clowns ""

   (logical (what-does-soul-mean-to-you SoulIsTheSpiritsOf43DeadClownsHauntingTheCar))

   =>

   (assert (UI-state (title AnswerNashMetro)
                     (state final))))

(defrule conclusions-million-miles ""

   (logical (what-does-soul-mean-to-you SouldIsTheAbilityToGoAMillionMilesWithSuCarbsAndLucasElectrics))

   =>

   (assert (UI-state (title AnswerVolvoP1800)
                     (state final))))



(defrule determine-ok-what-kind-of-style ""

   (logical (why-do-you-want-a-classic IPreferTheStyle))

   =>

   (assert (UI-state (title OKWhatKindOfStyle)
                     (relation-asserted ok-what-kind-of-style)
                     (response AfricanDictator)
                     (valid-answers AfricanDictator ILoveCorvairsButLiveInA34ScaleUniverse LikeBuckBogersBosssDad ILoveChromeAndLoudShirts ReallySlowCarsThatLookFast ILoveBrassAndLanters ICanOnlyDriveCarsThatAreMuseumWorthy WorkingClassHeroAlsoBeer ClassicGermanWithATouchOfPedalConfusion))))

(defrule conclusions-african-dictator ""

   (logical (ok-what-kind-of-style AfricanDictator))

   =>

   (assert (UI-state (title AnswerMercedesBenz600)
                     (state final))))

(defrule conclusions-scale-34-universe ""

   (logical (ok-what-kind-of-style ILoveCorvairsButLiveInA34ScaleUniverse))

   =>

   (assert (UI-state (title AnswerNSUPrinz)
                     (state final))))

(defrule conclusions-like-buck-rogers ""

   (logical (ok-what-kind-of-style LikeBuckBogersBosssDad))

   =>

   (assert (UI-state (title Answer59CadillacEldorado)
                     (state final))))

(defrule conclusions-love-chrome-loud ""

   (logical (ok-what-kind-of-style ILoveChromeAndLoudShirts))

   =>

   (assert (UI-state (title Answer57ChevyBelAir)
                     (state final))))

(defrule conclusions-slow-look-fast ""

   (logical (ok-what-kind-of-style ReallySlowCarsThatLookFast))

   =>

   (assert (UI-state (title AnswerOpelGT)
                     (state final))))

(defrule conclusions-brass-lanterns ""

   (logical (ok-what-kind-of-style ILoveBrassAndLanters))

   =>

   (assert (UI-state (title AnswerAnythingPreWWII)
                     (state final))))

(defrule conclusions-museum-worthy ""

   (logical (ok-what-kind-of-style ICanOnlyDriveCarsThatAreMuseumWorthy))

   =>

   (assert (UI-state (title AnswerCitroenDS)
                     (state final))))

(defrule determine-working-class-hero ""

   (logical (ok-what-kind-of-style WorkingClassHeroAlsoBeer))

   =>

   (assert (UI-state (title WorkingClassHeroAlsoBeer)
                     (relation-asserted working-class-hero)
                     (response DoesYourHatSayYoudRatherPushAChevy)
                     (valid-answers DoesYourHatSayYoudRatherPushAChevy FordMustang))))

(defrule determine-what-do-you-want-from-tires ""

   (logical (working-class-hero FordMustang))

   =>

   (assert (UI-state (title WhatDoYouWantFromTires)
                     (relation-asserted what-do-you-want-from-tires)
                     (response NoiseAndSmoke)
                     (valid-answers NoiseAndSmoke NoiseSmokeAndTheTrailerParksUndyingRespect))))

(defrule conclusions-what-do-you-want-from-tires ""

   (logical (what-do-you-want-from-tires NoiseAndSmoke))

   =>

   (assert (UI-state (title AnswerFordMustangMachI)
                     (state final))))

(defrule conclusions-what-do-you-want-from-tires-rest ""

   (logical (what-do-you-want-from-tires NoiseSmokeAndTheTrailerParksUndyingRespect))

   =>

   (assert (UI-state (title AnswerFoxBodyMustang)
                     (state final))))




(defrule determine-hat-says ""

   (logical (working-class-hero DoesYourHatSayYoudRatherPushAChevy))

   =>

   (assert (UI-state (title DoesYourHatSayYoudRatherPushAChevy)
                     (relation-asserted hat-says)
                     (response SoItDoesFriend)
                     (valid-answers SoItDoesFriend DammitILostMyHat))))

(defrule conclusions-hat-says-yes ""

   (logical (hat-says SoItDoesFriend))

   =>

   (assert (UI-state (title AnswerChevyCamaro)
                     (state final))))

(defrule conclusions-hat-says-no ""

   (logical (hat-says DammitILostMyHat))

   =>

   (assert (UI-state (title AnswerAmcAmx)
                     (state final))))





(defrule conclusions-pedal-confusion ""


   (logical (ok-what-kind-of-style ClassicGermanWithATouchOfPedalConfusion))

   =>

   (assert (UI-state (title AnswerAudi100)
                     (state final))))




(defrule determine-real-speed-or-just-feels-speedy ""

   (logical (why-do-you-want-a-classic LoveSpeedHateSafety))

   =>

   (assert (UI-state (title RealSpeedOrJustFeelsSpeedy)
                     (relation-asserted real-speed-or-just-feels-speedy)
                     (response ILoveSpeedAndMoney)
                     (valid-answers ILoveSpeedAndMoney IHaveADeathWish FastAndCheap FakeIsFine))))




(defrule determine-great-who-are-you ""

   (logical (real-speed-or-just-feels-speedy ILoveSpeedAndMoney))

   =>

   (assert (UI-state (title GreatWhoAreYou)
                     (relation-asserted who-are-you)
                     (response SomeKindOfDukeAndIRally)
                     (valid-answers SomeKindOfDukeAndIRally MyGoalIsToDriveMYChildhoodBedroomPosters IHaveAWeirdFetishWhereILikePeopleAskingIsItReplica))))


(defrule conclusions-kind-duke ""

   (logical (who-are-you SomeKindOfDukeAndIRally))

   =>

   (assert (UI-state (title AnswerLanciaStratos)
                     (state final))))

(defrule conclusions-childhood-dream ""

   (logical (who-are-you MyGoalIsToDriveMYChildhoodBedroomPosters))

   =>

   (assert (UI-state (title AnswerLamborghiniCountach)
                     (state final))))

(defrule conclusions-weird-fetish ""

   (logical (who-are-you IHaveAWeirdFetishWhereILikePeopleAskingIsItReplica))

   =>

   (assert (UI-state (title AnswerACCobra)
                     (state final))))



(defrule determine-how-to-go ""

   (logical (real-speed-or-just-feels-speedy IHaveADeathWish))

   =>

   (assert (UI-state (title HowDoYouWantToGo)
                     (relation-asserted how-to-go)
                     (response ElectrocutedByWiperSwitch)
                     (valid-answers ElectrocutedByWiperSwitch CrushedByV8InTinySpace BlazeOfGlory CarTree RunOutOfTalentOffCliff))))

(defrule conclusions-crushed-by-v8 ""

   (logical (how-to-go CrushedByV8InTinySpace))

   =>

   (assert (UI-state (title AnswerSunbeamTiger)
                     (state final))))

(defrule conclusions-electrocuted ""

   (logical (how-to-go ElectrocutedByWiperSwitch))

   =>

   (assert (UI-state (title AnswerJaguarEType)
                     (state final))))

(defrule conclusions-blaze-of-glory ""

   (logical (how-to-go BlazeOfGlory))

   =>

   (assert (UI-state (title AnswerFerrariTestarossa)
                     (state final))))

(defrule conclusions-car-tree ""

   (logical (how-to-go CarTree))

   =>

   (assert (UI-state (title AnswerCamaroIROCZ)
                     (state final))))

(defrule conclusions-run-talent ""

   (logical (how-to-go RunOutOfTalentOffCliff))

   =>

   (assert (UI-state (title AnswerPorscheSpyder)
                     (state final))))

(defrule conclusions-fast-cheap ""

   (logical (real-speed-or-just-feels-speedy FastAndCheap))

   =>

   (assert (UI-state (title AnswerDodgeDMNIGLH)
                     (state final))))

(defrule conclusions-fake-is-fine ""

   (logical (real-speed-or-just-feels-speedy FakeIsFine))

   =>

   (assert (UI-state (title AnswerDatsun510)
                     (state final))))





(defrule no-repairs ""
	(declare (salience -10))
	(logical
		(UI-state (id ?id))
	)
	(state-list
		(current ?id)
	)
	=>
	(assert (UI-state
		(title "Suggested Repair: Take your car to a mechanic.")
		(state final)
	))
)

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
