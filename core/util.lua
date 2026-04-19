local util = {}

function util.fmt(n)
    if n > 1e6 then return string.format("%.1fM", n/1e6) end
    if n > 1e3 then return string.format("%.1fk", n/1e3) end
    return tostring(n)
end

function util.clean(s)
    return (s or ""):gsub("minecraft:",""):gsub("_"," ")
end

return util