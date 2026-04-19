local me = require("core/me")
local render = require("ui/render")
local input = require("ui/input")
local state = require("core/state")
local queue = require("modules/queue")

local monitor = peripheral.wrap("monitor_1")
local tick = 0

while true do
    tick = tick + 1
    local data = me.snapshot()

    render.draw(monitor,state,data,tick)

    local event,side,x,y = os.pullEvent()

    if event=="monitor_touch" then
        input.handle(state,{},x,y)

        local idx = state._indexMap and state._indexMap[y-3]
        if idx then
            state.selected = idx
        end
    end

    sleep(0.5)
end