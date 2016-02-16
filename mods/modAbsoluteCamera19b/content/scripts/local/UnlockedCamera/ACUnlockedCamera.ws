//#############################
//
// pMarK - 2016
// Absolute Camera 1.9.x
// Camera : Unlocked Camera
//
//#############################

class CACUcam {
	
	private var acX, acY, acZ : float;
	public var camName : string;
	public var groupName : name;
	
	// Get Vector
	public function acGetVector() : Vector 
	{ 
		return Vector( acX, acY, acZ ); 
	}
	
	// Math
	public function acMath( axis : name, dowhat : name, amount : float )
	{
		switch( axis )
		{
			case 'X' :
				if( dowhat == 'plus' )
					acX += amount;
				else if( dowhat == 'minus' )
					acX -= amount;
			break;
			
			case 'Y' :
				if( dowhat == 'plus' )
					acY += amount;
				else if( dowhat == 'minus' )
					acY -= amount;
			break;
			
			case 'Z' :
				if( dowhat == 'plus' )
					acZ += amount;
				else if( dowhat == 'minus' )
					acZ -= amount;
			break;
		}
	}
	
	// Initial Setup
	public function acInitSetup()
	{
		acX = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue( groupName, 'ACOffsetX' ));
		acY = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue( groupName, 'ACOffsetY' ));
		acZ = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue( groupName, 'ACOffsetZ' ));
	}
	
	// Save Camera
	public function acSaveCam()
	{
		theGame.GetInGameConfigWrapper().SetVarValue( groupName, 'ACOffsetX', acX );
		theGame.GetInGameConfigWrapper().SetVarValue( groupName, 'ACOffsetY', acY );
		theGame.GetInGameConfigWrapper().SetVarValue( groupName, 'ACOffsetZ', acZ );
		theGame.SaveUserSettings();
	}
	
	// Get Status
	public function acGetStatus() : string
	{
		var msg : string;
		
		msg = camName + ", ( X=" + acX+ ", Y=" + acY + ", Z=" + acZ + " )";
		
		return msg;
	}
}