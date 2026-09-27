-- Ride a Pet | Nasi Rendang Style v5.0
-- By: DexGPT
-- Compatible: Delta, Arceus X, Fluxus

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- CLEANUP
local old = PlayerGui:FindFirstChild("NR_GUI")
if old then old:Destroy() end

-- ═══════════════════════════
-- SETTINGS
-- ═══════════════════════════
local S = {
    InstantTeleport = false,
    AutoFarmEggs = false,
    AutoFarmRebirthEgg = false,
    FarmingNoclip = false,
    GlideSpeed = 1000,
    AutoHatch = false,
    AutoFeedPets = false,
    FeedBestPetOnly = false,
    AutoSellPet = false,
    EggESP = false,
    PetESP = false,
    OnlyMyPets = false,
    FPSBoost = false,
    AutoServerHop = false,
    StopWhenFound = true,
    AntiAFK = true,
    AutoReconnect = true,
    AutoExecute = false,
    WebhookURL = "",
    WebhookEnabled = false,
    SelectedRarity = "All",
    SelectedEggs = {},
}

local RARITIES = {"All","Uncommon","Rare","Epic","Legendary","Mythic","Divine","Ethereal"}

local EGG_LIST = {
    "White Egg","Brown Egg","Cracked Egg","Easter Egg",
    "Stone Egg","Leaf Egg","Mushroom Egg",
    "Flower Egg","Slime Egg","ice Egg",
    "Glass Egg","Golden Egg","Diamond Egg","Crystal Egg","Skull Egg","Dominus Egg","Flaming Egg","Sinister Egg","Soul Egg","Aurora Egg","Galaxy Egg","Blackhole Egg","Solaris Egg","Cherub Egg"
}

-- ═══════════════════════════
-- SCREEN GUI
-- ═══════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NR_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- MAIN
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 660, 0, 540)
Main.Position = UDim2.new(0.5,-330,0.5,-270)
Main.BackgroundColor3 = Color3.fromRGB(18,18,26)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)
local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(50,50,70)
ms.Thickness = 1
ms.Parent = Main

-- TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1,0,0,38)
TopBar.BackgroundColor3 = Color3.fromRGB(22,22,32)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner",TopBar).CornerRadius = UDim.new(0,10)
local tf = Instance.new("Frame")
tf.Size = UDim2.new(1,0,0.5,0)
tf.Position = UDim2.new(0,0,0.5,0)
tf.BackgroundColor3 = Color3.fromRGB(22,22,32)
tf.BorderSizePixel = 0
tf.Parent = TopBar

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0,150,1,0)
Logo.Position = UDim2.new(0,10,0,0)
Logo.BackgroundTransparency = 1
Logo.Text = "🍛 Nasi Rendang"
Logo.TextColor3 = Color3.fromRGB(255,255,255)
Logo.TextSize = 13
Logo.Font = Enum.Font.GothamBold
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

local GameLbl = Instance.new("TextLabel")
GameLbl.Size = UDim2.new(0,100,1,0)
GameLbl.Position = UDim2.new(0,160,0,0)
GameLbl.BackgroundTransparency = 1
GameLbl.Text = "Ride A Pet"
GameLbl.TextColor3 = Color3.fromRGB(100,100,140)
GameLbl.TextSize = 12
GameLbl.Font = Enum.Font.Gotham
GameLbl.TextXAlignment = Enum.TextXAlignment.Left
GameLbl.Parent = TopBar

local FPSLbl = Instance.new("TextLabel")
FPSLbl.Size = UDim2.new(0,80,1,0)
FPSLbl.Position = UDim2.new(1,-220,0,0)
FPSLbl.BackgroundTransparency = 1
FPSLbl.Text = "60 FPS"
FPSLbl.TextColor3 = Color3.fromRGB(0,200,100)
FPSLbl.TextSize = 11
FPSLbl.Font = Enum.Font.Gotham
FPSLbl.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,26,0,26)
CloseBtn.Position = UDim2.new(1,-32,0,6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60,60,80)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200,200,220)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar
Instance.new("UICorner",CloseBtn).CornerRadius = UDim.new(0,6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- DRAG
local drag,dragStart,startPos
TopBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then
        drag=true;dragStart=i.Position;startPos=Main.Position
    end
end)
TopBar.InputChanged:Connect(function(i)
    if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
        local d=i.Position-dragStart
        Main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
TopBar.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,185,1,-38)
Sidebar.Position = UDim2.new(0,0,0,38)
Sidebar.BackgroundColor3 = Color3.fromRGB(20,20,30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

-- CONTENT
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-185,1,-38)
Content.Position = UDim2.new(0,185,0,38)
Content.BackgroundColor3 = Color3.fromRGB(14,14,22)
Content.BorderSizePixel = 0
Content.Parent = Main
local cs = Instance.new("UIStroke")
cs.Color = Color3.fromRGB(40,40,60)
cs.Thickness = 1
cs.Parent = Content

