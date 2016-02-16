//#############################
//
// pMarK - 2016
// Absolute Camera 1.9.x
// Normal Cameras Manager
//
//#############################

class CACNormalManager {
	
	private var mACNexp, mACNmed, mACNclue, mACNsprint, mACNcbt, mACNfist, mACNaim, mACNsign, mACNlocked, mACNhorse, mACNhorseCbt, mACNboat, mACNint, mACNws, mACNwsInt, mACNswim : CACNcam;
	
	public function iniNormalManager()
	{
		mACNexp = new CACNcam in this;					mACNmed = new CACNcam in this;
		mACNclue = new CACNcam in this;					mACNcbt = new CACNcam in this;
		mACNfist = new CACNcam in this;					mACNaim = new CACNcam in this;
		mACNsign = new CACNcam in this;					mACNlocked = new CACNcam in this;
		mACNhorse = new CACNcam in this;				mACNhorseCbt = new CACNcam in this;
		mACNboat = new CACNcam in this;					mACNint = new CACNcam in this;
		mACNws = new CACNcam in this;					mACNwsInt = new CACNcam in this;
		mACNswim = new CACNcam in this;					mACNsprint = new CACNcam in this;
		
		mACNexp.camName = "Exploration"; 						mACNmed.camName = "Meditation";
		mACNclue.camName = "Clue Investigation"; 				mACNcbt.camName = "Combat";
		mACNfist.camName = "Fist Fight"; 						mACNaim.camName = "Aim";
		mACNsign.camName = "Sign";								mACNlocked.camName = "Locked to Target";
		mACNhorse.camName = "Horse Riding";						mACNhorseCbt.camName = "Horse Riding Combat";
		mACNboat.camName = "Sailing";							mACNint.camName = "Interiors";
		mACNws.camName = "Witcher Senses";						mACNwsInt.camName = "Witcher Senses Interiors";
		mACNswim.camName = "Swimming";							mACNsprint.camName = "Sprint";
	}
	
	public function acGetNVec( acState : EACSTATE ) : Vector
	{
		var nVec : Vector;
		
		switch( acState )
		{
			case ACSTATE_Exploration : 					nVec = mACNexp.acGetVector( 'ACexp' ); 					break;
			case ACSTATE_Meditation : 					nVec = mACNmed.acGetVector( 'ACmed' ); 					break;
			case ACSTATE_Clue : 						nVec = mACNclue.acGetVector( 'ACclue' ); 				break;
			case ACSTATE_Combat : 						nVec = mACNcbt.acGetVector( 'ACcbt' ); 					break;
			case ACSTATE_CombatFists : 					nVec = mACNfist.acGetVector( 'ACfist' ); 				break;
			case ACSTATE_Aim : 							nVec = mACNaim.acGetVector( 'ACaim' ); 					break;
			case ACSTATE_CombatSign : 					nVec = mACNsign.acGetVector( 'ACsign' ); 				break;
			case ACSTATE_CombatLocked : 				nVec = mACNlocked.acGetVector( 'AClck' ); 				break;
			case ACSTATE_Horse : 						nVec = mACNhorse.acGetVector( 'AChorse' ); 				break;
			case ACSTATE_HorseCombat : 					nVec = mACNhorseCbt.acGetVector( 'AChorseCbt' ); 		break;
			case ACSTATE_Boat : 						nVec = mACNboat.acGetVector( 'ACboat' ); 				break;
			case ACSTATE_Interiors : 					nVec = mACNint.acGetVector( 'ACint' ); 					break;
			case ACSTATE_WitcherSenses : 				nVec = mACNws.acGetVector( 'ACws' ); 					break;
			case ACSTATE_WitcherSensesInteriors : 		nVec = mACNwsInt.acGetVector( 'ACwsInt' ); 				break;
			case ACSTATE_Swimming : 					nVec = mACNswim.acGetVector( 'ACswim' ); 				break;
			case ACSTATE_Sprint : 						nVec = mACNsprint.acGetVector( 'ACsprint' ); 			break;
		}
		
		return nVec;
	}
	
	public function acGetNStatus( acState : EACSTATE ) : String
	{
		var msg : string;
		
		switch( acState )
		{
			case ACSTATE_Exploration : 					msg = mACNexp.acGetStatus(); 			break;
			case ACSTATE_Meditation : 					msg = mACNmed.acGetStatus(); 			break;
			case ACSTATE_Clue : 						msg = mACNclue.acGetStatus(); 			break;
			case ACSTATE_Combat : 						msg = mACNcbt.acGetStatus(); 			break;
			case ACSTATE_CombatFists : 					msg = mACNfist.acGetStatus(); 			break;
			case ACSTATE_Aim : 							msg = mACNaim.acGetStatus(); 			break;
			case ACSTATE_CombatSign : 					msg = mACNsign.acGetStatus(); 			break;
			case ACSTATE_CombatLocked : 				msg = mACNlocked.acGetStatus(); 		break;
			case ACSTATE_Horse : 						msg = mACNhorse.acGetStatus(); 			break;
			case ACSTATE_HorseCombat : 					msg = mACNhorseCbt.acGetStatus(); 		break;
			case ACSTATE_Boat : 						msg = mACNboat.acGetStatus(); 			break;
			case ACSTATE_Interiors : 					msg = mACNint.acGetStatus(); 			break;
			case ACSTATE_WitcherSenses : 				msg = mACNws.acGetStatus(); 			break;
			case ACSTATE_WitcherSensesInteriors : 		msg = mACNwsInt.acGetStatus(); 			break;
			case ACSTATE_Swimming : 					msg = mACNswim.acGetStatus(); 			break;
			case ACSTATE_Sprint : 						msg = mACNsprint.acGetStatus(); 		break;
		}
		
		return msg;
	}
}