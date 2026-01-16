local CoreGui = game:GetService("CoreGui");

local notif = {}
notif.list = {}

local gf = CoreGui:FindFirstChild("Hogs")
if not gf then
    gf = Instance.new("Folder")
    gf.Name = "Hogs"
    gf.Parent = CoreGui 
end

function notif:Notification(title, desc, iconId, visibletime)
    local gap = 8
    local limit = 3
    local startY = 0.5   
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Notif_" .. title
    screenGui.Parent = gf

    local Main = Instance.new("Frame")
    Main.Parent = screenGui
    Main.BackgroundColor3 = Color3.fromRGB(17,17,17)
    Main.BorderSizePixel = 0
    Main.Size = UDim2.new(0, 260, 0, 60)
    Main.Position = UDim2.new(1, 10, startY, 0)
    Main.AutomaticSize = Enum.AutomaticSize.Y 

    local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0, 10)
    
    local Padding = Instance.new("UIPadding", Main)
    Padding.PaddingTop = UDim.new(0, 5);Padding.PaddingBottom= UDim.new(0, 5)
    Padding.PaddingLeft = UDim.new(0, 5);Padding.PaddingRight= UDim.new(0, 5)
    
    local icon = Instance.new("ImageLabel")
	icon.Name = "icon"
	icon.Parent = Main
	icon.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	icon.BorderSizePixel = 0
	icon.Size = UDim2.new(0, 30, 0, 30)
	icon.Position = UDim2.new(0, 0, 0, 0)
	icon.AnchorPoint = Vector2.new(0, 0)
	icon.AutomaticSize = Enum.AutomaticSize.Y
	icon.BackgroundTransparency = 0
	icon.Visible = tostring(iconId or "") ~= ""
	icon.Image = iconId:match("^rbxassetid://") and iconId or "rbxassetid://" .. iconId
	

    local Title = Instance.new("TextLabel", Main)
    Title.Text = title
    Title.Font = Enum.Font.GothamSemibold
    Title.TextSize = 14
    Title.TextColor3 = Color3.new(1,1,1)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Desc = Instance.new("TextLabel", Main)
    Desc.Text = desc
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 13
    Desc.TextWrapped = true
    Desc.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    Desc.BackgroundTransparency = 1
    Desc.Size = UDim2.new(1, 0, 0, 0) -- Leave room for the X button
    Desc.Position = UDim2.new(0, 0, 0, 30)
    Desc.AutomaticSize = Enum.AutomaticSize.Y
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top

    local Close = Instance.new("TextButton", Main)
    Close.Text = "X"
    Close.Font = Enum.Font.GothamBold
    Close.TextColor3 = Color3.new(1, 1, 1)
    Close.TextSize = 15
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(1, -25, 0, 0)
    Close.Size = UDim2.new(0, 20, 0, 20)

    local function dismiss()
        local i = table.find(notif.list, Main)
        if i then table.remove(notif.list, i) end
        Main:TweenPosition(UDim2.new(1, 10, Main.Position.Y.Scale, Main.Position.Y.Offset), "In", "Sine", 0.3, true)
        task.delay(0.3, function() screenGui:Destroy() end)
    end
    
    if iconId ~= nil and iconId ~= "" then
	    Title.Size = UDim2.new(1, -35, 0, 25)
	    Title.Position = UDim2.new(0, 35, 0, 0)
		Desc.Size = UDim2.new(1, -35, 0, 0)
	    Desc.Position = UDim2.new(0, 35, 0, 20)
    end

    Close.MouseButton1Down:Connect(dismiss)

    task.wait() 
    
	for _, v in ipairs(notif.list) do
	    v:TweenPosition(
	        UDim2.new(v.Position.X.Scale, -v.AbsoluteSize.X - 10, v.Position.Y.Scale, v.Position.Y.Offset - (Main.AbsoluteSize.Y + gap)),
	        "Out", "Quad", 0.3, true
	    )
	end

    table.insert(notif.list, Main)
    if #notif.list > limit then
        local oldest = table.remove(notif.list, 1)
        oldest:TweenPosition(UDim2.new(1, 10, oldest.Position.Y.Scale, oldest.Position.Y.Offset), "In", "Sine", 0.3, true)
        task.delay(0.3, function() if oldest.Parent then oldest.Parent:Destroy() end end)
    end

    Main:TweenPosition(
        UDim2.new(1, -Main.AbsoluteSize.X - 10, startY, 0),
        "Out", "Back", 0.5, true
    )
    task.delay(visibletime, function()
        if Main and Main.Parent then dismiss() end
    end)
end

return notif

--[[
for i = 1, 3 do
    notif:Notification("Test "..i, "This is notification number ", "rbxassetid://101429715547928", 10)
    task.wait(0.2)
end
]]