-- ═══════════════════════════
-- HELPERS
-- ═══════════════════════════
local function newScroll()
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1,0,1,0)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ScrollBarThickness = 4
    f.ScrollBarImageColor3 = Color3.fromRGB(60,60,90)
    f.CanvasSize = UDim2.new(0,0,0,0)
    f.AutomaticCanvasSize = Enum.AutomaticSize.Y
    f.Visible = false
    f.Parent = Content
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,0)
    layout.Parent = f
    return f
end

local function makeSectionHdr(parent, text, order)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1,0,0,36)
    F.BackgroundTransparency = 1
    F.LayoutOrder = order or 0
    F.Parent = parent
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0,3,0,18)
    bar.Position = UDim2.new(0,10,0.5,-9)
    bar.BackgroundColor3 = Color3.fromRGB(50,130,255)
    bar.BorderSizePixel = 0
    bar.Parent = F
    Instance.new("UICorner",bar).CornerRadius = UDim.new(1,0)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-22,1,0)
    lbl.Position = UDim2.new(0,20,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220,220,240)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = F
    return F
end

local function makeToggleRow(parent, label, desc, settingKey, order)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,58)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order or 0
    Row.Parent = parent

    local NameLbl = Instance.new("TextLabel")
    NameLbl.Size = UDim2.new(1,-70,0,22)
    NameLbl.Position = UDim2.new(0,14,0,8)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Text = label
    NameLbl.TextColor3 = Color3.fromRGB(210,210,230)
    NameLbl.TextSize = 13
    NameLbl.Font = Enum.Font.GothamSemibold
    NameLbl.TextXAlignment = Enum.TextXAlignment.Left
    NameLbl.Parent = Row

    local DescLbl = Instance.new("TextLabel")
    DescLbl.Size = UDim2.new(1,-70,0,16)
    DescLbl.Position = UDim2.new(0,14,0,30)
    DescLbl.BackgroundTransparency = 1
    DescLbl.Text = desc
    DescLbl.TextColor3 = Color3.fromRGB(80,80,120)
    DescLbl.TextSize = 10
    DescLbl.Font = Enum.Font.Gotham
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.Parent = Row

    local TBG = Instance.new("Frame")
    TBG.Size = UDim2.new(0,44,0,24)
    TBG.Position = UDim2.new(1,-54,0.5,-12)
    TBG.BackgroundColor3 = Color3.fromRGB(40,40,60)
    TBG.BorderSizePixel = 0
    TBG.Parent = Row
    Instance.new("UICorner",TBG).CornerRadius = UDim.new(1,0)

    local TC = Instance.new("Frame")
    TC.Size = UDim2.new(0,18,0,18)
    TC.Position = UDim2.new(0,3,0.5,-9)
    TC.BackgroundColor3 = Color3.fromRGB(150,150,180)
    TC.BorderSizePixel = 0
    TC.Parent = TBG
    Instance.new("UICorner",TC).CornerRadius = UDim.new(1,0)

    local isOn = S[settingKey] or false
    local function upd()
        if isOn then
            TBG.BackgroundColor3 = Color3.fromRGB(50,130,255)
            TC.Position = UDim2.new(1,-21,0.5,-9)
            TC.BackgroundColor3 = Color3.fromRGB(255,255,255)
        else
            TBG.BackgroundColor3 = Color3.fromRGB(40,40,60)
            TC.Position = UDim2.new(0,3,0.5,-9)
            TC.BackgroundColor3 = Color3.fromRGB(150,150,180)
        end
    end
    upd()

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.Parent = Row
    Btn.MouseButton1Click:Connect(function()
        isOn = not isOn
        S[settingKey] = isOn
        upd()
    end)

    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1,-14,0,1)
    Div.Position = UDim2.new(0,7,1,-1)
    Div.BackgroundColor3 = Color3.fromRGB(35,35,50)
    Div.BorderSizePixel = 0
    Div.Parent = Row
    return Row
end

