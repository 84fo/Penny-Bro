-- GUI Teleport Script
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local savedPosition = nil

local screenGui = Instance.new("ScreenGui", game.CoreGui)

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.5, -100, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true

local saveBtn = Instance.new("TextButton", frame)
saveBtn.Size = UDim2.new(1, -20, 0, 40)
saveBtn.Position = UDim2.new(0, 10, 0, 10)
saveBtn.Text = "Save Position"
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
saveBtn.TextColor3 = Color3.new(1,1,1)

local tpBtn = Instance.new("TextButton", frame)
tpBtn.Size = UDim2.new(1, -20, 0, 40)
tpBtn.Position = UDim2.new(0, 10, 0, 60)
tpBtn.Text = "Teleport"
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
tpBtn.TextColor3 = Color3.new(1,1,1)

saveBtn.MouseButton1Click:Connect(function()
    if character and character:FindFirstChild("HumanoidRootPart") then
        savedPosition = character.HumanoidRootPart.CFrame
        saveBtn.Text = "Saved!"
        task.wait(1)
        saveBtn.Text = "Save Position"
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    if savedPosition then
        character.HumanoidRootPart.CFrame = savedPosition
    else
        tpBtn.Text = "No Position!"
        task.wait(1)
        tpBtn.Text = "Teleport"
    end
end)

player.CharacterAdded:Connect(function(char)
    character = char
end)
