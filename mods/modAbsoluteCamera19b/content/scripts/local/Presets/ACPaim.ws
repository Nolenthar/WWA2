// Generated File on 16/12/2015 22:11:37
//#############################
//
// pMarK - 2016
// Absolute Camera - Preset
//
//#############################
// Cam State: Aim

class CACPaim {

	private var acpX, acpY, acpZ : float;
	private var author, presetState : string;

	default acpX = 0.30f;
	default acpY = 2.10f;
	default acpZ = 0.10f;

	default author = "[Generated]";

	default presetState = "Aim";

	public function acGetVector() : Vector 
	{ 
		return Vector( acpX, acpY, acpZ ); 
	}

	public function acGetStatus() : string 
	{ 
		return presetState + " Preset by " + author + ", (X = " + acpX + ", Y = " + acpY + ", Z = " + acpZ + ")" ; 
	}

}