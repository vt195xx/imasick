

--dumoer vt195xx on dsc


local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local Players            = game:GetService("Players")
local TextService        = game:GetService("TextService")
local CoreGui             = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse        = LocalPlayer:GetMouse()
local Camera        = workspace.CurrentCamera
local function Create(class, props, children)
    local inst = Instance.new(class)
    for prop, value in pairs(props or {}) do
        inst[prop] = value
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    return inst
end

local function Tween(obj, info, props)
    local tw = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

local EASE = {
    Smooth   = TweenInfo.new(0.30, Enum.EasingStyle.Quint,   Enum.EasingDirection.Out),
    SmoothIn = TweenInfo.new(0.22, Enum.EasingStyle.Quad,    Enum.EasingDirection.In),
    Bounce   = TweenInfo.new(0.50, Enum.EasingStyle.Back,     Enum.EasingDirection.Out),
    BigBounce= TweenInfo.new(0.65, Enum.EasingStyle.Elastic,  Enum.EasingDirection.Out),
    Fast     = TweenInfo.new(0.15, Enum.EasingStyle.Quad,    Enum.EasingDirection.Out),
    Quick    = TweenInfo.new(0.10, Enum.EasingStyle.Sine,     Enum.EasingDirection.Out),
    Glow     = TweenInfo.new(1.8,  Enum.EasingStyle.Sine,     Enum.EasingDirection.InOut, -1, true),
    GlowFast = TweenInfo.new(0.9,  Enum.EasingStyle.Sine,     Enum.EasingDirection.InOut, -1, true),
}

local function Round(value, decimals)
    if decimals == 0 then return math.floor(value + 0.5) end
    local mult = 10 ^ decimals
    return math.floor(value * mult + 0.5) / mult
end

local GLOW_IMAGE   = "rbxassetid://5028857084"
local SHADOW_IMAGE  = "rbxassetid://1316045217"
local NOISE_IMAGE   = "rbxassetid://9968344227"
local CHEVRON_DOWN  = "rbxassetid://10709790948"
local CHEVRON_RIGHT = "rbxassetid://10709791437"
local CLOSE_ICON    = "rbxassetid://9886659671"
local MIN_ICON      = "rbxassetid://9886659276"
local MAX_ICON      = "rbxassetid://9886659406"
local RESTORE_ICON  = "rbxassetid://9886659001"
local CHECK_ICON    = "rbxassetid://10709790644"
local DOT_ICON       = "rbxassetid://12266946128"
local Icons = {
    home          = "rbxassetid://10723407389",
    settings      = "rbxassetid://10734950309",
    gear          = "rbxassetid://10734950309",
    user          = "rbxassetid://10747373176",
    users         = "rbxassetid://10747373426",
    info          = "rbxassetid://10723415903",
    list          = "rbxassetid://10723433811",
    bell          = "rbxassetid://10709775704",
    shield        = "rbxassetid://10734951847",
    star          = "rbxassetid://10734966248",
    check         = "rbxassetid://10709790644",
    x             = "rbxassetid://10747384394",
    folder        = "rbxassetid://10723387563",
    download      = "rbxassetid://10723344270",
    upload        = "rbxassetid://10747366434",
    trash         = "rbxassetid://10747362393",
    edit          = "rbxassetid://10734883598",
    plus          = "rbxassetid://10734924532",
    minus         = "rbxassetid://10734896206",
    lock          = "rbxassetid://10723434711",
    unlock        = "rbxassetid://10747366027",
    eye           = "rbxassetid://10723346959",
    sliders       = "rbxassetid://10734963400",
    gamepad       = "rbxassetid://10723395215",
    palette       = "rbxassetid://10734910430",
    globe         = "rbxassetid://10723404337",
    wrench        = "rbxassetid://10747383470",
    crown         = "rbxassetid://10709818626",
    gem           = "rbxassetid://10723396000",
    search        = "rbxassetid://10734943674",
    code          = "rbxassetid://10709810463",
    terminal      = "rbxassetid://10734982144",
    activity      = "rbxassetid://10709752035",
    layers        = "rbxassetid://10723424505",
    layoutdash    = "rbxassetid://10723424646",
    zap           = "rbxassetid://10734930466",
}
local Themes = {}

Themes.Dark = {
    Name              = "Dark",
    Background        = Color3.fromRGB(15, 15, 16),
    Surface           = Color3.fromRGB(21, 21, 23),
    SurfaceLight      = Color3.fromRGB(28, 28, 31),
    SurfaceElevated   = Color3.fromRGB(33, 33, 37),
    Border            = Color3.fromRGB(46, 46, 50),
    BorderLight       = Color3.fromRGB(60, 60, 65),
    Accent            = Color3.fromRGB(200, 200, 210),
    AccentDim         = Color3.fromRGB(150, 150, 160),
    AccentGlow        = Color3.fromRGB(225, 225, 235),
    Text              = Color3.fromRGB(238, 238, 241),
    SubText           = Color3.fromRGB(150, 150, 158),
    MutedText         = Color3.fromRGB(108, 108, 116),
    Element           = Color3.fromRGB(24, 24, 27),
    ElementHover      = Color3.fromRGB(31, 31, 35),
    ElementBorder     = Color3.fromRGB(50, 50, 55),
    Success           = Color3.fromRGB(140, 210, 160),
    Danger            = Color3.fromRGB(220, 120, 120),
}

Themes.Darker = setmetatable({
    Name = "Darker",
    Background = Color3.fromRGB(10,10,11),
    Surface = Color3.fromRGB(16,16,17),
}, { __index = Themes.Dark })

Themes.Slate = setmetatable({
    Name = "Slate",
    Accent = Color3.fromRGB(170, 185, 200),
    AccentGlow = Color3.fromRGB(195, 210, 225),
}, { __index = Themes.Dark })

local Library = {}
Library.__index = Library

Library.Version         = "2.0.0-luxe"
Library.Theme            = "Dark"
Library.Options          = {}
Library.OpenFrames       = {}
Library.Window            = nil
Library.Unloaded         = false
Library.UseAcrylic       = false
Library.MinimizeKey      = Enum.KeyCode.LeftControl
Library.MinimizeKeybind = nil
Library.DialogOpen       = false
Library.ThemeObjects      = {}
Library.Connections       = {}

local function CurrentTheme()
    return Themes[Library.Theme] or Themes.Dark
end

local function Themed(obj, map)
    Library.ThemeObjects[obj] = map
    local theme = CurrentTheme()
    for prop, key in pairs(map) do
        obj[prop] = theme[key]
    end
    return obj
end

function Library.UpdateTheme()
    local theme = CurrentTheme()
    for obj, map in pairs(Library.ThemeObjects) do
        if obj and obj.Parent then
            for prop, key in pairs(map) do
                if typeof(theme[key]) == "Color3" or typeof(theme[key]) == "number" then
                    Tween(obj, EASE.Smooth, { [prop] = theme[key] })
                end
            end
        else
            Library.ThemeObjects[obj] = nil
        end
    end
end

function Library:SafeCallback(fn, ...)
    if not fn then return end
    local ok, err = pcall(fn, ...)
    if not ok then
        self:Notify({ Title = "Interface", Content = "Callback error", SubContent = tostring(err), Duration = 5 })
    end
end

function Library.GetIcon(name)
    if not name or name == "" then return nil end
    return Icons[name]
end

local ScreenGui = Create("ScreenGui", {
    Name = "ParodyRise",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999,
})
if gethui then
    ScreenGui.Parent = gethui()
elseif RunService:IsStudio() then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
else
    ScreenGui.Parent = CoreGui
end
Library.GUI = ScreenGui

