local CustomRadius = {}
local myHero = Heroes.GetLocal()
local myPlayer = Players.GetLocal()
local Width, Height = Renderer.GetScreenSize()
local HeroList = nil
local FriendlyTeam = {}
local EnemyTeam = {}
local TimerUpdate1s = 0; -- Timer Update 1s
Width = math.floor(Width/2);
Height = math.floor(Height/5*3);

-- Menu
	-- Menu Item Save
		CustomRadius.optionEnabled = Menu.AddOptionBool({"Поддержка", "Кастом радиус"}, "Включить", false);
		Menu.AddMenuIcon({"Поддержка"}, "~/MenuIcons/Dota/preview_ward.png")
		CustomRadius.optionEnabledFriendlyTeam = Menu.AddOptionBool({"Поддержка", "Кастом радиус", "Союзники"}, "Включить", false);
		CustomRadius.optionTeamViewX = Menu.AddOptionSlider({"Поддержка", "Кастом радиус", "Союзники"}, "X", -Width, Width, 0);
		CustomRadius.optionTeamViewY = Menu.AddOptionSlider({"Поддержка", "Кастом радиус", "Союзники"}, "Y", -Height, Height, 0);
		CustomRadius.optionEnabledEnemyTeam = Menu.AddOptionBool({"Поддержка", "Кастом радиус", "Противники"}, "Включить", false);
		CustomRadius.optionTeamViewXEnemy = Menu.AddOptionSlider({"Поддержка", "Кастом радиус", "Противники"}, "X", -Width, Width, 0);
		CustomRadius.optionTeamViewYEnemy = Menu.AddOptionSlider({"Поддержка", "Кастом радиус", "Противники"}, "Y", -Height, Height, 0);
	-- End Menu Item Save
	function CustomRadius.StartScript()
		if myHero then
			
		end
	end
