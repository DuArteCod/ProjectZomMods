-- Adiciona e a BRABA aos cenarios narrativos do jogo (Story Clutter)

if StoryClutter then
    local toAdd = {
        ["CigarettePackSingle"] = {"EaBrabaMod.EaBrabaCigarette"},
        ["CigarettePackMulti"]  = {"EaBrabaMod.EaBrabaCigarette"},
        ["CigaretteCarton"]     = {"EaBrabaMod.EaBrabaCigarette"},
    }
    
    for storyType, items in pairs(toAdd) do
        if StoryClutter[storyType] then
            for _, item in ipairs(items) do
                table.insert(StoryClutter[storyType], item)
            end
        end
    end
end
