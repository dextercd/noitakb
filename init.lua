local minhook = dofile("mods/noitakb/minhook/minhook.lua")("mods/noitakb/minhook")
minhook.initialize()

local SDL = dofile("mods/noitakb/sdl2_ffi.lua")
local ffi = require("ffi")

function OnPlayerSpawned()
    SDL.SDL_StartTextInput()
end

local SDL_PollEvent_hook
SDL_PollEvent_hook = minhook.create_hook(SDL.SDL_PollEvent, function(event)

    local ret = SDL_PollEvent_hook.original(event)
    if ret == 0 then
        return 0
    end

    if event.type == SDL.SDL_TEXTINPUT then
        GamePrint(ffi.string(event.text.text))
    end

    return ret

end)

minhook.enable(SDL.SDL_PollEvent)
