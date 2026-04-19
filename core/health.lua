local health = {}

function health.compute(data,busy,total,queueSize)
    local items = 0
    for _,v in pairs(data) do items = items + v end

    local cpu = total>0 and busy/total or 0
    local queue = math.min(queueSize/10,1)
    local storage = math.min(items/5000000,1)

    return {
        score = cpu*0.4 + queue*0.3 + storage*0.3
    }
end

return health