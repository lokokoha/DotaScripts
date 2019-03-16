local Support = {}
local myHero = Heroes.GetLocal()
local myPlayer = Players.GetLocal()
local TimerWards = 1
local TimerTome = 1
local cheker = 0
local TargetHeal = nil;
Support.optionIcon = Menu.AddOptionIcon({"Support"})
Support.optionEnabled = Menu.AddOptionBool({"Support"}, "Enabled", false)
Support.optionPurchaseIcon = Menu.AddOptionIcon({"Support", "Auto purchase"})
Support.optionPurchaseIcon = Menu.AddOptionIcon({"Support", "Auto broadcast"})
Support.optionEnabledAnnounceStack = Menu.AddOptionBool({"Support", "Auto broadcast"}, "Announce Stack", false)
Support.optionAnnounceVolume = Menu.AddOptionSlider({"Support","Auto broadcast"}, "Volume", 1, 100, 10);
Support.optionWardsIcon = Menu.AddOptionIcon({"Support", "Auto purchase", "Wards"}, "panorama/images/items/ward_dispenser_png.vtex_c")
Support.optionTomeIcon = Menu.AddOptionIcon({"Support", "Auto purchase", "TOME"})
Support.optionDazzleIcon = Menu.AddOptionIcon({"Support", "Dazzle"}, "panorama/images/heroes/icons/npc_dota_hero_dazzle_png.vtex_c")
Support.optionOracleIcon = Menu.AddOptionIcon({"Support", "Oracle"}, "panorama/images/heroes/icons/npc_dota_hero_oracle_png.vtex_c")
Support.optionOracleIcon = Menu.AddOptionIcon({"Support", "Doctor"}, "panorama/images/heroes/icons/npc_dota_hero_witch_doctor_png.vtex_c")
Support.optionOracleIcon = Menu.AddOptionIcon({"Support", "Dark Willow"}, "panorama/images/heroes/icons/npc_dota_hero_dark_willow_png.vtex_c")
Support.optionEnabledDazzle = Menu.AddOptionBool({"Support", "Dazzle"}, "Enabled", false)
Support.optionEnabledOracle = Menu.AddOptionBool({"Support", "Oracle"}, "Enabled", false)
Support.optionEnabledDoctor = Menu.AddOptionBool({"Support", "Doctor"}, "Enabled", false)
Support.optionEnabledWillow = Menu.AddOptionBool({"Support", "Dark Willow"}, "Enabled", false)
Support.optionDoctorDamageCombo = Menu.AddOptionIcon({"Support", "Dark Willow", "Damage combo"})
Support.optionDoctorDamageCombo = Menu.AddOptionIcon({"Support", "Dark Willow", "Save"})
Support.optionDoctorDamageCombo = Menu.AddOptionIcon({"Support", "Doctor", "Damage combo"})
Support.optionEnabledWillowDamageCombo = Menu.AddOptionBool({"Support", "Dark Willow", "Damage combo"}, "Enabled", false)
Support.optionEnabledWillowDamageComboRealm = Menu.AddOptionBool({"Support", "Dark Willow", "Damage combo"}, "Use Realm Combo", false)
Support.optionEnabledWillowSave = Menu.AddOptionBool({"Support", "Dark Willow", "Save"}, "Enabled", false)
Support.optionCountEnemyWillowSave = Menu.AddOptionSlider({"Support","Dark Willow", "Save"}, "Save percent", 1, 99, 1)
Support.optionEnabledWillowDamageComboKey = Menu.AddKeyOption({"Support", "Dark Willow", "Damage combo"}, "Combo Key", Enum.ButtonCode.KEY_F)
Support.optionEnabledDoctorDamageCombo = Menu.AddOptionBool({"Support", "Doctor", "Damage combo"}, "Enabled", false)
Support.optionEnabledDoctorDamageComboKey = Menu.AddKeyOption({"Support", "Doctor", "Damage combo"}, "Combo Key", Enum.ButtonCode.KEY_F)
Support.optionDoctorDamageComboItem = Menu.AddOptionIcon({"Support", "Doctor", "Damage combo", "Item"})
Support.optionEnabledDoctorDamageComboItemUrn = Menu.AddOptionBool({"Support", "Doctor", "Damage combo", "Item"}, "Urn of Shadows", false)
Support.optionEnabledDoctorDamageComboItemVessel = Menu.AddOptionBool({"Support", "Doctor", "Damage combo", "Item"}, "Spirit Vessel", false)
Support.optionEnabledDoctorDamageComboItemGlimer = Menu.AddOptionBool({"Support", "Doctor", "Damage combo", "Item"}, "Glimmer", false)
Support.optionEnabledOracles = Menu.AddOptionIcon({"Support", "Oracle", "Damage combo"})
Support.optionEnabledOracleSave = Menu.AddOptionIcon({"Support", "Oracle", "Heal"})
Support.optionEnabledHealOracle = Menu.AddOptionBool({"Support", "Oracle", "Heal"}, "Enabled", false)
Support.optionEnabledOraclesHealStop = Menu.AddKeyOption({"Support", "Oracle", "Heal"}, "Stop Key", Enum.ButtonCode.KEY_F)
Support.optionEnabledOracleItem = Menu.AddOptionIcon({"Support", "Oracle", "Heal", "Item"})
Support.optionEnabledHealItemUrn = Menu.AddOptionBool({"Support", "Oracle", "Heal", "Item"}, "Urn of Shadows", false)
Support.optionEnabledHealItemVessel = Menu.AddOptionBool({"Support", "Oracle", "Heal", "Item"}, "Spirit Vessel", false)
Support.optionEnabledHealItemBottle = Menu.AddOptionBool({"Support", "Oracle", "Heal", "Item"}, "Bottle", false)
Support.optionEnabledHealItemSalve = Menu.AddOptionBool({"Support", "Oracle", "Heal", "Item"}, "Salve", false)
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
	
		if Menu.IsEnabled(Support.optionEnabledAnnounceStack) then
			GameTime=(GameRules.GetGameTime() - GameRules.GetGameStartTime())/60;
			GameTime=GameTime-math.modf(GameTime);
			if (GameTime>0.67) then
				if (cheker==0) then
					cheker=1;
					Engine.ExecuteCommand('playvol sounds/diagnostics/bell ' .. tostring(Menu.GetValue(Support.optionAnnounceVolume) * 0.01 ));
				end
			else
				cheker=0;
			end
			if (GameTime>0.69) then
				if (cheker==1) then
					cheker=2;
					Engine.ExecuteCommand('playvol sounds/diagnostics/bell ' .. tostring(Menu.GetValue(Support.optionAnnounceVolume) * 0.01 ));
				end
			end
			if (GameTime>0.71) then
				if (cheker==2) then
					cheker=3;
					Engine.ExecuteCommand('playvol sounds/diagnostics/bell ' .. tostring(Menu.GetValue(Support.optionAnnounceVolume) * 0.01 ));
				end
			end
		end
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
				if(Ability.IsReady(Flame)) and (Ability.IsReady(Fotuna)) and target then
					if  NPC.IsEntityInRange(myHero, target, Ability.GetCastRange(Flame)) then
						ethereal = NPC.GetItem(myHero, "item_ethereal_blade");
						if ethereal and Ability.IsReady(ethereal) and Ability.IsCastable(ethereal, NPC.GetMana(myHero), false) then
							Ability.CastTarget(ethereal,target,true);
						end
						if Ability.IsCastable(Flame, NPC.GetMana(myHero), false) then
							Ability.CastTarget(Flame,target,true);
						end
						if Ability.IsCastable(Fotuna, NPC.GetMana(myHero), false) then
							Ability.CastTarget(Fotuna,target,true);
						end
						Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Entity.GetOrigin(myHero), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero, false, false)
					end
				end
				if(Ability.IsReady(Flame)) and (NPC.GetItem(myHero, "item_ultimate_scepter")) and Menu.IsEnabled(Support.optionEnabledDamageAghanimOracle) and target then
					if  NPC.IsEntityInRange(myHero, target, Ability.GetCastRange(Flame)) then
						if Ability.IsCastable(Flame, NPC.GetMana(myHero), false) then
							Ability.CastTarget(Flame,target,true);
						end
					end
				end
			end
			if Menu.IsEnabled(Support.optionEnabledHealOracle) then
				TeamRadius =  Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Promise), Enum.TeamType.TEAM_FRIEND);
				if TeamRadius then
					Support.OracleHealTeam(TeamRadius,Edict,Promise,Flame);
				end
				if ((Entity.GetMaxHealth(myHero)*0.01)*Menu.GetValue(Support.optionCountEnemyHealOracle) >= Entity.GetHealth(myHero)) and Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Promise) then
					TargetHeal = myHero;
					if Ability.IsCastable(Promise, NPC.GetMana(myHero), false) then
						Ability.CastTarget(Promise,TargetHeal,true);
					end
				end
				if ((Menu.IsKeyDown(Support.optionEnabledOraclesHealStop)) or (TargetHeal and not(Entity.IsAlive(TargetHeal))) or (Menu.IsKeyDown(Support.optionEnabledOraclesComboDamage)))then
					TargetHeal = nil;
				end
				if TargetHeal then
					if NPC.GetModifier(TargetHeal, "modifier_oracle_false_promise_timer") then
						if Ability.IsReady(Flame) then
							Support.OracleHealTargetItem(TargetHeal);
							if Ability.IsCastable(Flame, NPC.GetMana(myHero), true) then
								Ability.CastTarget(Flame,TargetHeal,true);
							end
						end
					end
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
						if Ability.IsCastable(ethereal, NPC.GetMana(myHero), false) then
							Ability.CastTarget(ethereal,myHero,true);
						end
					end
					if Ghost and Ability.IsReady(Ghost) then
						if Ability.IsCastable(Ghost, NPC.GetMana(myHero), false) then
							Ability.CastNoTarget(Ghost, true);
						end
					end
					if Ability.IsCastable(Edict, NPC.GetMana(myHero), false) then
						Ability.CastTarget(Edict,myHero,true);
					end
				end
			end
		end
		if Menu.IsEnabled(Support.optionEnabledDoctor) and (NPC.GetUnitName(myHero)=="npc_dota_hero_witch_doctor") and Entity.IsAlive(myHero) then
			Caska = NPC.GetAbility(myHero, "witch_doctor_paralyzing_cask");
			Voodoo = NPC.GetAbility(myHero, "witch_doctor_voodoo_restoration");
			Maledict = NPC.GetAbility(myHero, "witch_doctor_maledict");
			Ward = NPC.GetAbility(myHero, "witch_doctor_death_ward");
			if Menu.IsEnabled(Support.optionEnabledDoctorDamageCombo) and Menu.IsKeyDown(Support.optionEnabledDoctorDamageComboKey) then
				target=Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY);
				if Ability.IsReady(Ward) and target and NPC.GetModifier(target, "modifier_maledict_dot") then
					if Ability.IsCastable(Ward, NPC.GetMana(myHero), false) then
						if Heroes.InRadius(Entity.GetOrigin(target), 180, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) then
							Ability.CastPosition(Ward, Entity.GetOrigin(target), true);
						end
					end
					if Menu.IsEnabled(Support.optionEnabledDoctorDamageComboItemGlimer) then
						Glimmer = NPC.GetItem(myHero, "item_glimmer_cape");
						if Glimmer and Ability.IsReady(Glimmer) and Ability.IsCastable(Glimmer, NPC.GetMana(myHero), false) then
							Ability.CastTarget(Glimmer,myHero,true);
						end
					end
				end
				if(Ability.IsReady(Caska)) and (Ability.IsReady(Maledict)) and (Ability.IsReady(Ward)) and target  and not(NPC.GetModifier(target, "modifier_maledict_dot")) and not(NPC.IsChannellingAbility(myHero)) then
					if  NPC.IsEntityInRange(myHero, target, Ability.GetCastRange(Maledict)) then
						if Ability.IsCastable(Caska, NPC.GetMana(myHero), false) then
							Ability.CastTarget(Caska,target,true);
						end
						if Ability.IsCastable(Maledict, NPC.GetMana(myHero), false) then
							if Heroes.InRadius(Entity.GetOrigin(target), 180, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) then
								Ability.CastPosition(Maledict, Entity.GetOrigin(target), true);
							end
						end
						if Menu.IsEnabled(Support.optionEnabledDoctorDamageComboItemUrn) then
							urn = NPC.GetItem(myHero, "item_urn_of_shadows");
							if urn and Ability.IsReady(urn) and Ability.IsCastable(urn, NPC.GetMana(myHero), false) and (Item.GetCurrentCharges(urn) >= 1) then
								Ability.CastTarget(urn,target,true);
							end
						end
						if Menu.IsEnabled(Support.optionEnabledDoctorDamageComboItemVessel) then
							vessel = NPC.GetItem(myHero, "item_spirit_vessel");
							if vessel and Ability.IsReady(vessel) and Ability.IsCastable(vessel, NPC.GetMana(myHero), false) and (Item.GetCurrentCharges(vessel) >= 1) then
								Ability.CastTarget(vessel,target,true);
							end
						end
					end
				end
			end
		end
		if Menu.IsEnabled(Support.optionEnabledWillow) and (NPC.GetUnitName(myHero)=="npc_dota_hero_dark_willow") and Entity.IsAlive(myHero) then
			Maze = NPC.GetAbility(myHero, "dark_willow_bramble_maze");
			Realm = NPC.GetAbility(myHero, "dark_willow_shadow_realm");
			Crown = NPC.GetAbility(myHero, "dark_willow_cursed_crown");
			Bedlam = NPC.GetAbility(myHero, "dark_willow_bedlam");
			Terrorize = NPC.GetAbility(myHero, "dark_willow_terrorize");
			if Menu.IsEnabled(Support.optionEnabledWillowDamageCombo) and Menu.IsKeyDown(Support.optionEnabledWillowDamageComboKey) then
				target=Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY);
				if Ability.IsCastable(Maze, NPC.GetMana(myHero), false) then
					if Heroes.InRadius(Entity.GetOrigin(target), 600, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) then
						Ability.CastPosition(Maze, Entity.GetOrigin(target), true);
					end
				end
				if Ability.IsCastable(Crown, NPC.GetMana(myHero), false) then
					if Heroes.InRadius(Entity.GetOrigin(target), 600, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) then
						Ability.CastTarget(Crown,target,true);
					end
				end
				if Ability.IsCastable(Bedlam, NPC.GetMana(myHero), false) then
					if Heroes.InRadius(Entity.GetOrigin(target), 200, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) then
						Ability.CastNoTarget(Bedlam, true);
					end
				end
				if Ability.IsCastable(Realm, NPC.GetMana(myHero), false) and Menu.IsEnabled(Support.optionEnabledWillowDamageComboRealm) then
					if Heroes.InRadius(Entity.GetOrigin(target), 200, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) then
						Ability.CastNoTarget(Realm, true);
					end
				end
			end
			if Menu.IsEnabled(Support.optionEnabledWillowSave) and ((Entity.GetMaxHealth(myHero)*0.01)*Menu.GetValue(Support.optionCountEnemyWillowSave) >= Entity.GetHealth(myHero)) and Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY) then
				if Ability.IsCastable(Realm, NPC.GetMana(myHero), false) then
					Ability.CastNoTarget(Realm, true);
				end
			end
		end
    end
