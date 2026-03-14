local Config = {
    notification_title = Enum.Font.GothamBold,
    notification_body = Enum.Font.Gotham,
    Color = Color3.fromRGB(255, 0, 72),
    Icn = {
        x = "rbxassetid://76821953846248",
        key = "rbxassetid://96510194465420",
        shield = "rbxassetid://89965059528921",
        check = "rbxassetid://76078495178149",
        copy = "rbxassetid://125851897718493",
        discord = "rbxassetid://83278450537116",
        heart = "rbxassetid://116559368303288",
        alert = "rbxassetid://140438367956051"
    }
}

local ntl = {}
function Config.ntf(tit, msg, dur, iconType)
    local nsg = Instance.new("ScreenGui")
    nsg.ResetOnSpawn = false
    nsg.DisplayOrder = 2147483647
    nsg.Parent = game:GetService("CoreGui")

    local scl = math.clamp(math.min(workspace.CurrentCamera.ViewportSize.X, workspace.CurrentCamera.ViewportSize.Y) / 1366, 0.6, 1.6)
    local wid = math.clamp(300 * scl, 220, 400)
    local hgt = math.clamp(70 * scl, 60, 100)

    local nfr = Instance.new("Frame")
    nfr.Size = UDim2.new(0, wid, 0, hgt)
    nfr.Position = UDim2.new(1, wid + 20, 1, -12)
    nfr.AnchorPoint = Vector2.new(1, 1)
    nfr.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    nfr.BorderSizePixel = 0
    nfr.Parent = nsg
    
    Instance.new("UICorner", nfr).CornerRadius = UDim.new(0, 10)

    local pbg = Instance.new("Frame")
    pbg.Size = UDim2.new(1, 0, 0, 4)
    pbg.Position = UDim2.new(0, 0, 1, -4)
    pbg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    pbg.BorderSizePixel = 0
    pbg.Parent = nfr
    Instance.new("UICorner", pbg).CornerRadius = UDim.new(0, 2)

    local pbr = Instance.new("Frame")
    pbr.Size = UDim2.new(1, 0, 1, 0)
    pbr.BackgroundColor3 = Config.Color
    pbr.BorderSizePixel = 0
    pbr.Parent = pbg
    Instance.new("UICorner", pbr).CornerRadius = UDim.new(0, 2)

    local icn = Instance.new("ImageLabel")
    icn.Size = UDim2.new(0, hgt - 30, 0, hgt - 30)
    icn.Position = UDim2.new(0, 12, 0.5, 0)
    icn.AnchorPoint = Vector2.new(0, 0.5)
    icn.BackgroundTransparency = 1
    icn.ImageColor3 = Color3.new(1, 1, 1)
    icn.ScaleType = Enum.ScaleType.Fit
    icn.Image = (iconType and Config.Icn[iconType]) or Config.Icn.alert
    icn.Parent = nfr

    local textX = 12 + (hgt - 30) + 12

    local ttl = Instance.new("TextLabel")
    ttl.Size = UDim2.new(1, -(textX + 10), 0, 20)
    ttl.Position = UDim2.new(0, textX, 0, 12)
    ttl.BackgroundTransparency = 1
    ttl.Font = Config.notification_title
    ttl.TextSize = math.clamp(14 * scl, 12, 18)
    ttl.TextXAlignment = Enum.TextXAlignment.Left
    ttl.TextColor3 = Color3.new(1, 1, 1)
    ttl.Text = tit
    ttl.TextTruncate = Enum.TextTruncate.AtEnd
    ttl.Parent = nfr

    local sbt = Instance.new("TextLabel")
    sbt.Size = UDim2.new(1, -(textX + 10), 0, 20)
    sbt.Position = UDim2.new(0, textX, 0, 32)
    sbt.BackgroundTransparency = 1
    sbt.Font = Config.notification_body
    sbt.TextSize = math.clamp(12 * scl, 10, 14)
    sbt.TextXAlignment = Enum.TextXAlignment.Left
    sbt.TextColor3 = Color3.fromRGB(180, 180, 180)
    sbt.Text = msg
    sbt.TextTruncate = Enum.TextTruncate.AtEnd
    sbt.Parent = nfr

    local id = tick() .. game:GetService("HttpService"):GenerateGUID(false)
    table.insert(ntl, {id = id, frame = nfr, gui = nsg, h = hgt})

    local function restack()
        local y = 0
        for i = #ntl, 1, -1 do
            local n = ntl[i]
            if n and n.frame and n.frame.Parent then
                game:GetService("TweenService"):Create(n.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -12, 1, -12 - y)}):Play()
                y = y + n.h + 8
            end
        end
    end

    game:GetService("TweenService"):Create(nfr, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -12, 1, -12)}):Play()
    task.wait(0.1)
    restack()

    local function dismiss()
        for i, n in ipairs(ntl) do
            if n.id == id then table.remove(ntl, i) break end
        end
        game:GetService("TweenService"):Create(nfr, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(1, wid + 20, nfr.Position.Y.Scale, nfr.Position.Y.Offset)}):Play()
        task.wait(0.3)
        nsg:Destroy()
        restack()
    end

    if dur and dur > 0 then
        game:GetService("TweenService"):Create(pbr, TweenInfo.new(dur, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()
        task.delay(dur, dismiss)
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = nfr
    btn.MouseButton1Click:Connect(dismiss)
end

return Config
