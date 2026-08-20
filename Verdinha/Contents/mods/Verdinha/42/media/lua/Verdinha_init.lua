require "Verdinha_context"

local function onGameStart()
    print("Verdinha: mod carregado")
end

Events.OnGameStart.Add(onGameStart)