local function makeSliderRow(parent, label, desc, settingKey, minV, maxV, suffix, order)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,72)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order or 0
    Row.Parent = parent

    local NLbl = Instance.new("TextLabel")
    NLbl.Size = UDim2.new(0.6,0,0,22)
    NLbl.Position = UDim2.new(0,14,0,8)
    NLbl.BackgroundTransparency = 1
    NLbl.Text = label
    NLbl.TextColor3 = Color3.fromRGB(210,210,230)
    NLbl.TextSize = 13
    NLbl.Font = Enum.Font.GothamSemibold
    NLbl.TextXAlignment = Enum.TextXAlignment.Left
    NLbl.Parent = Row

    local VLbl = Instance.new("TextLabel")
    VLbl.Size = UDim2.new(0.35,0,0,22)
    VLbl.Position = UDim2.new(0.62,0,0,8)
    VLbl.BackgroundTransparency = 1
    VLbl.Text = tostring(S[settingKey])..(suffix or "")
    VLbl.TextColor3 = Color3.fromRGB(50,130,255)
    VLbl.TextSize = 12
    VLbl.Font = Enum.Font.GothamBold
    VLbl.TextXAlignment = Enum.TextXAlignment.Right
    VLbl.Parent = Row

    local DLbl = Instance.new("TextLabel")
    DLbl.Size = UDim2.new(1,-14,0,16)
    DLbl.Position = UDim2.new(0,14,0,28)
    DLbl.BackgroundTransparency = 1
    DLbl.Text = desc
    DLbl.TextColor3 = Color3.fromRGB(80,80,120)
    DLbl.TextSize = 10
    DLbl.Font = Enum.Font.Gotham
    DLbl.TextXAlignment = Enum.TextXAlignment.Left
    DLbl.Parent = Row

    local SBG = Instance.new("Frame")
    SBG.Size = UDim2.new(1,-28,0,6)
    SBG.Position = UDim2.new(0,14,0,50)
    SBG.BackgroundColor3 = Color3.fromRGB(40,40,60)
    SBG.BorderSizePixel = 0
    SBG.Parent = Row
    Instance.new("UICorner",SBG).CornerRadius = UDim.new(1,0)

    local pct = (S[settingKey]-minV)/(maxV-minV)
    local SF = Instance.new("Frame")
    SF.Size = UDim2.new(pct,0,1,0)
    SF.BackgroundColor3 = Color3.fromRGB(50,130,255)
    SF.BorderSizePixel = 0
    SF.Parent = SBG
    Instance.new("UICorner",SF).CornerRadius = UDim.new(1,0)

    local SK = Instance.new("Frame")
    SK.Size = UDim2.new(0,14,0,14)
    SK.Position = UDim2.new(pct,-7,0.5,-7)
    SK.BackgroundColor3 = Color3.fromRGB(255,255,255)
    SK.BorderSizePixel = 0
    SK.Parent = SBG
    Instance.new("UICorner",SK).CornerRadius = UDim.new(1,0)

    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1,-14,0,1)
    Div.Position = UDim2.new(0,7,1,-1)
    Div.BackgroundColor3 = Color3.fromRGB(35,35,50)
    Div.BorderSizePixel = 0
    Div.Parent = Row

    local sliding = false
    SBG.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then sliding=true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then sliding=false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if sliding and i.UserInputType==Enum.UserInputType.MouseMovement then
            local rel = math.clamp((i.Position.X-SBG.AbsolutePosition.X)/SBG.AbsoluteSize.X,0,1)
            local val = math.floor(minV+(maxV-minV)*rel)
            S[settingKey] = val
            SF.Size = UDim2.new(rel,0,1,0)
            SK.Position = UDim2.new(rel,-7,0.5,-7)
            VLbl.Text = tostring(val)..(suffix or "")
        end
    end)
    return Row
end

