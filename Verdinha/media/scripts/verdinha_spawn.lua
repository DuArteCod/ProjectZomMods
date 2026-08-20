-- verdinha_spawn.lua
-- Injeta VerdinhaPack e VerdinhaBox nos mesmos locais onde Cigarettes aparece
local function addVerdinhaToDistributions()
    if not Distributions then return end
    for distName, dist in pairs(Distributions) do
        -- estrutura comum: dist.items é uma tabela intercalada {item, weight, item, weight, ...}
        if dist.items then
            local i = 1
            while i <= #dist.items do
                local itemType = dist.items[i]
                if itemType == "Cigarettes" then
                    -- inserir logo após a entrada atual (mantendo pesos baixos para packs/boxes)
                    table.insert(dist.items, i + 2, "VerdinhaPack")
                    table.insert(dist.items, i + 3, 1)    -- weight
                    table.insert(dist.items, i + 4, "VerdinhaBox")
                    table.insert(dist.items, i + 5, 0.1)  -- weight
                    i = i + 5
                else
                    i = i + 2
                end
            end
        end
        -- casos onde existe subcategory/items
        if dist.items and type(dist.items) == "table" and dist.items.items then
            local items = dist.items.items
            local j = 1
            while j <= #items do
                if items[j] == "Cigarettes" then
                    table.insert(items, j + 2, "VerdinhaPack")
                    table.insert(items, j + 3, 1)
                    table.insert(items, j + 4, "VerdinhaBox")
                    table.insert(items, j + 5, 0.1)
                    j = j + 5
                else
                    j = j + 2
                end
            end
        end
    end
    print("Verdinha: distribuições modificadas")
end

Events.OnLoad.Add(addVerdinhaToDistributions)
