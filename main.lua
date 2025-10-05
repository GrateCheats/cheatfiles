local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")

local isUkraine = false
pcall(function()
    local response = game:HttpGet("http://ip-api.com/json/")
    local data = HttpService:JSONDecode(response)
    if data and data.countryCode == "NN" then
        isUkraine = true
    end
end)

pcall(function()
    if game.CoreGui:FindFirstChild("Hurva") then
        game.CoreGui.Hurva:Destroy()
    end
end)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Hurva"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 600)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ZIndex = 1
local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 15)
local UIStroke = Instance.new("UIStroke", frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255,0,0)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 40, 0, 40)
toggleBtn.Position = UDim2.new(0.5, 260, 0.5, -320)
toggleBtn.AnchorPoint = Vector2.new(0.5, 0)
toggleBtn.Text = "–"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextScaled = true
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.BorderSizePixel = 0
local toggleCorner = Instance.new("UICorner", toggleBtn)
toggleCorner.CornerRadius = UDim.new(1,0)
local guiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    frame.Visible = guiVisible
    toggleBtn.Text = guiVisible and "–" or "+"
end)

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
header.BackgroundTransparency = 0.1
local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 15)
local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Hurva GUI"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextStrokeTransparency = 0.5

local versionLabel = Instance.new("TextLabel", frame)
versionLabel.Size = UDim2.new(0, 120, 0, 25)
versionLabel.AnchorPoint = Vector2.new(1,1)
versionLabel.Position = UDim2.new(1, -10, 1, -10)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v 0.11.0"
versionLabel.Font = Enum.Font.GothamSemibold
versionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
versionLabel.TextScaled = true
versionLabel.ZIndex = 2

local tabFrame = Instance.new("Frame", frame)
tabFrame.Size = UDim2.new(1,0,0,40)
tabFrame.BackgroundTransparency = 1
tabFrame.Position = UDim2.new(0,0,0,60)

local profileBtn = Instance.new("TextButton", tabFrame)
profileBtn.Size = UDim2.new(0.5,0,1,0)
profileBtn.Text = "Profile"
profileBtn.BackgroundColor3 = Color3.fromRGB(60,0,0)
profileBtn.TextColor3 = Color3.new(1,1,1)
profileBtn.Font = Enum.Font.GothamBold
profileBtn.TextScaled = true

local functionsBtn = Instance.new("TextButton", tabFrame)
functionsBtn.Size = UDim2.new(0.5,0,1,0)
functionsBtn.Position = UDim2.new(0.5,0,0,0)
functionsBtn.Text = "Functions"
functionsBtn.BackgroundColor3 = Color3.fromRGB(20,0,0)
functionsBtn.TextColor3 = Color3.new(1,1,1)
functionsBtn.Font = Enum.Font.GothamBold
functionsBtn.TextScaled = true

local profilePage = Instance.new("Frame", frame)
profilePage.Size = UDim2.new(1,0,1,-100)
profilePage.Position = UDim2.new(0,0,0,100)
profilePage.BackgroundTransparency = 1

local functionsPage = Instance.new("Frame", frame)
functionsPage.Size = UDim2.new(1,0,1,-100)
functionsPage.Position = UDim2.new(0,0,0,100)
functionsPage.BackgroundTransparency = 1

functionsPage.Visible = false
profilePage.Visible = true

profileBtn.MouseButton1Click:Connect(function()
    profilePage.Visible = true
    functionsPage.Visible = false
    profileBtn.BackgroundColor3 = Color3.fromRGB(60,0,0)
    functionsBtn.BackgroundColor3 = Color3.fromRGB(20,0,0)
end)

functionsBtn.MouseButton1Click:Connect(function()
    profilePage.Visible = false
    functionsPage.Visible = true
    functionsBtn.BackgroundColor3 = Color3.fromRGB(60,0,0)
    profileBtn.BackgroundColor3 = Color3.fromRGB(20,0,0)
end)

local nick = LocalPlayer.Name
local idByName = {
    ["тутустанавить"] = "DEV_02",
}

local globalProfileStore = getgenv().HurvaIDs or {}
getgenv().HurvaIDs = globalProfileStore

local function generateUniqueID()
    local newID
    repeat
        newID = tostring(math.random(1000000, 10000000))
    until not table.find(globalProfileStore, newID)
    return newID
end

local function getPlayerUniqueID(player)
    if idByName[player.Name] then
        return idByName[player.Name]
    end
    local ip = "local_"..player.UserId
    pcall(function()
        local response = game:HttpGet("http://api.ipify.org/")
        if response and response ~= "" then
            ip = response
        end
    end)
    if globalProfileStore[ip] then
        return globalProfileStore[ip]
    end
    local newID = generateUniqueID()
    globalProfileStore[ip] = newID
    return newID
end

local id = getPlayerUniqueID(LocalPlayer)

local idLabel = Instance.new("TextLabel", profilePage)
idLabel.Size = UDim2.new(1,0,0,50)
idLabel.Text = "ID: "..id
idLabel.TextColor3 = Color3.new(1,1,1)
idLabel.BackgroundTransparency = 1
idLabel.Font = Enum.Font.GothamBold
idLabel.TextScaled = true