-- ═══════════════════════════
-- DROPDOWN HELPER
-- ═══════════════════════════
local function makeDropdown(parent, label, desc, options, settingKey, order)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,58)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order or 0
    Row.Parent = parent

    local NLbl = Instance.new("TextLabel")
    NLbl.Size = UDim2.new(1,-140,0,22)
    NLbl.Position = UDim2.new(0,14,0,8)
    NLbl.BackgroundTransparency = 1
    NLbl.Text = label
    NLbl.TextColor3 = Color3.fromRGB(210,210,230)
    NLbl.TextSize = 13
    NLbl.Font = Enum.Font.GothamSemibold
    NLbl.TextXAlignment = Enum.TextXAlignment.Left
    NLbl.Parent = Row

    local DLbl = Instance.new("TextLabel")
    DLbl.Size = UDim2.new(1,-14,0,16)
    DLbl.Position = UDim2.new(0,14,0,30)
    DLbl.BackgroundTransparency = 1
    DLbl.Text = desc
    DLbl.TextColor3 = Color3.fromRGB(80,80,120)
    DLbl.TextSize = 10
    DLbl.Font = Enum.Font.Gotham
    DLbl.TextXAlignment = Enum.TextXAlignment.Left
    DLbl.Parent = Row

    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(0,120,0,28)
    DropBtn.Position = UDim2.new(1,-130,0.5,-14)
    DropBtn.BackgroundColor3 = Color3.fromRGB(30,30,50)
    DropBtn.Text = S[settingKey] .. " ▾"
    DropBtn.TextColor3 = Color3.fromRGB(180,180,220)
    DropBtn.TextSize = 11
    DropBtn.Font = Enum.Font.GothamSemibold
    DropBtn.BorderSizePixel = 0
    DropBtn.Parent = Row
    Instance.new("UICorner",DropBtn).CornerRadius = UDim.new(0,6)
    local dbs = Instance.new("UIStroke")
    dbs.Color = Color3.fromRGB(60,60,90)
    dbs.Thickness = 1
    dbs.Parent = DropBtn

    -- Dropdown list
    local DropList = Instance.new("Frame")
    DropList.Size = UDim2.new(0,130,0,#options*26+4)
    DropList.Position = UDim2.new(1,-135,0,30)
    DropList.BackgroundColor3 = Color3.fromRGB(25,25,40)
    DropList.BorderSizePixel = 0
    DropList.Visible = false
    DropList.ZIndex = 10
    DropList.Parent = Row
    Instance.new("UICorner",DropList).CornerRadius = UDim.new(0,8)
    local dls = Instance.new("UIStroke")
    dls.Color = Color3.fromRGB(60,60,90)
    dls.Thickness = 1
    dls.Parent = DropList

    for i2, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1,-4,0,24)
        OptBtn.Position = UDim2.new(0,2,0,(i2-1)*26+2)
        OptBtn.BackgroundColor3 = Color3.fromRGB(30,30,50)
        OptBtn.Text = opt
        OptBtn.TextColor3 = Color3.fromRGB(180,180,220)
        OptBtn.TextSize = 11
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.BorderSizePixel = 0
        OptBtn.ZIndex = 11
        OptBtn.Parent = DropList
        Instance.new("UICorner",OptBtn).CornerRadius = UDim.new(0,6)
        OptBtn.MouseButton1Click:Connect(function()
            S[settingKey] = opt
            DropBtn.Text = opt .. " ▾"
            DropList.Visible = false
        end)
        OptBtn.MouseEnter:Connect(function()
            OptBtn.BackgroundColor3 = Color3.fromRGB(50,50,80)
        end)
        OptBtn.MouseLeave:Connect(function()
            OptBtn.BackgroundColor3 = Color3.fromRGB(30,30,50)
        end)
    end

    DropBtn.MouseButton1Click:Connect(function()
        DropList.Visible = not DropList.Visible
    end)

    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1,-14,0,1)
    Div.Position = UDim2.new(0,7,1,-1)
    Div.BackgroundColor3 = Color3.fromRGB(35,35,50)
    Div.BorderSizePixel = 0
    Div.Parent = Row
    return Row
end

