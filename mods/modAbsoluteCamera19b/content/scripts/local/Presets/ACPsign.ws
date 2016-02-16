// Generated File on 16/12/2015 22:12:03
//#############################
//
// pMarK - 2016
// Absolute Camera - Preset
//
//#############################
// Cam State: Sign Channeling

class CACPsign {

	private var acpX, acpY, acpZ : float;
	private var author, presetState : string;

	default acpX = 0.00f;
	default acpY = 0.00f;
	default acpZ = 0.00f;

	default author = "[Generated]";

	default presetState = "Sign Channeling";

	public function acGetVector() : Vector 
	{ 
		return Vector( acpX, acpY, acpZ ); 
	}

	public function acGetStatus() : string 
	{ 
		return presetState + " Preset by " + author + ", (X = " + acpX + ", Y = " + acpY + ", Z = " + acpZ + ")" ; 
	}

}