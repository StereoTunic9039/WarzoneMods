require("UI")
function Client_PresentCommercePurchaseUI(rootParent, game, close)
    Init(rootParent);

    Game = game;
    Close = close;
    root = GetRoot();
    colors = GetColors();

    local line = CreateHorz(root);
    local theText = "Landmines are a special type of unit that cannot be moved. When a territory with a landmine gets attacked it will explode, killing "
    if Mod.Settings.IsFixedDamage then 
        theText = theText .. Mod.Settings.Damage .. " attackers. You can buy a landmine for "
    else
        theText = theText .. Mod.Settings.Damage .. "% of the attackers. You can buy a landmine for "
    end
    local gold; local N = 2
    if Mod.Settings.IsFixedCost then
        gold = Mod.Settings.UnitCost
    else
        if Mod.Settings.ArithmeticIncrease then
            gold = Mod.Settings.UnitInitialCost + N
        else
            gold = Mod.Settings.UnitInitialCost * N
        end
    end
    theText = theText .. gold .. " gold"
    if Mod.Settings.MaxUnits == 0 then 
        theText = theText .. "."
    elseif (Mod.Settings.MaxUnits - N) == 0 then 
        theText = theText .. ", however at this moment you already control the maximum number that is allowed by the game."
    else 
        theText = theText .." and you're allowed to buy " .. Mod.Settings.MaxUnits .. " more of them."
    end

    CreateLabel(line).SetText(theText).SetColor(colors.TextColor);
    CreateButton(line).SetText("Purchase Landmine").SetColor(colors["Dark Green"]).SetOnClick(buyLandmine).SetPreferredWidth(250);
end

function buyLandmine()
    Close();
    local units = 0;
    for _, terr in pairs(Game.LatestStanding.Territories) do
        if terr.OwnerPlayerID == Game.Us.ID then
            units = units + getNLandmines(terr);
        end
    end
    for _,order in pairs(Game.Orders) do
        if order.proxyType == "GameOrderCustom" and startsWith(order.Payload, "BuyLandmine_") then
            units = units + 1;
        end
    end
    if units >= Mod.Settings.MaxUnits and not (Mod.Settings.MaxUnits == 0) then
        UI.Alert("You already have the maximum amount of Landmines, remember that you can delete your purchase orders form the orders menu.");
        return;
    end
    Game.CreateDialog(pickTerr)
end

function pickTerr(rootParent, setMaxSize, setScrollable, game, close)
    Close = close;

    Init(rootParent);
    root = GetRoot().SetFlexibleWidth(1);

    selected = CreateButton(root).SetText("Change territory").SetColor(colors.Orange).SetOnClick(selectTerr);
    label = CreateLabel(root).SetText("").SetColor(colors.TextColor);
    purchase = CreateButton(root).SetText("Purchase Landmine").SetColor(colors.Green).SetOnClick(purchaseLandmine).SetInteractable(false);
    selectTerr();
end

function selectTerr()
    UI.InterceptNextTerritoryClick(terrClicked);
    label.SetText("Click the territory you want to receive the Landmine on. If needed you can move this dialog out of the way");
    selected.SetInteractable(false);
end

function terrClicked(terrDetails)
    selected.SetInteractable(true);
    if terrDetails == nil then
        label.SetText("");
        selectedTerr = nil;
    else
        if Game.LatestStanding.Territories[terrDetails.ID].OwnerPlayerID ~= Game.Us.ID then
            label.SetText("You can only receive a Landmine on a territory you own. Please try again");
            purchase.SetInteractable(false);
        else
            label.SetText("Selected territory: " .. terrDetails.Name);
            selectedTerr = terrDetails;
            purchase.SetInteractable(true);
        end
    end
end

function purchaseLandmine()
    local orders = Game.Orders;
    local index = 0;
    for i, order in pairs(orders) do
        if order.OccursInPhase ~= nil and order.OccursInPhase > WL.TurnPhase.Deploys then
            index = i;
            break;
        end
    end
    if index == 0 then index = #orders + 1; end
    table.insert(orders, index, WL.GameOrderCustom.Create(Game.Us.ID, "Buy a Landmine on " .. selectedTerr.Name, "BuyLandmine_" .. selectedTerr.ID, {[WL.ResourceType.Gold] = Mod.Settings.UnitCost}, WL.TurnPhase.Deploys + 1));
    Game.Orders = orders;
    Close();
end

function getNLandmines(terr)
    local ret = 0;
    for _, sp in pairs(terr.NumArmies.SpecialUnits) do
        if sp.proxyType == "CustomSpecialUnit" and sp.Name == "Landmine" then
            ret = ret + 1;
        end
    end
    return ret;
end

function startsWith(s, sub)
    return string.sub(s, 1, #sub) == sub;
end