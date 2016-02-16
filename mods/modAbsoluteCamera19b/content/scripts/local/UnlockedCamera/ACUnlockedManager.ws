//#############################
//
// pMarK - 2016
// Absolute Camera 1.9.x
// Unlocked Cameras Manager
//
//#############################

class CACUnlockedManager {
	
	private var mACUexp, mACUmed, mACUclue, mACUsprint, mACUcbt, mACUfist, mACUaim, mACUsign, mACUlocked, mACUhorse, mACUhorseCbt, mACUboat, mACUint, mACUws, mACUwsInt, mACUswim : CACUcam;
	
	public function iniUnlockedManager()
	{
		mACUexp = new CACUcam in this;			mACUmed = new CACUcam in this;
		mACUclue = new CACUcam in this;			mACUcbt = new CACUcam in this;
		mACUfist = new CACUcam in this;			mACUaim = new CACUcam in this;
		mACUsign = new CACUcam in this;			mACUlocked = new CACUcam in this;
		mACUhorse = new CACUcam in this;		mACUhorseCbt = new CACUcam in this;
		mACUboat = new CACUcam in this;			mACUint = new CACUcam in this;
		mACUws = new CACUcam in this;			mACUwsInt = new CACUcam in this;
		mACUswim = new CACUcam in this;			mACUsprint = new CACUcam in this;
		
		mACUexp.camName = "Unlocked Exploration"; 						mACUmed.camName = "Unlocked Meditation";
		mACUclue.camName = "Unlocked Clue Investigation"; 				mACUcbt.camName = "Unlocked Combat";
		mACUfist.camName = "Unlocked Fist Fight"; 						mACUaim.camName = "Unlocked Aim";
		mACUsign.camName = "Unlocked Sign";								mACUlocked.camName = "Unlocked Locked to Target";
		mACUhorse.camName = "Unlocked Horse Riding";					mACUhorseCbt.camName = "Unlocked Horse Riding Combat";
		mACUboat.camName = "Unlocked Sailing";							mACUint.camName = "Unlocked Interiors";
		mACUws.camName = "Unlocked Witcher Senses";						mACUwsInt.camName = "Unlocked Witcher Senses Interiors";
		mACUswim.camName = "Unlocked Swimming";							mACUsprint.camName = "Unlocked Sprint";
		
		mACUexp.groupName = 'ACexp'; 					mACUmed.groupName = 'ACmed';
		mACUclue.groupName = 'ACclue'; 					mACUcbt.groupName = 'ACcbt';
		mACUfist.groupName = 'ACfist'; 					mACUaim.groupName = 'ACaim';
		mACUsign.groupName = 'ACsign';					mACUlocked.groupName = 'AClck';
		mACUhorse.groupName = 'AChorse';				mACUhorseCbt.groupName = 'AChorseCbt';
		mACUboat.groupName = 'ACboat';					mACUint.groupName = 'ACint';
		mACUws.groupName = 'ACws';						mACUwsInt.groupName = 'ACwsInt';
		mACUswim.groupName = 'ACswim';					mACUsprint.groupName = 'ACsprint';
		
		acInitSetupUnlockedCamera();
	}
	
	public function acGetUVec( acState : EACSTATE ) : Vector
	{
		var uVec : Vector;
		
		switch( acState )
		{
			case ACSTATE_Exploration : 					uVec = mACUexp.acGetVector(); 			break;
			case ACSTATE_Meditation : 					uVec = mACUmed.acGetVector(); 			break;
			case ACSTATE_Clue : 						uVec = mACUclue.acGetVector(); 			break;
			case ACSTATE_Combat : 						uVec = mACUcbt.acGetVector(); 			break;
			case ACSTATE_CombatFists : 					uVec = mACUfist.acGetVector(); 			break;
			case ACSTATE_Aim : 							uVec = mACUaim.acGetVector(); 			break;
			case ACSTATE_CombatSign : 					uVec = mACUsign.acGetVector(); 			break;
			case ACSTATE_CombatLocked : 				uVec = mACUlocked.acGetVector(); 		break;
			case ACSTATE_Horse : 						uVec = mACUhorse.acGetVector(); 		break;
			case ACSTATE_HorseCombat : 					uVec = mACUhorseCbt.acGetVector(); 		break;
			case ACSTATE_Boat : 						uVec = mACUboat.acGetVector(); 			break;
			case ACSTATE_Interiors : 					uVec = mACUint.acGetVector(); 			break;
			case ACSTATE_WitcherSenses : 				uVec = mACUws.acGetVector(); 			break;
			case ACSTATE_WitcherSensesInteriors : 		uVec = mACUwsInt.acGetVector(); 		break;
			case ACSTATE_Swimming : 					uVec = mACUswim.acGetVector();			break;
			case ACSTATE_Sprint : 						uVec = mACUsprint.acGetVector(); 		break;
		}
		
		return uVec;
	}
	
