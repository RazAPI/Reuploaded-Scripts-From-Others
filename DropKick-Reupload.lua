
--[[
  FULLY MADE BY @sakupenny ON DISCORD
]]

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:FindFirstChild'HumanoidRootPart' or Character.PrimaryPart
local Humanoid = Character:FindFirstChildOfClass'Humanoid' or Character:WaitForChild'Humanoid'

Player.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:FindFirstChild'HumanoidRootPart' or char.PrimaryPart
    Humanoid = char:FindFirstChildOfClass'Humanoid' or char:WaitForChild'Humanoid'
end)

local function findPlayer(NAME)
    local nameLower = NAME:lower()

    for _, player in ipairs(Players:GetPlayers()) do
        if player.DisplayName:lower() == nameLower then
            return player
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name:lower() == nameLower then
            return player
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name:lower():sub(1, #nameLower) == nameLower then
            return player
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        local displayName = player.DisplayName:lower()
        if displayName:sub(1, #nameLower) == nameLower then
            return player
        end
    end

    return nil
end

local dropkick_anim = "rbxassetid://180436148"

local stopped = false


Player.Chatted:Connect(function (msg)
    local splitted = msg:split(" ")

    local command = splitted[1]

    if stopped then return end

    if command == ".stopscript" then
        stopped = true
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end)
        return
    end

    if command ~= ".dropkick" and command ~= ".dp" then
        return
    end

    if not splitted[2] then return end

    local targetuser = table.concat(splitted, "", 2, #splitted)

    local target = findPlayer(targetuser)

    if not target then return end

    if not target.Character then return end

    if not Humanoid then return end

    --// DROPKICK
    print("Started dropkick.")


    --// Running
    local TCharacter = target.Character
    local TRootPart = TCharacter:FindFirstChild("HumanoidRootPart")

    Humanoid:MoveTo(TRootPart.Position)
    Humanoid.WalkSpeed = 85

    repeat
        Humanoid:MoveTo(TRootPart.Position)
        task.wait()
    until (HumanoidRootPart.Position - TRootPart.Position).Magnitude < 5

    local anim = Instance.new("Animation")
    anim.AnimationId = dropkick_anim

    for _, Anim in pairs(Humanoid:GetPlayingAnimationTracks()) do
        Anim:Stop()
    end

    local track = Humanoid:LoadAnimation(anim)

    track:Play()

    track.TimePosition = 0.1
    track:AdjustSpeed(0)

    anim:Destroy()

    Humanoid:MoveTo(HumanoidRootPart.Position)

    local connection = game:GetService('RunService').RenderStepped:Connect(function ()
        if not HumanoidRootPart then return end

        HumanoidRootPart.CFrame = CFrame.new(TRootPart.Position + Vector3.new(0, 1.75, 0) + (TRootPart.CFrame.LookVector * 2.4))
        local direction = (TRootPart.Position - HumanoidRootPart.Position).unit
        local lookAtCFrame = CFrame.lookAt(HumanoidRootPart.Position, TRootPart.Position)
        HumanoidRootPart.CFrame = lookAtCFrame * CFrame.Angles(math.rad(115), math.rad(90), 0)
        HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end)

    task.wait(2)

    connection:Disconnect()

    if not Humanoid then return end

    for _, Anim in pairs(Humanoid:GetPlayingAnimationTracks()) do
        Anim:Stop()
    end

    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, TRootPart.Position or nil)

    Humanoid.Sit = true

    task.wait(1.5)

    Humanoid.Sit = false

    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
end)
