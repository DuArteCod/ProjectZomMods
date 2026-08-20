-- Verdinha_context.lua
-- Adiciona opcoes de contexto para VerdinhaBox e VerdinhaPack (Abrir / Pegar Verdinha)

local function addItemToInventory(playerObj, itemType)
    if not playerObj or not itemType then return false end
    local inv = playerObj:getInventory()
    -- tenta sem prefixo
    local added = inv:AddItem(itemType)
    if added then return true end
    -- tenta com prefixo do mod
    added = inv:AddItem("verdinha." .. itemType)
    if added then return true end
    -- tenta Base. (fallback)
    inv:AddItem("Base." .. itemType)
    return true
end

local function createSingleFromPack(playerObj, packItem)
    if not playerObj or not packItem then return end
    local inv = playerObj:getInventory()
    -- reduzir count do pack
    local packCount = packItem:getCount()
    if packCount and packCount > 1 then
        packItem:setCount(packCount - 1)
    else
        -- remove o pack se era a ultima unidade
        local container = packItem:getContainer()
        if container then container:Remove(packItem) end
    end
    -- adicionar a unidade Verdinha
    addItemToInventory(playerObj, "Verdinha")
end

local function openPackFromBox(playerObj, boxItem)
    if not playerObj or not boxItem then return end
    local inv = playerObj:getInventory()
    -- remove a caixa
    local container = boxItem:getContainer()
    if container then container:Remove(boxItem) end
    -- adicionar 10 macos VerdinhaPack
    for i = 1, 10 do
        addItemToInventory(playerObj, "VerdinhaPack")
    end
end

local function onFillInventoryObjectContextMenu(player, context, items)
    if not items or #items == 0 then return end
    local playerObj = getSpecificPlayer(player - 1)
    for _, item in ipairs(items) do
        local t = item:getType()
        if t == "VerdinhaBox" then
            context:addOption("Abrir caixa (100 da Braba)", playerObj, openPackFromBox, item)
        elseif t == "VerdinhaPack" then
            context:addOption("Pegar Verdinha", playerObj, createSingleFromPack, item)
            -- fumar direto ja eh tratado pelo Smokeable do item; nao precisamos adicionar "Fumar" manualmente
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)
