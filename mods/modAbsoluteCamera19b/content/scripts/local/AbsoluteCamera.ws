//#############################
//
// pMarK - 2016
// Absolute Camera 1.9.x
//
//#############################

enum EACSTATE {
	ACSTATE_Exploration,
	ACSTATE_Meditation,
	ACSTATE_Clue,
	ACSTATE_Sprint,
	ACSTATE_Combat,
	ACSTATE_CombatFists,
	ACSTATE_Aim,
	ACSTATE_CombatSign,
	ACSTATE_CombatLocked,
	ACSTATE_Horse,
	ACSTATE_HorseCombat,
	ACSTATE_Boat,
	ACSTATE_Interiors,
	ACSTATE_WitcherSenses,
	ACSTATE_WitcherSensesInteriors,
	ACSTATE_Swimming,
	ACSTATE_NoState
}

enum EACMODE {
	ACMODE_OFF,
	ACMODE_Normal,
	ACMODE_Preset,
	ACMODE_Unlocked
}

class CAbsoluteCamera {
	
	private var inGameConfigWrapper : CInGameConfigWrapper;
	
	private var mACManager : CACManager;
	
	//Enums
	private var acCamState : EACSTATE;
	private var acCamMode : EACMODE;
	
	public function InitAC()
	{
		inGameConfigWrapper = theGame.GetInGameConfigWrapper();
		
		mACManager = new CACManager in this;
		mACManager.initACManager();
		
		acSetupInputs();
		
		acSetupFOV( ACSTATE_Exploration, 'ACexp' );
		acSetupFOV( ACSTATE_Meditation, 'ACmed' );
		acSetupFOV( ACSTATE_Clue, 'ACclue' );
		acSetupFOV( ACSTATE_Sprint, 'ACsprint' );
		acSetupFOV( ACSTATE_Combat, 'ACcbt' );
		acSetupFOV( ACSTATE_CombatFists, 'ACfist' );
		acSetupFOV( ACSTATE_Aim, 'ACaim' );
		acSetupFOV( ACSTATE_CombatSign, 'ACsign' );
		acSetupFOV( ACSTATE_CombatLocked, 'AClck' );
		acSetupFOV( ACSTATE_Horse, 'AChorse' );
		acSetupFOV( ACSTATE_HorseCombat, 'AChorseCbt' );
		acSetupFOV( ACSTATE_Boat, 'ACboat' );
		acSetupFOV( ACSTATE_Interiors, 'ACint' );
		acSetupFOV( ACSTATE_WitcherSenses, 'ACws' );
		acSetupFOV( ACSTATE_WitcherSensesInteriors, 'ACwsInt' );
		acSetupFOV( ACSTATE_Swimming, 'ACswim' );
	}

	//#################################
	//	Bools
	//#################################	
	public function acGetBool( boolname : name ) : bool
	{
		var value : bool;
		
		switch(boolname)
		{
			case 'zCtrlExp' :			value = inGameConfigWrapper.GetVarValue('ACexp', 'ACexpZoomCtrl'); 			break;
			case 'zCtrlCbt' :			value = inGameConfigWrapper.GetVarValue('ACcbt', 'ACcbtZoomOutCtrl'); 		break;
			case 'zCtrlBoat' :			value = inGameConfigWrapper.GetVarValue('ACboat', 'ACboatZoomCtrl'); 		break;
			case 'medCamForPoP' : 		value = inGameConfigWrapper.GetVarValue('ACmed', 'ACexpMedForPoPON'); 		break;
			case 'FistUseCbtCam' :		value = inGameConfigWrapper.GetVarValue('ACfist', 'ACFistUseCbtCamON'); 	break;
			case 'isSprint' : 			value = thePlayer.IsSprintActionPressed(); 									break;
		}
		
		return value;
	}
	
