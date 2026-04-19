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

local function readLocalVersion()
    if not fs.exists("version.txt") then
        return "0.0.0"
    end

    local f = fs.open("version.txt", "r")
    local v = f.readAll()
    f.close()

    return v
end

local function readRemoteVersion()
    local res = http.get(base .. "version.txt")
    if not res then return nil end

    local v = res.readAll()
    res.close()

    return v
end

local function writeFile(path, content)
    local dir = path:match("(.+)/[^/]+$")
    if dir and not fs.exists(dir) then
        fs.makeDir(dir)
    end

    local f = fs.open(path, "w")
    f.write(content)
    f.close()
end

print("Checking for updates...")

local localVersion = readLocalVersion()
local remoteVersion = readRemoteVersion()

if not remoteVersion then
    print("Failed to contact GitHub.")
    return
end

print("Local version: " .. localVersion)
print("Remote version: " .. remoteVersion)

if localVersion == remoteVersion then
    print("Already up to date.")
    return
end

print("Updating ME OS...")

for _, file in ipairs(files) do
    print("Updating " .. file)

    local res = http.get(base .. file)
    if res then
        local content = res.readAll()
        res.close()

        writeFile(file, content)
    else
        print("Failed: " .. file)
    end
end

-- update version
writeFile("version.txt", remoteVersion)

print("Update complete!")

print("Restarting...")
sleep(1)
os.reboot()
