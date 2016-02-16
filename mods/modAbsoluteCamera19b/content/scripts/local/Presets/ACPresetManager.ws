//#############################
//
// pMarK - 2016
// Absolute Camera 1.9.x
// Preset Manager
//
//#############################

class CACPresetManager {
	
	private var mACPexp : CACPexp;
	private var mACPmed : CACPmed;
	private var mACPclue : CACPclue;
	private var mACPcbt : CACPcbt;
	private var mACPfist : CACPfist;
	private var mACPaim : CACPaim;
	private var mACPsign : CACPsign;
	private var mACPlocked : CACPlocked;
	private var mACPhorse : CACPhorse;
	private var mACPhorseCbt : CACPhorseCbt;
	private var mACPboat : CACPboat;
	private var mACPint : CACPint;
	private var mACPws : CACPws;
	private var mACPwsInt : CACPwsInt;
	private var mACPswim : CACPswim;
	private var mACPsprint : CACPsprint;
	
	public function iniPresetManager()
	{
		mACPexp = new CACPexp in this;
		mACPmed = new CACPmed in this;
		mACPclue = new CACPclue in this;
		mACPcbt = new CACPcbt in this;
		mACPfist = new CACPfist in this;
		mACPaim = new CACPaim in this;
		mACPsign = new CACPsign in this;
		mACPlocked = new CACPlocked in this;
		mACPhorse = new CACPhorse in this;
		mACPhorseCbt = new CACPhorseCbt in this;
		mACPboat = new CACPboat in this;
		mACPint = new CACPint in this;
		mACPws = new CACPws in this;
		mACPwsInt = new CACPwsInt in this;
		mACPswim = new CACPswim in this;
		mACPsprint = new CACPsprint in this;
	}
	
	// Getting Preset Vector
	public function acGetPVec( acCamState : EACSTATE ) : Vector
	{
		var pVec : Vector;
		
		switch(acCamState)
		{
			case ACSTATE_Exploration : 					pVec = mACPexp.acGetVector(); 			break;
			case ACSTATE_Meditation : 					pVec = mACPmed.acGetVector(); 			break;
			case ACSTATE_Clue : 						pVec = mACPclue.acGetVector(); 			break;
			case ACSTATE_Combat : 						pVec = mACPcbt.acGetVector(); 			break;
			case ACSTATE_CombatFists : 					pVec = mACPfist.acGetVector(); 			break;
			case ACSTATE_Aim : 							pVec = mACPaim.acGetVector(); 			break;
			case ACSTATE_CombatSign : 					pVec = mACPsign.acGetVector(); 			break;
			case ACSTATE_CombatLocked : 				pVec = mACPlocked.acGetVector(); 		break;
			case ACSTATE_Horse : 						pVec = mACPhorse.acGetVector(); 		break;
			case ACSTATE_HorseCombat : 					pVec = mACPhorseCbt.acGetVector(); 		break;
			case ACSTATE_Boat : 						pVec = mACPboat.acGetVector(); 			break;
			case ACSTATE_Interiors : 					pVec = mACPint.acGetVector(); 			break;
			case ACSTATE_WitcherSenses : 				pVec = mACPws.acGetVector(); 			break;
			case ACSTATE_WitcherSensesInteriors : 		pVec = mACPwsInt.acGetVector(); 		break;
			case ACSTATE_Swimming : 					pVec = mACPswim.acGetVector(); 			break;
			case ACSTATE_Sprint : 						pVec = mACPsprint.acGetVector(); 		break;
		}
		
		return pVec;
	}
	
	// Getting Cam Status
	public function acGetPStatus( acCamState : EACSTATE ) : string
	{
		var msg : string;
		
		switch(acCamState)
		{
			case ACSTATE_Exploration : 					msg = mACPexp.acGetStatus(); 			break;
			case ACSTATE_Meditation : 					msg = mACPmed.acGetStatus(); 			break;
			case ACSTATE_Clue : 						msg = mACPclue.acGetStatus(); 			break;
			case ACSTATE_Combat : 						msg = mACPcbt.acGetStatus(); 			break;
			case ACSTATE_CombatFists : 					msg = mACPfist.acGetStatus(); 			break;
			case ACSTATE_Aim : 							msg = mACPaim.acGetStatus(); 			break;
			case ACSTATE_CombatSign : 					msg = mACPsign.acGetStatus(); 			break;
			case ACSTATE_CombatLocked : 				msg = mACPlocked.acGetStatus(); 		break;
			case ACSTATE_Horse : 						msg = mACPhorse.acGetStatus(); 			break;
			case ACSTATE_HorseCombat : 					msg = mACPhorseCbt.acGetStatus(); 		break;
			case ACSTATE_Boat : 						msg = mACPboat.acGetStatus(); 			break;
			case ACSTATE_Interiors : 					msg = mACPint.acGetStatus(); 			break;
			case ACSTATE_WitcherSenses : 				msg = mACPws.acGetStatus(); 			break;
			case ACSTATE_WitcherSensesInteriors : 		msg = mACPwsInt.acGetStatus(); 			break;
			case ACSTATE_Swimming : 					msg = mACPswim.acGetStatus(); 			break;
			case ACSTATE_Sprint : 						msg = mACPsprint.acGetStatus(); 		break;
		}
		
		return msg;
	}
}