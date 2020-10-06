local Support = {}
local myHero = Heroes.GetLocal()
local myPlayer = Players.GetLocal()
local Width, Height = Renderer.GetScreenSize()
local HeroList = nil
local FriendlyTeam = {}
local EnemyTeam = {}
local StatusTeamView = false;
local TimerUpdate1s = 0; -- Timer Update 1s
local TimerUpdateAntPause = 0; -- Timer Update 0.2s
Width = math.floor(Width/2);
Height = math.floor(Height/5*3);
local image = {}
image[1] = Renderer.LoadImage("panorama/images/items/ward_sentry_png.vtex_c");
image[2] = Renderer.LoadImage("panorama/images/items/ward_sentry_png.vtex_c");
local MenuItemList={}
MenuItemList[1]={posX = Width, posY = Height, view = false}
local SupportItemList={}
SupportItemList[1] = {name = "item_solar_crest", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/solar_crest_png.vtex_c"), hero={}};
SupportItemList[2] = {name = "item_dagon", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/dagon_png.vtex_c"), hero={}};
SupportItemList[3] = {name = "item_rod_of_atos", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/rod_of_atos_png.vtex_c"), hero={}};
SupportItemList[4] = {name = "item_orchid", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/orchid_png.vtex_c"), hero={}};
SupportItemList[5] = {name = "item_nullifier", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/nullifier_png.vtex_c"), hero={}};
SupportItemList[6] = {name = "item_sheepstick", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/sheepstick_png.vtex_c"), hero={}};
SupportItemList[7] = {name = "item_diffusal_blade", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/diffusal_blade_png.vtex_c"), hero={}};
SupportItemList[8] = {name = "item_ethereal_blade", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/ethereal_blade_png.vtex_c"), hero={}};
SupportItemList[9] = {name = "item_abyssal_blade", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/abyssal_blade_png.vtex_c"), hero={}};
SupportItemList[10] = {name = "item_bloodthorn", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/bloodthorn_png.vtex_c"), hero={}};
SupportItemList[11] = {name = "item_heavens_halberd", status = false, item = nil, target = true, active = false, image = Renderer.LoadImage("panorama/images/items/heavens_halberd_png.vtex_c"), hero={}};

-- Menu
	Support.optionIcon = Menu.AddMenuIcon({"Support"}, "")
	Support.optionEnabled = Menu.AddOptionBool({"Support"}, "Enabled", false)
	Support.optionAntiPauseEnabled = Menu.AddOptionBool({"Support"}, "Anti pause", false)
	-- Menu Item Save
		Support.optionEnabledItemSave = Menu.AddOptionBool({"Support", "Item Save"}, "Enabled", false);
		Support.optionEnabledItemSaveUrn = Menu.AddOptionBool({"Support", "Item Save", "Urn of Shadows"}, "Enabled", false);
		Support.optionItemSaveVolumeUrn = Menu.AddOptionSlider({"Support", "Item Save","Urn of Shadows"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSaveVessel = Menu.AddOptionBool({"Support", "Item Save", "Spirit Vessel"}, "Enabled", false);
		Support.optionItemSaveVolumeVessel = Menu.AddOptionSlider({"Support", "Item Save","Spirit Vessel"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSaveBottle = Menu.AddOptionBool({"Support", "Item Save", "Bottle"}, "Enabled", false);
		Support.optionItemSaveVolumeBottle = Menu.AddOptionSlider({"Support", "Item Save","Bottle"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSaveGlimmer = Menu.AddOptionBool({"Support", "Item Save", "Glimmer"}, "Enabled", false);
		Support.optionItemSaveVolumeGlimmer = Menu.AddOptionSlider({"Support", "Item Save","Glimmer"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSaveSolarCrest = Menu.AddOptionBool({"Support", "Item Save", "Solar Crest"}, "Enabled", false);
		Support.optionItemSaveVolumeSolarCrest = Menu.AddOptionSlider({"Support", "Item Save","Solar Crest"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSaveMekansm = Menu.AddOptionBool({"Support", "Item Save", "Mekansm"}, "Enabled", false);
		Support.optionItemSaveVolumeMekansm = Menu.AddOptionSlider({"Support", "Item Save","Mekansm"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSaveGuardianGreaves = Menu.AddOptionBool({"Support", "Item Save", "Guardian Geaves"}, "Enabled", false);
		Support.optionItemSaveVolumeGuardianGreaves = Menu.AddOptionSlider({"Support", "Item Save","Guardian Geaves"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSavelinkenSphere = Menu.AddOptionBool({"Support", "Item Save", "linken's sphere"}, "Enabled", false);
		Support.optionItemSaveVolumeSphere = Menu.AddOptionSlider({"Support", "Item Save","linken's sphere"}, "Volume HP", 1, 100, 10);
		Support.optionEnabledItemSavelotus = Menu.AddOptionBool({"Support", "Item Save", "lotus orb"}, "Enabled", false);
		Support.optionItemSaveVolumelotus = Menu.AddOptionSlider({"Support", "Item Save","lotus orb"}, "Volume HP", 1, 100, 10);
	-- End Menu Item Save
	-- Menu Item Auto Cast
		Support.optionSaveItemIcon = Menu.AddMenuIcon(Support, "Item Auto Cast");
		Support.optionEnabledItemAutoCast = Menu.AddOptionBool({"Support", "Item Auto Cast"}, "Enabled", false);
		Support.optionEnabledItemAutoCastPanel = Menu.AddKeyOption({"Support", "Item Auto Cast"}, "View Panel", Enum.ButtonCode.KEY_F);
	-- End Menu Item Auto Cast
	function Support.StartScript()
		if myHero then
			if(NPC.GetUnitName(myHero)=="npc_dota_hero_dazzle")then
				Support.optionDazzle = Menu.AddMenuIcon({"Support"}, "Dazzle");
				Support.optionEnabledDazzle = Menu.AddOptionBool({"Support", "Dazzle"}, "Enabled", false);
				Support.optionEnabledGraveDazzle = Menu.AddOptionBool({"Support", "Dazzle", "Grave"}, "Enabled", false);
				Support.optionCountEnemyGrave = Menu.AddOptionSlider({"Support","Dazzle", "Grave"}, "Health", 1, 99, 1);
				Support.optionEnabledTeamView = Menu.AddOptionBool({"Support","Dazzle", "Team View"}, "Enabled", true);
				Support.optionTeamViewX = Menu.AddOptionSlider({"Support","Dazzle", "Team View"}, "X", -Width, Width, 0);
				Support.optionTeamViewY = Menu.AddOptionSlider({"Support","Dazzle", "Team View"}, "Y", -Height, Height, 0);
				StatusTeamView=true;
				return;
			end
			if(NPC.GetUnitName(myHero)=="npc_dota_hero_oracle")then
				Support.optionOracleIcon = Menu.AddMenuIcon(Support, "Oracle");
				Support.optionEnabledOracle = Menu.AddOptionBool({"Support", "Oracle"}, "Enabled", false);
				Support.optionEnabledHealOracle = Menu.AddOptionBool({"Support", "Oracle", "Heal"}, "Enabled", false);
				Support.optionEnabledTeamView = Menu.AddOptionBool({"Support","Oracle", "Team View"}, "Enabled", true);
				Support.optionTeamViewX = Menu.AddOptionSlider({"Support","Oracle", "Team View"}, "X", -Width, Width, 0);
				Support.optionTeamViewY = Menu.AddOptionSlider({"Support","Oracle", "Team View"}, "Y", -Height, Height, 0);
				Support.optionCountEnemyHealOracle = Menu.AddOptionSlider({"Support","Oracle", "Heal"}, "Health percent", 1, 99, 1);
				Support.optionEnabledAutoSaveOracle = Menu.AddOptionBool({"Support", "Oracle", "Auto Save"}, "Enabled", false);
				Support.optionCountEnemyAutoSaveOracle = Menu.AddOptionSlider({"Support","Oracle", "Auto Save"}, "Health percent", 1, 99, 1);
				Support.optionEnabledDamageOracle = Menu.AddOptionBool({"Support", "Oracle", "Damage combo"}, "Combo Enabled", false);
				Support.optionEnabledOraclesComboDamage = Menu.AddKeyOption({"Support", "Oracle", "Damage combo"}, "Damage Key", Enum.ButtonCode.KEY_F);
				StatusTeamView=true;
				return;
			end
			if(NPC.GetUnitName(myHero)=="npc_dota_hero_witch_doctor")then
				Support.optionOracleIcon = Menu.AddMenuIcon(Support, "Doctor");
				Support.optionEnabledDoctor = Menu.AddOptionBool({"Support", "Doctor"}, "Enabled", false);
				Support.optionEnabledDoctorDamageCombo = Menu.AddOptionBool({"Support", "Doctor", "Damage combo"}, "Enabled", false);
				Support.optionEnabledDoctorDamageComboWard = Menu.AddOptionBool({"Support", "Doctor", "Damage combo"}, "Use Ward in combo?", false);
				Support.optionEnabledDoctorDamageComboKey = Menu.AddKeyOption({"Support", "Doctor", "Damage combo"}, "Combo Key", Enum.ButtonCode.KEY_F);
				Support.optionEnabledDoctorDamageComboItemGlimer = Menu.AddOptionBool({"Support", "Doctor", "Damage combo", "Item"}, "Glimmer", false);
				return;
			end
			if(NPC.GetUnitName(myHero)=="npc_dota_hero_earthshaker")then
				Support.optionEarthshakerIcon = Menu.AddMenuIcon(Support, "Earthshaker");
				Support.optionEnabledEarthshaker = Menu.AddOptionBool({"Support", "Earthshaker"}, "Enabled", false);
				Support.optionEnabledEarthshakerStopUltimate = Menu.AddOptionBool({"Support", "Earthshaker"}, "Ultimate control", false);
				return;
			end
			if(NPC.GetUnitName(myHero)=="npc_dota_hero_undying")then
				Support.optionUndying = Menu.AddMenuIcon(Support, "Undying");
				Support.optionEnabledUndying = Menu.AddOptionBool({"Support", "Undying"}, "Enabled", false);
				Support.optionEnabledUndyingAutoDecay = Menu.AddOptionBool({"Support", "Undying"}, "Auto Decay", false);
				Support.optionCountUndyingAutoDecay = Menu.AddOptionSlider({"Support","Undying"}, "Count Hero (Auto Decay)", 1, 5, 2);
				return;
			end
		end
	end
-- End Menu
-- drawing
	function Support.OnDraw()
		if Menu.IsEnabled(Support.optionEnabled) then
			-- Team View
			if StatusTeamView then
				if Menu.IsEnabled(Support.optionEnabledTeamView) then
					local x = Width+Menu.GetValue(Support.optionTeamViewX);
					local y = Height+Menu.GetValue(Support.optionTeamViewY);
					local MousX,MousY = Input.GetCursorPos();
					Renderer.SetDrawColor(0, 0, 0, 150);
					Renderer.DrawFilledRect(x-4, y-3, 170, 35)
					local PosIcon = 0;
					for i = 1, #FriendlyTeam do
						if FriendlyTeam[i].status then
							Renderer.SetDrawColor(255, 255, 255, 255);
						else
							Renderer.SetDrawColor(255, 255, 255, 50);
						end
						Renderer.DrawImage(FriendlyTeam[i].icon, x+PosIcon, y, 30, 30);
						PosIcon=PosIcon+32;
					end
					if (MousX>=x and MousX<=x+170) and (MousY>=y and MousY<=y+35) then
						if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
							local PosCursorIcon = 32; 
							for i = 1, 5 do
								if (MousX-(x+PosCursorIcon))<=0 then
									if FriendlyTeam[i].status then
										FriendlyTeam[i].status=false;
									else
										FriendlyTeam[i].status=true;
									end
									break;
								end
								PosCursorIcon=PosCursorIcon+32;
							end
						end
					end
				end
			end
			-- End Team View
			-- Item Auto Cast
			if Menu.IsEnabled(Support.optionEnabledItemAutoCast) then
				if MenuItemList[1].view then
					local x = MenuItemList[1].posX;
					local y = MenuItemList[1].posY;
					local MousX,MousY = Input.GetCursorPos();
					Renderer.SetDrawColor(159, 0, 61, 250);
					Renderer.DrawFilledRect(x, y-20, 200, 20);
					Renderer.SetDrawColor(0, 0, 0, 150);
					Renderer.DrawFilledRect(x, y, 200, 240);
					Renderer.DrawFilledRect(x, y+250, 200, 40);
					local PosIcon = 0;
					for i = 1, #SupportItemList do
						if SupportItemList[i].status then
							if SupportItemList[i].active then
								Renderer.SetDrawColor(255, 255, 255, 255);
							else
								Renderer.SetDrawColor(255, 255, 255, 150);
							end
							Renderer.DrawImage(SupportItemList[i].image, x+PosIcon, y+250, 40, 40);
							PosIcon=PosIcon+42;
						end
					end
					PosIcon = 0;
					Renderer.SetDrawColor(255, 255, 255, 255);
					if #EnemyTeam then
						for i = 1, #EnemyTeam do
							local PosIcoY = 40;
							Renderer.DrawImage(EnemyTeam[i].icon, x+PosIcon, y, 40, 40);
							for j = 1, #SupportItemList do
								if #SupportItemList[j].hero then
									for k = 1, #SupportItemList[j].hero do
										if SupportItemList[j].hero[k] == EnemyTeam[i].Hero then
											Renderer.DrawImage(SupportItemList[j].image, x+PosIcon, y+PosIcoY, 40, 40);
											if (MousX>=x+PosIcon and MousX<=x+PosIcon+40) and (MousY>=y+PosIcoY and MousY<=y+PosIcoY+40) then
												if (Input.IsKeyDown(Enum.ButtonCode.KEY_MOUSE1)) then
													if SupportItemList[j].status then
														SupportItemList[j].hero[k]=nil;
													end
												end
											end
											PosIcoY=PosIcoY+40;
										end
									end
								end
							end
							PosIcon=PosIcon+40;
						end
					end
					if (MousX>=x and MousX<=x+200) and (MousY>=y and MousY<=y+40) then
						if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
							local PosCursorIcon = 40; 
							for i = 1, #EnemyTeam do
								if (MousX-(x+PosCursorIcon))<=0 then
									for j = 1, #SupportItemList do
										if SupportItemList[j].active then
											if #SupportItemList[j].hero then
												local HeroCheker=true;
												for k = 1, #SupportItemList[j].hero do
													if SupportItemList[j].hero[k]== EnemyTeam[i].Hero then
														HeroCheker = false;
														SupportItemList[j].active = false;
													end
												end
												if HeroCheker then
													SupportItemList[j].hero[#SupportItemList[j].hero+1]=EnemyTeam[i].Hero;
													SupportItemList[j].active = false;
												end
											end
										end
									end
								end
								PosCursorIcon=PosCursorIcon+40;
							end
						end
					end
					if (MousX>=x and MousX<=x+200) and (MousY>=y+250 and MousY<=y+290) then
						if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
							local PosCursorIcon = 40; 
							for i = 1, #SupportItemList do
								if SupportItemList[i].status then
									if (MousX-(x+PosCursorIcon))<=0 then
											if SupportItemList[i].active then
												SupportItemList[i].active=false;
											else
												SupportItemList[i].active=true;
											end
											break;
									end
									PosCursorIcon=PosCursorIcon+40;
								end
							end
						end
					end
					if (MousX>=x and MousX<=x+200) and (MousY>=y-20 and MousY<=y) then
						if (Input.IsKeyDown(Enum.ButtonCode.KEY_MOUSE1)) then
							MenuItemList[1].posX = MousX-100;
							MenuItemList[1].posY = MousY+10;
						end
					end
				end
			end
			-- End Item Auto Cast
		end
	end
-- End drawing
-- Main
	function Support.OnUpdate()
		if Menu.IsEnabled(Support.optionEnabled) then
			local TimerGameSec=(GameRules.GetGameTime() - GameRules.GetGameStartTime());
			if not(myHero) then	return false; end
			-- Update 1s
			if TimerUpdate1s <= TimerGameSec then
				Support.GetHeroList();
				Support.GetMyItemList();
				TimerUpdate1s=TimerGameSec+1;
			end
			-- End Update 1s
			-- Update 0.2s
			if Menu.IsEnabled(Support.optionAntiPauseEnabled) then
				if TimerUpdateAntPause <= TimerGameSec then
					Support.AntiPause();
					TimerUpdateAntPause=TimerGameSec+0.2;
				end
			end
			-- End Update 0.2s
			--Dazzle Script
			if (NPC.GetUnitName(myHero)=="npc_dota_hero_dazzle") then
				if Menu.IsEnabled(Support.optionEnabledDazzle) then
					if Menu.IsEnabled(Support.optionEnabledGraveDazzle) then
						if Entity.IsAlive(myHero) then
							local Grave = NPC.GetAbility(myHero, "dazzle_shallow_grave");
							local Scepter = NPC.GetItem(myHero, "item_ultimate_scepter");
							local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Grave), Enum.TeamType.TEAM_FRIEND);
							if #HeroRadius > 0 then
								for i = 1, #HeroRadius do
									if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyGrave) >= Entity.GetHealth(HeroRadius[i])) then
										for j = 1, #FriendlyTeam do
											if FriendlyTeam[j].Hero == HeroRadius[i] then
												if FriendlyTeam[j].status and Entity.IsAlive(FriendlyTeam[j].Hero) then
													if NPC.HasModifier(myHero, "modifier_wisp_tether_scepter") or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter") or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
														Support.CastSaveSpell(Grave,FriendlyTeam[j].Hero,false);
													else
														Support.CastSaveSpell(Grave,FriendlyTeam[j].Hero,true);
													end
													break;
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
			--End Dazzle Script
			-- Oracle
			if (NPC.GetUnitName(myHero)=="npc_dota_hero_oracle") then
				if Menu.IsEnabled(Support.optionEnabledOracle) then
					local Flame = NPC.GetAbility(myHero, "oracle_purifying_flames");
					local Fotuna = NPC.GetAbility(myHero, "oracle_fortunes_end");
					local Promise = NPC.GetAbility(myHero, "oracle_false_promise");
					local Edict = NPC.GetAbility(myHero, "oracle_fates_edict");
					if Menu.IsEnabled(Support.optionEnabledAutoSaveOracle) then
						if Entity.IsAlive(myHero) then
							local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Edict), Enum.TeamType.TEAM_FRIEND);
							if #HeroRadius > 0 then
								for i = 1, #HeroRadius do
									if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyAutoSaveOracle) >= Entity.GetHealth(HeroRadius[i])) then
										for j = 1, #FriendlyTeam do
											if FriendlyTeam[j].Hero == HeroRadius[i] then
												if FriendlyTeam[j].status and Entity.IsAlive(FriendlyTeam[j].Hero) then
													Support.CastSaveSpell(Edict,FriendlyTeam[j].Hero,true);
													local ethereal = NPC.GetItem(myHero, "item_ethereal_blade");
													if ethereal then
														Support.CastSaveSpell(ethereal,FriendlyTeam[j].Hero,true);
													end
												end
											end
										end
									end
								end
							end
						end
					end
					if Menu.IsEnabled(Support.optionEnabledHealOracle) then
						if Entity.IsAlive(myHero) then
							local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Promise), Enum.TeamType.TEAM_FRIEND);
							if #HeroRadius > 0 then
								for i = 1, #HeroRadius do
									if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyHealOracle) >= Entity.GetHealth(HeroRadius[i])) then
										for j = 1, #FriendlyTeam do
											if FriendlyTeam[j].Hero == HeroRadius[i] then
												if FriendlyTeam[j].status and Entity.IsAlive(FriendlyTeam[j].Hero) then
													if NPC.GetModifier(FriendlyTeam[j].Hero, "modifier_oracle_false_promise_timer") then
														Support.CastSaveSpell(Flame,FriendlyTeam[j].Hero,true);
													else
														Support.CastSaveSpell(Promise,FriendlyTeam[j].Hero,true);
													end
												end
											end
										end
									end
								end
							end
						end
					end
					if Menu.IsEnabled(Support.optionEnabledDamageOracle) then
						if Entity.IsAlive(myHero) then
							if Menu.IsKeyDown(Support.optionEnabledOraclesComboDamage) then
								local target=Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY);
								if(Ability.IsReady(Flame)) and (Ability.IsReady(Fotuna)) and target then
									if Entity.IsAlive(target) then
										if  NPC.IsEntityInRange(myHero, target, Ability.GetCastRange(Flame)) then
											local ethereal = NPC.GetItem(myHero, "item_ethereal_blade");
											if ethereal then
												Support.CastDamageSpell(ethereal,target,true);
											end
											Support.CastDamageSpell(Flame,target,true);
											Support.CastDamageSpell(Fotuna,target,true);
											Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Entity.GetOrigin(myHero), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero, false, false)
										end
									end
								end
							end
						end
					end
				end
			end
			-- End Oracle
			-- Doctor
			if (NPC.GetUnitName(myHero)=="npc_dota_hero_witch_doctor") then
				if Menu.IsEnabled(Support.optionEnabledDoctor) then
					local Caska = NPC.GetAbility(myHero, "witch_doctor_paralyzing_cask");
					local Voodoo = NPC.GetAbility(myHero, "witch_doctor_voodoo_restoration");
					local Maledict = NPC.GetAbility(myHero, "witch_doctor_maledict");
					local Ward = NPC.GetAbility(myHero, "witch_doctor_death_ward");
					if Entity.IsAlive(myHero) then
						if Menu.IsEnabled(Support.optionEnabledDoctorDamageCombo) then
							if Menu.IsKeyDown(Support.optionEnabledDoctorDamageComboKey) then
								local target=Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY);
								if target then
									if Entity.IsAlive(target) then
										if  NPC.IsEntityInRange(myHero, target, Ability.GetCastRange(Maledict)) then
											Support.CastDamageSpell(Caska,target,true);
											Support.CastDamageSpell(Maledict,target,false);
										end
										if Menu.IsEnabled(Support.optionEnabledDoctorDamageComboWard) then
											if NPC.GetModifier(target, "modifier_maledict_dot") then
												if  NPC.IsEntityInRange(myHero, target, Ability.GetCastRange(Ward)) then
													Support.CastDamageSpell(Ward,target,false);
													if Menu.IsEnabled(Support.optionEnabledDoctorDamageComboItemGlimer) then
														local item = NPC.GetItem(myHero, "item_glimmer_cape");
														if item then
															if not(NPC.GetModifier(myHero, "modifier_invisible")) then
																Support.CastDamageSpell(item,myHero,true);
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
			-- End Doctor
			-- Undying
			if (NPC.GetUnitName(myHero)=="npc_dota_hero_undying") then
				if Menu.IsEnabled(Support.optionEnabledUndying) then
					local Decay = NPC.GetAbility(myHero, "undying_decay");
					if Entity.IsAlive(myHero) and Decay then
						if Menu.IsEnabled(Support.optionEnabledUndyingAutoDecay) then
							local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Decay), Enum.TeamType.TEAM_ENEMY);
							if #HeroRadius > 0 then
								for i = 1, #HeroRadius do
									local EnemyHeroRadius = Entity.GetHeroesInRadius(HeroRadius[i], 300, Enum.TeamType.TEAM_FRIEND);
									if #EnemyHeroRadius >= Menu.GetValue(Support.optionCountUndyingAutoDecay) then
										Support.CastDamageSpell(Decay,HeroRadius[i],false);
									end
								end
							end
						end
					end
				end
			end
			-- End Undying
			-- Item Script
			if Menu.IsEnabled(Support.optionEnabledItemAutoCast) then
				Support.AutoCastItem();
				if Menu.IsKeyDownOnce(Support.optionEnabledItemAutoCastPanel) then
					MenuItemList[1].view=not(MenuItemList[1].view);
				end
			end	
			if Menu.IsEnabled(Support.optionEnabledItemSave) then
				Support.SaveItem();
			end	
			-- End Item Script
		end
	end
-- End Main
-- Use ability
	function Support.OnPrepareUnitOrders(orders)
		-- Earthshaker
		if myHero then
			if (NPC.GetUnitName(myHero)=="npc_dota_hero_earthshaker") then
				local EchoSlam = NPC.GetAbility(myHero, "earthshaker_echo_slam");
				if Menu.IsEnabled(Support.optionEnabledEarthshaker) then
					if Menu.IsEnabled(Support.optionEnabledEarthshakerStopUltimate) then
						if EchoSlam == orders.ability then
							local BadHerolist = Entity.GetHeroesInRadius(myHero, 600, Enum.TeamType.TEAM_ENEMY)
							if #BadHerolist==0 then
								return false;
							else
								return true;
							end
						end
					end
				end
			end
		end
		-- End Earthshaker
	end
-- End Use ability
-- Content
	-- Anti pause
		function Support.AntiPause()
			if (GameRules.IsPaused()) then
				Engine.ExecuteCommand("dota_pause");
			end
		end
	-- End Anti pause
	-- Cast Damage Spell
		function Support.CastDamageSpell(Spell,Target,TypeSpell)
			if NPC.IsEntityInRange(myHero, Target, Ability.GetCastRange(Spell)) then
				if Entity.IsAlive(Target) and Entity.IsAlive(myHero) then
					if Ability.IsReady(Spell) and Ability.IsCastable(Spell, NPC.GetMana(myHero), false) then
						if not(NPC.GetModifier(myHero, "modifier_invisible")) then
							if not(NPC.GetModifier(Target, "modifier_item_sphere")) and not(NPC.GetModifier(Target, "modifier_item_sphere_target")) and not(NPC.GetModifier(Target, "modifier_item_lotus_orb_active")) and not(NPC.GetModifier(Target, "modifier_antimage_counterspell")) then
								if TypeSpell then
									Ability.CastTarget(Spell,Target,false);
								else
									Ability.CastPosition(Spell, Entity.GetOrigin(Target), false);
								end
							end
						end
					end
				end
			end
		end
	-- End Cast Damage Spell
	-- Cast Save Spell
		function Support.CastSaveSpell(Spell,Target,TypeSpell)
			local BadHerolist = Entity.GetHeroesInRadius(Target, 1000, Enum.TeamType.TEAM_ENEMY)
			if #BadHerolist>0 then
				if Entity.IsAlive(Target) and Entity.IsAlive(myHero) then
					if Ability.IsReady(Spell) and Ability.IsCastable(Spell, NPC.GetMana(myHero), false) then
						if TypeSpell then
							Ability.CastTarget(Spell,Target,false);
						else
							Ability.CastPosition(Spell, Entity.GetOrigin(Target), false);
						end
					end
				end
			end
		end
	-- End Cast Save Spell
	-- Hero List
		function Support.GetHeroList()
			HeroList = Heroes.GetAll();
			if #HeroList > 0 then
				for i = 1, #HeroList do
					if Entity.IsAlive(HeroList[i]) and not(NPC.IsIllusion(HeroList[i])) then
						local Cheker = 0;
						if Entity.IsSameTeam(HeroList[i], myHero) then
							if #FriendlyTeam > 0 then
								for j = 1, #FriendlyTeam do
									if FriendlyTeam[j].Hero == HeroList[i] then
										Cheker = 1;
									end
								end
							end
							if Cheker == 0 then
								FriendlyTeam[#FriendlyTeam+1]={Hero = HeroList[i], damage = NPC.GetTrueMaximumDamage(HeroList[i]), armor = NPC.GetPhysicalArmorValue(HeroList[i]), Speed = math.ceil(NPC.GetMoveSpeed(HeroList[i])), icon = Renderer.LoadImage("panorama/images/heroes/icons/"..NPC.GetUnitName(HeroList[i]).."_png.vtex_c"), status=true};
							end
						else
							if #EnemyTeam > 0 then
								for j = 1, #EnemyTeam do
									if EnemyTeam[j].Hero == HeroList[i] then
										Cheker = 1;
									end
								end
							end
							if Cheker == 0 then
								EnemyTeam[#EnemyTeam+1]={Hero = HeroList[i], damage = NPC.GetTrueMaximumDamage(HeroList[i]), armor = NPC.GetPhysicalArmorValue(HeroList[i]), Speed = math.ceil(NPC.GetMoveSpeed(HeroList[i])), icon = Renderer.LoadImage("panorama/images/heroes/icons/"..NPC.GetUnitName(HeroList[i]).."_png.vtex_c"), status=true};
							end
						end
					end
				end
			end
		end
	-- End Hero List
	
	-- Item
		-- Get Item List
		function Support.AutoCastItem()
			for i = 1, #SupportItemList do
				if SupportItemList[i].status then
					if #SupportItemList[i].hero > 0 then
						local EnemyRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(SupportItemList[i].item), Enum.TeamType.TEAM_ENEMY);
						if #EnemyRadius > 0 then
							for j = 1, #SupportItemList[i].hero do
								for k = 1, #EnemyRadius do
									if SupportItemList[i].hero[j]==EnemyRadius[k] then
										Support.CastDamageSpell(SupportItemList[i].item,EnemyRadius[k],true)
									end
								end
							end
						end
					end
				end
			end
		end
		function Support.GetMyItemList()
			for i = 1, #SupportItemList do
				local item = NPC.GetItem(myHero, SupportItemList[i].name);
				if item then
					SupportItemList[i].status = true;
					SupportItemList[i].item = item;
				else
					SupportItemList[i].status = false;
					SupportItemList[i].item = nil;
					SupportItemList[i].hero = {};
				end
			end
		end
		-- End Get Item List
		function Support.SaveItem()
			-- Unr of Shadows
			if Menu.IsEnabled(Support.optionEnabledItemSaveUrn) then
				local item = NPC.GetItem(myHero, "item_urn_of_shadows");
				if item then
					if (Item.GetCurrentCharges(item) > 0) then
						local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
						if #HeroRadius > 0 then
							for i = 1, #HeroRadius do
								if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeUrn) >= Entity.GetHealth(HeroRadius[i])) then
									if not(NPC.GetModifier(HeroRadius[i], "modifier_item_urn_heal")) and not(NPC.GetModifier(HeroRadius[i], "modifier_ice_blast")) then
										Support.CastItemSave(item,HeroRadius[i],true);
									end
									break;
								end
							end
						end
					end
				end
			end
			-- End Unr of Shadows
			-- Spirit Vessel
			if Menu.IsEnabled(Support.optionEnabledItemSaveVessel) then
				local item = NPC.GetItem(myHero, "item_spirit_vessel");
				if item then
					if (Item.GetCurrentCharges(item) > 0) then
						local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
						if #HeroRadius > 0 then
							for i = 1, #HeroRadius do
								if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeVessel) >= Entity.GetHealth(HeroRadius[i])) then
									if not(NPC.GetModifier(HeroRadius[i], "modifier_item_spirit_vessel_heal")) and not(NPC.GetModifier(HeroRadius[i], "modifier_ice_blast")) then
										Support.CastItemSave(item,HeroRadius[i],true);
									end
									break;
								end
							end
						end
					end
				end
			end
			-- End Spirit Vessel
			-- Bottle
			if Menu.IsEnabled(Support.optionEnabledItemSaveBottle) then
				local item = NPC.GetItem(myHero, "item_bottle");
				if item then
					if (Item.GetCurrentCharges(item) > 0) then
						local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
						if #HeroRadius > 0 then
							for i = 1, #HeroRadius do
								if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeBottle) >= Entity.GetHealth(HeroRadius[i])) then
									if not(NPC.GetModifier(HeroRadius[i], "modifier_bottle_regeneration")) and not(NPC.GetModifier(HeroRadius[i], "modifier_ice_blast")) then
										Support.CastItemSave(item,HeroRadius[i],true);
									end
									break;
								end
							end
						end
					end
				end
			end
			-- End Bottle
			-- Glimmer Cape
			if Menu.IsEnabled(Support.optionEnabledItemSaveGlimmer) then
				local item = NPC.GetItem(myHero, "item_glimmer_cape");
				if item then
					local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
					if #HeroRadius > 0 then
						for i = 1, #HeroRadius do
							if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeGlimmer) >= Entity.GetHealth(HeroRadius[i])) then
								if not(NPC.GetModifier(HeroRadius[i], "modifier_invisible")) then
									Support.CastItemSave(item,HeroRadius[i],true);
								end
								break;
							end
						end
					end
				end
			end
			-- End Glimmer Cape
			-- Solar Crest
			if Menu.IsEnabled(Support.optionEnabledItemSaveSolarCrest) then
				local item = NPC.GetItem(myHero, "item_solar_crest");
				if item then
					local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
					if #HeroRadius > 0 then
						for i = 1, #HeroRadius do
							if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeSolarCrest) >= Entity.GetHealth(HeroRadius[i])) and HeroRadius[i]~=myHero then
								if not(NPC.GetModifier(HeroRadius[i], "modifier_item_solar_crest_armor_addition")) then
									Support.CastItemSave(item,HeroRadius[i],true);
								end
								break;
							end
						end
					end
				end
			end
			-- End Solar Crest
			-- Mekansm
			if Menu.IsEnabled(Support.optionEnabledItemSaveMekansm) then
				local item = NPC.GetItem(myHero, "item_mekansm");
				if item then
					local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
					if #HeroRadius > 0 then
						for i = 1, #HeroRadius do
							if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeMekansm) >= Entity.GetHealth(HeroRadius[i])) then
								if not(NPC.GetModifier(HeroRadius[i], "modifier_ice_blast")) then
									Support.CastItemSave(item,HeroRadius[i],false);
								end
								break;
							end
						end
					end
				end
			end
			-- End Mekansm
			-- Guardian Geaves
			if Menu.IsEnabled(Support.optionEnabledItemSaveGuardianGreaves) then
				local item = NPC.GetItem(myHero, "item_guardian_greaves");
				if item then
					local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
					if #HeroRadius > 0 then
						for i = 1, #HeroRadius do
							if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeGuardianGreaves) >= Entity.GetHealth(HeroRadius[i])) then
								if not(NPC.GetModifier(HeroRadius[i], "modifier_ice_blast")) then
									Support.CastItemSave(item,HeroRadius[i],false);
								end
								break;
							end
						end
					end
				end
			end
			-- End Guardian Geaves
			-- linken Sphere
			if Menu.IsEnabled(Support.optionEnabledItemSavelinkenSphere) then
				local item = NPC.GetItem(myHero, "item_sphere");
				if item then
					local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
					if #HeroRadius > 0 then
						for i = 1, #HeroRadius do
							if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumeSphere) >= Entity.GetHealth(HeroRadius[i])) and HeroRadius[i]~=myHero then
								Support.CastItemSave(item,HeroRadius[i],true);
								break;
							end
						end
					end
				end
			end
			-- End linken Sphere
			-- lotus orb
			if Menu.IsEnabled(Support.optionEnabledItemSavelotus) then
				local item = NPC.GetItem(myHero, "item_lotus_orb");
				if item then
					local HeroRadius = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(item), Enum.TeamType.TEAM_FRIEND);
					if #HeroRadius > 0 then
						for i = 1, #HeroRadius do
							if ((Entity.GetMaxHealth(HeroRadius[i])*0.01)*Menu.GetValue(Support.optionItemSaveVolumelotus) >= Entity.GetHealth(HeroRadius[i])) then
								Support.CastItemSave(item,HeroRadius[i],true);
								break;
							end
						end
					end
				end
			end
			-- End lotus orb
		end
		function Support.CastItemSave(Item,Target,TypeItem)
			local BadHerolist = Entity.GetHeroesInRadius(Target, 1000, Enum.TeamType.TEAM_ENEMY)
			if #BadHerolist>0 then
				if Ability.IsReady(Item) and Ability.IsCastable(Item, NPC.GetMana(myHero), false) then
					if TypeItem then
						Ability.CastTarget(Item,Target,false);
					else
						Ability.CastNoTarget(Item, true);
					end
				end
			end
		end
	-- End Item
-- End Content
Support.StartScript();
return Support