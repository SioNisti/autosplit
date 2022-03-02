/*
made by SioN.
edit: 28/2/22
siontea.com  
*/

state("CATWOMAN") {
    bool start : "CATWOMAN.exe", 0x0014C17C, 0x38, 0x7DC;
    bool inresults : "CATWOMAN.exe", 0x0008D4C4, 0x28;
    float bosshealth : "CATWOMAN.exe", 0x0017F3E4, 0xB0, 0x1C4, 0x194;
}

startup {
	vars.timerModel = new TimerModel { CurrentState = timer };
	Action<string> Debug = (text) => { print("[cw] " + text); };
	vars.Debug = Debug;
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
