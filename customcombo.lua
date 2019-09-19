local CustomCombo = {}
local myHero = Heroes.GetLocal()
local myPlayer = Players.GetLocal()
local Width, Height = Renderer.GetScreenSize()
local CastSpellList = {};
local SpellList = {};
local ItemList = {};
local ChannelSpell = false
local NumberSpell=1;
local font = Renderer.LoadFont("Tahoma", 35, 0)
local TimerUpdate1s = 0; -- Timer Update 1s
Width = math.floor(Width/2);
Height = math.floor(Height/5*3);
-- Menu
	CustomCombo.optionIcon = Menu.AddMenuIcon({"Custom Combo"}, "")
	CustomCombo.optionEnabled = Menu.AddOptionBool({"Custom Combo"}, "Enabled", false)
	CustomCombo.optionEnabledView = Menu.AddOptionBool({"Custom Combo"}, "View", false)
	CustomCombo.optionCustomComboViewX = Menu.AddOptionSlider({"Custom Combo"}, "X", -Width, Width, 0);
	CustomCombo.optionCustomComboViewY = Menu.AddOptionSlider({"Custom Combo"}, "Y", -Height, Height, 0);
	CustomCombo.optionComboKey = Menu.AddKeyOption({"Custom Combo"}, "Combo Key", Enum.ButtonCode.KEY_F);