local NotifyHolder = Create("Frame", {
    Name = "Notifications",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -24, 1, -24),
    Size = UDim2.new(0, 320, 1, -24),
    BackgroundTransparency = 1,
    Parent = ScreenGui,
}, {
    Create("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
    }),
})
local function BuildElementCard(title, desc, parent, clickable)
    local theme = CurrentTheme()

    local titleLabel = Create("TextLabel", {
        Font = Enum.Font.GothamMedium,
        Text = title or "",
        TextColor3 = theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
    })
    Themed(titleLabel, { TextColor3 = "Text" })

    local descLabel = Create("TextLabel", {
        Font = Enum.Font.Gotham,
        Text = desc or "",
        TextColor3 = theme.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Visible = (desc ~= nil and desc ~= ""),
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundTransparency = 1,
    })
    Themed(descLabel, { TextColor3 = "SubText" })

    local labelHolder = Create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -32, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, {
        Create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 2),
        }),
        Create("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12) }),
        titleLabel,
        descLabel,
    })

    local stroke = Create("UIStroke", {
        Thickness = 1,
        Transparency = 0.7,
        Color = theme.ElementBorder,
    })
    Themed(stroke, { Color = "ElementBorder" })

    local scale = Create("UIScale", { Scale = 1 })

    local card = Create(clickable and "TextButton" or "Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = theme.Element,
        BackgroundTransparency = 0,
        AutoButtonColor = false,
        Text = "",
        LayoutOrder = 1,
        Parent = parent,
    }, {
        Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
        stroke,
        scale,
        labelHolder,
    })
    Themed(card, { BackgroundColor3 = "Element" })

    if clickable then
        card.MouseEnter:Connect(function()
            Tween(card, EASE.Fast, { BackgroundColor3 = CurrentTheme().ElementHover })
            Tween(stroke, EASE.Fast, { Transparency = 0.35 })
        end)
        card.MouseLeave:Connect(function()
            Tween(card, EASE.Fast, { BackgroundColor3 = CurrentTheme().Element })
            Tween(stroke, EASE.Fast, { Transparency = 0.7 })
        end)
        card.MouseButton1Down:Connect(function()
            Tween(scale, EASE.Quick, { Scale = 0.985 })
        end)
        card.MouseButton1Up:Connect(function()
            Tween(scale, EASE.Bounce, { Scale = 1 })
        end)
    end

    local api = {}
    api.Frame       = card
    api.TitleLabel  = titleLabel
    api.DescLabel   = descLabel
    api.LabelHolder = labelHolder
    api.Stroke      = stroke
    function api:SetTitle(t) titleLabel.Text = t end
    function api:SetDesc(d)
        descLabel.Visible = (d ~= nil and d ~= "")
        descLabel.Text = d or ""
    end
    function api:Destroy() card:Destroy() end
    return api
end
function Library:Notify(cfg)
    cfg = cfg or {}
    local theme = CurrentTheme()
    local title, content, subcontent, duration = cfg.Title or "Notification", cfg.Content or "", cfg.SubContent or "", cfg.Duration

    local scale = Create("UIScale", { Scale = 0.9 })
    local accentBar = Create("Frame", {
        Size = UDim2.new(0, 3, 1, -16),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = theme.Accent,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    Themed(accentBar, { BackgroundColor3 = "Accent" })

    local closeBtn = Create("ImageButton", {
        Image = CLOSE_ICON,
        Size = UDim2.fromOffset(14, 14),
        Position = UDim2.new(1, -12, 0, 12),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        ImageColor3 = theme.SubText,
    })
    Themed(closeBtn, { ImageColor3 = "SubText" })

    local titleLabel = Create("TextLabel", {
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -40, 0, 16),
        Position = UDim2.fromOffset(16, 12),
        BackgroundTransparency = 1,
    })
    Themed(titleLabel, { TextColor3 = "Text" })

    local contentLabel = Create("TextLabel", {
        Font = Enum.Font.Gotham,
        Text = content,
        TextColor3 = theme.SubText,
        TextSize = 13,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, -32, 0, 0),
        Position = UDim2.fromOffset(16, 34),
        BackgroundTransparency = 1,
        Visible = content ~= "",
    })
    Themed(contentLabel, { TextColor3 = "SubText" })

    local subLabel = Create("TextLabel", {
        Font = Enum.Font.Gotham,
        Text = subcontent,
        TextColor3 = theme.MutedText,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, -32, 0, 0),
        Position = UDim2.fromOffset(16, 34),
        BackgroundTransparency = 1,
        Visible = subcontent ~= "",
    })
    Themed(subLabel, { TextColor3 = "MutedText" })

    local progressBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = theme.Accent,
        BackgroundTransparency = 0.2,
    })
    Themed(progressBar, { BackgroundColor3 = "Accent" })

    local stroke = Create("UIStroke", { Thickness = 1, Transparency = 0.55, Color = theme.Border })
    Themed(stroke, { Color = "Border" })

    local glow = Create("ImageLabel", {
        Image = GLOW_IMAGE,
        ImageColor3 = theme.AccentGlow,
        ImageTransparency = 0.82,
        Size = UDim2.new(1, 120, 1, 120),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ZIndex = 0,
    })
    Themed(glow, { ImageColor3 = "AccentGlow" })

    local root = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = theme.Surface,
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        Parent = NotifyHolder,
    }, {
        Create("UICorner", { CornerRadius = UDim.new(0, 12) }),
        stroke, glow, scale, accentBar, closeBtn, titleLabel, contentLabel, subLabel, progressBar,
        Create("UIPadding", { PaddingBottom = UDim.new(0, 14) }),
    })
    Themed(root, { BackgroundColor3 = "Surface" })
    root.ClipsDescendants = false

   
    root.Position = UDim2.new(1.2, 0, 0, 0)
    Tween(root, EASE.Bounce, { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0 })
    Tween(scale, EASE.Bounce, { Scale = 1 })

    local closed = false
    local function close()
        if closed then return end
        closed = true
        Tween(root, EASE.SmoothIn, { Position = UDim2.new(1.2, 0, 0, 0), BackgroundTransparency = 1 })
        Tween(scale, EASE.SmoothIn, { Scale = 0.9 })
        task.delay(0.25, function() root:Destroy() end)
    end
    closeBtn.MouseButton1Click:Connect(close)

    if duration then
        Tween(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, 2) })
        task.delay(duration, close)
    else
        progressBar.Visible = false
    end

    return { Root = root, Close = close }
end

