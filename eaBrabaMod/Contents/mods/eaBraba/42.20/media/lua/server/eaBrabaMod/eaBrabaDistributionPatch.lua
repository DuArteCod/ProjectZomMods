require "Items/ProceduralDistributions"

--------------------------------------------------
-- TAXA DE SPAWN (RARIDADE)
--------------------------------------------------

local CIGARETTE_SPAWN_RATE = 10.0

--------------------------------------------------
-- LOCAIS DE SPAWN (B42.20)
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
-- FUNCAO DE ADICAO
--------------------------------------------------

local function addToDistribution(distName, itemName, rate)
    local dist = ProceduralDistributions.list[distName]

    if dist and dist.items then
        table.insert(dist.items, itemName)
        table.insert(dist.items, rate)
    end
end

--------------------------------------------------
-- APLICAR DISTRIBUICAO
--------------------------------------------------

local function applyDistributions()
    for _, location in ipairs(spawnLocations) do
        -- Usar o nome completo do item do mod para spawnar o item custom
        addToDistribution(location, "EaBrabaMod.EaBrabaCigarette", CIGARETTE_SPAWN_RATE)
    end
end

Events.OnPreDistributionMerge.Add(applyDistributions)