-- End Menu
-- Drawing
	function CustomCombo.OnDraw()
		if Menu.IsEnabled(CustomCombo.optionEnabled) then
			if Menu.IsEnabled(CustomCombo.optionEnabledView) then
				local x = Width+Menu.GetValue(CustomCombo.optionCustomComboViewX);
				local y = Height+Menu.GetValue(CustomCombo.optionCustomComboViewY);
				local MousX,MousY = Input.GetCursorPos();
				local WidthSpell = 40*#SpellList;
				Renderer.SetDrawColor(0, 0, 0, 150);			
				Renderer.DrawFilledRect(x, y, WidthSpell, 40)
				Renderer.SetDrawColor(255, 0, 0, 150);
				Renderer.DrawFilledRect(x-30, y, 30, 40)
				for i = 1, #SpellList do
					if SpellList[i].status then
						Renderer.SetDrawColor(255, 255, 255, 255);
					else
						Renderer.SetDrawColor(255, 255, 255, 100);
					end
					Renderer.DrawImage(SpellList[i].icon, x+(i*40-40), y, 40, 40);
					if SpellList[i].status and SpellList[i].position > 0 then
						Renderer.DrawText(font, x+(i*40-23), y, SpellList[i].position)
					end
					if (MousX>=x+(i*40-40) and MousX<=x+(i*40)) and (MousY>=y and MousY<=y+40) then
						if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
							SpellList[i].status = true;
							if SpellList[i].position == 0 then
								SpellList[i].position = NumberSpell;
								CastSpellList[NumberSpell]=SpellList[i];
								NumberSpell=NumberSpell+1;
							end
						end
					end
				end
				for i = 1, #ItemList do
					if ItemList[i].status then
						Renderer.SetDrawColor(255, 255, 255, 255);
					else
						Renderer.SetDrawColor(255, 255, 255, 100);
					end
					Renderer.DrawImage(ItemList[i].icon, x+((#SpellList*40)+i*40-40), y, 40, 40);
					if ItemList[i].status and ItemList[i].position > 0 then
						Renderer.DrawText(font, x+((#SpellList*40)+i*40-23), y, ItemList[i].position)
					end
					if (MousX>=x+((#SpellList*40)+i*40-40) and MousX<=x+((#SpellList*40)+i*40)) and (MousY>=y and MousY<=y+40) then
						if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
							ItemList[i].status = true;
							if ItemList[i].position == 0 then
								ItemList[i].position = NumberSpell;
								CastSpellList[NumberSpell]=ItemList[i];
								NumberSpell=NumberSpell+1;
							end
						end
					end
				end
				if (MousX>=x-30 and MousX<=x) and (MousY>=y and MousY<=y+40) then
					if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
						ItemList = {};
						SpellList = {};
						CastSpellList = {};
						NumberSpell=1;
					end
				end
				
			end
		end
	end
-- End Drawing
-- Main
	function CustomCombo.OnUpdate()
		if Menu.IsEnabled(CustomCombo.optionEnabled) then
			local TimerGameSec=(GameRules.GetGameTime() - GameRules.GetGameStartTime());
			if not(myHero) then	return false; end
			-- Update 1s
			if TimerUpdate1s <= TimerGameSec then
				CustomCombo.GetSpellList();
				CustomCombo.GetItemList();
				TimerUpdate1s=TimerGameSec+1;
			end
			-- End Update 1s
			if Menu.IsKeyDown(CustomCombo.optionComboKey) then
				local target=Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY);
				if target then
					if not(ChannelSpell) then
						if #CastSpellList > 0 then
							for i = 1, #CastSpellList do
								if CastSpellList[i].target < 3 then 
									if NPC.IsEntityInRange(myHero, target, Ability.GetCastRange(CastSpellList[i].spell)) then
										 CustomCombo.CastDamageSpell(CastSpellList[i].spell,target,CastSpellList[i].target);
										if CastSpellList[i].channeled then
											if Ability.IsChannelling(CastSpellList[i].spell) then
												ChannelSpell = CastSpellList[i].spell;
												break;
											end
										end
									end
								else
									CustomCombo.CastDamageSpell(CastSpellList[i].spell,target,CastSpellList[i].target);
								end
							end
						end
					else
						if not(Ability.IsChannelling(ChannelSpell)) then
							ChannelSpell = false;
						end
					end
				end
				Log.Write(ChannelSpell)
			end
		end
	end
-- End Main
-- Content
	-- Cast Damage Spell
		function CustomCombo.CastDamageSpell(Spell,Target,TypeSpell)
			if Entity.IsAlive(Target) and Entity.IsAlive(myHero) then
				if Ability.IsReady(Spell) and Ability.IsCastable(Spell, NPC.GetMana(myHero), false) then
					if not(NPC.GetModifier(Target, "modifier_item_sphere")) and not(NPC.GetModifier(Target, "modifier_item_sphere_target")) and not(NPC.GetModifier(Target, "modifier_item_lotus_orb_active")) and not(NPC.GetModifier(Target, "modifier_antimage_counterspell")) then
						if TypeSpell == 1 then
							Ability.CastTarget(Spell,Target,false);
						elseif TypeSpell == 2 then
							Ability.CastPosition(Spell, Entity.GetOrigin(Target), false);
						elseif TypeSpell == 3 then
							Ability.CastNoTarget(Spell, false);
						end
					end
				end
			end
		end
	-- End Cast Damage Spell
	-- Get Item
	function CustomCombo.GetItemList()
		for i = 1, 6 do
			local item = NPC.GetItemByIndex(myHero, i-1);
			local Cheker = true;
			if item then
				if not(Ability.IsPassive(item))  and not(Ability.GetTargetTeam(item) == Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) then
					for j = 1, #ItemList do
						if ItemList[j].spell == item then
							Cheker = false;
						end
					end
					if Cheker then
						local targets = 1;
						if Ability.GetTargetType(item)==Enum.TargetType.DOTA_UNIT_TARGET_NONE then
							targets = 2;
						end
						if CustomCombo.ChekerAbilityType(Ability.GetBehavior(item), Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
							targets = 3;
						end
						ItemList[#ItemList+1]={spell = item, icon = Renderer.LoadImage("panorama/images/items/"..string.sub(Ability.GetName(item) ,string.len("item_") + 1).."_png.vtex_c"), status = false, position = 0, target = targets, channeled = false};
					end
				end
			end
		end
	end
	-- End Get Item
	-- Get Spell
	function CustomCombo.GetSpellList()
		local Spell = Abilities.GetAll();
		if #Spell then
			for i = 1, #Spell do
				if NPC.HasAbility(myHero, Ability.GetName(Spell[i])) and not(Ability.IsPassive(Spell[i])) and not(Ability.IsHidden(Spell[i])) and not(Ability.IsAttributes(Spell[i])) and Ability.GetOwner(Spell[i])== myHero and not(Ability.GetTargetTeam(Spell[i]) == Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) then 
					local Cheker = true;
					for j = 1, #SpellList do
						if SpellList[j].spell == Spell[i] then
							Cheker = false;
						end
					end
					if Cheker then
						
						local targets = 1;
						local channeled = false;
						if CustomCombo.ChekerAbilityType(Ability.GetBehavior(Spell[i]), Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_CHANNELLED) then
							channeled = true;
						end
						if Ability.GetTargetType(Spell[i])==Enum.TargetType.DOTA_UNIT_TARGET_NONE then
							targets = 2;
						end
						if CustomCombo.ChekerAbilityType(Ability.GetBehavior(Spell[i]), Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
							targets = 3;
						end
						SpellList[#SpellList+1]={spell = Spell[i], icon = Renderer.LoadImage("panorama/images/spellicons/"..Ability.GetName(Spell[i]).."_png.vtex_c"), status = false, position = 0, target = targets, channeled = channeled};
					end
				end
			end
		end
	end
	-- End Get Spell
	-- Cheker AbilityBehavior
	function CustomCombo.ChekerAbilityType(a,b)
		local flag = false;
		while a ~= 0 do
			local c = 2^math.floor(math.log(a,2))
			if (b ~= c) then
				a = a - c
			else
				flag = true;
				return flag
			end
		end
		return flag
	end
	-- End Cheker AbilityBehavior
-- End Content
return CustomCombo