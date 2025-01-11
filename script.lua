-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModerationMenu"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the Frame (menu background)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 550)
frame.Position = UDim2.new(0.5, -150, 0.5, -275)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Create the "Fly" button
local flyButton = Instance.new("TextButton")
flyButton.Text = "Fly"
flyButton.Size = UDim2.new(0, 280, 0, 40)
flyButton.Position = UDim2.new(0, 10, 0, 460)
flyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.Font = Enum.Font.SourceSans
flyButton.TextSize = 18
flyButton.Parent = frame

-- Create the "Stop Fly" button
local stopFlyButton = Instance.new("TextButton")
stopFlyButton.Text = "Stop Fly"
stopFlyButton.Size = UDim2.new(0, 280, 0, 40)
stopFlyButton.Position = UDim2.new(0, 10, 0, 510)
stopFlyButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
stopFlyButton.TextColor3 = Color3.new(1, 1, 1)
stopFlyButton.Font = Enum.Font.SourceSans
stopFlyButton.TextSize = 18
stopFlyButton.Parent = frame

-- Create the "Close" button
local closeButton = Instance.new("TextButton")
closeButton.Text = "Close"
closeButton.Size = UDim2.new(0, 280, 0, 40)
closeButton.Position = UDim2.new(0, 10, 0, 550)
closeButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 16
closeButton.Parent = frame

-- Variables for Fly functionality
local flying = false
local bodyVelocity = nil

-- Function to enable Fly
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
                    -- Move up
                    bodyVelocity.Velocity = Vector3.new(0, 50, 0)
                elseif input.KeyCode == Enum.KeyCode.LeftShift then
                    -- Move down
                    bodyVelocity.Velocity = Vector3.new(0, -50, 0)
                elseif input.KeyCode == Enum.KeyCode.W then
                    -- Move forward
                    bodyVelocity.Velocity = Vector3.new(0, bodyVelocity.Velocity.Y, 50)
                elseif input.KeyCode == Enum.KeyCode.S then
                    -- Move backward
                    bodyVelocity.Velocity = Vector3.new(0, bodyVelocity.Velocity.Y, -50)
                elseif input.KeyCode == Enum.KeyCode.A then
                    -- Move left
                    bodyVelocity.Velocity = Vector3.new(-50, bodyVelocity.Velocity.Y, 0)
                elseif input.KeyCode == Enum.KeyCode.D then
                    -- Move right
                    bodyVelocity.Velocity = Vector3.new(50, bodyVelocity.Velocity.Y, 0)
                end
            end
        end)
    end
end

-- Function to disable Fly
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

-- Close menu
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
