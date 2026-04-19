local util = require("core/util")
local me = require("core/me")
local health = require("core/health")
local queue = require("modules/queue")
local inspector = require("modules/inspector")

local render = {}

function render.draw(m,state,data,tick)
    local w,h = m.getSize()
    m.setBackgroundColor(colors.black)
    m.clear()

    m.setTextColor(colors.cyan)
    m.setCursorPos(2,1)
    m.write("ME OS v6 SCADA")

    local mid = math.floor(w/2)

    m.setTextColor(colors.yellow)
    m.setCursorPos(2,3)
    m.write("STORAGE")

    local i=0
    state._indexMap={}

    for k,v in pairs(data) do
        i=i+1
        if i>12 then break end
        state._indexMap[i]=k

        m.setCursorPos(2,3+i)
        m.setTextColor(colors.white)
        m.write(util.clean(k):sub(1,10).." "..util.fmt(v))
    end

    local busy,total = me.cpus()

    m.setTextColor(colors.yellow)
    m.setCursorPos(mid+2,3)
    m.write("SYSTEM")

    m.setTextColor(colors.white)
    m.setCursorPos(mid+2,4)
    m.write("CPU "..busy.."/"..total)

    local hdata = health.compute(data,busy,total,0)

    m.setCursorPos(mid+2,5)
    m.write("LOAD "..math.floor(hdata.score*100).."%")

    m.setTextColor(colors.yellow)
    m.setCursorPos(mid+2,7)
    m.write("QUEUE")

    local q = queue.list()
    for i=1,3 do
        local job = q[i]
        if job then
            m.setCursorPos(mid+2,7+i)
            m.setTextColor(colors.white)
            m.write(util.clean(job.name):sub(1,10))
        end
    end

    if inspector.open then
        m.setTextColor(colors.gray)
        m.setCursorPos(mid-5,12)
        m.write("ITEM "..util.clean(inspector.open.item))
    end
end

return render