local function BuildDialog(window)
    local theme = CurrentTheme()

    local tint = Create("TextButton", {
        Text = "",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        Parent = window.Root,
        ZIndex = 50,
    })

    local dscale = Create("UIScale", { Scale = 0.85 })

    local titleLabel = Create("TextLabel", {
        Font = Enum.Font.GothamBold,
        Text = "Dialog",
        TextColor3 = theme.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -40, 0, 22),
        Position = UDim2.fromOffset(20, 22),
        BackgroundTransparency = 1,
        ZIndex = 52,
    })
    Themed(titleLabel, { TextColor3 = "Text" })

    local buttonHolder = Create("Frame", {
        Size = UDim2.new(1, -40, 0, 36),
        Position = UDim2.new(0, 20, 1, -56),
        BackgroundTransparency = 1,
        ZIndex = 52,
    }, {
        Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 10),
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
    })

    local stroke = Create("UIStroke", { Thickness = 1, Transparency = 0.5, Color = theme.BorderLight })
    Themed(stroke, { Color = "BorderLight" })
    local glow = Create("ImageLabel", {
        Image = GLOW_IMAGE, ImageColor3 = theme.AccentGlow, ImageTransparency = 0.85,
        Size = UDim2.new(1, 160, 1, 160), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1, ZIndex = 51,
    })
    Themed(glow, { ImageColor3 = "AccentGlow" })

    local root = Create("Frame", {
        Size = UDim2.fromOffset(340, 170),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundColor3 = theme.SurfaceElevated,
        BackgroundTransparency = 0,
        Parent = tint,
        ZIndex = 51,
    }, {
        Create("UICorner", { CornerRadius = UDim.new(0, 14) }),
        stroke, glow, dscale, titleLabel, buttonHolder,
    })
    Themed(root, { BackgroundColor3 = "SurfaceElevated" })

    local d = { Buttons = 0, Root = root, Title = titleLabel }

    function d:Open()
        Library.DialogOpen = true
        Tween(tint, EASE.Smooth, { BackgroundTransparency = 0.45 })
        Tween(root, EASE.Bounce, { BackgroundTransparency = 0 })
        Tween(dscale, EASE.Bounce, { Scale = 1 })
    end

    function d:Close()
        Library.DialogOpen = false
        Tween(tint, EASE.SmoothIn, { BackgroundTransparency = 1 })
        Tween(dscale, EASE.SmoothIn, { Scale = 0.85 })
        task.delay(0.2, function() tint:Destroy() end)
    end

    function d:Button(text, callback)
        d.Buttons = d.Buttons + 1
        text = text or "Button"
        callback = callback or function() end

        local btnScale = Create("UIScale", { Scale = 1 })
        local bstroke = Create("UIStroke", { Thickness = 1, Transparency = 0.4, Color = theme.BorderLight })
        Themed(bstroke, { Color = "BorderLight" })

        local btn = Create("TextButton", {
            Size = UDim2.new(0, 100, 1, 0),
            BackgroundColor3 = theme.SurfaceLight,
            AutoButtonColor = false,
            Text = text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextColor3 = theme.Text,
            Parent = buttonHolder,
        }, { Create("UICorner", { CornerRadius = UDim.new(0, 8) }), bstroke, btnScale })
        Themed(btn, { BackgroundColor3 = "SurfaceLight", TextColor3 = "Text" })

        btn.MouseEnter:Connect(function() Tween(btn, EASE.Fast, { BackgroundColor3 = CurrentTheme().ElementHover }) end)
        btn.MouseLeave:Connect(function() Tween(btn, EASE.Fast, { BackgroundColor3 = CurrentTheme().SurfaceLight }) end)
        btn.MouseButton1Down:Connect(function() Tween(btnScale, EASE.Quick, { Scale = 0.94 }) end)
        btn.MouseButton1Up:Connect(function() Tween(btnScale, EASE.Bounce, { Scale = 1 }) end)
        btn.MouseButton1Click:Connect(function()
            Library:SafeCallback(callback)
            pcall(function() d:Close() end)
        end)
        return btn
    end

    return d
end

local Elements = {}

function Elements.Button(container, cfg)
    assert(cfg.Title, "Button - Missing Title")
    cfg.Callback = cfg.Callback or function() end
    local card = BuildElementCard(cfg.Title, cfg.Description, container, true)

    local chevron = Create("ImageLabel", {
        Image = CHEVRON_RIGHT,
        Size = UDim2.fromOffset(15, 15),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        BackgroundTransparency = 1,
        ImageColor3 = CurrentTheme().SubText,
        Parent = card.Frame,
    })
    Themed(chevron, { ImageColor3 = "SubText" })

    card.Frame.MouseEnter:Connect(function() Tween(chevron, EASE.Fast, { Position = UDim2.new(1, -8, 0.5, 0) }) end)
    card.Frame.MouseLeave:Connect(function() Tween(chevron, EASE.Fast, { Position = UDim2.new(1, -12, 0.5, 0) }) end)
    card.Frame.MouseButton1Click:Connect(function()
        Library:SafeCallback(cfg.Callback)
    end)
    return card
end

function Elements.Toggle(container, idx, cfg)
    assert(cfg.Title, "Toggle - Missing Title")
    local theme = CurrentTheme()
    local card = BuildElementCard(cfg.Title, cfg.Description, container, true)

    local api = { Value = cfg.Default or false, Type = "Toggle", Callback = cfg.Callback or function() end }
    api.SetTitle, api.SetDesc = card.SetTitle, card.SetDesc

    local knob = Create("Frame", {
        Size = UDim2.fromOffset(15, 15),
        Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = theme.SubText,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    Themed(knob, { BackgroundColor3 = "SubText" })

    local knobGlow = Create("ImageLabel", {
        Image = GLOW_IMAGE, Size = UDim2.fromOffset(38, 38),
        Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1, ImageColor3 = theme.AccentGlow, ImageTransparency = 1,
        Parent = knob, ZIndex = 0,
    })
    Themed(knobGlow, { ImageColor3 = "AccentGlow" })

    local track = Create("Frame", {
        Size = UDim2.fromOffset(38, 20),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -14, 0.5, 0),
        BackgroundColor3 = theme.SurfaceLight,
        Parent = card.Frame,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }), knob })
    Themed(track, { BackgroundColor3 = "SurfaceLight" })

    function api:SetValue(v)
        v = not not v
        api.Value = v
        local th = CurrentTheme()
        Tween(track, EASE.Fast, { BackgroundColor3 = v and th.Accent or th.SurfaceLight })
        Tween(knob, EASE.Bounce, { Position = v and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 2, 0.5, 0) })
        Tween(knob, EASE.Fast, { BackgroundColor3 = v and Color3.new(1, 1, 1) or th.SubText })
        Tween(knobGlow, EASE.Fast, { ImageTransparency = v and 0.55 or 1 })
        Library:SafeCallback(api.Callback, v)
        if api.Changed then Library:SafeCallback(api.Changed, v) end
    end
    function api:OnChanged(fn) api.Changed = fn; fn(api.Value) end
    function api:Destroy() card:Destroy(); Library.Options[idx] = nil end

    card.Frame.MouseButton1Click:Connect(function() api:SetValue(not api.Value) end)
    api:SetValue(api.Value)
    if idx then Library.Options[idx] = api end
    return api
end

function Elements.Slider(container, idx, cfg)
    assert(cfg.Title, "Slider - Missing Title")
    assert(cfg.Min ~= nil and cfg.Max ~= nil, "Slider - Missing Min/Max")
    local theme = CurrentTheme()
    local card = BuildElementCard(cfg.Title, cfg.Description, container, false)

    local api = { Min = cfg.Min, Max = cfg.Max, Rounding = cfg.Rounding or 1, Type = "Slider", Callback = cfg.Callback or function() end }
    api.SetTitle, api.SetDesc = card.SetTitle, card.SetDesc

    do
        local pad = card.LabelHolder:FindFirstChildOfClass("UIPadding")
        if pad then pad.PaddingBottom = UDim.new(0, 2) end
    end

    local valueLabel = Create("TextLabel", {
        Font = Enum.Font.GothamMedium, Text = tostring(cfg.Default or cfg.Min),
        TextColor3 = theme.SubText, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Right,
        Size = UDim2.new(0, 50, 0, 14), Position = UDim2.new(1, -14, 0, 12),
        AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, Parent = card.Frame,
    })
    Themed(valueLabel, { TextColor3 = "SubText" })

    local fill = Create("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = theme.Accent,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    Themed(fill, { BackgroundColor3 = "Accent" })

    local knobGlow = Create("ImageLabel", {
        Image = GLOW_IMAGE, Size = UDim2.fromOffset(30, 30), AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(1, 0.5), BackgroundTransparency = 1,
        ImageColor3 = theme.AccentGlow, ImageTransparency = 0.6, Parent = fill,
    })
    Themed(knobGlow, { ImageColor3 = "AccentGlow" })

    local knob = Create("Frame", {
        Size = UDim2.fromOffset(14, 14), AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(1, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), Parent = fill,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

    local rail = Create("Frame", {
        Size = UDim2.new(1, -32, 0, 6),
        Position = UDim2.new(0, 16, 0, 34),
        BackgroundColor3 = theme.SurfaceLight,
        ClipsDescendants = false,
        Parent = card.Frame,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }), fill })
    Themed(rail, { BackgroundColor3 = "SurfaceLight" })

    card.Frame.Size = UDim2.new(1, 0, 0, 56)
    card.Frame.AutomaticSize = Enum.AutomaticSize.None

    local dragging = false
    local function updateFromAlpha(alpha)
        alpha = math.clamp(alpha, 0, 1)
        local value = Round(api.Min + (api.Max - api.Min) * alpha, api.Rounding)
        api.Value = value
        valueLabel.Text = tostring(value)
        local a = (value - api.Min) / (api.Max - api.Min)
        Tween(fill, EASE.Quick, { Size = UDim2.new(a, 0, 1, 0) })
        Library:SafeCallback(api.Callback, value)
        if api.Changed then Library:SafeCallback(api.Changed, value) end
    end

    function api:SetValue(v)
        local alpha = (v - api.Min) / (api.Max - api.Min)
        updateFromAlpha(alpha)
    end
    function api:OnChanged(fn) api.Changed = fn; fn(api.Value) end
    function api:Destroy() card:Destroy(); Library.Options[idx] = nil end

    local function beginDrag()
        dragging = true
        Tween(knob, EASE.Bounce, { Size = UDim2.fromOffset(18, 18) })
    end
    local function endDrag()
        dragging = false
        Tween(knob, EASE.Bounce, { Size = UDim2.fromOffset(14, 14) })
    end

    rail.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            beginDrag()
            local alpha = (Mouse.X - rail.AbsolutePosition.X) / rail.AbsoluteSize.X
            updateFromAlpha(alpha)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local alpha = (Mouse.X - rail.AbsolutePosition.X) / rail.AbsoluteSize.X
            updateFromAlpha(alpha)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) then
            endDrag()
        end
    end)

    api:SetValue(cfg.Default or cfg.Min)
    if idx then Library.Options[idx] = api end
    return api
