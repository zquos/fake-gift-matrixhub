loadstring([[

-- THIS FILE PUBLISHED BY CRUSTY HUB -- discord.gg/crustyhub
-- Modified only: default balance changed to 436800 (436.8k)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local PlayerBalance = 436800   -- ← changed here (was 492864)

local ROBUX_CHAR = utf8.char(0xE002)

local function createBuyUI(itemName, itemPrice, itemImageId, giftedTo)
    local price = tonumber((tostring(itemPrice):gsub("[^%d]", ""))) or 0
    local balanceAfter = PlayerBalance - price
    if CoreGui:FindFirstChild("BuyItemGUI") then CoreGui.BuyItemGUI:Destroy() end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BuyItemGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999
    screenGui.Parent = CoreGui
    local overlay = Instance.new("Frame", screenGui)
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    overlay.BackgroundTransparency = 0.55
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 10
    local card = Instance.new("Frame", screenGui)
    card.Name = "Card"
    card.Size = UDim2.new(0,380,0,315)
    card.AnchorPoint = Vector2.new(0.5,0.5)
    card.Position = UDim2.new(0.5,0,-0.3,0)
    card.BackgroundColor3 = Color3.fromRGB(34,34,40)
    card.BorderSizePixel = 0
    card.ZIndex = 11
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,14)
    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1,0,0,54); title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1; title.Text = "Buy Item"
    title.TextColor3 = Color3.fromRGB(255,255,255); title.Font = Enum.Font.GothamBold
    title.TextSize = 20; title.TextXAlignment = Enum.TextXAlignment.Center; title.ZIndex = 12
    local divider = Instance.new("Frame", card)
    divider.Size = UDim2.new(1,0,0,1); divider.Position = UDim2.new(0,0,0,54)
    divider.BackgroundColor3 = Color3.fromRGB(52,52,62); divider.BorderSizePixel = 0; divider.ZIndex = 12
    local imgHolder = Instance.new("Frame", card)
    imgHolder.Size = UDim2.new(0,88,0,88); imgHolder.AnchorPoint = Vector2.new(0.5,0)
    imgHolder.Position = UDim2.new(0.5,0,0,68); imgHolder.BackgroundTransparency = 1; imgHolder.ZIndex = 12
    local itemImg = Instance.new("ImageLabel", imgHolder)
    itemImg.Size = UDim2.new(1,0,1,0); itemImg.BackgroundTransparency = 1
    itemImg.Image = itemImageId or ""; itemImg.ScaleType = Enum.ScaleType.Fit; itemImg.ZIndex = 13
    local question = Instance.new("TextLabel", card)
    question.Size = UDim2.new(1,-50,0,46); question.AnchorPoint = Vector2.new(0.5,0)
    question.Position = UDim2.new(0.5,0,0,168); question.BackgroundTransparency = 1
    question.Text = 'Would you like to buy "'..itemName..'"?' 
    question.TextColor3 = Color3.fromRGB(208,208,214); question.Font = Enum.Font.GothamMedium
    question.TextSize = 14; question.TextWrapped = true
    question.TextXAlignment = Enum.TextXAlignment.Center; question.ZIndex = 12
    local BTN_W = 160; local BTN_H = 46; local BTN_Y = 226
    local GAP = 12; local LEFT_X = math.floor((380-(BTN_W*2+GAP))/2)
    local cancelBtn = Instance.new("TextButton", card)
    cancelBtn.Name = "CancelButton"; cancelBtn.Size = UDim2.new(0,BTN_W,0,BTN_H)
    cancelBtn.Position = UDim2.new(0,LEFT_X,0,BTN_Y)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(42,42,52); cancelBtn.AutoButtonColor = false
    cancelBtn.BorderSizePixel = 0; cancelBtn.Text = "Cancel"
    cancelBtn.TextColor3 = Color3.fromRGB(205,205,212); cancelBtn.Font = Enum.Font.GothamMedium
    cancelBtn.TextSize = 15; cancelBtn.ZIndex = 15
    Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0,9)
    local cStr = Instance.new("UIStroke", cancelBtn)
    cStr.Color = Color3.fromRGB(68,68,82); cStr.Thickness = 1.2
    local buyBtn = Instance.new("TextButton", card)
    buyBtn.Name = "BuyButton"; buyBtn.Size = UDim2.new(0,BTN_W,0,BTN_H)
    buyBtn.Position = UDim2.new(0,LEFT_X+BTN_W+GAP,0,BTN_Y)
    buyBtn.BackgroundColor3 = Color3.fromRGB(242,242,242); buyBtn.AutoButtonColor = false
    buyBtn.BorderSizePixel = 0; buyBtn.Text = ""; buyBtn.ZIndex = 15; buyBtn.ClipsDescendants = true
    Instance.new("UICorner", buyBtn).CornerRadius = UDim.new(0,9)
    local fillBar = Instance.new("Frame", buyBtn)
    fillBar.Size = UDim2.new(0,0,1,0); fillBar.Position = UDim2.new(0,0,0,0)
    fillBar.BackgroundColor3 = Color3.fromRGB(18,18,18); fillBar.BorderSizePixel = 0; fillBar.ZIndex = 16
    local buyRow = Instance.new("Frame", buyBtn)
    buyRow.Size = UDim2.new(1,0,1,0); buyRow.BackgroundTransparency = 1; buyRow.ZIndex = 17
    local brl = Instance.new("UIListLayout", buyRow)
    brl.FillDirection = Enum.FillDirection.Horizontal
    brl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    brl.VerticalAlignment = Enum.VerticalAlignment.Center
    brl.Padding = UDim.new(0,4)
    local robuxIco = Instance.new("TextLabel", buyRow)
    robuxIco.Size = UDim2.new(0,26,1,0); robuxIco.BackgroundTransparency = 1
    robuxIco.Text = ROBUX_CHAR; robuxIco.TextColor3 = Color3.fromRGB(18,18,18)
    robuxIco.Font = Enum.Font.GothamBold; robuxIco.TextSize = 24
    robuxIco.TextXAlignment = Enum.TextXAlignment.Center; robuxIco.ZIndex = 18
    local buyPriceLabel = Instance.new("TextLabel", buyRow)
    buyPriceLabel.Size = UDim2.new(0,55,1,0); buyPriceLabel.BackgroundTransparency = 1
    buyPriceLabel.Text = tostring(price); buyPriceLabel.TextColor3 = Color3.fromRGB(18,18,18)
    buyPriceLabel.Font = Enum.Font.GothamBold; buyPriceLabel.TextSize = 16
    buyPriceLabel.TextXAlignment = Enum.TextXAlignment.Left; buyPriceLabel.ZIndex = 18
    local balLabel = Instance.new("TextLabel", card)
    balLabel.Size = UDim2.new(1,-30,0,22); balLabel.AnchorPoint = Vector2.new(0.5,0)
    balLabel.Position = UDim2.new(0.5,0,0,284); balLabel.BackgroundTransparency = 1
    balLabel.Text = "Your balance after this transaction will be "..ROBUX_CHAR.." "..tostring(balanceAfter)
    balLabel.TextColor3 = Color3.fromRGB(112,112,126); balLabel.Font = Enum.Font.GothamMedium
    balLabel.TextSize = 11; balLabel.TextXAlignment = Enum.TextXAlignment.Center; balLabel.ZIndex = 12
    local sCard = Instance.new("Frame", screenGui)
    sCard.Name = "SuccessCard"; sCard.Size = UDim2.new(0,380,0,200)
    sCard.AnchorPoint = Vector2.new(0.5,0.5); sCard.Position = UDim2.new(0.5,0,-0.4,0)
    sCard.BackgroundColor3 = Color3.fromRGB(34,34,40); sCard.BorderSizePixel = 0
    sCard.ZIndex = 20; sCard.Visible = false
    Instance.new("UICorner", sCard).CornerRadius = UDim.new(0,14)
    local sTitle = Instance.new("TextLabel", sCard)
    sTitle.Size = UDim2.new(1,0,0,54); sTitle.Position = UDim2.new(0,0,0,0)
    sTitle.BackgroundTransparency = 1; sTitle.Text = "Buy Item"
    sTitle.TextColor3 = Color3.fromRGB(255,255,255); sTitle.Font = Enum.Font.GothamBold
    sTitle.TextSize = 20; sTitle.TextXAlignment = Enum.TextXAlignment.Center; sTitle.ZIndex = 21
    local sDivider = Instance.new("Frame", sCard)
    sDivider.Size = UDim2.new(1,0,0,1); sDivider.Position = UDim2.new(0,0,0,54)
    sDivider.BackgroundColor3 = Color3.fromRGB(52,52,62); sDivider.BorderSizePixel = 0; sDivider.ZIndex = 21
    local successMsg = Instance.new("TextLabel", sCard)
    successMsg.Size = UDim2.new(1,-50,0,52); successMsg.AnchorPoint = Vector2.new(0.5,0)
    successMsg.Position = UDim2.new(0.5,0,0,68); successMsg.BackgroundTransparency = 1
    if giftedTo and giftedTo ~= "" then
        successMsg.Text = "Successfully Gifted \""..itemName.."\" to "..giftedTo.."!"
    else
        successMsg.Text = "Successfully Purchased \""..itemName.."\"!"
    end
    successMsg.TextColor3 = Color3.fromRGB(208,208,214); successMsg.Font = Enum.Font.GothamMedium
    successMsg.TextSize = 15; successMsg.TextWrapped = true
    successMsg.TextXAlignment = Enum.TextXAlignment.Center; successMsg.ZIndex = 21
    local okBtn = Instance.new("TextButton", sCard)
    okBtn.Size = UDim2.new(1,-32,0,50); okBtn.AnchorPoint = Vector2.new(0.5,0)
    okBtn.Position = UDim2.new(0.5,0,0,132); okBtn.BackgroundColor3 = Color3.fromRGB(240,240,240)
    okBtn.AutoButtonColor = false; okBtn.BorderSizePixel = 0; okBtn.Text = "OK"
    okBtn.TextColor3 = Color3.fromRGB(18,18,18); okBtn.Font = Enum.Font.GothamBold
    okBtn.TextSize = 17; okBtn.ZIndex = 22
    Instance.new("UICorner", okBtn).CornerRadius = UDim.new(0,10)
    cancelBtn.MouseEnter:Connect(function()
        TweenService:Create(cancelBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(58,58,70)}):Play()
    end)
    cancelBtn.MouseLeave:Connect(function()
        TweenService:Create(cancelBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(42,42,52)}):Play()
    end)
    okBtn.MouseEnter:Connect(function()
        TweenService:Create(okBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(215,215,215)}):Play()
    end)
    okBtn.MouseLeave:Connect(function()
        TweenService:Create(okBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(240,240,240)}):Play()
    end)
    local closing=false; local fillDone=false; local buyDone=false; local fillTween=nil
    local function closeDown()
        if closing then return end; closing=true
        if fillTween then fillTween:Cancel() end
        TweenService:Create(card,TweenInfo.new(0.32,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,1.4,0)}):Play()
        TweenService:Create(overlay,TweenInfo.new(0.30),{BackgroundTransparency=1}):Play()
        task.delay(0.33,function() screenGui:Destroy() end)
    end
    local function closeSuccess()
        if closing then return end; closing=true
        TweenService:Create(sCard,TweenInfo.new(0.32,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,1.4,0)}):Play()
        TweenService:Create(overlay,TweenInfo.new(0.30),{BackgroundTransparency=1}):Play()
        task.delay(0.33,function() screenGui:Destroy() end)
    end
    local function showSuccess()
        card.Visible=false; sCard.Visible=true; sCard.Position=UDim2.new(0.5,0,-0.35,0)
        TweenService:Create(sCard,TweenInfo.new(0.38,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.5,0)}):Play()
        pcall(function()
            local successSfx = game:GetService("ReplicatedStorage").Sounds.Sfx.Success
            successSfx:Play()
        end)
        if giftedTo and giftedTo ~= "" then
            if CoreGui:FindFirstChild("GiftLabelGUI") then CoreGui.GiftLabelGUI:Destroy() end
            local gGui = Instance.new("ScreenGui")
            gGui.Name = "GiftLabelGUI"
            gGui.ResetOnSpawn = false
            gGui.IgnoreGuiInset = true
            gGui.DisplayOrder = 1000
            gGui.Parent = CoreGui
            local gLabel = Instance.new("TextLabel", gGui)
            gLabel.Size = UDim2.new(1,0,0,40)
            gLabel.AnchorPoint = Vector2.new(0.5,1)
            gLabel.Position = UDim2.new(0.5,0,1,-64)
            gLabel.BackgroundTransparency = 1
            gLabel.RichText = true
            gLabel.Text = '<font color="#92FF67">Successfully Gifted To '..giftedTo..'</font>'
            gLabel.Font = Enum.Font.GothamBold
            gLabel.TextSize = 19
            gLabel.TextXAlignment = Enum.TextXAlignment.Center
            gLabel.ZIndex = 5
            task.delay(5, function()
                if not gGui or not gGui.Parent then return end
                for i = 1, 20 do
                    task.wait(0.05)
                    if gLabel and gLabel.Parent then
                        gLabel.TextTransparency = i / 20
                    end
                end
                pcall(function() gGui:Destroy() end)
            end)
            screenGui.AncestryChanged:Connect(function()
                if not screenGui.Parent then
                    pcall(function() gGui:Destroy() end)
                end
            end)
        end
    end
    local slideTween=TweenService:Create(card,TweenInfo.new(0.42,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.5,0)})
    slideTween:Play()
    slideTween.Completed:Connect(function()
        if closing then return end
        robuxIco.TextColor3=Color3.fromRGB(255,255,255)
        buyPriceLabel.TextColor3=Color3.fromRGB(255,255,255)
        fillTween=TweenService:Create(fillBar,TweenInfo.new(1.5,Enum.EasingStyle.Linear),{Size=UDim2.new(1,0,1,0)})
        fillTween:Play()
        fillTween.Completed:Connect(function(state)
            if state~=Enum.PlaybackState.Completed or closing then return end
            fillDone=true
            TweenService:Create(fillBar,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
            TweenService:Create(robuxIco,TweenInfo.new(0.15),{TextColor3=Color3.fromRGB(18,18,18)}):Play()
            TweenService:Create(buyPriceLabel,TweenInfo.new(0.15),{TextColor3=Color3.fromRGB(18,18,18)}):Play()
        end)
    end)
    cancelBtn.MouseButton1Click:Connect(function() closeDown() end)
    buyBtn.MouseButton1Click:Connect(function()
        if not fillDone or buyDone or closing then return end
        buyDone=true; showSuccess()
    end)
    okBtn.MouseButton1Click:Connect(function() closeSuccess() end)
    overlay.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 then
            if sCard.Visible then closeSuccess() else closeDown() end
        end
    end)
