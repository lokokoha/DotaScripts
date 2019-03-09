local Support = {}
local myHero = Heroes.GetLocal()
local myPlayer = Players.GetLocal()
local TimerWards = 1
local TimerTome = 1
local TargetHeal = nil;
Support.optionIcon = Menu.AddOptionIcon({"Support"})
Support.optionEnabled = Menu.AddOptionBool({"Support"}, "Enabled", false)
Support.optionPurchaseIcon = Menu.AddOptionIcon({"Support", "Auto purchase"})
Support.optionWardsIcon = Menu.AddOptionIcon({"Support", "Auto purchase", "Wards"}, "panorama/images/items/ward_dispenser_png.vtex_c")
Support.optionTomeIcon = Menu.AddOptionIcon({"Support", "Auto purchase", "TOME"})

Support.optionDazzleIcon = Menu.AddOptionIcon({"Support", "Dazzle"}, "panorama/images/heroes/icons/npc_dota_hero_dazzle_png.vtex_c")
Support.optionOracleIcon = Menu.AddOptionIcon({"Support", "Oracle"}, "panorama/images/heroes/icons/npc_dota_hero_oracle_png.vtex_c")
Support.optionEnabledDazzle = Menu.AddOptionBool({"Support", "Dazzle"}, "Enabled", false)
Support.optionEnabledOracle = Menu.AddOptionBool({"Support", "Oracle"}, "Enabled", false)
Support.optionEnabledOracles = Menu.AddOptionIcon({"Support", "Oracle", "Damage combo"})
Support.optionEnabledOracleSave = Menu.AddOptionIcon({"Support", "Oracle", "Heal"})
Support.optionEnabledHealOracle = Menu.AddOptionBool({"Support", "Oracle", "Heal"}, "Enabled", false)
Support.optionEnabledOraclesHealStop = Menu.AddKeyOption({"Support", "Oracle", "Heal"}, "Stop Key", Enum.ButtonCode.KEY_F)
Support.optionEnabledOracleItem = Menu.AddOptionIcon({"Support", "Oracle", "Heal", "Item"})
Support.optionEnabledHealItemUrn = Menu.AddOptionBool({"Support", "Oracle", "Heal", "Item"}, "Urn of Shadows", false)
Support.optionEnabledHealItemVessel = Menu.AddOptionBool({"Support", "Oracle", "Heal", "Item"}, "Spirit Vessel", false)
Support.optionEnabledHealItemBottle = Menu.AddOptionBool({"Support", "Oracle", "Heal", "Item"}, "Bottle", false)
Support.optionEnabledOracleAutoSave = Menu.AddOptionIcon({"Support", "Oracle", "Auto Save"})
Support.optionEnabledAutoSaveOracle = Menu.AddOptionBool({"Support", "Oracle", "Auto Save"}, "Enabled", false)
Support.optionCountEnemyAutoSaveOracle = Menu.AddOptionSlider({"Support","Oracle", "Auto Save"}, "Health percent", 1, 99, 1)
Support.optionCountEnemyHealOracle = Menu.AddOptionSlider({"Support","Oracle", "Heal"}, "Health percent", 1, 99, 1)
Support.optionEnabledDamageOracle = Menu.AddOptionBool({"Support", "Oracle", "Damage combo"}, "Combo Enabled", false)
Support.optionEnabledOraclesComboDamage = Menu.AddKeyOption({"Support", "Oracle", "Damage combo"}, "Damage Key", Enum.ButtonCode.KEY_F)
Support.optionEnabledDamageAghanimOracle = Menu.AddOptionBool({"Support", "Oracle", "Damage combo"}, "Aghanim spam cast", false)
Support.optionDazzleGraveIcon = Menu.AddOptionIcon({"Support", "Dazzle", "Grave"}, "panorama/images/spellicons/dazzle/immortal/dazzle_shallow_grave_png.vtex_c")
Support.optionDazzleWaveIcon = Menu.AddOptionIcon({"Support", "Dazzle", "Wave"}, "panorama/images/spellicons/dazzle/immortal/dazzle_shallow_grave_png.vtex_c")
Support.optionCountEnemyGrave = Menu.AddOptionSlider({"Support","Dazzle", "Grave"}, "Health", 1, 99, 1)

