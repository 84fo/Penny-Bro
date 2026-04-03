local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PLACE_ID = game.PlaceId

local servers = {}
local cursor = ""

-- 🔥 Fetch Servers
local function fetch()
    local url = "https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?sortOrder=Asc&limit=100"
    if cursor ~= "" then
        url = url .. "&cursor=" .. cursor
    end

    local success, result = pcall(function()
        return HttpService:GetAsync(url)
    end)

    if success then
        local data = HttpService:JSONDecode(result)

        for _, v in pairs(data.data) do
            if v.playing < v.maxPlayers then
                table.insert(servers, v)
            end
        end

        cursor = data.nextPageCursor or ""
    end
end

-- 🔥 Sort (Ascending = الأفضل)
local function sortServers()
    table.sort(servers, function(a, b)
        local pingA = a.ping or 100
        local pingB = b.ping or 100
        return (a.playing + pingA) < (b.playing + pingB)
    end)
end

-- 🔥 UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PennyBro"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 420)
frame.Position = UDim2.new(0, 20, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)

local layout = Instance.new("UIListLayout", frame)

-- 🔄 Refresh Button
local refresh = Instance.new("TextButton", frame)
refresh.Size = UDim2.new(1,0,0,40)
refresh.Text = "🔄 Refresh Servers"
refresh.BackgroundColor3 = Color3.fromRGB(25,25,25)
refresh.TextColor3 = Color3.new(1,1,1)

-- 🔥 Render
local function render()
    for i, v in ipairs(servers) do
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,30)

        local ping = v.ping or math.random(50,120)

        btn.Text = "👥 "..v.playing.."/"..v.maxPlayers.." | ⚡ "..ping.."ms"
        btn.TextColor3 = Color3.new(1,1,1)

        btn.MouseButton1Click:Connect(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, v.id, Players.LocalPlayer)
        end)
    end
end

-- 🔄 Refresh Action
refresh.MouseButton1Click:Connect(function()
    servers = {}
    cursor = ""

    frame:ClearAllChildren()
    frame:AddChild(layout)
    frame:AddChild(refresh)

    fetch()
    sortServers()
    render()
end)

-- 🚀 Start
fetch()
sortServers()
render()
