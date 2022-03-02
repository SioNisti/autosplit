/*
made by SioN.
edit: 28/2/22
siontea.com  
*/

state("CATWOMAN") {
	bool start : 0x14C17C, 0x38, 0x7DC;
	bool inresults : 0x8D4C4, 0x28;
	float bosshealth : 0x17F3E4, 0xB0, 0x1C4, 0x194;
}

startup {
	vars.timerModel = new TimerModel { CurrentState = timer };
	vars.Debug = (Action<object>)(text => print("[cw] " + text));
	vars.Debug("Initialized!");
}

start {
	if (!old.start && current.start) {
		vars.Debug(old.start + " / " +current.start);
		return true;
	}
}

split {
	if (!old.inresults && current.inresults) {
		vars.Debug(old.inresults + " / " +current.inresults);
		return true;
	}

	if (timer.CurrentSplitIndex == timer.Run.Count - 1 && current.bosshealth == 0 && old.bosshealth >= 1 && old.bosshealth <= 25) {
		vars.Debug(old.bosshealth + " / " +current.bosshealth);
		return true;
	}
}

exit {
	vars.timerModel.Reset();
}
