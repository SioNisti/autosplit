/*
made by SioN.
edit: 11/2/22
siontea.com
*/

state("mission117") {
	
	/*
	all level numbers are preceded by 44 eg level 2 is 442
	splash screen: 4499
	clicking a difficulty: 440
	screen 1: 441
	screen 2: 442
	screen 3: 443
	screen 4: 444
	screen 5: 445
	screen 6 (cat boss): 446
	cutscene: 447
	credits 1: 448
	final level: 449
	card boss: 4410
	credits 2: 4411
	*/
	int level : 0x000AC9AC, 0x268, 0x1C8;
	
	//achivements
	//0 = not gotten
	//44 = gotten
	int ach1 : 0x000AC9AC, 0x268, 0x1D8; //bomb
	int ach2 : 0x000AC9AC, 0x268, 0x1E8; //gun
	int ach3 : 0x000AC9AC, 0x268, 0x2F8; //pacifist
	int ach4 : 0x000AC9AC, 0x268, 0x208; //cat1
	int ach5 : 0x000AC9AC, 0x268, 0x218; //cat2
	int ach6 : 0x000AC9AC, 0x268, 0x228; //card1
	int ach7 : 0x000AC9AC, 0x268, 0x238; //card2
	int ach8 : 0x000AC9AC, 0x268, 0x248; //all
}

startup {
	vars.timerModel = new TimerModel { CurrentState = timer };
	Action<string> Debug = (text) => { print("[mission117] " + text); };
	vars.Debug = Debug;
	vars.Debug("Initialized!");
	
	settings.Add("aa", true, "All Achievements");
	settings.SetToolTip("aa", "Splits in order:\neasy cat\nhard cat\nhard cards\nenter final level\neasy cards\ndeath on bomb");
	settings.Add("cat", false, "Cat");
	settings.SetToolTip("cat", "Splits after every room");
	settings.Add("card", false, "Card");
	settings.SetToolTip("card", "Splits after every room");
}

start {
	//change to 4499 and 440 if you want to start the time on clicking a difficulty instead of loading in
	if (old.level == 440 && current.level == 441) {
		vars.Debug("start!");
		return true;
	}
}

split {
	if (settings["aa"]) {
		if (old.ach4 == 0 && current.ach4 == 44) {
			vars.Debug("cat1");
			return true;
		}
		else if (old.ach5 == 0 && current.ach5 == 44) {
			vars.Debug("cat2");
			return true;
		}
		else if (old.ach7 == 0 && current.ach7 == 44) {
			vars.Debug("card2");
			return true;
		}
		else if (old.level == 446 && current.level == 449 && current.ach7 == 44) {
			vars.Debug("cat1 2");
			return true;
		}
		else if (old.ach6 == 0 && current.ach6 == 44) {
			vars.Debug("card1");
			return true;
		}
		else if (old.ach1 == 0 && current.ach1 == 44) {
			vars.Debug("bomb");
			return true;
		} else {
			return false;
		}
	} 
	else if (settings["cat"] || settings["card"]) {
		if (old.level < current.level && current.level != 4499 && current.level != 441 && current.level != 447) {
			return true;
		} else {
			return false;
		}
	}
	else {
		return false;
	}
}

reset {
	if (old.level == 4499 && current.level == 4499) {
		return true;
	}
}

exit {
	vars.timerModel.Reset();
}