end
function Support.OracleHealTargetItem(Target)
	if Menu.IsEnabled(Support.optionEnabledHealItemUrn) then
		urn = NPC.GetItem(myHero, "item_urn_of_shadows");
		if urn and Ability.IsReady(urn) and Ability.IsCastable(urn, NPC.GetMana(myHero), false) and (Item.GetCurrentCharges(urn) >= 1) then
			Ability.CastTarget(urn,Target,true);
		end
	end
	if Menu.IsEnabled(Support.optionEnabledHealItemVessel) then
		vessel = NPC.GetItem(myHero, "item_spirit_vessel");
		if vessel and Ability.IsReady(vessel) and Ability.IsCastable(vessel, NPC.GetMana(myHero), false) and (Item.GetCurrentCharges(vessel) >= 1) then
			Ability.CastTarget(vessel,Target,true);
		end
	end
	if Menu.IsEnabled(Support.optionEnabledHealItemBottle)then
		Bottle = NPC.GetItem(myHero, "item_bottle");
		if Bottle and Ability.IsReady(Bottle) and not(NPC.HasModifier(Target, 'modifier_bottle_regeneration')) and Ability.IsCastable(Bottle, NPC.GetMana(myHero), false) and (Item.GetCurrentCharges(Bottle) >= 1) then
			Ability.CastTarget(Bottle,Target,true);
		end
	end
	if Menu.IsEnabled(Support.optionEnabledHealItemSalve)then
		Salve = NPC.GetItem(myHero, "item_flask");
		if Salve and Ability.IsReady(Salve) and not(NPC.HasModifier(Target, 'modifier_flask_healing')) then
			Ability.CastTarget(Salve,Target,true);
		end
	end
