/*
made by SioN.
edit: 27/2/22
siontea.com  
*/

state("HellCat") {
    int level : "HellCat.exe", 0x000FFF00, 0x0;
}

startup {
	vars.timerModel = new TimerModel { CurrentState = timer };
	Action<string> Debug = (text) => { print("[hc] " + text); };
	vars.Debug = Debug;
	vars.Debug("Initialized!");
}

update {
	/*if (old.level != current.level) {
		vars.Debug(old.level + " / " +current.level);
	}*/
}

start {
	if (old.level == 6 && current.level == 8) {
		vars.Debug(old.level + " / " +current.level);
		return true;
	}
}

split {
	if (old.level > 6 && current.level != 14 && current.level != 15 && current.level != 19 && current.level != 20 && current.level != 24 && current.level != 25) {
		if (old.level < current.level) {
			vars.Debug(old.level + " / " +current.level);
			return true;
		}
	}
}

reset {
	if (current.level == 6) {
		vars.Debug(old.level + " / " +current.level);
		return true;
	}
}

exit {
	vars.timerModel.Reset();
}