	//#################################
	//	Get Cam State
	//#################################	
	public function GetCamState() : EACSTATE
	{ 
		var horseComp : W3HorseComponent;
		var cam : EACSTATE;
	
		if( thePlayer.GetCurrentStateName() == 'AimThrow' )
			cam = ACSTATE_Aim;
		else if( thePlayer.IsCurrentSignChanneled() && thePlayer.GetCurrentlyCastSign() != ST_Quen && thePlayer.GetCurrentlyCastSign() != ST_Yrden )
			cam = ACSTATE_CombatSign;
		else if( thePlayer.GetCurrentStateName() == 'ExplorationMeditation' || ( thePlayer.GetPlayerAction() == PEA_Meditation && acGetBool( 'medCamForPoP' ) ) )
			cam = ACSTATE_Meditation;
		else if( thePlayer.GetPlayerAction() == PEA_ExamineGround )
			cam = ACSTATE_Clue;
		else if( thePlayer.IsSwimming() )
			cam = ACSTATE_Swimming;
		else if (thePlayer.GetCurrentStateName() == 'HorseRiding')
		{
			if(thePlayer.IsInCombat())
				cam = ACSTATE_HorseCombat;
			else
				cam = ACSTATE_Horse;
		}
		else if( thePlayer.GetCurrentStateName() == 'Sailing' )
			cam = ACSTATE_Boat;
		else if (theGame.IsFocusModeActive())
		{
			if (thePlayer.IsInInterior())
				cam = ACSTATE_WitcherSensesInteriors;
			else
				cam = ACSTATE_WitcherSenses;
		}
		else if( thePlayer.IsInInterior() && !thePlayer.IsInCombat())
			cam = ACSTATE_Interiors;
		else if( thePlayer.GetCurrentStateName() == 'TraverseExploration' )
			cam = ACSTATE_Exploration;
		else if (thePlayer.GetCurrentStateName() == 'Exploration' )
		{
			if (acGetBool('isSprint') && acGetACMode(ACSTATE_Sprint) != ACMODE_OFF)
				cam = ACSTATE_Sprint;
			else
				cam = ACSTATE_Exploration;
		}
		else if (thePlayer.IsInCombat())
		{
			if (thePlayer.IsInCombatFist())
				cam = ACSTATE_CombatFists;
			else if (thePlayer.IsCameraLockedToTarget())
				cam = ACSTATE_CombatLocked;
			else
				cam = ACSTATE_Combat;
		}
		else
			cam = ACSTATE_NoState;
		
		return cam;
	}
	