-- End Menu
-- drawing
	function CustomRadius.OnDraw()
		if Menu.IsEnabled(CustomRadius.optionEnabled) then
			-- FriendlyTeam
			if Menu.IsEnabled(CustomRadius.optionEnabledFriendlyTeam) then
				local x = Width+Menu.GetValue(CustomRadius.optionTeamViewX);
				local y = Height+Menu.GetValue(CustomRadius.optionTeamViewY);
				local MousX,MousY = Input.GetCursorPos();
				local PosIconX = 0;
				local PosIconY = 0;
				for i = 1, #FriendlyTeam do
					PosIconY = 30;
					if FriendlyTeam[i].status then
						Renderer.SetDrawColor(255, 255, 255, 255);
					else
						Renderer.SetDrawColor(255, 255, 255, 50);
					end
					Renderer.DrawImage(FriendlyTeam[i].icon, x+PosIconX, y, 28, 28);
					for j = 1, #FriendlyTeam[i].AbilityList do
						if Ability.GetLevel(FriendlyTeam[i].AbilityList[j].ability)>=1 and Ability.GetCastRange(FriendlyTeam[i].AbilityList[j].ability)>1 then
							if not(FriendlyTeam[i].AbilityList[j].icon) then
								FriendlyTeam[i].AbilityList[j].icon = Renderer.LoadImage("panorama/images/spellicons/"..Ability.GetName(FriendlyTeam[i].AbilityList[j].ability).."_png.vtex_c");
							end
							if FriendlyTeam[i].AbilityList[j].status then
								Renderer.SetDrawColor(255, 255, 255, 255);
							else
								Renderer.SetDrawColor(255, 255, 255, 50);
							end
							Renderer.DrawImage(FriendlyTeam[i].AbilityList[j].icon, x+PosIconX, y+PosIconY, 28, 28);
							PosIconY=PosIconY+30
							
						end
					end
					PosIconX=PosIconX+30;
				end
				
				local sizeX = PosIconX+5;
				local sizeY = 170;
				Renderer.SetDrawColor(0, 0, 0, 150);
				Renderer.DrawFilledRect(x-4, y-3, sizeX, sizeY)
				if (MousX>=x and MousX<=x+sizeX) and (MousY>=y and MousY<=y+sizeY) then
					if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
						local PosCursorIcon = 30; 
						for i = 1, #FriendlyTeam do
							if (MousX-(x+PosCursorIcon))<=0 then
								local PosCursorIconY = 60; 
								for j = 1, #FriendlyTeam[i].AbilityList do
									if Ability.GetLevel(FriendlyTeam[i].AbilityList[j].ability)>=1 and Ability.GetCastRange(FriendlyTeam[i].AbilityList[j].ability)>1  then
										if (MousY-(y+PosCursorIconY))<=0 then
											if FriendlyTeam[i].AbilityList[j].status then
												FriendlyTeam[i].AbilityList[j].status=false;
											else
												FriendlyTeam[i].AbilityList[j].status=true;
											end
											break;
										end
										PosCursorIconY=PosCursorIconY+30;
									end
								end
								break;
							end
							
							PosCursorIcon=PosCursorIcon+30;
						end
					end
				end
			end
			-- End FriendlyTeam
			-- EnemyTeam
			if Menu.IsEnabled(CustomRadius.optionEnabledEnemyTeam) then
				local x = Width+Menu.GetValue(CustomRadius.optionTeamViewXEnemy);
				local y = Height+Menu.GetValue(CustomRadius.optionTeamViewYEnemy);
				local MousX,MousY = Input.GetCursorPos();
				local PosIconX = 0;
				local PosIconY = 0;
				for i = 1, #EnemyTeam do
					PosIconY = 30;
					if EnemyTeam[i].status then
						Renderer.SetDrawColor(255, 255, 255, 255);
					else
						Renderer.SetDrawColor(255, 255, 255, 50);
					end
					Renderer.DrawImage(EnemyTeam[i].icon, x+PosIconX, y, 28, 28);
					for j = 1, #EnemyTeam[i].AbilityList do
						if Ability.GetLevel(EnemyTeam[i].AbilityList[j].ability)>=1 and Ability.GetCastRange(EnemyTeam[i].AbilityList[j].ability)>1  then
							if not(EnemyTeam[i].AbilityList[j].icon) then
								EnemyTeam[i].AbilityList[j].icon = Renderer.LoadImage("panorama/images/spellicons/"..Ability.GetName(EnemyTeam[i].AbilityList[j].ability).."_png.vtex_c");
							end
							if EnemyTeam[i].AbilityList[j].status then
								Renderer.SetDrawColor(255, 255, 255, 255);
							else
								Renderer.SetDrawColor(255, 255, 255, 50);
							end
							Renderer.DrawImage(EnemyTeam[i].AbilityList[j].icon, x+PosIconX, y+PosIconY, 28, 28);
							PosIconY=PosIconY+30
						end
					end
					PosIconX=PosIconX+30;
				end
				local sizeX = PosIconX+5;
				local sizeY = 170;
				Renderer.SetDrawColor(0, 0, 0, 150);
				Renderer.DrawFilledRect(x-4, y-3, sizeX, sizeY)
				if (MousX>=x and MousX<=x+sizeX) and (MousY>=y and MousY<=y+sizeY) then
					if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
						local PosCursorIcon = 30; 
						for i = 1, #EnemyTeam do
							if (MousX-(x+PosCursorIcon))<=0 then
								local PosCursorIconY = 60; 
								for j = 1, #EnemyTeam[i].AbilityList do
									if Ability.GetLevel(EnemyTeam[i].AbilityList[j].ability)>=1 and Ability.GetCastRange(EnemyTeam[i].AbilityList[j].ability)>1  then
										if (MousY-(y+PosCursorIconY))<=0 then
											if EnemyTeam[i].AbilityList[j].status then
												EnemyTeam[i].AbilityList[j].status=false;
											else
												EnemyTeam[i].AbilityList[j].status=true;
											end
											break;
										end
										PosCursorIconY=PosCursorIconY+30;
									end
								end
								break;
							end
							
							PosCursorIcon=PosCursorIcon+30;
						end
					end
				end
			end
			-- End EnemyTeam
		end
	end
-- End drawing
-- Main
	function CustomRadius.OnUpdate()
		if Menu.IsEnabled(CustomRadius.optionEnabled) then
			if Menu.IsEnabled(CustomRadius.optionEnabledFriendlyTeam) or Menu.IsEnabled(CustomRadius.optionEnabledEnemyTeam) then
				local TimerGameSec =(GameRules.GetGameTime() - GameRules.GetGameStartTime());
				if not(myHero) then	return false; end
				-- Update 1s
				if TimerUpdate1s <= TimerGameSec then
					CustomRadius.GetHeroList();
					CustomRadius.CreateParticle();
					--CustomRadius.UpdateAbilHero();
					TimerUpdate1s=TimerGameSec+1;
				end
				CustomRadius.UpdateParticle();
			end
		end
	end