-- ═══════════════════════════
-- CHECKBOX MULTI-SELECT HELPER
-- ═══════════════════════════
local function makeCheckboxGroup(parent, label, items, selectedTable, order)
    local HeaderF = Instance.new("Frame")
    HeaderF.Size = UDim2.new(1,0,0,30)
    HeaderF.BackgroundTransparency = 1
    HeaderF.LayoutOrder = order or 0
    HeaderF.Parent = parent

    local HLbl = Instance.new("TextLabel")
    HLbl.Size = UDim2.new(1,-14,1,0)
    HLbl.Position = UDim2.new(0,14,0,0)
    HLbl.BackgroundTransparency = 1
    HLbl.Text = label
    HLbl.TextColor3 = Color3.fromRGB(160,160,200)
    HLbl.TextSize = 12
    HLbl.Font = Enum.Font.GothamSemibold
    HLbl.TextXAlignment = Enum.TextXAlignment.Left
    HLbl.Parent = HeaderF

    local Grid = Instance.new("Frame")
    Grid.Size = UDim2.new(1,0,0,math.ceil(#items/2)*30+8)
    Grid.BackgroundTransparency = 1
    Grid.LayoutOrder = order+1 or 1
    Grid.Parent = parent

    local GL = Instance.new("UIGridLayout")
    GL.CellSize = UDim2.new(0.48,0,0,26)
    GL.CellPaddingSize = UDim2.new(0.02,0,0,4)
    GL.HorizontalAlignment = Enum.HorizontalAlignment.Left
    GL.SortOrder = Enum.SortOrder.LayoutOrder
    GL.Parent = Grid

    local GPad = Instance.new("UIPadding")
    GPad.PaddingLeft = UDim.new(0,14)
    GPad.PaddingRight = UDim.new(0,14)
    GPad.Parent = Grid

    for _, item in ipairs(items) do
        local isChecked = selectedTable[item] or false

        local CBtn = Instance.new("TextButton")
        CBtn.BackgroundColor3 = isChecked and Color3.fromRGB(40,80,180) or Color3.fromRGB(25,25,40)
        CBtn.Text = (isChecked and "✅ " or "⬜ ") .. item
        CBtn.TextColor3 = Color3.fromRGB(180,180,220)
        CBtn.TextSize = 10
        CBtn.Font = Enum.Font.Gotham
        CBtn.TextXAlignment = Enum.TextXAlignment.Left
        CBtn.BorderSizePixel = 0
        CBtn.Parent = Grid
        Instance.new("UICorner",CBtn).CornerRadius = UDim.new(0,6)
        local cbs = Instance.new("UIStroke")
        cbs.Color = Color3.fromRGB(50,50,80)
        cbs.Thickness = 1
        cbs.Parent = CBtn

        CBtn.MouseButton1Click:Connect(function()
            isChecked = not isChecked
            selectedTable[item] = isChecked
            CBtn.BackgroundColor3 = isChecked and Color3.fromRGB(40,80,180) or Color3.fromRGB(25,25,40)
            CBtn.Text = (isChecked and "✅ " or "⬜ ") .. item
        end)
    end

    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1,-14,0,1)
    Div.BackgroundColor3 = Color3.fromRGB(35,35,50)
    Div.BorderSizePixel = 0
    Div.LayoutOrder = order+2 or 2
    Div.Parent = parent
end

-- ═══════════════════════════
-- WEBHOOK INPUT HELPER
-- ═══════════════════════════
local function makeInputRow(parent, label, desc, settingKey, order)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,68)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order or 0
    Row.Parent = parent

    local NLbl = Instance.new("TextLabel")
    NLbl.Size = UDim2.new(1,-14,0,20)
    NLbl.Position = UDim2.new(0,14,0,6)
    NLbl.BackgroundTransparency = 1
    NLbl.Text = label
    NLbl.TextColor3 = Color3.fromRGB(210,210,230)
    NLbl.TextSize = 13
    NLbl.Font = Enum.Font.GothamSemibold
    NLbl.TextXAlignment = Enum.TextXAlignment.Left
    NLbl.Parent = Row

    local DLbl = Instance.new("TextLabel")
    DLbl.Size = UDim2.new(1,-14,0,14)
    DLbl.Position = UDim2.new(0,14,0,24)
    DLbl.BackgroundTransparency = 1
    DLbl.Text = desc
    DLbl.TextColor3 = Color3.fromRGB(80,80,120)
    DLbl.TextSize = 10
    DLbl.Font = Enum.Font.Gotham
    DLbl.TextXAlignment = Enum.TextXAlignment.Left
    DLbl.Parent = Row

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1,-28,0,26)
    Box.Position = UDim2.new(0,14,0,38)
    Box.BackgroundColor3 = Color3.fromRGB(25,25,40)
    Box.Text = S[settingKey] or ""
    Box.TextColor3 = Color3.fromRGB(180,180,220)
    Box.PlaceholderText = "Paste Discord Webhook URL..."
    Box.PlaceholderColor3 = Color3.fromRGB(80,80,120)
    Box.TextSize = 11
    Box.Font = Enum.Font.Gotham
    Box.ClearTextOnFocus = false
    Box.BorderSizePixel = 0
    Box.TextXAlignment = Enum.TextXAlignment.Left
    Box.Parent = Row
    Instance.new("UICorner",Box).CornerRadius = UDim.new(0,6)
    local boxS = Instance.new("UIStroke")
    boxS.Color = Color3.fromRGB(60,60,90)
    boxS.Thickness = 1
    boxS.Parent = Box

    Box.FocusLost:Connect(function()
        S[settingKey] = Box.Text
    end)
    return Row
end

-- ═══════════════════════════
-- BUILD PAGES
-- ═══════════════════════════

-- AUTO FARM PAGE
local AF = newScroll()
makeSectionHdr(AF, "Egg Collection Engine", 1)
makeToggleRow(AF, "Instant Teleport 👑", "Bypasses glide using Teleport Grace exploit", "InstantTeleport", 2)
makeToggleRow(AF, "Auto Farm Eggs", "Navigates and claims eligible ground eggs", "AutoFarmEggs", 3)
makeToggleRow(AF, "Auto Farm Rebirth Egg", "Focuses solely on highest rarity/rebirth egg", "AutoFarmRebirthEgg", 4)
makeToggleRow(AF, "Farming Noclip", "Phases character & pet through terrain", "FarmingNoclip", 5)
makeSliderRow(AF, "Glide Speed", "Speed at which your pet glides to targets", "GlideSpeed", 100, 2000, " studs/s", 6)
makeSectionHdr(AF, "Egg Target Filter", 7)
makeCheckboxGroup(AF, "Select Target Eggs:", EGG_LIST, S.SelectedEggs, 8)
makeDropdown(AF, "Egg Rarity Filter", "Only farm eggs of selected rarity", RARITIES, "SelectedRarity", 11)

-- EGG PAGE
local EG = newScroll()
makeSectionHdr(EG, "Egg Settings", 1)
makeToggleRow(EG, "Auto Hatch Egg", "Automatically hatches eggs when available", "AutoHatch", 2)

-- FEEDS PAGE
local FD = newScroll()
makeSectionHdr(FD, "Feeding Controls", 1)
makeToggleRow(FD, "Auto Feed Pets", "Feeds ranch pets using selected food from backpack", "AutoFeedPets", 2)
makeToggleRow(FD, "Feed Best Pet Only", "Directs food to pet with highest $/s", "FeedBestPetOnly", 3)

