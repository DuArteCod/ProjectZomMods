-- Verdinha_spawn.lua (Atualizado para a API estável da Build 42)

require "Items/ProceduralDistributions"

--------------------------------------------------
-- TAXAS DE SPAWN (RARIDADE INDIVIDUAL)
--------------------------------------------------
local VERDINHA_RATE = 10.0      -- Comum (Cigarro Solto)
local PACK_RATE = 3.0           -- Incomum (Maço com 20)
local BOX_RATE = 0.5            -- Muito Raro (Caixa com 100)

--------------------------------------------------
-- LOCAIS DE SPAWN COMPLETOS (B42)
--------------------------------------------------
local spawnLocations = {
    "BarCounterMisc",
    "BarCounterCigarettes",
    "BedroomDresser",
    "BedroomDresserClassy",
    "BedroomDresserRedneck",
    "BedroomSidetable",
    "BedroomSidetableClassy",
    "BedroomSidetableRedneck",
    "GasStoreSpecial",
    "GloveBox",
    "KitchenRandom",
    "LivingRoomSideTable",
    "MechanicShelfMisc",
    "OfficeDeskStressed",
    "PrisonCellRandom",
    "StoreCounterTobacco",
    "TobaccoStoreCigarettes",
    "UniversitySideTable",
}

--------------------------------------------------
-- FUNÇÃO AUXILIAR DE INSERÇÃO
--------------------------------------------------
local function addToDistribution(distName, itemName, rate)
    local dist = ProceduralDistributions.list[distName]

    if dist and dist.items then
        table.insert(dist.items, itemName)
        table.insert(dist.items, rate)
    end
end

--------------------------------------------------
-- APLICAR DISTRIBUIÇÃO NO MAPA
--------------------------------------------------
local function applyVerdinhaDistributions()
    if not ProceduralDistributions or not ProceduralDistributions.list then return end

    for _, location in ipairs(spawnLocations) do
        addToDistribution(location, "VerdinhaMod.Verdinha", VERDINHA_RATE)
        addToDistribution(location, "VerdinhaMod.VerdinhaPack", PACK_RATE)
        addToDistribution(location, "VerdinhaMod.VerdinhaBox", BOX_RATE)
    end
end

Events.OnPreDistributionMerge.Add(applyVerdinhaDistributions)
