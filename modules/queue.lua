local queue = {list = {}}

function queue.add(name,count)
    queue.list[#queue.list+1] = {
        name=name,
        count=count,
        status="pending"
    }
end

function queue.list()
    return queue.list
end

return queue