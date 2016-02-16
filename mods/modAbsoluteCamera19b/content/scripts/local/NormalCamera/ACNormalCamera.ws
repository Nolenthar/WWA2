//#############################
//
// pMarK - 2016
// Absolute Camera 1.9.x
// Camera : Normal Camera
//
//#############################

class CACNcam {
	
	private var acX, acY, acZ : float;
	public var camName : string;
	
	// Get Locked Camera
	public function acGetVector( groupName : name ) : Vector
	{
		acX = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue( groupName, 'ACOffsetX' ));
		acY = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue( groupName, 'ACOffsetY' ));
		acZ = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue( groupName, 'ACOffsetZ' ));
		
		return Vector( acX, acY, acZ );
	}
	
	// Get Status
	public function acGetStatus() : string
	{
		var msg : string;
		
		msg = camName + ", ( X=" + acX+ ", Y=" + acY + ", Z=" + acZ + " )";
		
		return msg;
	}
}