end

function Elements.Dropdown(container, idx, cfg)
    assert(cfg.Title, "Dropdown - Missing Title")
    local theme = CurrentTheme()
    local card = BuildElementCard(cfg.Title, cfg.Description, container, true)

    local api = { Values = cfg.Values or {}, Multi = cfg.Multi or false, Value = cfg.Multi and {} or nil, Type = "Dropdown", Callback = cfg.Callback or function() end, Opened = false }
    api.SetTitle, api.SetDesc = card.SetTitle, card.SetDesc

    local valueLabel = Create("TextLabel", {
        Font = Enum.Font.Gotham, Text = "--", TextColor3 = theme.SubText, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Size = UDim2.new(1, -34, 0, 16), Position = UDim2.fromOffset(12, 8), BackgroundTransparency = 1,
    })
    Themed(valueLabel, { TextColor3 = "SubText" })

    local chevron = Create("ImageLabel", {
        Image = CHEVRON_DOWN, Size = UDim2.fromOffset(14, 14),
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0),
        BackgroundTransparency = 1, ImageColor3 = theme.SubText,
    })
    Themed(chevron, { ImageColor3 = "SubText" })

    local pillStroke = Create("UIStroke", { Thickness = 1, Transparency = 0.4, Color = theme.ElementBorder })
    Themed(pillStroke, { Color = "ElementBorder" })

    local pill = Create("TextButton", {
        Size = UDim2.new(0, 170, 0, 32),
        Position = UDim2.new(1, -14, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = theme.SurfaceLight,
        AutoButtonColor = false,
        Text = "",
        Parent = card.Frame,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 9) }), pillStroke, valueLabel, chevron })
    Themed(pill, { BackgroundColor3 = "SurfaceLight" })

    local listLayout = Create("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
    local optionsHolder = Create("Frame", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, -10, 0, 0), BackgroundTransparency = 1, Position = UDim2.fromOffset(5, 5) }, { listLayout })

    local popStroke = Create("UIStroke", { Thickness = 1, Transparency = 0.35, Color = theme.BorderLight })
    Themed(popStroke, { Color = "BorderLight" })
    local popGlow = Create("ImageLabel", {
        Image = GLOW_IMAGE, ImageColor3 = theme.AccentGlow, ImageTransparency = 0.88,
        Size = UDim2.new(1, 80, 1, 80), Position = UDim2.fromScale(0.5, 0), AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1, ZIndex = 0,
    })
    Themed(popGlow, { ImageColor3 = "AccentGlow" })
    local popScale = Create("UIScale", { Scale = 0.92 })

    local popup = Create("Frame", {
        Size = UDim2.fromOffset(170, 0),
        BackgroundColor3 = theme.SurfaceElevated,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Visible = false,
        ZIndex = 40,
        Parent = ScreenGui,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }), popStroke, popGlow, popScale, optionsHolder })
    Themed(popup, { BackgroundColor3 = "SurfaceElevated" })
    table.insert(Library.OpenFrames, popup)

    local optionButtons = {}

    local function refreshLabel()
        if api.Multi then
            local names = {}
            for _, v in ipairs(api.Values) do
                if api.Value[v] then table.insert(names, v) end
            end
            valueLabel.Text = #names > 0 and table.concat(names, ", ") or "--"
        else
            valueLabel.Text = api.Value or "--"
        end
    end

    local function buildList()
        for _, child in ipairs(optionsHolder:GetChildren()) do
            if not child:IsA("UIListLayout") then child:Destroy() end
        end
        optionButtons = {}
        for _, name in ipairs(api.Values) do
            local selected = api.Multi and api.Value[name] or (api.Value == name)
            local optStroke = Create("UIStroke", { Thickness = 0, Transparency = 1, Color = CurrentTheme().Accent })
            local opt = Create("TextButton", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = selected and CurrentTheme().ElementHover or CurrentTheme().SurfaceElevated,
                AutoButtonColor = false,
                Text = "",
                Parent = optionsHolder,
            }, {
                Create("UICorner", { CornerRadius = UDim.new(0, 7) }),
                optStroke,
                Create("TextLabel", {
                    Font = Enum.Font.Gotham, Text = name, TextColor3 = CurrentTheme().Text, TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
                    Size = UDim2.new(1, -30, 1, 0), Position = UDim2.fromOffset(10, 0),
                }),
                Create("ImageLabel", {
                    Name = "Check", Image = CHECK_ICON, Size = UDim2.fromOffset(14, 14),
                    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0),
                    BackgroundTransparency = 1, ImageColor3 = CurrentTheme().Accent,
                    ImageTransparency = selected and 0 or 1,
                }),
            })
            opt.MouseEnter:Connect(function() Tween(opt, EASE.Fast, { BackgroundColor3 = CurrentTheme().ElementHover }) end)
            opt.MouseLeave:Connect(function()
                local sel = api.Multi and api.Value[name] or (api.Value == name)
                Tween(opt, EASE.Fast, { BackgroundColor3 = sel and CurrentTheme().ElementHover or CurrentTheme().SurfaceElevated })
            end)
            opt.MouseButton1Click:Connect(function()
                if api.Multi then
                    api.Value[name] = not api.Value[name] or nil
                else
                    api.Value = name
                    api:Close()
                end
                refreshLabel()
                buildList()
                Library:SafeCallback(api.Callback, api.Value)
                if api.Changed then Library:SafeCallback(api.Changed, api.Value) end
            end)
            optionButtons[name] = opt
        end
    end

    function api:Open()
        api.Opened = true
        popup.Visible = true
        local pos = pill.AbsolutePosition
        local size = pill.AbsoluteSize
        popup.Position = UDim2.fromOffset(pos.X, pos.Y + size.Y + 6)
        popup.Size = UDim2.fromOffset(size.X, 0)
        Tween(popup, EASE.Bounce, { BackgroundTransparency = 0, Size = UDim2.fromOffset(size.X, math.min(#api.Values * 33 + 10, 240)) })
        Tween(popScale, EASE.Bounce, { Scale = 1 })
        Tween(chevron, EASE.Fast, { Rotation = 180 })
    end
    function api:Close()
        api.Opened = false
        Tween(popup, EASE.SmoothIn, { BackgroundTransparency = 1, Size = UDim2.fromOffset(pill.AbsoluteSize.X, 0) })
        Tween(popScale, EASE.SmoothIn, { Scale = 0.92 })
        Tween(chevron, EASE.Fast, { Rotation = 0 })
        task.delay(0.22, function() if not api.Opened then popup.Visible = false end end)
    end
    function api:SetValues(values)
        api.Values = values
        buildList()
    end
    function api:SetValue(v)
        if api.Multi then
            local map = {}
            for _, name in ipairs(v) do map[name] = true end
            api.Value = map
        else
            api.Value = v
        end
        refreshLabel()
        buildList()
        Library:SafeCallback(api.Callback, api.Value)
        if api.Changed then Library:SafeCallback(api.Changed, api.Value) end
    end
    function api:OnChanged(fn) api.Changed = fn; fn(api.Value) end
    function api:Destroy() card:Destroy(); popup:Destroy(); Library.Options[idx] = nil end

    pill.MouseButton1Click:Connect(function()
        if api.Opened then api:Close() else api:Open() end
    end)
    UserInputService.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if api.Opened then
                local pos, size = popup.AbsolutePosition, popup.AbsoluteSize
                local mp = UserInputService:GetMouseLocation()
                if mp.X < pos.X or mp.X > pos.X + size.X or mp.Y < pos.Y or mp.Y > pos.Y + size.Y then
                    if not (Mouse.X >= pill.AbsolutePosition.X and Mouse.X <= pill.AbsolutePosition.X + pill.AbsoluteSize.X
                        and Mouse.Y >= pill.AbsolutePosition.Y and Mouse.Y <= pill.AbsolutePosition.Y + pill.AbsoluteSize.Y) then
                        api:Close()
                    end
                end
            end
        end
    end)

    buildList()
    if cfg.Default then
        if api.Multi and type(cfg.Default) == "table" then
            local map = {}
            for _, v in ipairs(cfg.Default) do map[v] = true end
            api.Value = map
        elseif not api.Multi then
            api.Value = cfg.Default
        end
    end
    refreshLabel()
    buildList()
    if idx then Library.Options[idx] = api end
    return api
end

function Elements.Colorpicker(container, idx, cfg)
    assert(cfg.Title, "Colorpicker - Missing Title")
    assert(cfg.Default, "Colorpicker - Missing Default")
    local theme = CurrentTheme()
    local card = BuildElementCard(cfg.Title, cfg.Description, container, true)

    local api = { Value = cfg.Default, Type = "Colorpicker", Callback = cfg.Callback or function() end }
    api.SetTitle, api.SetDesc = card.SetTitle, card.SetDesc

    local swatchStroke = Create("UIStroke", { Thickness = 1, Transparency = 0.3, Color = theme.BorderLight })
    Themed(swatchStroke, { Color = "BorderLight" })
    local swatch = Create("Frame", {
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -14, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = api.Value,
        Parent = card.Frame,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 8) }), swatchStroke })

    local dialogLib
    local function openPicker()
        local d = BuildDialog(Library.Window)
        d.Title.Text = cfg.Title
        d.Root.Size = UDim2.fromOffset(300, 300)

        local hue, sat, val = Color3.toHSV(api.Value)

        local svMap = Create("ImageLabel", {
            Image = "rbxassetid://4155801252",
            Size = UDim2.fromOffset(220, 140),
            Position = UDim2.fromOffset(20, 55),
            BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
            Parent = d.Root, ZIndex = 52,
        }, { Create("UICorner", { CornerRadius = UDim.new(0, 8) }) })

        local svCursor = Create("ImageLabel", {
            Image = DOT_ICON, Size = UDim2.fromOffset(14, 14),
            AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1,
            ImageColor3 = Color3.new(1, 1, 1), Parent = svMap, ZIndex = 53,
        })

        local hueBarStroke = Create("UIStroke", { Thickness = 1, Transparency = 0.4 })
        local hueBar = Create("Frame", {
            Size = UDim2.fromOffset(220, 16),
            Position = UDim2.fromOffset(20, 205),
            Parent = d.Root, ZIndex = 52,
        }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }), hueBarStroke })
        local hueSeq = {}
        for i = 0, 1, 0.1 do table.insert(hueSeq, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1))) end
        Create("UIGradient", { Color = ColorSequence.new(hueSeq), Parent = hueBar })

        local hueCursor = Create("Frame", {
            Size = UDim2.fromOffset(4, 20), AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(hue, 0, 0.5, 0), BackgroundColor3 = Color3.new(1, 1, 1),
            Parent = hueBar, ZIndex = 53,
        }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

        local function apply()
            svMap.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            svCursor.Position = UDim2.new(sat, 0, 1 - val, 0)
            hueCursor.Position = UDim2.new(hue, 0, 0.5, 0)
            local c = Color3.fromHSV(hue, sat, val)
            swatch.BackgroundColor3 = c
        end
        apply()

        local draggingSV, draggingHue = false, false
        svMap.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingSV = true end
        end)
        hueBar.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingHue = true end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingSV, draggingHue = false, false end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if inp.UserInputType ~= Enum.UserInputType.MouseMovement then return end
            if draggingSV then
                sat = math.clamp((Mouse.X - svMap.AbsolutePosition.X) / svMap.AbsoluteSize.X, 0, 1)
                val = 1 - math.clamp((Mouse.Y - svMap.AbsolutePosition.Y) / svMap.AbsoluteSize.Y, 0, 1)
                apply()
            elseif draggingHue then
                hue = math.clamp((Mouse.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
                apply()
            end
        end)

        d:Button("Done", function()
            api.Value = Color3.fromHSV(hue, sat, val)
            Library:SafeCallback(api.Callback, api.Value)
            if api.Changed then Library:SafeCallback(api.Changed, api.Value) end
        end)
        d:Button("Cancel")
        d:Open()
    end

    card.Frame.MouseButton1Click:Connect(openPicker)
    function api:SetValue(c) api.Value = c; swatch.BackgroundColor3 = c end
    function api:OnChanged(fn) api.Changed = fn; fn(api.Value) end
    function api:Destroy() card:Destroy(); Library.Options[idx] = nil end

    if idx then Library.Options[idx] = api end
    return api
end

function Elements.Keybind(container, idx, cfg)
    assert(cfg.Title, "Keybind - Missing Title")
    assert(cfg.Default, "Keybind - Missing Default")
    local theme = CurrentTheme()
    local card = BuildElementCard(cfg.Title, cfg.Description, container, true)

    local api = { Value = cfg.Default, Mode = cfg.Mode or "Toggle", Toggled = false, Type = "Keybind", Callback = cfg.Callback or function() end }
    api.SetTitle, api.SetDesc = card.SetTitle, card.SetDesc

    local label = Create("TextLabel", {
        Font = Enum.Font.GothamMedium, Text = tostring(cfg.Default), TextColor3 = theme.Text, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Center, AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 0, 14), BackgroundTransparency = 1,
    })
    Themed(label, { TextColor3 = "Text" })

    local pillStroke = Create("UIStroke", { Thickness = 1, Transparency = 0.4, Color = theme.ElementBorder })
    Themed(pillStroke, { Color = "ElementBorder" })

    local pill = Create("TextButton", {
        Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X,
        Position = UDim2.new(1, -14, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = theme.SurfaceLight, AutoButtonColor = false, Text = "",
        Parent = card.Frame,
    }, {
        Create("UICorner", { CornerRadius = UDim.new(0, 9) }), pillStroke,
        Create("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }),
        label,
    })
    Themed(pill, { BackgroundColor3 = "SurfaceLight" })

    local listening = false
    pill.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        label.Text = "..."
        Tween(pillStroke, EASE.Fast, { Color = CurrentTheme().Accent, Transparency = 0 })
        local conn
        conn = UserInputService.InputBegan:Connect(function(inp)
            local keyName
            if inp.UserInputType == Enum.UserInputType.Keyboard then
                keyName = inp.KeyCode.Name
            elseif inp.UserInputType == Enum.UserInputType.MouseButton1 then
                keyName = "MouseLeft"
            elseif inp.UserInputType == Enum.UserInputType.MouseButton2 then
                keyName = "MouseRight"
            end
            if keyName then
                api.Value = keyName
                label.Text = keyName
                listening = false
                Tween(pillStroke, EASE.Fast, { Color = CurrentTheme().ElementBorder, Transparency = 0.4 })
                if api.Changed then Library:SafeCallback(api.Changed, keyName) end
                conn:Disconnect()
            end
        end)
    end)

    function api:GetState()
        if api.Mode == "Always" then return true end
        if api.Mode == "Hold" then
            if api.Value == "MouseLeft" then return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) end
            if api.Value == "MouseRight" then return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) end
            local ok, kc = pcall(function() return Enum.KeyCode[api.Value] end)
            return ok and kc and UserInputService:IsKeyDown(kc)
        end
        return api.Toggled
    end
    function api:SetValue(v, mode) api.Value = v; api.Mode = mode or api.Mode; label.Text = v end
    function api:OnClick(fn) api.Clicked = fn end
    function api:OnChanged(fn) api.Changed = fn; fn(api.Value) end
    function api:Destroy() card:Destroy(); Library.Options[idx] = nil end

    UserInputService.InputBegan:Connect(function(inp)
        if listening or UserInputService:GetFocusedTextBox() then return end
        if api.Mode == "Toggle" then
            local matched = false
            if api.Value == "MouseLeft" and inp.UserInputType == Enum.UserInputType.MouseButton1 then matched = true end
            if api.Value == "MouseRight" and inp.UserInputType == Enum.UserInputType.MouseButton2 then matched = true end
            if inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode.Name == api.Value then matched = true end
            if matched then
                api.Toggled = not api.Toggled
                Library:SafeCallback(api.Callback, api.Toggled)
                if api.Clicked then Library:SafeCallback(api.Clicked, api.Toggled) end
            end
        end
    end)

    if idx then Library.Options[idx] = api end
    return api
