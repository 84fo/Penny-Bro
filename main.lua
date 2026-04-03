local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PLACE_ID = game.PlaceId

local servers = {}

-- 🔥 Fetch باستخدام request (مو HttpService)
local function fetchServers()
    local cursor = ""
    
    for i = 1,3 do -- يجيب 3 صفحات
        local url = "https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?sortOrder=Asc&limit=100"
        if cursor ~= "" then
            url = url .. "&cursor="..cursor
        end
        
        local res = request({
            Url = url,
            Method = "GET"
        })
        
        local data = game:GetService("HttpService"):JSONDecode(res.Body)
        
        for _, v in pairs(data.data) do
            if v.playing < v.maxPlayers then
                table.insert(servers, v)
            end
        end
        
        cursor = data.nextPageCursor
        if not cursor then break end
    end
end

-- 🔥 ترتيب احترافي
local function sortServers()
    table.sort(servers, function(a, b)
        return a.playing < b.playing
    end)
end

-- 🔥 UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PennyPro"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 330, 0, 450)
frame.Position = UDim2.new(0, 20, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(10,10,10)

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0,5)

-- 🔄 Refresh
local refresh = Instance.new("TextButton", frame)
refresh.Size = UDim2.new(1,0,0,40)
refresh.Text = "🔄 Refresh (Smart Scan)"
refresh.BackgroundColor3 = Color3.fromRGB(20,20,20)
refresh.TextColor3 = Color3.new(1,1,1)

-- 🔥 Render
local function render()
    for _, v in pairs(servers) do
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(25,25,25)

        btn.Text = "👥 "..v.playing.."/"..v.maxPlayers
        btn.TextColor3 = Color3.new(1,1,1)

        btn.MouseButton1Click:Connect(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, v.id, Players.LocalPlayer)
        end)
    end
end

-- 🔄 Refresh Action
refresh.MouseButton1Click:Connect(function()
    servers = {}

    for _, v in pairs(frame:GetChildren()) do
        if v:IsA("TextButton") and v ~= refresh then
            v:Destroy()
        end
    end

    fetchServers()
    sortServers()
    render()
end)

-- 🚀 تشغيل
fetchServers()
sortServers()
render()