Support.optionEnabledPurchaseWards = Menu.AddOptionBool({"Support", "Auto purchase", "Wards"}, "Enabled", false)
Support.optionEnabledPurchaseTome = Menu.AddOptionBool({"Support", "Auto purchase", "TOME"}, "Enabled", false)


function Support.OnUpdate()
	if Menu.IsEnabled(Support.optionEnabled) then
		if Menu.IsEnabled(Support.optionEnabledPurchaseWards) then
			if (GameRules.GetGameTime() - GameRules.GetGameStartTime()) >= TimerWards*130 then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 42, Vector(0,0,0), 42, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
				TimerWards=TimerWards+1;
			end
		end
		if Menu.IsEnabled(Support.optionEnabledPurchaseTome) then
			if (GameRules.GetGameTime() - GameRules.GetGameStartTime()) >= TimerTome*670 then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
				TimerTome=TimerTome+1;
			end
		end
		if Menu.IsEnabled(Support.optionEnabledDazzle) and (NPC.GetUnitName(myHero)=="npc_dota_hero_dazzle") and Entity.IsAlive(myHero) then
			Grave = NPC.GetAbility(myHero, "dazzle_shallow_grave");
			if Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Grave), Enum.TeamType.TEAM_FRIEND) then
				Support.DazzleGrave(Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Grave), Enum.TeamType.TEAM_FRIEND),Grave);
			end
			if ((Entity.GetMaxHealth(myHero)*0.01)*Menu.GetValue(Support.optionCountEnemyGrave) >= Entity.GetHealth(myHero)) and Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Grave) then
				Support.DazzleCastGrave(Grave,myHero);
			end
		end
		if Menu.IsEnabled(Support.optionEnabledOracle) and (NPC.GetUnitName(myHero)=="npc_dota_hero_oracle") and Entity.IsAlive(myHero) then
			Flame = NPC.GetAbility(myHero, "oracle_purifying_flames");
			Fotuna = NPC.GetAbility(myHero, "oracle_fortunes_end");
			Promise = NPC.GetAbility(myHero, "oracle_false_promise");
			Edict = NPC.GetAbility(myHero, "oracle_fates_edict");
			if Menu.IsEnabled(Support.optionEnabledDamageOracle) and Menu.IsKeyDown(Support.optionEnabledOraclesComboDamage) then
				target=Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY);
				if(Ability.IsReady(Flame)) and (Ability.IsReady(Fotuna)) then
					ethereal = NPC.GetItem(myHero, "item_ethereal_blade");
					if ethereal and Ability.IsReady(ethereal) then
						Ability.CastTarget(ethereal,target,true);
					end
					Ability.CastTarget(Flame,target,true);
					Ability.CastTarget(Fotuna,target,true);
					Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Entity.GetOrigin(myHero), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero, false, false)
				end
				if(Ability.IsReady(Flame)) and (NPC.GetItem(myHero, "item_ultimate_scepter")) and Menu.IsEnabled(Support.optionEnabledDamageAghanimOracle) then
					Ability.CastTarget(Flame,target,true);
				end
			end
			if Menu.IsEnabled(Support.optionEnabledHealOracle) then
				TeamRadius =  Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Promise), Enum.TeamType.TEAM_FRIEND);
				if TeamRadius  and (TargetHeal == nil)  then
					Support.OracleHealTeam(TeamRadius,Edict,Promise,Flame);
				end
				if ((Entity.GetMaxHealth(myHero)*0.01)*Menu.GetValue(Support.optionCountEnemyHealOracle) >= Entity.GetHealth(myHero)) and Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Promise) then
					TargetHeal = myHero;
					Ability.CastTarget(Promise,TargetHeal,true);
				end
				if TargetHeal and (Ability.SecondsSinceLastUse(Promise) < 9) then
					if Ability.IsReady(Flame) then
						Support.OracleHealTargetItem(TargetHeal);
						Ability.CastTarget(Flame,TargetHeal,true);
					end
				end
				if (TargetHeal and (Ability.SecondsSinceLastUse(Promise) > 9)) or (Menu.IsKeyDown(Support.optionEnabledOraclesHealStop)) or (TargetHeal and not(Entity.IsAlive(TargetHeal))) or (Menu.IsKeyDown(Support.optionEnabledOraclesComboDamage)) then
					TargetHeal = nil;
				end
			end
			if Menu.IsEnabled(Support.optionEnabledAutoSaveOracle) then
				TeamRadius =  Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Edict), Enum.TeamType.TEAM_FRIEND);
				if TeamRadius then
					Support.OracleSaveTeam(TeamRadius,Edict,Promise,Flame);
				end
				if ((Entity.GetMaxHealth(myHero)*0.01)*Menu.GetValue(Support.optionCountEnemyAutoSaveOracle) >= Entity.GetHealth(myHero)) and Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Edict) then
					ethereal = NPC.GetItem(myHero, "item_ethereal_blade");
					Ghost = NPC.GetItem(myHero, "item_ghost");
					if ethereal and Ability.IsReady(ethereal) then
						Ability.CastTarget(ethereal,myHero,true);
					end
					if Ghost and Ability.IsReady(Ghost) then
						Ability.CastNoTarget(Ghost, true);
					end
					Ability.CastTarget(Edict,myHero,true);
				end
			end
		end
    end