end

function Elements.Input(container, idx, cfg)
    assert(cfg.Title, "Input - Missing Title")
    local theme = CurrentTheme()
    local card = BuildElementCard(cfg.Title, cfg.Description, container, false)

    local api = { Value = cfg.Default or "", Numeric = cfg.Numeric or false, Type = "Input", Callback = cfg.Callback or function() end }
    api.SetTitle, api.SetDesc = card.SetTitle, card.SetDesc

    do
        local pad = card.LabelHolder:FindFirstChildOfClass("UIPadding")
        if pad then pad.PaddingBottom = UDim.new(0, 2) end
    end

    local indicator = Create("Frame", {
        Size = UDim2.new(1, -4, 0, 1), Position = UDim2.new(0, 2, 1, 0), AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = theme.BorderLight,
    })
    Themed(indicator, { BackgroundColor3 = "BorderLight" })

    local box = Create("TextBox", {
        Font = Enum.Font.Gotham, Text = api.Value, PlaceholderText = cfg.Placeholder or "",
        TextColor3 = theme.Text, PlaceholderColor3 = theme.MutedText, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false,
        Size = UDim2.new(1, -20, 0, 30), Position = UDim2.fromOffset(10, 0), BackgroundTransparency = 1,
    })
    Themed(box, { TextColor3 = "Text", PlaceholderColor3 = "MutedText" })

    local stroke = Create("UIStroke", { Thickness = 1, Transparency = 0.5, Color = theme.ElementBorder })
    Themed(stroke, { Color = "ElementBorder" })

    local frame = Create("Frame", {
        Size = UDim2.new(1, -28, 0, 34), Position = UDim2.fromOffset(14, 44),
        BackgroundColor3 = theme.SurfaceLight, Parent = card.Frame,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 9) }), stroke, indicator, box })
    Themed(frame, { BackgroundColor3 = "SurfaceLight" })
    card.Frame.AutomaticSize = Enum.AutomaticSize.None
    card.Frame.Size = UDim2.new(1, 0, 0, 88)

    function api:SetValue(v)
        if cfg.MaxLength and #v > cfg.MaxLength then v = v:sub(1, cfg.MaxLength) end
        if api.Numeric and v:len() > 0 and not tonumber(v) then v = api.Value end
        api.Value = v
        box.Text = v
        Library:SafeCallback(api.Callback, v)
        if api.Changed then Library:SafeCallback(api.Changed, v) end
    end
    function api:OnChanged(fn) api.Changed = fn; fn(api.Value) end
    function api:Destroy() card:Destroy(); Library.Options[idx] = nil end

    box.Focused:Connect(function()
        Tween(indicator, EASE.Fast, { BackgroundColor3 = CurrentTheme().Accent, Size = UDim2.new(1, -2, 0, 2) })
        Tween(stroke, EASE.Fast, { Color = CurrentTheme().Accent, Transparency = 0.1 })
    end)
    box.FocusLost:Connect(function(entered)
        Tween(indicator, EASE.Fast, { BackgroundColor3 = CurrentTheme().BorderLight, Size = UDim2.new(1, -4, 0, 1) })
        Tween(stroke, EASE.Fast, { Color = CurrentTheme().ElementBorder, Transparency = 0.5 })
        if cfg.Finished then
            if entered then api:SetValue(box.Text) end
        end
    end)
    if not cfg.Finished then
        box:GetPropertyChangedSignal("Text"):Connect(function() api:SetValue(box.Text) end)
    end

    if idx then Library.Options[idx] = api end
    return api