-- End Main
-- Content
	function CustomRadius.UpdateAbilHero()
		if Menu.IsEnabled(CustomRadius.optionEnabledFriendlyTeam) then
			for i = 1, #FriendlyTeam do
				local AbilityList = CustomRadius.GetAbilityList(FriendlyTeam[i].Hero);
				if #AbilityList > #FriendlyTeam[i].AbilityList then
					for j = 1, #FriendlyTeam[i].AbilityList do
						if FriendlyTeam[i].AbilityList[j].status then
							Particle.Destroy(FriendlyTeam[i].AbilityList[j].part);
						end
					end
					FriendlyTeam[i].AbilityList = AbilityList; 
				end
			end
		end
		if Menu.IsEnabled(CustomRadius.optionEnabledEnemyTeam) then
			for i = 1, #EnemyTeam do
				local AbilityList = CustomRadius.GetAbilityList(EnemyTeam[i].Hero);
				if #AbilityList > #EnemyTeam[i].AbilityList then
					for j = 1, #EnemyTeam[i].AbilityList do
						if FriendlyTeam[i].AbilityList[j].status then
							Particle.Destroy(EnemyTeam[i].AbilityList[j].part);
						end
					end
					EnemyTeam[i].AbilityList = AbilityList; 
				end
			end
		end
		
	end
	function CustomRadius.CreateParticle()
		if Menu.IsEnabled(CustomRadius.optionEnabledFriendlyTeam) then
			for i = 1, #FriendlyTeam do
				for j = 1, #FriendlyTeam[i].AbilityList do
					if FriendlyTeam[i].AbilityList[j].status and not(FriendlyTeam[i].AbilityList[j].part) then
						FriendlyTeam[i].AbilityList[j].part = Particle.Create("particles\\ui_mouseactions\\drag_selected_ring.vpcf", Enum.ParticleAttachment.PATTACH_WORLDORIGIN, FriendlyTeam[i].Hero)
						Particle.SetControlPoint(FriendlyTeam[i].AbilityList[j].part, 0, Entity.GetAbsOrigin(FriendlyTeam[i].Hero))
						Particle.SetControlPoint(FriendlyTeam[i].AbilityList[j].part, 1, Vector(120, 120, 255))
						Particle.SetControlPoint(FriendlyTeam[i].AbilityList[j].part, 2, Vector(FriendlyTeam[i].AbilityList[j].abCastRange, 255, 255))
					else
						if not(FriendlyTeam[i].AbilityList[j].status) and FriendlyTeam[i].AbilityList[j].part then
							Particle.Destroy(FriendlyTeam[i].AbilityList[j].part);
							FriendlyTeam[i].AbilityList[j].part = nil;
						end
					end
				end
			end
		end
		if Menu.IsEnabled(CustomRadius.optionEnabledEnemyTeam) then
			for i = 1, #EnemyTeam do
				for j = 1, #EnemyTeam[i].AbilityList do
					if EnemyTeam[i].AbilityList[j].status and not(EnemyTeam[i].AbilityList[j].part) then
						EnemyTeam[i].AbilityList[j].part = Particle.Create("particles\\ui_mouseactions\\drag_selected_ring.vpcf", Enum.ParticleAttachment.PATTACH_WORLDORIGIN, EnemyTeam[i].Hero)
						Particle.SetControlPoint(EnemyTeam[i].AbilityList[j].part, 0, Entity.GetAbsOrigin(EnemyTeam[i].Hero))
						Particle.SetControlPoint(EnemyTeam[i].AbilityList[j].part, 1, Vector(255, 100, 100))
						Particle.SetControlPoint(EnemyTeam[i].AbilityList[j].part, 2, Vector(EnemyTeam[i].AbilityList[j].abCastRange, 255, 255))
					else
						if not(EnemyTeam[i].AbilityList[j].status) and EnemyTeam[i].AbilityList[j].part then
							Particle.Destroy(EnemyTeam[i].AbilityList[j].part);
							EnemyTeam[i].AbilityList[j].part = nil;
						end
					end
				end
			end
		end
	end
	function CustomRadius.UpdateParticle()
		if Menu.IsEnabled(CustomRadius.optionEnabledFriendlyTeam) then
			for i = 1, #FriendlyTeam do
				for j = 1, #FriendlyTeam[i].AbilityList do
					if FriendlyTeam[i].AbilityList[j].status and FriendlyTeam[i].AbilityList[j].part then
						Particle.SetControlPoint(FriendlyTeam[i].AbilityList[j].part, 0, Entity.GetAbsOrigin(FriendlyTeam[i].Hero))
						Particle.SetControlPoint(FriendlyTeam[i].AbilityList[j].part, 1, Vector(120, 120, 255))
						local castRange = Ability.GetCastRange(FriendlyTeam[i].AbilityList[j].ability)+NPC.GetHullRadius(FriendlyTeam[i].Hero);
						if FriendlyTeam[i].AbilityList[j].abCastRange ~=  castRange then
							Particle.Destroy(FriendlyTeam[i].AbilityList[j].part);
							FriendlyTeam[i].AbilityList[j].abCastRange = castRange;
							FriendlyTeam[i].AbilityList[j].part = nil;
						end
					end
				end
			end
		end
		if Menu.IsEnabled(CustomRadius.optionEnabledEnemyTeam) then
			for i = 1, #EnemyTeam do
				for j = 1, #EnemyTeam[i].AbilityList do
					if EnemyTeam[i].AbilityList[j].status and EnemyTeam[i].AbilityList[j].part then
						Particle.SetControlPoint(EnemyTeam[i].AbilityList[j].part, 0, Entity.GetAbsOrigin(EnemyTeam[i].Hero))
						Particle.SetControlPoint(EnemyTeam[i].AbilityList[j].part, 1, Vector(255, 100, 100))
						local castRange = Ability.GetCastRange(EnemyTeam[i].AbilityList[j].ability)+NPC.GetHullRadius(EnemyTeam[i].Hero);
						if EnemyTeam[i].AbilityList[j].abCastRange ~=  castRange then
							Particle.Destroy(EnemyTeam[i].AbilityList[j].part);
							EnemyTeam[i].AbilityList[j].abCastRange = castRange;
							EnemyTeam[i].AbilityList[j].part = nil;
						end
					end
				end
			end
		end
	end

	-- Hero List
		function CustomRadius.GetHeroList()
			HeroList = Heroes.GetAll();
			if #HeroList > 0 then
				for i = 1, #HeroList do
					if Entity.IsAlive(HeroList[i]) and not(NPC.IsIllusion(HeroList[i])) then
						if Entity.IsHero(HeroList[i]) then
							local Cheker = 0;
							if Entity.IsSameTeam(HeroList[i], myHero) then
								if Menu.IsEnabled(CustomRadius.optionEnabledFriendlyTeam) then
									if #FriendlyTeam > 0 then
										for j = 1, #FriendlyTeam do
											if FriendlyTeam[j].Hero == HeroList[i] then
												Cheker = 1;
											end
										end
									end
									if Cheker == 0 then
										FriendlyTeam[#FriendlyTeam+1]={Hero = HeroList[i], damage = NPC.GetTrueMaximumDamage(HeroList[i]), armor = NPC.GetPhysicalArmorValue(HeroList[i]), Speed = math.ceil(NPC.GetMoveSpeed(HeroList[i])), icon = Renderer.LoadImage("panorama/images/heroes/icons/"..NPC.GetUnitName(HeroList[i]).."_png.vtex_c"), AbilityList = CustomRadius.GetAbilityList(HeroList[i]), status=true};
									end
								end
								
							else
								if Menu.IsEnabled(CustomRadius.optionEnabledEnemyTeam) then
									if #EnemyTeam > 0 then
										for j = 1, #EnemyTeam do
											if EnemyTeam[j].Hero == HeroList[i] then
												Cheker = 1;
											end
										end
									end
									if Cheker == 0 then
										EnemyTeam[#EnemyTeam+1]={Hero = HeroList[i], damage = NPC.GetTrueMaximumDamage(HeroList[i]), armor = NPC.GetPhysicalArmorValue(HeroList[i]), Speed = math.ceil(NPC.GetMoveSpeed(HeroList[i])), icon = Renderer.LoadImage("panorama/images/heroes/icons/"..NPC.GetUnitName(HeroList[i]).."_png.vtex_c"), AbilityList = CustomRadius.GetAbilityList(HeroList[i]), status=true};
									end
								end
							end
						end
					end
				end
			end
		end
	-- End Hero List
	-- Ability List
		function CustomRadius.GetAbilityList(hero)
				local abilityList={}
				for i = 0, 14 do
					local abili = NPC.GetAbilityByIndex(hero, i);
					if abili and not(Ability.IsAttributes(abili)) then
						abilityList[#abilityList+1] = {ability = abili, icon = nil, abCastRange = Ability.GetCastRange(abili)+NPC.GetHullRadius(hero), part = nil, status=false};
					end
				end
				return abilityList;
		end
	-- End Ability List
-- End Content
CustomRadius.StartScript();
return CustomRadius