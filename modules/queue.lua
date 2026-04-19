local queue = {}

local jobs = {}

function queue.add(name, count)
    jobs[#jobs + 1] = {
        name = name,
        count = count,
        status = "pending"
    }
end

function queue.list()
    return jobs
end

return queue