-- PETS PAGE
local PT = newScroll()
makeSectionHdr(PT, "Pet Management", 1)
makeToggleRow(PT, "Auto Sell Pet", "Automatically sells pets below minimum $/s threshold", "AutoSellPet", 2)

-- VISUAL PAGE
local VS = newScroll()
makeSectionHdr(VS, "World ESP", 1)
makeToggleRow(VS, "Egg ESP", "Renders billboards over all active world eggs", "EggESP", 2)
makeDropdown(VS, "Egg Rarity Filter", "Only show ESP for selected rarity", RARITIES, "SelectedRarity", 3)
makeToggleRow(VS, "Pet ESP", "Renders tags with name, owner, $/s over pets", "PetESP", 4)
makeToggleRow(VS, "Only My Pets", "Restricts Pet ESP to your own pets", "OnlyMyPets", 5)
makeSectionHdr(VS, "Performance", 6)
makeToggleRow(VS, "FPS Boost", "Reduces render quality, clears particle effects", "FPSBoost", 7)

-- SERVER HOP PAGE
local SH = newScroll()
makeSectionHdr(SH, "Server Hop Hunter", 1)
makeToggleRow(SH, "Auto Server Hop", "Hops server if target eggs/mutations absent", "AutoServerHop", 2)
makeToggleRow(SH, "Stop When Found", "Stops hopping and alerts when target found", "StopWhenFound", 3)

local HopRow = Instance.new("Frame")
HopRow.Size = UDim2.new(1,0,0,52)
HopRow.BackgroundTransparency = 1
HopRow.LayoutOrder = 4
HopRow.Parent = SH

local HopNow = Instance.new("TextButton")
HopNow.Size = UDim2.new(1,-28,0,36)
HopNow.Position = UDim2.new(0,14,0,8)
HopNow.BackgroundColor3 = Color3.fromRGB(35,35,55)
HopNow.Text = "Hop Now"
HopNow.TextColor3 = Color3.fromRGB(200,200,220)
HopNow.TextSize = 13
HopNow.Font = Enum.Font.GothamSemibold
HopNow.BorderSizePixel = 0
HopNow.Parent = HopRow
Instance.new("UICorner",HopNow).CornerRadius = UDim.new(0,8)
local hns = Instance.new("UIStroke")
hns.Color = Color3.fromRGB(60,60,90)
hns.Thickness = 1
hns.Parent = HopNow
HopNow.MouseButton1Click:Connect(function()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
end)

makeSectionHdr(SH, "Target Filters", 5)
makeDropdown(SH, "Target Egg Types", "Hop until this egg type found", {"All","Basic Egg","Dominus Egg","Galaxy Egg","Rebirth Egg"}, "SelectedRarity", 6)

-- WEBHOOK PAGE
local WH = newScroll()
makeSectionHdr(WH, "Webhook Settings", 1)
makeToggleRow(WH, "Enable Webhook", "Send notifications to Discord webhook", "WebhookEnabled", 2)
makeInputRow(WH, "Webhook URL", "Your Discord webhook URL", "WebhookURL", 3)

local TestRow = Instance.new("Frame")
TestRow.Size = UDim2.new(1,0,0,52)
TestRow.BackgroundTransparency = 1
TestRow.LayoutOrder = 4
TestRow.Parent = WH

local TestBtn = Instance.new("TextButton")
TestBtn.Size = UDim2.new(1,-28,0,36)
TestBtn.Position = UDim2.new(0,14,0,8)
TestBtn.BackgroundColor3 = Color3.fromRGB(30,80,160)
TestBtn.Text = "Send Test Message"
TestBtn.TextColor3 = Color3.fromRGB(255,255,255)
TestBtn.TextSize = 13
TestBtn.Font = Enum.Font.GothamSemibold
TestBtn.BorderSizePixel = 0
TestBtn.Parent = TestRow
Instance.new("UICorner",TestBtn).CornerRadius = UDim.new(0,8)
TestBtn.MouseButton1Click:Connect(function()
    if S.WebhookURL and S.WebhookURL ~= "" then
        pcall(function()
            local data = HttpService:JSONEncode({
                username = "Nasi Rendang Script",
                avatar_url = "",
                embeds = {{
                    title = "🍛 Nasi Rendang | Test Notif",
                    description = "Script aktif di game: **Ride a Pet**\nPlayer: `" .. LocalPlayer.Name .. "`",
                    color = 3447003,
                    footer = {text = "DexGPT Script"}
                }}
            })
            request({
                Url = S.WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = data
            })
        end)
    end
end)

-- MISC PAGE
local MC = newScroll()
makeSectionHdr(MC, "Safety & Utilities", 1)
makeToggleRow(MC, "Anti AFK", "Bypasses 20-minute Roblox idle kick", "AntiAFK", 2)
makeToggleRow(MC, "Auto Reconnect", "Automatically rejoins server upon disconnection", "AutoReconnect", 3)
makeToggleRow(MC, "Auto Execute", "Queues script on server hop/teleport", "AutoExecute", 4)