end

function Elements.Paragraph(container, cfg)
    local card = BuildElementCard(cfg.Title, cfg.Content, container, false)
    card.Frame.BackgroundTransparency = 0.5
    card.Stroke.Transparency = 0.75
    return card
end

local function AttachElementAPI(obj, contentFrame)
    function obj:AddButton(cfg) return Elements.Button(contentFrame, cfg) end
    function obj:AddToggle(idx, cfg) return Elements.Toggle(contentFrame, idx, cfg) end
    function obj:AddSlider(idx, cfg) return Elements.Slider(contentFrame, idx, cfg) end
    function obj:AddDropdown(idx, cfg) return Elements.Dropdown(contentFrame, idx, cfg) end
    function obj:AddColorpicker(idx, cfg) return Elements.Colorpicker(contentFrame, idx, cfg) end
    function obj:AddKeybind(idx, cfg) return Elements.Keybind(contentFrame, idx, cfg) end
    function obj:AddInput(idx, cfg) return Elements.Input(contentFrame, idx, cfg) end
    function obj:AddParagraph(cfg) return Elements.Paragraph(contentFrame, cfg) end
    return obj
end

local function BuildSection(name, parent)
    local theme = CurrentTheme()
    local section = {}

    local titleLabel = Create("TextLabel", {
        Font = Enum.Font.GothamBold, Text = name, TextColor3 = theme.SubText, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1,
    })
    Themed(titleLabel, { TextColor3 = "SubText" })

    local content = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }) })

    local root = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
        Parent = parent,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }), titleLabel, content })

    section.Root = root
    return AttachElementAPI(section, content)
end