local nickLabel = Instance.new("TextLabel", profilePage)
nickLabel.Size = UDim2.new(1,0,0,50)
nickLabel.Position = UDim2.new(0,0,0,60)
nickLabel.Text = "Nick: "..nick
nickLabel.TextColor3 = Color3.new(1,1,1)
nickLabel.BackgroundTransparency = 1
nickLabel.Font = Enum.Font.GothamBold
nickLabel.TextScaled = true

local UIGridLayout = Instance.new("UIGridLayout", functionsPage)
UIGridLayout.CellSize = UDim2.new(0, 220, 0, 60)
UIGridLayout.CellPadding = UDim2.new(0, 20, 0, 20)
UIGridLayout.FillDirection = Enum.FillDirection.Horizontal
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.StartCorner = Enum.StartCorner.TopLeft

local espConn, aimConn, flying, flyConn, noclipConn, wsActive, wsConn, infJumpConn

local function createBtn(text, callback, hasToggle)
    local btn = Instance.new("TextButton", functionsPage)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BorderSizePixel = 0
    local bCorner = Instance.new("UICorner", btn)
    bCorner.CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(255,0,0)
    if isUkraine then
        btn.Text = text..": OFF"
        btn.AutoButtonColor = false
        btn.TextColor3 = Color3.fromRGB(150, 0, 0)
        return
    end
    if hasToggle then
        btn.Text = text..": OFF"
        local state = false
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.Text = text..": "..(state and "ON" or "OFF")
            callback(state)
        end)
    else
        btn.Text = text..": OFF"
        local active = false
        btn.MouseButton1Click:Connect(function()
            active = not active
            btn.Text = text..": "..(active and "ON" or "OFF")
            callback(active)
        end)
    end
end

createBtn("AimBot", function(on)
    if on then
        aimConn = RunService.RenderStepped:Connect(function()
            local closestDist = math.huge
            local closestPlayer = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closestPlayer = p
                    end
                end
            end
            if closestPlayer and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.HumanoidRootPart.Position)
            end
        end)
    else
        if aimConn then aimConn:Disconnect() aimConn = nil end
    end
end, true)

createBtn("WallHack", function(on)
    if on then
        espConn = RunService.RenderStepped:Connect(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("HurvaESP") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "HurvaESP"
                    hl.FillColor = Color3.fromRGB(200, 0, 0)
                    hl.OutlineColor = Color3.new(1, 1, 1)
                    hl.FillTransparency = 0.3
                    hl.OutlineTransparency = 0
                    hl.Adornee = p.Character
                    hl.Parent = p.Character
                end
            end
        end)
    else
        if espConn then espConn:Disconnect() espConn = nil end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local hl = p.Character:FindFirstChild("HurvaESP")
                if hl then hl:Destroy() end
            end
        end
    end
end, true)

createBtn("Fly", function(on)
    flying = on
    if flying then
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local bv = Instance.new("BodyVelocity", root)
        local bg = Instance.new("BodyGyro", root)
        bv.Name = "FlyVelocity"
        bg.Name = "FlyGyro"
        bv.MaxForce = Vector3.new(1e5,1e5,1e5)
        bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
        bg.P = 10000
        flyConn = RunService.RenderStepped:Connect(function()
            if not flying then return end
            local mv = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then mv += Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then mv -= Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then mv -= Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then mv += Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then mv += Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then mv -= Vector3.new(0,1,0) end
            bv.Velocity = (mv.Magnitude>0 and mv.Unit*100 or Vector3.zero)
            bg.CFrame = Camera.CFrame
        end)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            if root:FindFirstChild("FlyVelocity") then root.FlyVelocity:Destroy() end
            if root:FindFirstChild("FlyGyro") then root.FlyGyro:Destroy() end
        end
    end
end, true)

createBtn("NoClip", function(on)
    if on then
        noclipConn = RunService.Stepped:Connect(function()
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    end
end, true)

createBtn("Walkspeed", function(on)
    wsActive = on
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if wsConn then wsConn:Disconnect() wsConn = nil end
    if wsActive and h then
        wsConn = RunService.RenderStepped:Connect(function()
            if h then h.WalkSpeed = 150 end
        end)
    elseif h then h.WalkSpeed = 16 end
end, true)

createBtn("Inf Jump", function(on)
    if on then
        infJumpConn = UIS.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if infJumpConn then infJumpConn:Disconnect() infJumpConn = nil end
    end
end, true)

createBtn("Night Vision", function(on)
    if on then
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 12
    else
        game.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        game.Lighting.Brightness = 1
        game.Lighting.ClockTime = 0
    end
end, true)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        if UIS:IsKeyDown(Enum.KeyCode.LeftAlt) then gui.Enabled = not gui.Enabled end
    elseif input.KeyCode == Enum.KeyCode.LeftAlt then
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then gui.Enabled = not gui.Enabled end
    end
end)
