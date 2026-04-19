local base = "https://raw.githubusercontent.com/JakeM125/me-os-v6/main/"

local files = {
    "main.lua",
    "core/me.lua",
    "core/state.lua",
    "core/util.lua",
    "core/health.lua",
    "ui/render.lua",
    "ui/input.lua",
    "modules/queue.lua",
    "modules/inspector.lua"
}

for _, file in ipairs(files) do
    print("Downloading " .. file)

    local url = base .. file
    local res = http.get(url)

    if res then
        local content = res.readAll()
        res.close()

        -- make sure folder exists (important in CC:Tweaked)
        local pathParts = {}
        for part in string.gmatch(file, "[^/]+") do
            table.insert(pathParts, part)
        end

        -- create directories if needed
        if #pathParts > 1 then
            local dir = ""
            for i = 1, #pathParts - 1 do
                dir = dir .. pathParts[i]
                if i < #pathParts - 1 then
                    dir = dir .. "/"
                end
                if not fs.exists(dir) then
                    fs.makeDir(dir)
                end
            end
        end

        local f = fs.open(file, "w")
        f.write(content)
        f.close()

        print("Saved " .. file)
    else
        print("Failed to download " .. file)
    end
end

print("Done.")