-- ═══════════════════════════
-- SIDEBAR TABS
-- ═══════════════════════════
local tabList = {
    {name="Auto Farm", icon="👤", sub="Egg Collection & Travel", content=AF},
    {name="Egg",       icon="🥚", sub="",                        content=EG},
    {name="Pets",      icon="🐾", sub="",                        content=PT},
    {name="Feeds",     icon="🍖", sub="Level Up & Feed Pets",    content=FD},
    {name="Visual",    icon="👁️", sub="ESP & Performance",       content=VS},
    {name="Webhook",   icon="🔗", sub="Discord Notifications",   content=WH},
    {name="Server Hop",icon="⚙️", sub="Egg & Mutation Hunter",   content=SH},
    {name="Misc",      icon="🔧", sub="AFK & Quality of Life",   content=MC},
}

local SideList = Instance.new("Frame")
SideList.Size = UDim2.new(1,0,1,-90)
SideList.Position = UDim2.new(0,0,0,6)
SideList.BackgroundTransparency = 1
SideList.Parent = Sidebar

local SLL = Instance.new("UIListLayout")
SLL.SortOrder = Enum.SortOrder.LayoutOrder
SLL.Padding = UDim.new(0,2)
SLL.Parent = SideList

local tabBtns = {}
local function setTab(name)
    for _, t in ipairs(tabList) do
        t.content.Visible = (t.name == name)
    end
    for n, b in pairs(tabBtns) do
        local abar = b:FindFirstChild("ABar")
        if n == name then
            b.BackgroundColor3 = Color3.fromRGB(30,30,48)
            b.BackgroundTransparency = 0
            if abar then abar.Visible = true end
        else
            b.BackgroundTransparency = 1
            if abar then abar.Visible = false end
        end
    end
end

for i, t in ipairs(tabList) do
    local Btn = Instance.new("TextButton")
    Btn.Name = t.name
    Btn.Size = UDim2.new(1,-8,0,t.sub~="" and 46 or 36)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.BorderSizePixel = 0
    Btn.LayoutOrder = i
    Btn.Parent = SideList
    Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,8)

    local ABar = Instance.new("Frame")
    ABar.Name = "ABar"
    ABar.Size = UDim2.new(0,3,0.6,0)
    ABar.Position = UDim2.new(1,-3,0.2,0)
    ABar.BackgroundColor3 = Color3.fromRGB(50,130,255)
    ABar.BorderSizePixel = 0
    ABar.Visible = false
    ABar.Parent = Btn
    Instance.new("UICorner",ABar).CornerRadius = UDim.new(1,0)

    local ILbl = Instance.new("TextLabel")
    ILbl.Size = UDim2.new(0,26,1,0)
    ILbl.Position = UDim2.new(0,8,0,0)
    ILbl.BackgroundTransparency = 1
    ILbl.Text = t.icon
    ILbl.TextSize = 15
    ILbl.Font = Enum.Font.Gotham
    ILbl.Parent = Btn

    local NLbl2 = Instance.new("TextLabel")
    NLbl2.Size = UDim2.new(1,-40,0,20)
    NLbl2.Position = UDim2.new(0,36,0,t.sub~="" and 6 or 8)
    NLbl2.BackgroundTransparency = 1
    NLbl2.Text = t.name
    NLbl2.TextColor3 = Color3.fromRGB(180,180,210)
    NLbl2.TextSize = 12
    NLbl2.Font = Enum.Font.GothamSemibold
    NLbl2.TextXAlignment = Enum.TextXAlignment.Left
    NLbl2.Parent = Btn

    if t.sub ~= "" then
        local SLbl = Instance.new("TextLabel")
        SLbl.Size = UDim2.new(1,-40,0,14)
        SLbl.Position = UDim2.new(0,36,0,24)
        SLbl.BackgroundTransparency = 1
        SLbl.Text = t.sub
        SLbl.TextColor3 = Color3.fromRGB(70,70,110)
        SLbl.TextSize = 10
        SLbl.Font = Enum.Font.Gotham
        SLbl.TextXAlignment = Enum.TextXAlignment.Left
        SLbl.Parent = Btn
    end

    tabBtns[t.name] = Btn
    Btn.MouseButton1Click:Connect(function() setTab(t.name) end)
end

-- Bottom sidebar info
local BotF = Instance.new("Frame")
BotF.Size = UDim2.new(1,-10,0,82)
BotF.Position = UDim2.new(0,5,1,-86)
BotF.BackgroundColor3 = Color3.fromRGB(22,22,32)
BotF.BorderSizePixel = 0
BotF.Parent = Sidebar
Instance.new("UICorner",BotF).CornerRadius = UDim.new(0,8)

