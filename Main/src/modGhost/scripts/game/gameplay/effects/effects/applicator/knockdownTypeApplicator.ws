/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/




class W3Effect_KnockdownTypeApplicator extends W3ApplicatorEffect
{
	private saved var customEffectValue : SAbilityAttributeValue;		
	private saved var customDuration : float;							
	private saved var customAbilityName : name;							

	default effectType = EET_KnockdownTypeApplicator;
	default isNegative = true;
	default isPositive = false;
	
	
	event OnEffectAdded(optional customParams : W3BuffCustomParams)
	{
		var aardPower	: float;
		var tags : array<name>;
		var i : int;
		var appliedType : EEffectType;
		var null, sp : SAbilityAttributeValue; //modSigns
		var resPts, resPrc, rawSP : float; //modSigns
		var npc : CNewNPC;
		var params : SCustomEffectParams;
		var mutagen : CBaseGameplayEffect;
		var min, max : SAbilityAttributeValue;
		var encumbranceBonus : float; 
		
		//modSigns: removed by CDPR in 1.12
		// Mutagen 8 - increase knockdown resistance based on the current encumbrance
		/*if (target == thePlayer && thePlayer.HasBuff(EET_Mutagen08))
		{
			mutagen = thePlayer.GetBuff(EET_Mutagen08);
			theGame.GetDefinitionsManager().GetAbilityAttributeValue(mutagen.GetAbilityName(), 'resistGainRate', min, max);
			encumbranceBonus = GetWitcherPlayer().GetEncumbrance() * CalculateAttributeValue(GetAttributeRandomizedValue(min, max));
			resistance += encumbranceBonus / 100;
			// APPLY ARMOR MODIFIERS
		}*/
		
		if(isOnPlayer)
		{
			thePlayer.OnRangedForceHolster( true, true, false );
		}
		/*
		//first determine the type of effect to apply - let's calculate
		if(effectValue.valueMultiplicative + effectValue.valueAdditive > 0)		//if effect value set
			aardPower = effectValue.valueMultiplicative * ( 1 - resistance ) / (1 + effectValue.valueAdditive/100);
		else
			aardPower = creatorPowerStat.valueMultiplicative * ( 1 - resistance ) / (1 + creatorPowerStat.valueAdditive/100);
		*/
		//modSigns
		if(effectValue.valueMultiplicative + effectValue.valueAdditive > 0)		//if effect value set
			sp = effectValue;
		else
			sp = creatorPowerStat;
		//target.GetResistValue(resistStat, resPts, resPrc); // get both pts and prc
		rawSP = sp.valueMultiplicative - 1; // modSigns
		if(isSignEffect) // Aard: 30% chance for heavy knockdown, 30% + 21% = 51% chance for any knockdown
			aardPower = MaxF(0, 0.3 + ClampF(rawSP, 0, 1)/2 + ClampF(rawSP - 1, 0, 1)/3 + ClampF(rawSP - 2, 0, 1)/4 - resistancePts/100) * (1 - resistance);
		else
			aardPower = MaxF(0.1, 0.8 + (sp.valueMultiplicative - 1)/2 - resistancePts/100) * (1 - resistance);
		//combat log
		//theGame.witcherLog.AddCombatMessage("Sign power: " + FloatToString(sp.valueMultiplicative), thePlayer, NULL);
		//theGame.witcherLog.AddCombatMessage("Knockdown applicator: aard power = " + FloatToString(aardPower), thePlayer, NULL);
		//move Petri philtre effect here
		if(isSignEffect && GetCreator() == GetWitcherPlayer() && GetWitcherPlayer().GetPotionBuffLevel(EET_PetriPhiltre) == 3 && resistance < 1)
		{
			aardPower = 1;
			//combat log
			//theGame.witcherLog.AddCombatMessage("Petri philtre lvl 3: aard power = 1", thePlayer, NULL);
		}
		
		//for shielded enemy
		npc = (CNewNPC)target;
		if(npc && npc.HasShieldedAbility() )
		{
			//modSigns
			if(!npc.IsShielded(GetCreator()) && RandF() < aardPower)
				appliedType = EET_Knockdown;
			else if(RandF() < aardPower)
				appliedType = EET_LongStagger;
			else
				appliedType = EET_Stagger;
			/*if ( npc.IsShielded(GetCreator()) )
			{
				if ( aardPower >= 1.2 )//when aard is most powerfull
					appliedType = EET_LongStagger;
				else
					appliedType = EET_Stagger;
			}
			else
			{
				if ( aardPower >= 1.2 )//when aard is most powerfull
					appliedType = EET_Knockdown;
				if ( aardPower >= 1.0 )
					appliedType = EET_LongStagger;
				else
					appliedType = EET_Stagger;
			}*/
		}
		else if ( target.HasAbility( 'mon_type_huge' ) )
		{
			//modSigns
			if(RandF() < aardPower)
				appliedType = EET_LongStagger;
			else
				appliedType = EET_Stagger;
			/*if ( aardPower >= 1.2 )
				appliedType = EET_LongStagger;
			else
				appliedType = EET_Stagger;*/
		}
		else if ( target.HasAbility( 'WeakToAard' ) )
		{
			appliedType = EET_Knockdown;
		}
		/*else if( aardPower >= 1.2 )
		{
			appliedType = EET_HeavyKnockdown;
		}
		else if( aardPower >= 0.95 )
		{
			appliedType = EET_Knockdown;
		}
		else if( aardPower >= 0.75 )
		{
			appliedType = EET_LongStagger;
		}
		else
		{
			appliedType = EET_Stagger;
		}
		*/
		//modSigns
		else if(RandF() < aardPower)
			appliedType = EET_HeavyKnockdown;
		else if(RandF() < aardPower)
			appliedType = EET_Knockdown;
		else if(RandF() < aardPower)
			appliedType = EET_LongStagger;
		else
			appliedType = EET_Stagger;
		
		
		appliedType = ModifyHitSeverityBuff(target, appliedType);
		
		
		params.effectType = appliedType;
		params.creator = GetCreator();
		params.sourceName = sourceName;
		params.isSignEffect = isSignEffect;
		params.customPowerStatValue = creatorPowerStat;
		params.customAbilityName = customAbilityName;
		params.duration = customDuration;
		params.effectValue = customEffectValue;	
		
		target.AddEffectCustom(params);
				
		
		
		isActive = true;
		duration = 0;
	}
			
	public function Init(params : SEffectInitInfo)
	{
		customDuration = params.duration;
		customEffectValue = params.customEffectValue;
		customAbilityName = params.customAbilityName;
		
		super.Init(params);
	}
}