end
function Support.OracleHealTargetItem(Target)
	if Menu.IsEnabled(Support.optionEnabledHealItemUrn) then
		urn = NPC.GetItem(myHero, "item_urn_of_shadows");
		if urn and Ability.IsReady(urn) then
			Ability.CastTarget(urn,Target,true);
		end
	end
	if Menu.IsEnabled(Support.optionEnabledHealItemVessel) then
		vessel = NPC.GetItem(myHero, "item_spirit_vessel");
		if vessel and Ability.IsReady(vessel) then
			Ability.CastTarget(vessel,Target,true);
		end
	end
	if Menu.IsEnabled(Support.optionEnabledHealItemBottle) then
		Bottle = NPC.GetItem(myHero, "item_bottle");
		if Bottle and Ability.IsReady(Bottle) and not(NPC.HasModifier(Target, 'modifier_bottle_regeneration')) then
			Ability.CastTarget(Bottle,Target,true);
		end
	end
	if Menu.IsEnabled(Support.optionEnabledHealItemBottle) then
		Bottle = NPC.GetItem(myHero, "item_bottle");
		if Bottle and Ability.IsReady(Bottle) and not(NPC.HasModifier(Target, 'modifier_bottle_regeneration')) then
			Ability.CastTarget(Bottle,Target,true);
		end
	end
end
function Support.DazzleCastGrave(Grave,Target)
	if(NPC.GetItem(myHero, "item_ultimate_scepter")) then
		Ability.CastPosition(Grave, Entity.GetOrigin(Target), true);
	else
		Ability.CastTarget(Grave,Target,true);
	end
end
function Support.OracleSaveTeam(HeroesRadius,Edict,Promise,Flame)
	for i = 1, #HeroesRadius do
		if ((Entity.GetMaxHealth(HeroesRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyAutoSaveOracle) >= Entity.GetHealth(HeroesRadius[i])) and Entity.GetHeroesInRadius(HeroesRadius[i], 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Edict) then
			ethereal = NPC.GetItem(myHero, "item_ethereal_blade");
			if ethereal and Ability.IsReady(ethereal) then
				Ability.CastTarget(ethereal,HeroesRadius[i],true);
			end
			Ability.CastTarget(Edict,HeroesRadius[i],true);
		end
	end
end
function Support.OracleHealTeam(HeroesRadius,Edict,Promise,Flame)
	for i = 1, #HeroesRadius do
		if ((Entity.GetMaxHealth(HeroesRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyHealOracle) >= Entity.GetHealth(HeroesRadius[i])) and Entity.GetHeroesInRadius(HeroesRadius[i], 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Promise) then
			TargetHeal = HeroesRadius[i];
			Ability.CastTarget(Promise,TargetHeal,true);
		end
	end
end
function Support.DazzleGrave(HeroesRadius,Grave)
	for i = 1, #HeroesRadius do
		if ((Entity.GetMaxHealth(HeroesRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyGrave) >= Entity.GetHealth(HeroesRadius[i])) and Entity.GetHeroesInRadius(HeroesRadius[i], 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Grave) then
			Support.DazzleCastGrave(Grave,HeroesRadius[i]);
		end
	end
end

return Support