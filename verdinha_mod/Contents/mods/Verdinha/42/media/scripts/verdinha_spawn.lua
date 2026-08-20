-- Verdinha_spawn.lua
-- Adiciona os itens às tabelas de loot do jogo

local function insertVerdinhaLoot()
    -- Locais comuns de cigarro (bares, postos de gasolina, balcões de conveniência, etc.)
    local locations = {
        "Cigarettes",
        "GasStationCounters",
        "BarCounter",
        "StoreCounter",
        "LivingRoomSideTable",
        "GloveBox"
    }

    for _, location in ipairs(locations) do
        if ProceduralDistributions and ProceduralDistributions.list[location] then
            local items = ProceduralDistributions.list[location].items
            
            -- Adiciona os itens com suas respectivas chances (pesos de spawn)
            table.insert(items, "Base.Verdinha")
            table.insert(items, 8) -- Chance de spawn individual
            
            table.insert(items, "Base.VerdinhaPack")
            table.insert(items, 3) -- Chance de spawn do maço
            
            table.insert(items, "Base.VerdinhaBox")
            table.insert(items, 0.5) -- Chance muito rara da caixa completa
        end
    end
end

-- Registra a inserção de loot assim que o jogo carrega a distribuição nativa
Events.OnPreDistributionMerge.Add(insertVerdinhaLoot)