	//#################################
	//	Get Cam Mode
	//#################################
	public function acGetACMode( optional acCamState : EACSTATE ) : EACMODE
	{
		var varValue : Int32;
		var mode : EACMODE;
		
		if(acCamState == 0)
			acCamState = GetCamState();
		
		switch( acCamState )
		{
			case ACSTATE_Exploration : 				varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACexp', 'acMode' ) ); 		break;
			case ACSTATE_Meditation :				varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACmed', 'acMode' ) ); 		break;
			case ACSTATE_Clue : 					varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACclue', 'acMode' ) ); 		break;
			case ACSTATE_Sprint :					varValue = StringToInt(	inGameConfigWrapper.GetVarValue( 'ACsprint', 'acMode' ) ); 		break;
			case ACSTATE_Combat :					varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACcbt', 'acMode' ) ); 		break;
			case ACSTATE_CombatFists : 				varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACfist', 'acMode' ) ); 		break;
			case ACSTATE_Aim :						varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACaim', 'acMode' ) ); 		break;
			case ACSTATE_CombatSign : 				varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACsign', 'acMode' ) ); 		break;
			case ACSTATE_CombatLocked :				varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'AClck', 'acMode' ) ); 		break;
			case ACSTATE_Horse : 					varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'AChorse', 'acMode' ) ); 		break;
			case ACSTATE_HorseCombat :				varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'AChorseCbt', 'acMode' ) ); 	break;
			case ACSTATE_Boat : 					varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACboat', 'acMode' ) ); 		break;
			case ACSTATE_Interiors :				varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACint', 'acMode' ) ); 		break;
			case ACSTATE_WitcherSenses : 			varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACws', 'acMode' ) ); 			break;
			case ACSTATE_WitcherSensesInteriors :	varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACwsInt', 'acMode' ) ); 		break;
			case ACSTATE_Swimming :					varValue = StringToInt( inGameConfigWrapper.GetVarValue( 'ACswim', 'acMode' ) ); 		break;
		}
		
		if( varValue < 0 || varValue > 3 )
			varValue = 0;
		
		switch(varValue)
		{
			case 0 : mode = ACMODE_OFF; 		break;
			case 1 : mode = ACMODE_Normal; 		break;
			case 2 : mode = ACMODE_Preset; 		break;
			case 3 : mode = ACMODE_Unlocked; 	break;
		}
		
		return mode;
	}
	
	//#################################
	//	FOV
	//#################################
	public function acFinalGetFOV( acState : EACSTATE ) : float
	{
		var fFOV : float;
		
		switch( acState )
		{
			case ACSTATE_Exploration : 				fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACexp', 'ACFOV' ) ); 		break;
			case ACSTATE_Meditation :				fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACmed', 'ACFOV' ) ); 		break;
			case ACSTATE_Clue : 					fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACclue', 'ACFOV' ) ); 		break;
			case ACSTATE_Sprint : 					fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACsprint', 'ACFOV' ) ); 	break;
			case ACSTATE_Combat :					fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACcbt', 'ACFOV' ) ); 		break;
			case ACSTATE_CombatFists : 				fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACfist', 'ACFOV' ) ); 		break;
			case ACSTATE_Aim :						fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACaim', 'ACFOV' ) ); 		break;
			case ACSTATE_CombatSign : 				fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACsign', 'ACFOV' ) ); 		break;
			case ACSTATE_CombatLocked :				fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'AClck', 'ACFOV' ) ); 		break;
			case ACSTATE_Horse : 					fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'AChorse', 'ACFOV' ) ); 		break;
			case ACSTATE_HorseCombat :				fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'AChorseCbt', 'ACFOV' ) ); 	break;
			case ACSTATE_Boat : 					fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACboat', 'ACFOV' ) ); 		break;
			case ACSTATE_Interiors :				fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACint', 'ACFOV' ) ); 		break;
			case ACSTATE_WitcherSenses : 			fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACws', 'ACFOV' ) ); 		break;
			case ACSTATE_WitcherSensesInteriors :	fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACwsInt', 'ACFOV' ) ); 		break;
			case ACSTATE_Swimming :					fFOV = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACswim', 'ACFOV' ) ); 		break;
		}
		
		return fFOV;
	}
	
	public function acSetupFOV( acState : EACSTATE, groupName : name )
	{
		var fFOV : float;
		
		fFOV = acFinalGetFOV( acState );
		
		if( fFOV < 50.0 || fFOV > 80.0 )
		{
			inGameConfigWrapper.SetVarValue( groupName, 'ACFOV', 70.0);
			theGame.SaveUserSettings();
		}
	}
	
	//#################################
	//	Get Vector
	//#################################
	public function acFinalGetVector( acState : EACSTATE ) : Vector
	{
		var fVector : Vector;
		
		acCamMode = acGetACMode();
		
		fVector = mACManager.acGetManagedVector( acState , acCamMode );
		
		return fVector;
	}
	
	//#################################
	//	Get Auto-Center Mode
	//#################################
	public function acGetACautoCenter() : Int32 
	{ 
		var ACautoCenter : Int32;
	
		ACautoCenter = StringToInt(inGameConfigWrapper.GetVarValue('ACautoCenterPitch', 'ACautoCenter'));
		
		if( ACautoCenter < 0 || ACautoCenter > 2 )
		{
			inGameConfigWrapper.SetVarValue( 'ACautoCenterPitch', 'ACautoCenter', 0);
			theGame.SaveUserSettings();
		}
		
		return ACautoCenter; 
	}
	
	//#################################
	//	Pitch Options
	//#################################
	public function acGetPitchOptions() : Int32 
	{ 
		var pitchMode : Int32;
	
		pitchMode = StringToInt(inGameConfigWrapper.GetVarValue('ACautoCenterPitch', 'ACpitchOptions'));
		
		if( pitchMode < 0 || pitchMode > 2 )
		{
			inGameConfigWrapper.SetVarValue( 'ACautoCenterPitch', 'ACpitchOptions', 2);
			theGame.SaveUserSettings();
		}
		
		return pitchMode; 
	}
	
	public function acGetPitchValues( desiredValue : name ) : float
	{
		var value : float;
		
		switch( desiredValue )
		{
			case 'desiredPitch' :
				value = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACautoCenterPitch', 'ACdesiredPitch' ) );
				if(value < -80.0f || value > 80.0f)
				{
					theGame.GetInGameConfigWrapper().SetVarValue( 'ACautoCenterPitch', 'ACdesiredPitch', -80.0 );
					theGame.SaveUserSettings();
				}
			break;
			
			case 'minPitch' : 		
				value = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACautoCenterPitch', 'ACminPitch' ) ); 		
				if(value < -80.0f || value > -10.0f)
				{
					theGame.GetInGameConfigWrapper().SetVarValue( 'ACautoCenterPitch', 'ACminPitch', -60.0 );
					theGame.SaveUserSettings();
				}
			break;
			
			case 'maxPitch' : 		
				value = StringToFloat( inGameConfigWrapper.GetVarValue( 'ACautoCenterPitch', 'ACmaxPitch' ) ); 		
				if(value < 10.0f || value > 80.0f)
				{
					theGame.GetInGameConfigWrapper().SetVarValue( 'ACautoCenterPitch', 'ACmaxPitch', 60.0 );
					theGame.SaveUserSettings();
				}
			break;
		}
		
		return value;
	}
	
	//#################################
	//	Inputs
	//#################################
	private function acSetupInputs()
	{
		theInput.RegisterListener( this, 'OnCommACFreeCam', 'ACFreeCamONOFF' );
		theInput.RegisterListener( this, 'OnCommRGTCheckStatus', 'RGTcheckOffsets' );
		theInput.RegisterListener( this, 'OnCommRGTShoulderToggle', 'RGTShoulderToggle' );
		theInput.RegisterListener( this, 'OnCommRGTAddOffsetX', 'RGTAddOffsetX' );
		theInput.RegisterListener( this, 'OnCommRGTAddOffsetY', 'RGTAddOffsetY' );
		theInput.RegisterListener( this, 'OnCommRGTAddOffsetZ', 'RGTAddOffsetZ' );	
		theInput.RegisterListener( this, 'OnCommRGTRemOffsetX', 'RGTRemOffsetX' );
		theInput.RegisterListener( this, 'OnCommRGTRemOffsetY', 'RGTRemOffsetY' );
		theInput.RegisterListener( this, 'OnCommRGTRemOffsetZ', 'RGTRemOffsetZ' );
		theInput.RegisterListener( this, 'OnCommRGTsaveCamera', 'RGTsaveCamera' );
		theInput.RegisterListener( this, 'OnCommACGameStateDebug', 'ACGameStateDebug' );
		theInput.RegisterListener( this, 'OnCommACResetCamera', 'ACResetCamera' );
	}
	
	event OnCommACResetCamera(action:SInputAction)
	{
		if(IsPressed(action))
		{
			mACManager.acReset(GetCamState());
		}
	}
	
	event OnCommACFreeCam( action:SInputAction )
	{
		var isFreeCamON : bool;
		
		isFreeCamON = theGame.IsFreeCameraEnabled();
		
		if( IsPressed( action ) )
		{
			theGame.EnableFreeCamera( !isFreeCamON );
		}
	}

	event OnCommRGTCheckStatus( action:SInputAction )
	{
		var msg : string;
		
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			msg = mACManager.acGetManagedStatus( acCamState, acCamMode );
			
			thePlayer.DisplayHudMessage(msg);
		}
	}
	
	event OnCommRGTShoulderToggle( action:SInputAction )
	{	
		if(IsPressed(action))
		{
			mACManager.acToggleShoulder();
		}
	}
	
	event OnCommRGTAddOffsetX( action:SInputAction )
	{
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			mACManager.acManagedMath( acCamState, acCamMode, 'X', 'plus' );
		}
	}
	
	event OnCommRGTAddOffsetY( action:SInputAction )
	{
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			mACManager.acManagedMath( acCamState, acCamMode, 'Y', 'plus' );
		}
	}
	
	event OnCommRGTAddOffsetZ( action:SInputAction )
	{
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			mACManager.acManagedMath( acCamState, acCamMode, 'Z', 'plus' );
		}
	}
	
	event OnCommRGTRemOffsetX( action:SInputAction )
	{
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			mACManager.acManagedMath( acCamState, acCamMode, 'X', 'minus' );
		}
	}
	
	event OnCommRGTRemOffsetY( action:SInputAction )
	{
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			mACManager.acManagedMath( acCamState, acCamMode, 'Y', 'minus' );
		}
	}
	
	event OnCommRGTRemOffsetZ( action:SInputAction )
	{
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			mACManager.acManagedMath( acCamState, acCamMode, 'Z', 'minus' );
		}
	}
	
	event OnCommRGTsaveCamera( action:SInputAction )
	{
		acCamState = GetCamState();
		acCamMode = acGetACMode();
		
		if( IsPressed( action ) )
		{
			mACManager.acManagedAskForSave( acCamState, acCamMode );
		}
	}
	
	event OnCommACGameStateDebug( action:SInputAction )
	{
		if( IsPressed( action ) )
		{
			thePlayer.DisplayHudMessage("Game State: " + thePlayer.GetCurrentStateName() + ", AC: " + GetCamState() + ", Player Action: " + thePlayer.GetPlayerAction() );
		}
	}
}