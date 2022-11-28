/*
made by SioN.
edit: 28/11/22
siontea.com
*/

state("RoboRumble") {
    int loadscr : "RoboRumble.exe", 0x003B7678, 0x464;
    int curlap : "RoboRumble.exe", 0x0038EF78, 0x64;
    int lapcount : "RoboRumble.exe", 0x0038EF78, 0x68;
}

isLoading{
	if (current.loadscr == 131075) {
		return true;
	} else {
		return false;
	}
}

start {
	if (current.loadscr == 131075) {
		return true;
	}
}

split {
	if (old.curlap == current.lapcount && current.curlap == current.lapcount + 1) {
		return true;
	}
	if (old.curlap == 1 && current.curlap == 10) {
		return true;
	}
}
