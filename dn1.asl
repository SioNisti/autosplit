/*
made by SioN.
edit: 12/2/22
siontea.com

huge thanks to Rincewind from the Prince of Persia discord
for explaining to me how to get pointers with DOSbox


This autosplitter is usable like this but needs adjustement for start{}
and the last split is when proton dies instead of when the screen goes black


	Level ID or something______
	Corridor: 0
	Level 1:  4
	Level 2:  2
	Level 3:  4
	Level 4:  3
	Level 5:  36
	Level 6:  2
	Level 7:  5570573
	Level 8:  1441798
	Level 9:  4
	Level 10: 1572868
	
	Proton's health______
	662784(Full)
	597248
	531712
	466176
	400640
	335104
	269568
	204032
	138496
	72960(Dead)
	*/
	
	
state("DOSBOX")
{
    int points : "DOSBox.exe", 0x193C370, 0x20148;
    //int health : "DOSBox.exe", 0x193C370, 0x0001E724;
    int level : "DOSBox.exe", 0x193C370, 0x00019E08;
    int ProtonHealth : "DOSBox.exe", 0x193C370, 0x00026990;
}

startup {
	vars.timerModel = new TimerModel { CurrentState = timer };
	Action<string> Debug = (text) => { print("[DUKE NUKEM 1 E1] " + text); };
	vars.Debug = Debug;
	vars.Debug("Initialized!");
}

update {
	vars.Debug(current.ProtonHealth+"");
}

init {
	vars.pos = 0; //stores your point value on split
}

start {
	if (old.level < 4 && current.level != 0) {
		//vars.Debug(old.level+" < 4 && "+old.level+" != 2031621 === "+(bool)(old.level < 4 && current.level != 2031621));
		return true;
	}
}

split {
	if (vars.pos < current.points) {
		if (old.level == 4 && current.level == 0) {
			vars.pos = current.points;
			return true;
		}
		else if (old.level == 2 && current.level == 0) {
			vars.pos = current.points;
			return true;
		}
		else if (old.level == 34 && current.level == 0) {
			vars.pos = current.points;
			return true;
		}
		else if (old.level == 3 && current.level == 0) {
			vars.pos = current.points;
			return true;
		}
		else if (old.level == 36 && current.level == 0) {
			vars.pos = current.points;
			return true;
		}
		else if (old.level == 5570573 && current.level == 0) {
			vars.pos = current.points;
			return true;
		}
		else if (old.level == 1441798 && current.level == 0) {
			vars.pos = current.points;
			return true;
		}
		else if (old.level == 1572868 && current.level == 0 ) {
			vars.pos = current.points;
			return true;
		}
		else if (old.ProtonHealth == 138496 && current.ProtonHealth == 72960 ) {
			return true;
		} 
	}
}

onReset {
	vars.pos = 0;
}

exit {
	vars.timerModel.Reset();
}
