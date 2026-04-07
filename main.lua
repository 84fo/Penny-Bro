--// حذف القديم لو موجود
pcall(function()
    game.CoreGui.FakeRobuxGUI:Destroy()
end)

--// إنشاء GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local Button = Instance.new("TextButton")
local Result = Instance.new("TextLabel")
local Close = Instance.new("TextButton")

ScreenGui.Name = "FakeRobuxGUI"
ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.Active = true
Frame.Draggable = true

--// عنوان
Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "💸 Fake Robux Generator"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

--// زر إغلاق
Close.Parent = Frame
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-30,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(170,0,0)
Close.TextColor3 = Color3.new(1,1,1)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--// إدخال الرقم
TextBox.Parent = Frame
TextBox.Size = UDim2.new(0.8,0,0,35)
TextBox.Position = UDim2.new(0.1,0,0.3,0)
TextBox.PlaceholderText = "اكتب عدد الروبوكس"
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
TextBox.TextColor3 = Color3.new(1,1,1)

--// زر التنفيذ
Button.Parent = Frame
Button.Size = UDim2.new(0.8,0,0,35)
Button.Position = UDim2.new(0.1,0,0.55,0)
Button.Text = "Generate"
Button.BackgroundColor3 = Color3.fromRGB(0,170,255)
Button.TextColor3 = Color3.new(1,1,1)

--// النتيجة
Result.Parent = Frame
Result.Size = UDim2.new(0.8,0,0,30)
Result.Position = UDim2.new(0.1,0,0.78,0)
Result.Text = "رصيدك: 0"
Result.BackgroundTransparency = 1
Result.TextColor3 = Color3.fromRGB(0,255,0)
Result.TextScaled = true

--// منطق الروبوكس الوهمي
local fakeBalance = 0

Button.MouseButton1Click:Connect(function()
    local amount = tonumber(TextBox.Text)

    if amount and amount > 0 then
        fakeBalance = fakeBalance + amount
        Result.Text = "رصيدك: " .. fakeBalance .. " R$"
    else
        Result.Text = "اكتب رقم صحيح"
    end
end)