end

local function injectItem(item)
    if item:FindFirstChild("__inj") then return end
    local buyObj = item:FindFirstChild("Buy")
    if not buyObj then return end
    local priceLbl = buyObj:FindFirstChild("Price") or item:FindFirstChild("Price")
    local nameLbl = item:FindFirstChild("ItemName") or item:FindFirstChild("Text")
    local iconObj = item:FindFirstChild("Icon")
    local itemName = (nameLbl and nameLbl.Text) or "Unknown"
    local itemPrice = (priceLbl and priceLbl.Text) or "0"
    local itemImageId = (iconObj and iconObj.Image) or ""
    local ghost = Instance.new("TextButton", buyObj)
    ghost.Name = "GhostBtn"
    ghost.Size = UDim2.new(1,0,1,0)
    ghost.Position = UDim2.new(0,0,0,0)
    ghost.AnchorPoint = Vector2.new(0,0)
    ghost.BackgroundTransparency = 1
    ghost.Text = ""
    ghost.AutoButtonColor = false
    ghost.BorderSizePixel = 0
    ghost.ZIndex = buyObj.ZIndex + 20
    local tag = Instance.new("BoolValue", item)
    tag.Name = "__inj"
    ghost.MouseButton1Click:Connect(function()
        local snd = Instance.new("Sound", game:GetService("SoundService"))
        snd.SoundId = "rbxassetid://75311202481026"
        snd.Volume = 1
        snd:Play()
        game:GetService("Debris"):AddItem(snd, 5)
        local giftedTo = nil
        pcall(function()
            local giftBtn = game:GetService("Players").LocalPlayer.PlayerGui.Shop.Shop.GiftPlayerSelect.Buttons.GiftButton
            local txt = giftBtn:FindFirstChild("Txt")
            if txt and txt:IsA("TextLabel") then
                if string.lower(txt.Text) == "back" then
                    local playerNameLbl = game:GetService("Players").LocalPlayer.PlayerGui.Shop.Shop.GiftPlayerSelect.PlayerSelected.PlayerName
                    if playerNameLbl then
                        local ct = playerNameLbl:FindFirstChild("ContentText") or playerNameLbl
                        giftedTo = ct.Text
                    end
                end
            end
        end)
        createBuyUI(itemName, itemPrice, itemImageId, giftedTo)
    end)
