-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullMenu"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the Frame (menu background)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 600)
frame.Position = UDim2.new(0.5, -150, 0.5, -300)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Create the "Fly" button
local flyButton = Instance.new("TextButton")
flyButton.Text = "Fly"
flyButton.Size = UDim2.new(0, 280, 0, 40)
flyButton.Position = UDim2.new(0, 10, 0, 60)
flyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.Font = Enum.Font.SourceSans
flyButton.TextSize = 18
flyButton.Parent = frame

-- Create the "Stop Fly" button
local stopFlyButton = Instance.new("TextButton")
stopFlyButton.Text = "Stop Fly"
stopFlyButton.Size = UDim2.new(0, 280, 0, 40)
stopFlyButton.Position = UDim2.new(0, 10, 0, 110)
stopFlyButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
stopFlyButton.TextColor3 = Color3.new(1, 1, 1)
stopFlyButton.Font = Enum.Font.SourceSans
stopFlyButton.TextSize = 18
stopFlyButton.Parent = frame

-- Create the "God Mode" button
local godModeButton = Instance.new("TextButton")
godModeButton.Text = "God Mode"
godModeButton.Size = UDim2.new(0, 280, 0, 40)
godModeButton.Position = UDim2.new(0, 10, 0, 160)
godModeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
godModeButton.TextColor3 = Color3.new(1, 1, 1)
godModeButton.Font = Enum.Font.SourceSans
godModeButton.TextSize = 18
godModeButton.Parent = frame

-- Create the "Highlight All" button
local highlightAllButton = Instance.new("TextButton")
highlightAllButton.Text = "Highlight All"
highlightAllButton.Size = UDim2.new(0, 280, 0, 40)
highlightAllButton.Position = UDim2.new(0, 10, 0, 210)
highlightAllButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
highlightAllButton.TextColor3 = Color3.new(1, 1, 1)
highlightAllButton.Font = Enum.Font.SourceSans
highlightAllButton.TextSize = 18
highlightAllButton.Parent = frame

-- Create the "Free Cam" button
local freeCamButton = Instance.new("TextButton")
freeCamButton.Text = "Free Cam"
freeCamButton.Size = UDim2.new(0, 280, 0, 40)
freeCamButton.Position = UDim2.new(0, 10, 0, 260)
freeCamButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
freeCamButton.TextColor3 = Color3.new(1, 1, 1)
freeCamButton.Font = Enum.Font.SourceSans
freeCamButton.TextSize = 18
freeCamButton.Parent = frame

-- Create the "Anti AFK" button
local antiAfkButton = Instance.new("TextButton")
antiAfkButton.Text = "Anti AFK"
antiAfkButton.Size = UDim2.new(0, 280, 0, 40)
antiAfkButton.Position = UDim2.new(0, 10, 0, 310)
antiAfkButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
antiAfkButton.TextColor3 = Color3.new(1, 1, 1)
antiAfkButton.Font = Enum.Font.SourceSans
antiAfkButton.TextSize = 18
antiAfkButton.Parent = frame

-- Create the "Close" button
local closeButton = Instance.new("TextButton")
closeButton.Text = "Close"
closeButton.Size = UDim2.new(0, 280, 0, 40)
closeButton.Position = UDim2.new(0, 10, 0, 510)
closeButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 16
closeButton.Parent = frame

-- Variables for Fly functionality
local flying = false
local bodyVelocity = nil

-- Enable Fly function
local function enableFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    if not flying then
        flying = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000) -- High force to keep the player floating
        bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Initial upward velocity
        bodyVelocity.Parent = rootPart

        -- Listen for keyboard inputs to move the player while flying
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if flying then
                if input.KeyCode == Enum.KeyCode.Space then
                    bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Move up
                elseif input.KeyCode == Enum.KeyCode.LeftShift then
                    bodyVelocity.Velocity = Vector3.new(0, -50, 0) -- Move down
                elseif input.KeyCode == Enum.KeyCode.W then
                    bodyVelocity.Velocity = Vector3.new(0, bodyVelocity.Velocity.Y, 50) -- Move forward
                elseif input.KeyCode == Enum.KeyCode.S then
                    bodyVelocity.Velocity = Vector3.new(0, bodyVelocity.Velocity.Y, -50) -- Move backward
                elseif input.KeyCode == Enum.KeyCode.A then
                    bodyVelocity.Velocity = Vector3.new(-50, bodyVelocity.Velocity.Y, 0) -- Move left
                elseif input.KeyCode == Enum.KeyCode.D then
                    bodyVelocity.Velocity = Vector3.new(50, bodyVelocity.Velocity.Y, 0) -- Move right
                end
            end
        end)
    end
end

-- Disable Fly function
local function disableFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    if flying then
        flying = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end

-- Toggle God Mode (Infinite Health)
local function toggleGodMode()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    if humanoid.Health == humanoid.MaxHealth then
        humanoid.Health = humanoid.MaxHealth -- Infinite health
    end
end

-- Highlight All players with OnScaling enabled
local function highlightAllPlayers()
    for _, target in pairs(game.Players:GetPlayers()) do
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = target.Character
            highlight.Adornee = target.Character
            highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Yellow color
            highlight.FillTransparency = 0.5
            highlight.OnScaling = true  -- Enable OnScaling for the highlight
        end
    end
end

-- Start/Stop Free Cam
local function toggleFreeCam()
    local player = game.Players.LocalPlayer
    local camera = game.Workspace.CurrentCamera

    if camera.CameraType == Enum.CameraType.Scriptable then
        camera.CameraType = Enum.CameraType.Custom
    else
        camera.CameraType = Enum.CameraType.Scriptable
    end
end

-- Anti AFK function
local function antiAfk()
    while true do
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.Health -- Reset health to avoid AFK kicks
            end
        end
        wait(5) -- Check every 5 seconds
    end
end

-- Button action for Fly
flyButton.MouseButton1Click:Connect(function()
    if flying then
        disableFly()  -- If flying, disable it when the button is clicked again
    else
        enableFly()   -- If not flying, enable fly
    end
end)

-- Button action for Stop Fly
stopFlyButton.MouseButton1Click:Connect(function()
    disableFly()  -- Stops the fly immediately
end)

-- Button action for God Mode
godModeButton.MouseButton1Click:Connect(function()
    toggleGodMode()  -- Activates infinite health
end)

-- Button action for Highlight All
highlightAllButton.MouseButton1Click:Connect(function()
    highlightAllPlayers()  -- Highlights all players with OnScaling enabled
end)

-- Button action for Free Cam
freeCamButton.MouseButton1Click:Connect(function()
    toggleFreeCam()  -- Toggles Free Cam mode
end)

-- Button action for Anti AFK
antiAfkButton.MouseButton1Click:Connect(function()
    coroutine.wrap(antiAfk)()  -- Start Anti AFK feature
end)

-- Close menu
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
