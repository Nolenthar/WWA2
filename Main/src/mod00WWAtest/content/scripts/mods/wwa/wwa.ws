/****************************************************************************/
/** Copyright © CD Projekt RED 2015
/** Author : Nolenthar
/****************************************************************************/

import function ItemHasTag( itemId : SItemUniqueId, tag : name ) : bool;

class WhiteWolfAdventure extends CActor
{	
	public function oilIsValidDamageImprovement(type : EMonsterCategory, oilType : name) : bool
	{
		switch(type)
		{
			case MC_Beast :	
				if (oilType == 'Beast Oil 1' || oilType == 'Beast Oil 2' || oilType == 'Beast Oil 3' )
				return true;
			case MC_Cursed :
				if (oilType == 'Cursed Oil 1' || oilType == 'Cursed Oil 2' || oilType == 'Cursed Oil 3')
				return true;
			case MC_Draconide :
				if (oilType == 'Draconide Oil 1' || oilType == 'Draconide Oil 2' || oilType == 'Draconide Oil 3')
				return true;
			case MC_Human :				
				if (oilType == 'Hanged Man Venom 1' || oilType == 'Hanged Man Venom 2' || oilType == 'Hanged Man Venom 3')
				return true;
			case MC_Hybrid :
				if (oilType == 'Hybrid Oil 1' || oilType == 'Hybrid Oil 2' || oilType == 'Hybrid Oil 3')
				return true;
			case MC_Insectoid :
				if (oilType== 'Insectoid Oil 1' || oilType== 'Insectoid Oil 2' || oilType== 'Insectoid Oil 3')
				return true;
			case MC_Magicals :
				if (oilType == 'Magicals Oil 1' || oilType == 'Magicals Oil 2' || oilType == 'Magicals Oil 3')
				return true;
			case MC_Necrophage :
				if (oilType == 'Necrophage Oil 1' || oilType == 'Necrophage Oil 2' || oilType =='Necrophage Oil 3')
				return true;
			case MC_Relic :	
				if (oilType == 'Relic Oil 1' || oilType == 'Relic Oil 2' || oilType == 'Relic Oil 3')
				return true;
			case MC_Specter :
				if (oilType == 'Specter Oil 1' || oilType == 'Specter Oil 2' || oilType == 'Specter Oil 3')
				return true;
			case MC_Troll :				
				if (oilType == 'Ogre Oil 1' || oilType == 'Ogre Oil 2' || oilType == 'Ogre Oil 3' )
				return true;
			case MC_Vampire :
				if (oilType=='Vampire Oil 1' || oilType=='Vampire Oil 2' || oilType=='Vampire Oil 3')
				return true;
			default :				return false;
		}
	}
	
	public function silverDamageIncrease(monster : EMonsterCategory,item : SItemUniqueId) : float
	{
		var damageMultiplier : float;
		var witcher : W3PlayerWitcher;
		
		witcher = GetWitcherPlayer();
		damageMultiplier=1;
		
		//log.AddMessage("item has tag"+ItemHasTag(sword,'wwaSilverSword'));
		if (!(witcher.inv.ItemHasTag(item,'wwaSilverSword')))
			return damageMultiplier;
		
		switch(monster)
		{
			case MC_Cursed :
				damageMultiplier+=0.45;
				break;
			case MC_Draconide :
				damageMultiplier+=0.25;
				break;
			case MC_Human :
				break;
			case MC_Beast :	
				break;
			case MC_Hybrid :
				damageMultiplier+=0.25;
				break;	
			case MC_Insectoid :
				break;	
			case MC_Magicals :
				damageMultiplier+=0.35;
				break;	
			case MC_Necrophage :
				damageMultiplier+=0.45;
				break;	
			case MC_Relic :
				damageMultiplier+=0.2;
				break;	
			case MC_Specter :
				damageMultiplier+=0.45;
				break;	
			case MC_Troll :
				damageMultiplier+=0.2;
				break;	
			case MC_Vampire :
				damageMultiplier+=0.45;
				break;				
		}
		return damageMultiplier;		
	}
		
	public function calculateArmorRatio(): float 
	{

		var item : SItemUniqueId;
		var encumbrance 	: float;
		var armors : array<SItemUniqueId>;
		var armorRatio :float;
		var i, cnt : int;
		var armorType : EArmorType;
		var witcher : W3PlayerWitcher;
		var points:float;
	
		witcher = GetWitcherPlayer();
		armors.Resize(4);
		
		if(witcher.inv.GetItemEquippedOnSlot(EES_Armor, item))
			armors[0] = item;
			
		if(witcher.inv.GetItemEquippedOnSlot(EES_Boots, item))
			armors[1] = item;
			
		if(witcher.inv.GetItemEquippedOnSlot(EES_Pants, item))
			armors[2] = item;
			
		if(witcher.inv.GetItemEquippedOnSlot(EES_Gloves, item))
			armors[3] = item;
		armorRatio=0;
		for(i=0; i<armors.Size(); i+=1)
		{
			if(i==0){ points=0.5;}
			if(i==1){ points=0.125;}
			if(i==2){ points=0.25;}
			if(i==3){ points=0.125;}
				
			armorType = witcher.inv.GetArmorType(armors[i]);
			if(armorType == EAT_Light)
				 armorRatio -= points;
			else if(armorType == EAT_Medium)
				armorRatio += 0;
			else if(armorType == EAT_Heavy)
				armorRatio += points;
			else if(armorType == EAT_Undefined)
				armorRatio -= points;
		}
		return armorRatio;
	}
		
