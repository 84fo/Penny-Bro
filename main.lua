--// Anti duplicate
pcall(function()
    game.CoreGui.FakeRobuxPro:Destroy()
end)

--// GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FakeRobuxPro"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 190)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true

--// Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.Text = "💸 Fake Robux Panel"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

--// Close
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,35,0,35)
close.Position = UDim2.new(1,-35,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(170,0,0)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

--// Input
local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8,0,0,35)
box.Position = UDim2.new(0.1,0,0.3,0)
box.PlaceholderText = "Enter Robux Amount"
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.TextColor3 = Color3.new(1,1,1)

--// Button
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.8,0,0,35)
btn.Position = UDim2.new(0.1,0,0.55,0)
btn.Text = "Generate"
btn.BackgroundColor3 = Color3.fromRGB(0,170,255)

--// Result
local result = Instance.new("TextLabel", frame)
result.Size = UDim2.new(0.8,0,0,30)
result.Position = UDim2.new(0.1,0,0.78,0)
result.Text = "Balance: 0 R$"
result.BackgroundTransparency = 1
result.TextColor3 = Color3.fromRGB(0,255,0)
result.TextScaled = true

--// Logic
local balance = 0

btn.MouseButton1Click:Connect(function()
    local num = tonumber(box.Text)

    if num and num > 0 then
        balance += num
        result.Text = "Balance: "..balance.." R$"
    else
        result.Text = "Invalid number"
    end
end)
