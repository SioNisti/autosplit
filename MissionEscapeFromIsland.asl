/*
made by SioN.
edit: 26/2/22
siontea.com  
*/

state("MissionEscapeFromIsland") {
	  //no clue what this is but its always 0 during loading and 1 during gameplay so it works
    //note that dying also splits (twice)
    int thing : "MissionEscapeFromIsland.exe", 0x011060C8, 0x20, 0x668, 0x10, 0x90, 0x20, 0x0, 0x2E4;
}

startup
{
	vars.timerModel = new TimerModel { CurrentState = timer };
	Action<string> Debug = (text) => { print("[MEFI] " + text); };
	vars.Debug = Debug;
	vars.Debug("Initialized!");
	settings.Add("rl", false, "Remove Loads");
}

update
{
	if (old.thing != current.thing) {
		vars.Debug(current.thing + " " + vars.times);
	}
}

start {
	if (old.thing == 1 && current.thing == 0) {
		return true;
	}
}

split {
	if (old.thing == 1 && current.thing == 0) {
		if(vars.times != 0) {
			return true;
		} else {
			vars.times++;
		}
	}
}

init {
	vars.times = 0;
}

onReset {
	vars.times = 0;
}

isLoading {
	if (settings["rl"]) {
		if (current.thing == 0) {
			return true;
		}
		else {
			return false;
		}
	}
}

exit
{
	vars.timerModel.Reset();
}
