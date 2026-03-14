-- THIS FILE PUBLISHED BY CRUSTY HUB -- discord.gg/crustyhub
-- MODIFIED: Added balance changer menu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- changeable balance (this is what you edit via the menu)
local PlayerBalance = 492864   -- default value

local ROBUX_CHAR = utf8.char(0xE002)

-- Simple draggable menu to change balance
local function createBalanceMenu()
    if CoreGui:FindFirstChild("BalanceChanger") then return end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "BalanceChanger"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 1001
    gui.Parent = CoreGui
    
    -- Toggle button (floating circle)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 60, 0, 60)
    toggle.Position = UDim2.new(1, -80, 0, 20)
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    toggle.Text = "💰"
    toggle.TextColor3 = Color3.fromRGB(255, 220, 100)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 28
    toggle.AutoButtonColor = false
    toggle.ZIndex = 100
    toggle.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = toggle
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 100)
    stroke.Thickness = 2
    stroke.Parent = toggle
    
    -- Draggable logic for toggle
    local dragging, dragInput, dragStart, startPos
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = toggle.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    toggle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            toggle.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Popup frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 140)
    frame.Position = UDim2.new(0.5, -140, 0.5, -70)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.ZIndex = 101
    frame.Parent = gui
    
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 12)
    uicorner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "Change Fake Balance"
    title.TextColor3 = Color3.fromRGB(220, 220, 230)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = frame
    
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0.9, 0, 0, 36)
    inputBox.Position = UDim2.new(0.05, 0, 0.35, 0)
    inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.PlaceholderText = "Enter new Robux amount..."
    inputBox.Text = tostring(PlayerBalance)
    inputBox.Font = Enum.Font.Gotham
    inputBox.TextSize = 16
    inputBox.ClearTextOnFocus = false
    inputBox.Parent = frame
    
    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(0.9, 0, 0, 40)
    applyBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    applyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    applyBtn.Text = "Apply"
    applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.TextSize = 17
    applyBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = applyBtn
    
    -- Toggle popup
    toggle.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)
    
    -- Apply new balance
    applyBtn.MouseButton1Click:Connect(function()
        local num = tonumber(inputBox.Text)
        if num and num >= 0 then
            PlayerBalance = math.floor(num)
            inputBox.Text = tostring(PlayerBalance)
            -- Optional: show quick feedback
            applyBtn.Text = "Applied!"
            task.delay(1.2, function()
                if applyBtn and applyBtn.Parent then
                    applyBtn.Text = "Apply"
                end
            end)
        else
            inputBox.Text = tostring(PlayerBalance) -- revert if invalid
        end
    end)
    
    -- Close popup when clicking outside (optional improvement)
    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local mousePos = UserInputService:GetMouseLocation()
            local frameAbsPos, frameAbsSize = frame.AbsolutePosition, frame.AbsoluteSize
            if frame.Visible and not (
                mousePos.X >= frameAbsPos.X and mousePos.X <= frameAbsPos.X + frameAbsSize.X and
                mousePos.Y >= frameAbsPos.Y and mousePos.Y <= frameAbsPos.Y + frameAbsSize.Y
            ) and not (
                mousePos.X >= toggle.AbsolutePosition.X and mousePos.X <= toggle.AbsolutePosition.X + toggle.AbsoluteSize.X and
                mousePos.Y >= toggle.AbsolutePosition.Y and mousePos.Y <= toggle.AbsolutePosition.Y + toggle.AbsoluteSize.Y
            ) then
                frame.Visible = false
            end
        end
    end
    UserInputService.InputBegan:Connect(onInputBegan)
end

-- Launch the menu once
task.spawn(createBalanceMenu)

-- ═════════════════════════════════════════════════════════════════════════════
-- The rest of your original script (only changed the balance reference)
-- ═════════════════════════════════════════════════════════════════════════════

local function createBuyUI(itemName, itemPrice, itemImageId, giftedTo)
    local price = tonumber((tostring(itemPrice):gsub("[^%d]", ""))) or 0
    local balanceAfter = PlayerBalance - price   -- ← now uses the changeable variable
    
    if CoreGui:FindFirstChild("BuyItemGUI") then
        CoreGui.BuyItemGUI:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BuyItemGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999
    screenGui.Parent = CoreGui

    -- (the rest of createBuyUI is unchanged — just paste the original body here)
    -- I've removed the repeated long code for brevity, but keep everything from:
    -- local overlay = Instance.new("Frame", screenGui)   ...   all the way to the end of createBuyUI

    -- Important: replace the old hardcoded line:
    -- local PlayerBalance = 492864
    -- with the global one at the top

    -- ... paste original createBuyUI content here ...

    -- At the very end of createBuyUI, it already uses balanceAfter which now pulls from PlayerBalance
end

-- The rest of the script (injectItem, injectContainer, injectAll, etc.) stays exactly the same
-- Just make sure to remove any duplicate local PlayerBalance = 492864 lines

-- (paste the original injection logic here unchanged)

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Balance Changer Injected | discord.gg/crustyhub",
        Text = "Use the floating button to change fake Robux amount",
        Duration = 6,
    })
end)

-- Your original shop waiting/injection loop here...
task.spawn(function()
    -- ... original waiting code ...
end)
