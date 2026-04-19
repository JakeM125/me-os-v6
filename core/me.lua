local bridge = peripheral.wrap("me_bridge_0")

local me = {}

function me.snapshot()
    local data = {}
    local ok,items = pcall(bridge.getItems)
    if not ok or not items then return data end

    for _,v in pairs(items) do
        if v.name then
            data[v.name] = v.amount or v.count or 0
        end
    end

    return data
end

function me.cpus()
    local ok,cpus = pcall(bridge.getCraftingCPUs)
    if not ok or not cpus then return 0,0 end

    local busy = 0
    for _,c in pairs(cpus) do
        if c.isBusy then busy = busy + 1 end
    end

    return busy,#cpus
end

function me.craft(name,count)
    if bridge.requestCrafting then
        return pcall(bridge.requestCrafting,name,count)
    end
    return false
end

return me