local function BuildTab(window, cfg)
    local theme = CurrentTheme()
    cfg = cfg or {}
    local iconId = Library.GetIcon(cfg.Icon)

    local tab = { Name = cfg.Title or "Tab", Selected = false }

    local icon = Create("ImageLabel", {
        Image = iconId or DOT_ICON, Size = UDim2.fromOffset(16, 16),
        Position = UDim2.new(0, 12, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1, ImageColor3 = theme.SubText,
    })
    Themed(icon, { ImageColor3 = "SubText" })

    local label = Create("TextLabel", {
        Font = Enum.Font.GothamMedium, Text = tab.Name, TextColor3 = theme.SubText, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, iconId and 36 or 14, 0, 0), BackgroundTransparency = 1,
    })
    Themed(label, { TextColor3 = "SubText" })

    local scale = Create("UIScale", { Scale = 1 })
    local button = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 36), BackgroundTransparency = 1, AutoButtonColor = false, Text = "",
        Parent = window.TabHolder,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 9) }), scale, icon, label })

    local scroll = Create("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false,
        ScrollBarThickness = 3, ScrollBarImageColor3 = theme.BorderLight, ScrollBarImageTransparency = 0.4,
        BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Parent = window.ContainerHolder,
    }, {
        Create("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
        Create("UIPadding", { PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 20) }),
    })
    tab.Button, tab.Icon, tab.Label, tab.Content, tab.Scroll = button, icon, label, scroll, scroll
    tab.Container = scroll

    local layout = scroll:FindFirstChildOfClass("UIListLayout")
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    button.MouseEnter:Connect(function()
        if not tab.Selected then Tween(button, EASE.Fast, { BackgroundTransparency = 0.85 }) end
    end)
    button.MouseLeave:Connect(function()
        if not tab.Selected then Tween(button, EASE.Fast, { BackgroundTransparency = 1 }) end
    end)
    button.MouseButton1Down:Connect(function() Tween(scale, EASE.Quick, { Scale = 0.97 }) end)
    button.MouseButton1Up:Connect(function() Tween(scale, EASE.Bounce, { Scale = 1 }) end)
    button.MouseButton1Click:Connect(function() window:SelectTab(tab) end)

    function tab:Select()
        tab.Selected = true
        local th = CurrentTheme()
        Tween(button, EASE.Smooth, { BackgroundTransparency = 0.88, BackgroundColor3 = th.ElementHover })
        Tween(icon, EASE.Fast, { ImageColor3 = th.Text })
        Tween(label, EASE.Fast, { TextColor3 = th.Text })
    end
    function tab:Deselect()
        tab.Selected = false
        local th = CurrentTheme()
        Tween(button, EASE.Smooth, { BackgroundTransparency = 1 })
        Tween(icon, EASE.Fast, { ImageColor3 = th.SubText })
        Tween(label, EASE.Fast, { TextColor3 = th.SubText })
    end

    return AttachElementAPI(tab, scroll)
end