	public function acGetUStatus( acState : EACSTATE ) : String
	{
		var msg : string;
		
		switch( acState )
		{
			case ACSTATE_Exploration : 					msg = mACUexp.acGetStatus(); 			break;
			case ACSTATE_Meditation : 					msg = mACUmed.acGetStatus(); 			break;
			case ACSTATE_Clue : 						msg = mACUclue.acGetStatus(); 			break;
			case ACSTATE_Combat : 						msg = mACUcbt.acGetStatus(); 			break;
			case ACSTATE_CombatFists : 					msg = mACUfist.acGetStatus(); 			break;
			case ACSTATE_Aim : 							msg = mACUaim.acGetStatus(); 			break;
			case ACSTATE_CombatSign : 					msg = mACUsign.acGetStatus(); 			break;
			case ACSTATE_CombatLocked : 				msg = mACUlocked.acGetStatus(); 		break;
			case ACSTATE_Horse : 						msg = mACUhorse.acGetStatus(); 			break;
			case ACSTATE_HorseCombat : 					msg = mACUhorseCbt.acGetStatus(); 		break;
			case ACSTATE_Boat : 						msg = mACUboat.acGetStatus(); 			break;
			case ACSTATE_Interiors : 					msg = mACUint.acGetStatus(); 			break;
			case ACSTATE_WitcherSenses : 				msg = mACUws.acGetStatus(); 			break;
			case ACSTATE_WitcherSensesInteriors : 		msg = mACUwsInt.acGetStatus(); 			break;
			case ACSTATE_Swimming : 					msg = mACUswim.acGetStatus();			break;
			case ACSTATE_Sprint : 						msg = mACUsprint.acGetStatus();			break;
		}
		
		return msg;
	}
	
	public function acMathUnlocked( acState : EACSTATE, axis : name, dowhat : name )
	{
		var amount : float;
		
		amount = StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue( 'RGTotherSettings', 'RGToffsetPerHit' ) );
		
		if( amount < 0.1 )
		{
			theGame.GetInGameConfigWrapper().SetVarValue( 'RGTotherSettings', 'RGToffsetPerHit', 0.1 );
			theGame.SaveUserSettings();
		}
		
