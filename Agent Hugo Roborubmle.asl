/*
made by SioN.
edit: 29/11/22
siontea.com
*/

state("RoboRumble") {
    int loadscr : "RoboRumble.exe", 0x003B7678, 0x464;
    int curlap : "RoboRumble.exe", 0x0038EF78, 0x64;
    int lapcount : "RoboRumble.exe", 0x0038EF78, 0x68;
    int igt : "RoboRumble.exe", 0x0038EF78, 0x88;
}

startup {
	settings.Add("igt", false, "IL autosplit + IGT");
	vars.timerModel = new TimerModel { CurrentState = timer };
	Action<string> Debug = (text) => { print("[ahrr] " + text); };
	vars.Debug = Debug;
	vars.Debug("Initialized!");
}

isLoading{
	if (!settings["igt"]) {
		if (current.loadscr == 131075) {
			return true;
		} else {
			return false;
		}
	} else {
		return true;
	}
}

gameTime{
	if (settings["igt"]) {
		vars.Debug(current.igt+"");
		return TimeSpan.FromMilliseconds(System.Convert.ToDouble(current.igt));
	}
}

start {
	if (settings["igt"]) {
		if (current.igt > 0 && current.curlap != 10 && current.curlap != current.lapcount+1) {
			return true;
		}
	} else if (current.loadscr == 131075) {
		return true;
	}
}

reset {
	if (settings["igt"]) {
		if (current.loadscr == 131075) {
			return true;
		}
	}
}

split {
	if (settings["igt"]) {
		if (old.curlap == current.curlap-1) {
			return true;
		}
		if (old.curlap == 1 && current.curlap == 10) {
			return true;
		}
	} else {
		if (old.curlap == current.lapcount && current.curlap == current.lapcount + 1) {
			return true;
		}
		if (old.curlap == 1 && current.curlap == 10) {
			return true;
		}
	}
}