	public function wwaFocusRatio() : float
	{
		var ratio : float;
		var witcher : W3PlayerWitcher;
		
		witcher = GetWitcherPlayer();
		
		ratio=witcher.GetStatPercents(BCS_Focus);
		
		return ratio;
	}
		
	public function wwaStaminaRatio() : float
	{
		var ratio : float;
		var witcher : W3PlayerWitcher;
		
		witcher = GetWitcherPlayer();
		
		ratio=witcher.GetStatPercents(BCS_Stamina);
		
		return ratio;
	}

	public function wwaActionSpeedMultiplier(actionType : EBufferActionType) : float
	{
		var finalMultiplier : float;
		var toxicityLevel : float;
		var witcher :  W3PlayerWitcher;
		var toxicity: float;
		var swordSkill : float ;
		var alchemySkill : float;
		var dodgeSkill : float;
		var focusRatio : float;
		var armorMalus : float;
		
		finalMultiplier=1;
		swordSkill=0;
		alchemySkill=0;
		dodgeSkill=0;
		
		witcher=GetWitcherPlayer();
		armorMalus=calculateArmorRatio();

		toxicity=witcher.GetStatPercents(BCS_Toxicity);
		toxicityLevel=0;
		
		if (toxicity >= 0.2 && toxicity <= 0.5)
			toxicityLevel=1.5;
		else if (toxicity >=0.5 && toxicity < 1)
			toxicityLevel=2.0;
		if (toxicity >= witcher.GetToxicityDamageThreshold() )
			toxicityLevel=2.5;
		
		if (witcher.GetSkillLevel(S_Sword_s13) >0)
			swordSkill = (witcher.GetSkillLevel(S_Sword_s13) +2) * witcher.GetStat(BCS_Focus);
		if (witcher.GetSkillLevel(S_Alchemy_s15) >0)
			alchemySkill = (witcher.GetSkillLevel(S_Alchemy_s15) +2) * toxicityLevel;
		if (witcher.GetSkillLevel(S_Sword_s15) >0)
			dodgeSkill = (witcher.GetSkillLevel(S_Sword_s15) +2) * witcher.GetStat(BCS_Focus);	
		
		switch(actionType)
		{
			case EBAT_LightAttack :
			{
				finalMultiplier+=((2.5 * (swordSkill+alchemySkill)*0.01)-(armorMalus * 0.1)) + attackSpeedFromWeapon()  ;
				return finalMultiplier;
			}	
			case EBAT_HeavyAttack :
			{
				finalMultiplier+=((4 * (swordSkill+alchemySkill)*0.01) -(armorMalus * 0.2)) + (attackSpeedFromWeapon() *2) ;
				return finalMultiplier;
			}
			{
				case EBAT_Dodge :
				finalMultiplier+=(2.5 * (dodgeSkill+alchemySkill)*0.01 )-(armorMalus * 0.1);
				return finalMultiplier;
			}	
			case EBAT_Roll :
			{
				finalMultiplier+=(2 * (dodgeSkill+alchemySkill)*0.01 )-(armorMalus * 0.1);
				return finalMultiplier;
			}
			case EBAT_SpecialAttack_Light :
			{
				finalMultiplier+=(((2.5 * (swordSkill+alchemySkill)*0.01)-(armorMalus * 0.1)) + attackSpeedFromWeapon())/2  ;
				return finalMultiplier;
			}
		}
		return finalMultiplier;
	}
	
	public final function speedAttackMultiplier(actionType : EBufferActionType)
	{
		thePlayer.SetAnimationSpeedMultiplier(wwaActionSpeedMultiplier(actionType));
	}

	public final function resetSpeedAttackMultiplier()
	{
		thePlayer.SetAnimationSpeedMultiplier(1.0);
	}
	
	public function calculateWeaponWeightRatio() : float
	{
		var witcher		: W3PlayerWitcher; 
		var weight	 	: float;
		var item 		: SItemUniqueId;
		var itemWeight	: SAbilityAttributeValue;
		var weaponWeightRatio : float;
		
		witcher = GetWitcherPlayer();
		if (witcher.IsWeaponHeld( 'steelsword'))
		{
			item=witcher.GetEquippedSword(true);
		}
		else if (witcher.IsWeaponHeld( 'silversword'))
		{
			item=witcher.GetEquippedSword(false);
		}
		
		itemWeight=witcher.inv.GetItemAttributeValue(item, 'weight');
		weight=itemWeight.valueBase;
		if (weight <= 2.5)
		{
			weaponWeightRatio = 1;
		}
		else if (weight > 2.5 && weight <= 3.125)
		{
			weaponWeightRatio = 1.25;
		}
		else if (weight > 3.125 && weight <= 3.75 )
		{
			weaponWeightRatio = 1.5;
		}
		else if (weight > 3.75 && weight <= 4.375)
		{
			weaponWeightRatio = 1.75 ;
		}
		else 
		{
			weaponWeightRatio = 2;
		}
		return weaponWeightRatio;
	}
	