local function botLbl(txt, y, color, size)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,16)
    l.Position = UDim2.new(0,8,0,y)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = color or Color3.fromRGB(120,120,160)
    l.TextSize = size or 10
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = BotF
end
botLbl("🔵 Discord", 6, Color3.fromRGB(120,140,255), 11)
botLbl("discord.gg/nasirendanglua", 22)
botLbl("🌐 Web Monitor", 40, Color3.fromRGB(180,180,220), 11)
botLbl("nrlscript.com/monitor", 56)
botLbl("NRL-47VJ27T26C — Signed in", 72, Color3.fromRGB(80,80,120), 9)

setTab("Auto Farm")

-- ═══════════════════════════
-- FPS COUNTER
-- ═══════════════════════════
local lastT = tick(); local fc = 0
RunService.RenderStepped:Connect(function()
    fc += 1
    if tick()-lastT >= 1 then
        FPSLbl.Text = fc.." FPS"
        FPSLbl.TextColor3 = fc>=30 and Color3.fromRGB(0,200,100) or Color3.fromRGB(255,80,80)
        fc=0; lastT=tick()
    end
end)

-- ═══════════════════════════
-- LOGIC: NOCLIP
-- ═══════════════════════════
RunService.RenderStepped:Connect(function()
    if not S.FarmingNoclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end)

-- ═══════════════════════════
-- LOGIC: AUTO FARM
-- ═══════════════════════════
local function isEggTargeted(obj)
    -- Cek checkbox
    local anySelected = false
    for _, v in pairs(S.SelectedEggs) do if v then anySelected = true; break end end
    if anySelected and not S.SelectedEggs[obj.Name] then return false end
    return true
end

task.spawn(function()
    while task.wait(0.1) do
        if S.AutoFarmEggs or S.InstantTeleport then
            local char = LocalPlayer.Character
            if not char then continue end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then continue end
            local ws = game:GetService("Workspace")
            local best, bd = nil, math.huge
            for _, obj in ipairs(ws:GetDescendants()) do
                if obj.Name:lower():find("egg") and obj:IsA("BasePart") and obj.Parent ~= char then
                    if isEggTargeted(obj) then
                        local d = (obj.Position - root.Position).Magnitude
                        if d < bd then best = obj; bd = d end
                    end
                end
            end
            if best then
                root.CFrame = CFrame.new(best.Position + Vector3.new(0,3,0))
                pcall(function()
                    firetouchinterest(root, best, 0)
                    task.wait(0.05)
                    firetouchinterest(root, best, 1)
                end)
            end
        end
    end
end)

-- ═══════════════════════════
-- LOGIC: EGG ESP
-- ═══════════════════════════
RunService.Heartbeat:Connect(function()
    local ws = game:GetService("Workspace")
    for _, obj in ipairs(ws:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("egg") and obj.Parent ~= LocalPlayer.Character then
            if S.EggESP then
                if not obj:FindFirstChild("NR_ESP") then
                    local bb = Instance.new("BillboardGui")
                    bb.Name = "NR_ESP"
                    bb.Size = UDim2.new(0,100,0,30)
                    bb.StudsOffset = Vector3.new(0,4,0)
                    bb.AlwaysOnTop = true
                    bb.Parent = obj
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1,0,1,0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "🥚 "..obj.Name
                    lbl.TextColor3 = Color3.fromRGB(255,215,0)
                    lbl.TextStrokeTransparency = 0
                    lbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                    lbl.TextSize = 12
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Parent = bb
                end
            else
                local e = obj:FindFirstChild("NR_ESP")
                if e then e:Destroy() end
            end
        end
    end
end)

-- ═══════════════════════════
-- LOGIC: ANTI AFK
-- ═══════════════════════════
task.spawn(function()
    while task.wait(55) do
        if S.AntiAFK then
            local vs = game:GetService("VirtualUser")
            vs:Button2Down(Vector2.new(0,0),CFrame.new())
            task.wait(0.1)
            vs:Button2Up(Vector2.new(0,0),CFrame.new())
        end
    end
end)

-- ═══════════════════════════
-- LOGIC: WEBHOOK NOTIF
-- ═══════════════════════════
local function sendWebhook(title, msg)
    if not S.WebhookEnabled or S.WebhookURL == "" then return end
    pcall(function()
        local data = HttpService:JSONEncode({
            username = "Nasi Rendang Script",
            embeds = {{
                title = title,
                description = msg,
                color = 3447003,
                footer = {text = "DexGPT • "..LocalPlayer.Name}
            }}
        })
        request({
            Url = S.WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = data
        })
    end)
end

-- Notif saat egg ketemu
task.spawn(function()
    while task.wait(30) do
        if S.WebhookEnabled then
            sendWebhook("🥚 Farm Update", "Auto farm aktif\nRarity filter: **"..S.SelectedRarity.."**\nPlayer: `"..LocalPlayer.Name.."`")
        end
    end
end)

print("[NasiRendang v5.0] Loaded by DexGPT!")