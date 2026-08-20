-- Verdinha_context.lua

local function getItemFullType(itemType)
    if itemType == "Verdinha" then return "Base.Verdinha" end
    if itemType == "VerdinhaPack" then return "Base.VerdinhaPack" end
    if itemType == "VerdinhaBox" then return "Base.VerdinhaBox" end
    return "Base." .. itemType
end

-- Menu de Contexto (Compatível com B42)
local function onFillInventoryObjectContextMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    if not playerObj then return end

    for _, v in ipairs(items) do
        local testItem = v
        if type(v) == "table" and v.items then
            testItem = v.items[1]
        end

        if testItem and type(testItem) == "userdata" and testItem.getFullType then
            local fullType = testItem:getFullType()
            
            if fullType == "Base.VerdinhaBox" then
                context:addOption("Abrir caixa (100 da Braba)", playerObj, function()
                    local inv = playerObj:getInventory()
                    local container = testItem:getContainer()
                    if container then
                        container:Remove(testItem)
                        for i = 1, 10 do
                            inv:AddItem(getItemFullType("VerdinhaPack"))
                        end
                    end
                end)
                break
                
            elseif fullType == "Base.VerdinhaPack" then
                context:addOption("Pegar Verdinha", playerObj, function()
                    local inv = playerObj:getInventory()
                    inv:AddItem(getItemFullType("Verdinha"))

                    local delta = testItem:getUseDelta()
                    local currentDelta = testItem:getUsedDelta()

                    if currentDelta > (delta + 0.001) then
                        testItem:setUsedDelta(currentDelta - delta)
                    else
                        local container = testItem:getContainer()
                        if container then
                            container:Remove(testItem)
                        else
                            inv:Remove(testItem)
                        end
                    end
                end)
                break
            end
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)