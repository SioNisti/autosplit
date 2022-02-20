/*
made by SioN.
edit: 20/2/22
siontea.com
*/

state("Drift86 V3") {}

startup
{
	vars.Log = (Action<object>)(output => print("[d86] " + output));
	vars.Unity = Activator.CreateInstance(Assembly.LoadFrom(@"Components\UnityASL.bin").GetType("UnityASL.Unity"));
	
	settings.Add("laps", false, "Lap Splits");
}

init 
{
	vars.Unity.TryOnLoad = (Func<dynamic, bool>)(helper =>
	{
		var gc = helper.GetClass("Assembly-CSharp", "GameController");
		var re = helper.GetClass("Assembly-CSharp", "RaceEntity");
		var cs = helper.GetClass("Assembly-CSharp", "CarStatistic");
		var pc = helper.GetClass("Assembly-CSharp", "PositioningCar");

		vars.Unity.Make<bool>(gc.Static, gc["Instance"], gc["m_GameIsEnded"]).Name = "gameEnd";
		vars.Unity.Make<bool>(gc.Static, gc["Instance"], gc["m_RaceIsStarted"]).Name = "gameStart";
		vars.Unity.Make<float>(gc.Static, gc["RaceEntity"], re["PlayerStatistics"], cs["TotalRaceTime"] ).Name = "raceTime";
		vars.Unity.Make<int>(gc.Static, gc["RaceEntity"], re["PlayerStatistics"], cs["PositioningCar"], pc["CurrentLap"] ).Name = "currentLap";
		return true;
	});

	vars.Unity.Load(game);
	vars.tt = 0.0f;
}

update
{
	if (!vars.Unity.Loaded) return false;

	vars.Unity.Update();
}

start {
	if (vars.Unity["gameStart"].Current == true && vars.Unity["gameStart"].Old == false && vars.Unity["gameEnd"].Old == false) {
		return true;
	}
}

gameTime{	
	if (vars.Unity["gameEnd"].Current == true && vars.Unity["gameEnd"].Old == false) {
		vars.tt += vars.Unity["raceTime"].Current;
		return TimeSpan.FromSeconds(vars.tt);
	}
}

split {
	if (vars.Unity["gameEnd"].Current == true && vars.Unity["gameEnd"].Old == false) {
		return true;
	}
}

isLoading {
	return true;
}

onReset {
	vars.tt = 0.0f;
}

exit
{
	vars.Unity.Reset();
}

shutdown
{
	vars.Unity.Reset();
}