		switch( acState )
		{
			case ACSTATE_Exploration : 					mACUexp.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Meditation : 					mACUmed.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Clue : 						mACUclue.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Combat : 						mACUcbt.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_CombatFists : 					mACUfist.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Aim : 							mACUaim.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_CombatSign : 					mACUsign.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_CombatLocked : 				mACUlocked.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Horse : 						mACUhorse.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_HorseCombat : 					mACUhorseCbt.acMath( axis, dowhat, amount ); 	break;
			case ACSTATE_Boat : 						mACUboat.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Interiors : 					mACUint.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_WitcherSenses : 				mACUws.acMath( axis, dowhat, amount ); 			break;
			case ACSTATE_WitcherSensesInteriors : 		mACUwsInt.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Swimming : 					mACUswim.acMath( axis, dowhat, amount ); 		break;
			case ACSTATE_Sprint : 						mACUsprint.acMath( axis, dowhat, amount ); 		break;
		}
	}
	
	private function acInitSetupUnlockedCamera()
	{
		mACUexp.acInitSetup();
		mACUmed.acInitSetup();
		mACUclue.acInitSetup();
		mACUcbt.acInitSetup();
		mACUfist.acInitSetup();
		mACUaim.acInitSetup();
		mACUsign.acInitSetup();
		mACUlocked.acInitSetup();
		mACUhorse.acInitSetup();
		mACUhorseCbt.acInitSetup();
		mACUboat.acInitSetup();
		mACUint.acInitSetup();
		mACUws.acInitSetup();
		mACUwsInt.acInitSetup();
		mACUswim.acInitSetup();
		mACUsprint.acInitSetup();
	}
	
	public function acResetCamera( acState : EACSTATE )
	{
		switch( acState )
		{
			case ACSTATE_Exploration : 					mACUexp.acInitSetup(); 			break;
			case ACSTATE_Meditation : 					mACUmed.acInitSetup(); 			break;
			case ACSTATE_Clue : 						mACUclue.acInitSetup(); 		break;
			case ACSTATE_Combat : 						mACUcbt.acInitSetup(); 			break;
			case ACSTATE_CombatFists : 					mACUfist.acInitSetup(); 		break;
			case ACSTATE_Aim : 							mACUaim.acInitSetup(); 			break;
			case ACSTATE_CombatSign : 					mACUsign.acInitSetup(); 		break;
			case ACSTATE_CombatLocked : 				mACUlocked.acInitSetup(); 		break;
			case ACSTATE_Horse : 						mACUhorse.acInitSetup(); 		break;
			case ACSTATE_HorseCombat : 					mACUhorseCbt.acInitSetup(); 	break;
			case ACSTATE_Boat : 						mACUboat.acInitSetup(); 		break;
			case ACSTATE_Interiors : 					mACUint.acInitSetup(); 			break;
			case ACSTATE_WitcherSenses : 				mACUws.acInitSetup(); 			break;
			case ACSTATE_WitcherSensesInteriors : 		mACUwsInt.acInitSetup(); 		break;
			case ACSTATE_Swimming : 					mACUswim.acInitSetup(); 		break;
			case ACSTATE_Sprint : 						mACUsprint.acInitSetup(); 		break;
		}
	}
	
	public function acUnlockedSaveCam( acState : EACSTATE )
	{
		var msg : string;
		
		switch( acState )
		{
			case ACSTATE_Exploration : 					mACUexp.acSaveCam(); 			msg = "Exploration Camera Saved"; 				break;
			case ACSTATE_Meditation : 					mACUmed.acSaveCam(); 			msg = "Meditation Camera Saved"; 				break;
			case ACSTATE_Clue : 						mACUclue.acSaveCam(); 			msg = "Clue Investigation Camera Saved";		break;
			case ACSTATE_Combat : 						mACUcbt.acSaveCam(); 			msg = "Combat Camera Saved";					break;
			case ACSTATE_CombatFists : 					mACUfist.acSaveCam(); 			msg = "Fist Fight Camera Saved";				break;
			case ACSTATE_Aim : 							mACUaim.acSaveCam(); 			msg = "Aim Camera Saved";						break;
			case ACSTATE_CombatSign : 					mACUsign.acSaveCam(); 			msg = "Sign Camera Saved";						break;
			case ACSTATE_CombatLocked : 				mACUlocked.acSaveCam(); 		msg = "Locked to Target Camera Saved";			break;
			case ACSTATE_Horse : 						mACUhorse.acSaveCam(); 			msg = "Horse Riding Camera Saved";				break;
			case ACSTATE_HorseCombat : 					mACUhorseCbt.acSaveCam();		msg = "Horse Riding Combat Camera Saved";		break;
			case ACSTATE_Boat : 						mACUboat.acSaveCam(); 			msg = "Sailing Camera Saved";					break;
			case ACSTATE_Interiors : 					mACUint.acSaveCam(); 			msg = "Interiors Camera Saved";					break;
			case ACSTATE_WitcherSenses : 				mACUws.acSaveCam(); 			msg = "Witcher Senses Camera Saved";			break;
			case ACSTATE_WitcherSensesInteriors : 		mACUwsInt.acSaveCam(); 			msg = "Witcher Senses Interiors Camera Saved";	break;
			case ACSTATE_Swimming : 					mACUswim.acSaveCam(); 			msg = "Swimming Camera Saved";					break;
			case ACSTATE_Sprint : 						mACUsprint.acSaveCam(); 		msg = "Sprint Camera Saved";					break;
		}
		
		thePlayer.DisplayHudMessage(msg);
	}
}