end

local function injectContainer(container, label)
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("ImageLabel") or child:IsA("Frame") then
            pcall(injectItem, child)
        end
    end
    container.ChildAdded:Connect(function(child)
        task.wait(0.1)
        if child:IsA("ImageLabel") or child:IsA("Frame") then
            pcall(injectItem, child)
        end
    end)
end

local function injectAll()
    local shopGui = playerGui:FindFirstChild(player.DisplayName..".Shop") or playerGui:FindFirstChild(player.Name..".Shop") or playerGui:FindFirstChild("Shop")
    if not shopGui then return end
    local inner = shopGui:FindFirstChild("Shop")
    local content = inner and inner:FindFirstChild("Content")
    local list = content and content:FindFirstChild("List")
    if not list then return end
    local itemsList = list:FindFirstChild("ItemsList")
    if itemsList then injectContainer(itemsList, "ItemsList") end
    local gamepassList = list:FindFirstChild("GamepassList")
    if gamepassList then
        injectContainer(gamepassList, "GamepassList")
        local main = gamepassList:FindFirstChild("Main")
        if main then injectContainer(main, "GamepassList.Main") end
    end
    local serverLuck = list:FindFirstChild("ServerLuck")
    if serverLuck then
        local slFrame = serverLuck:FindFirstChild("Frame")
        if slFrame then pcall(injectItem, slFrame) end
        serverLuck.ChildAdded:Connect(function(child)
            task.wait(0.1)
            if child.Name == "Frame" then pcall(injectItem, child) end
        end)
    end
end

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Successfully Injected | discord.gg/crustyhub",
        Text = "Successfully Injected To Gears And Passes (balance set to 436.8k)",
        Duration = 5,
    })
end)

task.spawn(function()
    local names = {player.DisplayName..".Shop", player.Name..".Shop", "Shop"}
    local found, waited = false, 0
    repeat
        task.wait(0.5); waited += 0.5
        for _,n in ipairs(names) do
            if playerGui:FindFirstChild(n) then found=true; break end
        end
    until found or waited >= 20
    if not found then return end
    task.wait(0.3)
    injectAll()
end)

]] )()
