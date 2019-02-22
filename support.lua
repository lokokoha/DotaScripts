local Support = {}
local myHero = Heroes.GetLocal()
local myPlayer = Players.GetLocal()
local TimerWards = 1
local TimerTome = 1
Support.optionIcon = Menu.AddOptionIcon({"Support"})
Support.optionEnabled = Menu.AddOptionBool({"Support"}, "Enabled", false)
Support.optionPurchaseIcon = Menu.AddOptionIcon({"Support", "Auto purchase"})
Support.optionWardsIcon = Menu.AddOptionIcon({"Support", "Auto purchase", "Wards"}, "panorama/images/items/ward_dispenser_png.vtex_c")
Support.optionTomeIcon = Menu.AddOptionIcon({"Support", "Auto purchase", "TOME"})
Support.optionDazzleIcon = Menu.AddOptionIcon({"Support", "Dazzle"}, "panorama/images/heroes/icons/npc_dota_hero_dazzle_png.vtex_c")
Support.optionEnabledDazzle = Menu.AddOptionBool({"Support", "Dazzle"}, "Enabled", false)
Support.optionDazzleGraveIcon = Menu.AddOptionIcon({"Support", "Dazzle", "Grave"}, "panorama/images/spellicons/dazzle/immortal/dazzle_shallow_grave_png.vtex_c")
Support.optionDazzleWaveIcon = Menu.AddOptionIcon({"Support", "Dazzle", "Wave"}, "panorama/images/spellicons/dazzle/immortal/dazzle_shallow_grave_png.vtex_c")
Support.optionCountEnemyGrave = Menu.AddOptionSlider({"Support","Dazzle", "Grave"}, "Health", 1, 99, 1)

Support.optionEnabledPurchaseWards = Menu.AddOptionBool({"Support", "Auto purchase", "Wards"}, "Enabled", false)
Support.optionEnabledPurchaseTome = Menu.AddOptionBool({"Support", "Auto purchase", "TOME"}, "Enabled", false)


function Support.OnUpdate()
	if Menu.IsEnabled(Support.optionEnabled) then
		if Menu.IsEnabled(Support.optionEnabledPurchaseWards) then
			Wards = NPC.GetItem(myHero, "item_ward_observer");
			if GameRules.GetGameTime() >= TimerWards*130 then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 42, Vector(0,0,0), 42, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
				TimerWards=TimerWards+1;
			end
		end
		if Menu.IsEnabled(Support.optionEnabledPurchaseTome) then
			if GameRules.GetGameTime() >= TimerTome*670 then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
				TimerTome=TimerTome+1;
			end
		end
		if Menu.IsEnabled(Support.optionEnabledDazzle) then
			Grave = NPC.GetAbility(myHero, "dazzle_shallow_grave");
			if Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Grave), Enum.TeamType.TEAM_FRIEND) then
				Support.DazzleGrave(Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(Grave), Enum.TeamType.TEAM_FRIEND),Grave);
			end
		end
		
    end
end

function Support.DazzleGrave(HeroesRadius,Grave)
	for i = 1, #HeroesRadius do
		if ((Entity.GetMaxHealth(HeroesRadius[i])*0.01)*Menu.GetValue(Support.optionCountEnemyGrave) >= Entity.GetHealth(HeroesRadius[i])) and Entity.GetHeroesInRadius(HeroesRadius[i], 1000, Enum.TeamType.TEAM_ENEMY) and Ability.IsReady(Grave) then
			Ability.CastTarget(Grave,HeroesRadius[i],true);
		end
	end
end

return Support