end
function Support.DazzleCastGrave(Grave,Target)
	if(NPC.GetItem(myHero, "item_ultimate_scepter")) and Ability.IsReady(Grave) then
		Ability.CastPosition(Grave, Entity.GetOrigin(Target), true);
	else
		if Ability.IsCastable(Grave, NPC.GetMana(myHero), false) and Ability.IsReady(Grave) then
			Ability.CastTarget(Grave,Target,true);
		end
	end
end
function Support.OracleSaveTeam(HeroesRadius,Edict,Promise,Flame)
	for i = 1, #HeroesRadius do
		if ((Entity.GetMaxHealth(HeroesRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyAutoSaveOracle) >= Entity.GetHealth(HeroesRadius[i])) and Entity.GetHeroesInRadius(HeroesRadius[i], 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Edict) then
			ethereal = NPC.GetItem(myHero, "item_ethereal_blade");
			if ethereal and Ability.IsReady(ethereal) then
				if Ability.IsCastable(ethereal, NPC.GetMana(myHero), false) then
					Ability.CastTarget(ethereal,HeroesRadius[i],true);
				end
			end
			if Ability.IsCastable(Edict, NPC.GetMana(myHero), false) then
				Ability.CastTarget(Edict,HeroesRadius[i],true);
			end
		end
	end
end
function Support.OracleHealTeam(HeroesRadius,Edict,Promise,Flame)
	for i = 1, #HeroesRadius do
		if ((Entity.GetMaxHealth(HeroesRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyHealOracle) >= Entity.GetHealth(HeroesRadius[i])) and Entity.GetHeroesInRadius(HeroesRadius[i], 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Promise) then
			TargetHeal = HeroesRadius[i];
			if Ability.IsCastable(Promise, NPC.GetMana(myHero), false) then
				Ability.CastTarget(Promise,TargetHeal,true);
			end
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