local function BuildWindow(cfg)
    assert(cfg.Title, "Window - Missing Title")
    local theme = CurrentTheme()
    cfg.Size = cfg.Size or UDim2.fromOffset(580, 460)
    cfg.TabWidth = cfg.TabWidth or 160

    local window = {
        Tabs = {}, TabCount = 0, SelectedTab = nil,
        Minimized = false, Maximized = false,
        Size = cfg.Size,
    }

    local ambientGlow = Create("ImageLabel", {
        Image = GLOW_IMAGE, ImageColor3 = theme.AccentGlow, ImageTransparency = 0.9,
        Size = UDim2.new(1, 220, 1, 220), Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ZIndex = 0,
    })
    Themed(ambientGlow, { ImageColor3 = "AccentGlow" })

    local noise = Create("ImageLabel", {
        Image = NOISE_IMAGE, ImageTransparency = 0.965, ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.new(0, 128, 0, 128), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 1,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 16) }) })

    local glowStroke = Create("UIStroke", { Thickness = 1, Transparency = 0.55, Color = theme.AccentGlow, ZIndex = 3 })
    Themed(glowStroke, { Color = "AccentGlow" })
    Tween(glowStroke, EASE.Glow, { Transparency = 0.15, Thickness = 1.4 })

    local borderStroke = Create("UIStroke", { Thickness = 1, Transparency = 0.55, Color = theme.Border, ZIndex = 3 })
    Themed(borderStroke, { Color = "Border" })

    local rootScale = Create("UIScale", { Scale = 0.85 })

    local root = Create("Frame", {
        Size = cfg.Size,
        Position = UDim2.fromOffset(
            (Camera.ViewportSize.X - cfg.Size.X.Offset) / 2,
            (Camera.ViewportSize.Y - cfg.Size.Y.Offset) / 2
        ),
        BackgroundColor3 = theme.Background,
        ClipsDescendants = true,
        Parent = ScreenGui,
    }, {
        Create("UICorner", { CornerRadius = UDim.new(0, 16) }),
        ambientGlow, noise, glowStroke, borderStroke, rootScale,
    })
    Themed(root, { BackgroundColor3 = "Background" })
    window.Root = root

    root.BackgroundTransparency = 1
    Tween(root, EASE.Smooth, { BackgroundTransparency = 0 })
    Tween(rootScale, EASE.BigBounce, { Scale = 1 })

    local titleLabel = Create("TextLabel", {
        Font = Enum.Font.GothamBold, Text = cfg.Title, TextColor3 = theme.Text, TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
    })
    Themed(titleLabel, { TextColor3 = "Text" })

    local subtitleLabel = Create("TextLabel", {
        Font = Enum.Font.Gotham, Text = cfg.SubTitle or "", TextColor3 = theme.SubText, TextSize = 12,
        TextTransparency = 0.2, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.fromScale(0, 1),
        AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1,
    })
    Themed(subtitleLabel, { TextColor3 = "SubText" })

    local function makeCaptionButton(image, order)
        local s = Create("UIScale", { Scale = 1 })
        local btn = Create("ImageButton", {
            Size = UDim2.fromOffset(30, 30), BackgroundTransparency = 1, LayoutOrder = order,
        }, {
            Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
            s,
            Create("ImageLabel", { Name = "Icon", Image = image, Size = UDim2.fromOffset(14, 14), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = theme.SubText }),
        })
        Themed(btn.Icon, { ImageColor3 = "SubText" })
        btn.MouseEnter:Connect(function()
            Tween(btn, EASE.Fast, { BackgroundTransparency = 0.88, BackgroundColor3 = CurrentTheme().ElementHover })
            Tween(btn.Icon, EASE.Fast, { ImageColor3 = CurrentTheme().Text })
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, EASE.Fast, { BackgroundTransparency = 1 })
            Tween(btn.Icon, EASE.Fast, { ImageColor3 = CurrentTheme().SubText })
        end)
        btn.MouseButton1Down:Connect(function() Tween(s, EASE.Quick, { Scale = 0.85 }) end)
        btn.MouseButton1Up:Connect(function() Tween(s, EASE.Bounce, { Scale = 1 }) end)
        return btn
    end

    local closeBtn  = makeCaptionButton(CLOSE_ICON, 3)
    local maxBtn    = makeCaptionButton(MAX_ICON, 2)
    local minBtn    = makeCaptionButton(MIN_ICON, 1)

    local captionRow = Create("Frame", {
        Size = UDim2.fromOffset(96, 30), Position = UDim2.new(1, -8, 0, 8), AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
    }, { Create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }), minBtn, maxBtn, closeBtn })

    local titleBarLine = Create("Frame", { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, 0), BackgroundColor3 = theme.Border, BackgroundTransparency = 0.4 })
    Themed(titleBarLine, { BackgroundColor3 = "Border" })

    local titleBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 48), BackgroundTransparency = 1, Parent = root,
    }, {
        Create("Frame", { Size = UDim2.new(1, -110, 1, 0), Position = UDim2.fromOffset(18, 0), BackgroundTransparency = 1 },
            { Create("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 1), SortOrder = Enum.SortOrder.LayoutOrder }), titleLabel, subtitleLabel }),
        captionRow, titleBarLine,
    })
    window.TitleBar = titleBar

    local selectorBar = Create("Frame", {
        Size = UDim2.fromOffset(3, 30), Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = theme.Accent,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    Themed(selectorBar, { BackgroundColor3 = "Accent" })
    local selectorGlow = Create("ImageLabel", {
        Image = GLOW_IMAGE, ImageColor3 = theme.AccentGlow, ImageTransparency = 0.5,
        Size = UDim2.new(1, 26, 1, 26), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1, Parent = selectorBar, ZIndex = 0,
    })
    Themed(selectorGlow, { ImageColor3 = "AccentGlow" })

    local tabHolder = Create("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScrollBarThickness = 0,
        BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0),
    }, { Create("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }) })
    window.TabHolder = tabHolder

    local tabColumn = Create("Frame", {
        Size = UDim2.new(0, cfg.TabWidth, 1, -66), Position = UDim2.new(0, 12, 0, 56),
        BackgroundTransparency = 1, ClipsDescendants = true, Parent = root,
    }, { tabHolder, selectorBar })
    window.TabColumn = tabColumn

    local separator = Create("Frame", {
        Size = UDim2.new(0, 1, 1, -66), Position = UDim2.new(0, cfg.TabWidth + 20, 0, 56),
        BackgroundColor3 = theme.Border, BackgroundTransparency = 0.5, Parent = root,
    })
    Themed(separator, { BackgroundColor3 = "Border" })

    local containerHolder = Create("Frame", {
        Size = UDim2.new(1, -cfg.TabWidth - 44, 1, -66), Position = UDim2.new(0, cfg.TabWidth + 32, 0, 56),
        BackgroundTransparency = 1, Parent = root, ClipsDescendants = true,
    })
    window.ContainerHolder = containerHolder

    tabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabHolder.CanvasSize = UDim2.new(0, 0, 0, tabHolder.UIListLayout.AbsoluteContentSize.Y)
    end)

    function window:SelectTab(tab)
        if window.SelectedTab == tab then return end
        if window.SelectedTab then window.SelectedTab:Deselect() end
        window.SelectedTab = tab
        tab:Select()

        local targetY = tab.Button.AbsolutePosition.Y - tabHolder.AbsolutePosition.Y + tabHolder.CanvasPosition.Y
        Tween(selectorBar, EASE.Bounce, { Position = UDim2.fromOffset(0, targetY) })

        for _, t in pairs(window.Tabs) do
            if t ~= tab then t.Scroll.Visible = false end
        end
        tab.Scroll.Position = UDim2.fromOffset(14, 0)
        tab.Scroll.Visible = true
        Tween(tab.Scroll, EASE.Smooth, { Position = UDim2.fromOffset(0, 0) })
    end

    function window:AddTab(tcfg)
        window.TabCount = window.TabCount + 1
        local tab = BuildTab(window, tcfg)
        table.insert(window.Tabs, tab)
        if window.TabCount == 1 then
            task.defer(function() window:SelectTab(tab) end)
        end
        return tab
    end

    local dragging, dragStart, startPos = false, nil, nil
    titleBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = root.Position
            local conn
            conn = inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    conn:Disconnect()
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local delta = inp.Position - dragStart
            root.Position = UDim2.fromOffset(startPos.X.Offset + delta.X, startPos.Y.Offset + delta.Y)
        end
    end)

    local resizeHandle = Create("Frame", {
        Size = UDim2.fromOffset(18, 18), Position = UDim2.new(1, 0, 1, 0), AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1, Parent = root,
    })
    local resizing, resizeStart, startSize = false, nil, nil
    resizeHandle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeStart = inp.Position
            startSize = root.Size
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if resizing and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local delta = inp.Position - resizeStart
            local newX = math.clamp(startSize.X.Offset + delta.X, 480, 1400)
            local newY = math.clamp(startSize.Y.Offset + delta.Y, 380, 1000)
            root.Size = UDim2.fromOffset(newX, newY)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)

    local preMaxSize, preMaxPos

    function window:Maximize()
        window.Maximized = not window.Maximized
        maxBtn.Icon.Image = window.Maximized and RESTORE_ICON or MAX_ICON
        if window.Maximized then
            preMaxSize, preMaxPos = root.Size, root.Position
            Tween(root, EASE.Bounce, { Size = UDim2.fromOffset(Camera.ViewportSize.X, Camera.ViewportSize.Y), Position = UDim2.fromOffset(0, 0) })
        else
            Tween(root, EASE.Bounce, { Size = preMaxSize, Position = preMaxPos })
        end
    end
    maxBtn.MouseButton1Click:Connect(function() window:Maximize() end)

    local minimizeNotified = false
    function window:Minimize()
        window.Minimized = not window.Minimized
        if window.Minimized then
            Tween(rootScale, EASE.SmoothIn, { Scale = 0.85 })
            Tween(root, EASE.SmoothIn, { BackgroundTransparency = 1 })
            task.delay(0.22, function() if window.Minimized then root.Visible = false end end)
            if not minimizeNotified then
                minimizeNotified = true
                local keyName = (Library.MinimizeKeybind and Library.MinimizeKeybind.Value) or Library.MinimizeKey.Name
                Library:Notify({ Title = "Interface", Content = "Press " .. tostring(keyName) .. " to toggle the interface.", Duration = 6 })
            end
        else
            root.Visible = true
            Tween(rootScale, EASE.Bounce, { Scale = 1 })
            Tween(root, EASE.Smooth, { BackgroundTransparency = 0 })
        end
    end
    minBtn.MouseButton1Click:Connect(function() window:Minimize() end)

    function window:Dialog(dcfg)
        local d = BuildDialog(window)
        d.Title.Text = dcfg.Title or "Dialog"
        local contentLabel = Create("TextLabel", {
            Font = Enum.Font.Gotham, Text = dcfg.Content or "", TextColor3 = theme.SubText, TextSize = 13,
            TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
            Size = UDim2.new(1, -40, 1, -90), Position = UDim2.fromOffset(20, 54), BackgroundTransparency = 1,
            Parent = d.Root, ZIndex = 52,
        })
        Themed(contentLabel, { TextColor3 = "SubText" })
        for _, b in ipairs(dcfg.Buttons or {}) do
            d:Button(b.Title, b.Callback)
        end
        d:Open()
        return d
    end

    closeBtn.MouseButton1Click:Connect(function()
        window:Dialog({
            Title = "Close",
            Content = "Are you sure you want to unload the interface?",
            Buttons = {
                { Title = "Yes", Callback = function() Library:Destroy() end },
                { Title = "No" },
            },
        })
    end)

    UserInputService.InputBegan:Connect(function(inp)
        if UserInputService:GetFocusedTextBox() then return end
        if type(Library.MinimizeKeybind) == "table" and Library.MinimizeKeybind.Type == "Keybind" then
            if inp.KeyCode and inp.KeyCode.Name == Library.MinimizeKeybind.Value then window:Minimize() end
        elseif inp.KeyCode == Library.MinimizeKey then
            window:Minimize()
        end
    end)

    function window:Destroy()
        root:Destroy()
    end

    return window
end

function Library:CreateWindow(cfg)
    cfg = cfg or {}
    if Library.Window then
        warn("You cannot create more than one window.")
        return Library.Window
    end
    Library.MinimizeKey = cfg.MinimizeKeybind or Library.MinimizeKey
    Library.UseAcrylic = cfg.Acrylic or false
    Library.Theme = (cfg.Theme and Themes[cfg.Theme]) and cfg.Theme or "Dark"

    local window = BuildWindow(cfg)
    Library.Window = window
    return window
end

function Library:SetTheme(name)
    if Themes[name] then
        Library.Theme = name
        Library.UpdateTheme()
    end
end

function Library:ToggleAcrylic(state)
    Library.UseAcrylic = state
end

function Library:Destroy()
    if Library.Window then
        Library.Unloaded = true
        Library.Window:Destroy()
        Library.GUI:Destroy()
    end
end

if getgenv then
    getgenv().Fluent = Library
    getgenv().ParodyRise = Library
end

return Library
