//#############################
//
// pMarK - 2016
// Absolute Camera 1.9.x
// Main Manager
//
//#############################

class CACManager {
	
	private var inGameConfigWrapper : CInGameConfigWrapper;
	
	//Shoulder Toggle
	private var isShoulderToggled : bool; default isShoulderToggled = false;
	
	//Classes
	private var mACNormalManager : CACNormalManager;
	private var mACPresetManager : CACPresetManager;
	private var mACUnlockedManager : CACUnlockedManager;
	
	public function initACManager()
	{
		inGameConfigWrapper = theGame.GetInGameConfigWrapper();
		
		mACNormalManager = new CACNormalManager in this;
		mACPresetManager = new CACPresetManager in this;
		mACUnlockedManager = new CACUnlockedManager in this;
		
		mACNormalManager.iniNormalManager();
		mACPresetManager.iniPresetManager();
		mACUnlockedManager.iniUnlockedManager();
	}
	
	// Get Vector
	public function acGetManagedVector( acState : EACSTATE, acMode : EACMODE ) : Vector
	{
		var acManVector : Vector;
		
		switch( acMode )
		{
			case ACMODE_Normal :	acManVector = mACNormalManager.acGetNVec( acState );	break;
			case ACMODE_Preset :	acManVector = mACPresetManager.acGetPVec( acState );	break;
			case ACMODE_Unlocked :	acManVector = mACUnlockedManager.acGetUVec( acState );	break;
		}
		
		if( GetisShoulderToggled() )
			return Vector( acManVector.X*-1, acManVector.Y, acManVector.Z );
		else
			return acManVector;
	}
	
	// Get Status
	public function acGetManagedStatus( acState : EACSTATE, acMode : EACMODE ) : string
	{
		var msg : string;
		
		switch( acMode )
		{
			case ACMODE_OFF : 		msg = "Camera is OFF";								break;
			case ACMODE_Normal :	msg = mACNormalManager.acGetNStatus( acState );		break;
			case ACMODE_Preset :	msg = mACPresetManager.acGetPStatus( acState );		break;
			case ACMODE_Unlocked :	msg = mACUnlockedManager.acGetUStatus( acState );	break;
		}
		
		if( GetisShoulderToggled() && acMode != ACMODE_OFF )
			return msg += ", Shoulder Toggled";
		else
			return msg;
	}
	
	// Math Offsets
	public function acManagedMath( acState : EACSTATE, acMode : EACMODE, axis : name, dowhat : name )
	{
		switch( acMode )
		{
			case ACMODE_OFF : 		thePlayer.DisplayHudMessage("Can't do that. Camera is OFF");						break;
			case ACMODE_Normal :	thePlayer.DisplayHudMessage("Can't do that with the camera mode set to Normal");	break;
			case ACMODE_Preset :	thePlayer.DisplayHudMessage("Can't do that. You're using a preset");				break;
			case ACMODE_Unlocked :	mACUnlockedManager.acMathUnlocked( acState, axis, dowhat );							break;
		}
	}
	
	// Save Camera
	public function acManagedAskForSave( acState : EACSTATE, acMode : EACMODE )
	{
		switch( acMode )
		{
			case ACMODE_OFF : 		thePlayer.DisplayHudMessage("Can't do that. Camera is OFF");						break;
			case ACMODE_Normal :	thePlayer.DisplayHudMessage("Can't do that with the camera mode set to Normal");	break;
			case ACMODE_Preset :	thePlayer.DisplayHudMessage("Can't do that. You're using a preset");				break;
			case ACMODE_Unlocked :	mACUnlockedManager.acUnlockedSaveCam( acState );									break;
		}
	}
	
	// Reset Camera
	public function acReset(acState : EACSTATE)
	{
		mACUnlockedManager.acResetCamera(acState);
	}
	
	// Handling Shoulder Toggle
	private function GetisShoulderToggled() : bool { return isShoulderToggled; }
	public function acToggleShoulder() { isShoulderToggled = !GetisShoulderToggled(); }
}