	public function weaponWeightCriticalCheck() : float
	{
		var weaponWeightCheck : float;
		var finalCriticalMalus : float;
		
		finalCriticalMalus = 0;
		
		weaponWeightCheck = calculateWeaponWeightRatio();
		switch (weaponWeightCheck)
		{
			case 1 :
				return finalCriticalMalus;
			case 1.25 :
				finalCriticalMalus -= 0.05;
				break;
			case 1.5 :
				finalCriticalMalus -= 0.15 ;
				break;
			case 1.75 :
				finalCriticalMalus -= 0.25 ;
				break;
			case 2 :
				finalCriticalMalus -= 0.5 ;
				break;
			default :
				break;
		}
		return finalCriticalMalus;
	}
	
	public function attackSpeedFromWeapon() : float
	{
		var finalAttackSpeedModifier : float;
		var weaponWeightRatio : float;
		
		finalAttackSpeedModifier = 0;
		
		weaponWeightRatio=calculateWeaponWeightRatio();
		if (weaponWeightRatio == 1.5)
		{
			finalAttackSpeedModifier -= 0.15;
		}
		else if (weaponWeightRatio == 1.75)
		{
			finalAttackSpeedModifier -= 0.25;
		}
		else if( weaponWeightRatio == 2)
		{
			finalAttackSpeedModifier -= 0.35;
		}
		return finalAttackSpeedModifier;
	}
	
	public function calculateDurabilityReduceChanceFromArmor(actorVictim : CActor) : float
	{
		var armor,armorReduction,armorReductionPercentage,durabilityReduceChance : float;
		var armorReduc,armorPerc : SAbilityAttributeValue;
		
		armor=CalculateAttributeValue(actorVictim.GetTotalArmor());
		armorReduc=actorVictim.GetAttributeValue('armor_reduction');
		armorReduction=armorReduc.valueBase;
	
		return armor;
	}
	
	public function calculateStaminaCostMultiplier(action : EStaminaActionType,optional abilityName : name) : float
	{
		var multiplier : float;
		multiplier=1;

		switch(action)
		{
			case ESAT_LightAttack :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor();
				multiplier*=calculateWeaponWeightRatio();
				break;
			}	
			case ESAT_HeavyAttack :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor();
				multiplier*=calculateWeaponWeightRatio();
				break;
			}
			case ESAT_Parry :
			{	
				multiplier+=calculateStaminaUsageRatioFromArmor();
				multiplier*=calculateWeaponWeightRatio();
				break;
			}
			case ESAT_Dodge :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor();
				break;
			}
			case ESAT_Roll :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor();
				break;
			}
			case ESAT_Counterattack :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor();
				break;
			}
			case ESAT_Evade :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor();
				break;
			}
			case ESAT_Jump :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor() * 2;
				break;
			}
			case ESAT_Sprint :
			{
				multiplier+=calculateStaminaUsageRatioFromArmor() * 2;
				break;
			}
			case ESAT_Ability:
			{
				if (abilityName == 'sword_s1' || abilityName=='sword_s2')
				{
					multiplier+=calculateStaminaUsageRatioFromArmor();
					multiplier*=calculateWeaponWeightRatio();
				}
				else if (abilityName == 'magic_1' || abilityName == 'magic_2' || abilityName == 'magic_3' || abilityName == 'magic_4' || abilityName == 'magic_5' || abilityName == 'magic_s1' || abilityName == 'magic_s2' || abilityName == 'magic_s3' || abilityName == 'magic_s4' )
				{
					multiplier+=calculateStaminaUsageRatioFromArmor();
				}
				break;	
			}
		}
		return multiplier;
	}
	
	public function calculateStaminaUsageRatioFromArmor(): float 
	{
		var armorRatio : float;
		var focusRatio : float;
		var staminaCostRatio : float;
		
		armorRatio=calculateArmorRatio() + 1;
		focusRatio=wwaFocusRatio() *0.1 ;
				
		staminaCostRatio=((armorRatio)/4) - focusRatio;
		return staminaCostRatio;
	}
	
	public function staminaDamageModifier() : float
	{
		var modifier : float;
		var staminaRatio : float;
		
		modifier=1;
		staminaRatio = wwaStaminaRatio();

		if (staminaRatio > 0.05 && staminaRatio <=0.30)
		{
			modifier-=0.2;
		}
		else if (staminaRatio <= 0.05)
		{
			modifier-=0.5;
		}
		
		return modifier;
	}
	
	public final function wwaLogging(message : string) //DEBUG
	{
		var log:W3GameLog;
		log=new W3GameLog in this;
		
		log.AddMessage(message);
	}
	
}