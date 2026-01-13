
local TweenService = game:GetService("TweenService")
local modules = {}

function modules:GetOuttaHere(pp, ppp)
local gui = Instance.new("ScreenGui")
gui.Name = "a gui for smth"
gui.Parent = game.CoreGui
	local main = Instance.new("Frame")
	main.ZIndex = 8
	main.Name = "main"
	main.Size = UDim2.new(0, 210, 0, 100)
	main.AutomaticSize = "Y"
	main.Position = UDim2.new(0, 0, 0, 0)
	main.BackgroundColor3 = Color3.fromRGB(8,8,8)
	main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	main.BorderSizePixel = 0
	main.Active = true
	main.BackgroundTransparency = 0
	main.Draggable = true -- allows you to move the frame freely
	main.Parent = gui -- change this to gui
	
		local list = Instance.new("UIListLayout")
	list.Name = "list"
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Padding = UDim.new(0, 6)
	list.HorizontalAlignment = Enum.HorizontalAlignment.Center
	list.VerticalAlignment = Enum.VerticalAlignment.Top
	list.Parent = main
	
	
	
	
	local corner = Instance.new("UICorner")
	corner.Name = "corner"
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = main
	
	local padding = Instance.new("UIPadding")
	padding.Name = "padding"
	padding.PaddingTop = UDim.new(0, 8)
	padding.PaddingBottom = UDim.new(0, 8)
	padding.PaddingLeft = UDim.new(0, 8)
	padding.PaddingRight = UDim.new(0, 8)
	padding.Parent = main
	
	local title = Instance.new("TextLabel")
	title.Name = "title"
	title.ZIndex = 8
	title.Size = UDim2.new(1, 0, 0, 20)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	title.BorderSizePixel = 1
	title.Text = pp or "Popup"
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.Font = Enum.Font.Gotham
	title.Parent = main
	title.TextSize = 15
	
	if ppp ~= nil then
	local context = Instance.new("TextLabel")
	context.ZIndex = 8
	context.Name = "context"
	context.Size = UDim2.new(1, 0, 0, 0)
	context.Position = UDim2.new(0, 0, 0, 0)
	context.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	context.BorderColor3 = Color3.fromRGB(0, 0, 0)
	context.BorderSizePixel = 1
	context.Text = ppp or "there's an existing UI\n do you want to delete the previous UI?"
	context.TextYAlignment = "Top"
	context.TextWrapped = true
	context.AutomaticSize = "Y"
	context.BackgroundTransparency = 1
	context.TextColor3 = Color3.fromRGB(255,255,255)
	context.Font = Enum.Font.Gotham
	context.Parent = main
	context.TextSize = 13
	
	local trash = Instance.new("Frame")
	trash.ZIndex = 8
	trash.Name = "trash"
	trash.Size = UDim2.new(1, 0, 0, 35)
	trash.BackgroundTransparency = 1
	trash.Parent = main -- change this to gu
	
	
	local horizontalframe = Instance.new("Frame")
	horizontalframe.ZIndex = 9
	horizontalframe.Name = "horizontalframe"
	horizontalframe.Size = UDim2.new(1, 0, 0, 35)
	horizontalframe.Position = UDim2.new(0, 0, 0, 0)
	horizontalframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	horizontalframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
	horizontalframe.BorderSizePixel = 0
	horizontalframe.Active = true
	horizontalframe.BackgroundTransparency = 1
	horizontalframe.Draggable = true -- allows you to move the frame freely
	horizontalframe.Parent = trash -- change this to gui
	
		local list = Instance.new("UIListLayout")
	list.Name = "list"
	list.FillDirection= "Horizontal"
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Padding = UDim.new(0, 5)
	list.HorizontalAlignment = Enum.HorizontalAlignment.Center
	list.VerticalAlignment = Enum.VerticalAlignment.Center
	list.Parent = horizontalframe
	
	local shitline = Instance.new("Frame")
	shitline.ZIndex = 9
	shitline.Name = "shitline"
	shitline.Size = UDim2.new(0, 10, 0, 1.5)
	shitline.Position = UDim2.new(0, 0, 1, 0)
	shitline.AnchorPoint = Vector2.new(0, 1)
	shitline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	shitline.BorderColor3 = Color3.fromRGB(0, 0, 0)
	shitline.BorderSizePixel = 0
	shitline.Active = true
	shitline.BackgroundTransparency = 1
	shitline.Parent = trash 
	
	local function move_line(target)
	    local relX = target.AbsolutePosition.X - shitline.Parent.AbsolutePosition.X
	    TweenService:Create(
	        shitline,
	        TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	        {
	            Position = UDim2.new(0, relX, 1, 0),
	            Size = UDim2.new(0, target.AbsoluteSize.X, 0, 1.5)
	        }
	    ):Play()
	end
	
	local buttons = {}
	function buttons:SetButton(name, callback)
	    if #buttons >= 2 then warn("You can only create less than 2 button sorry") return end
	
		local button1 = Instance.new("TextButton")
		button1.ZIndex = 9
		button1.Name = "button1"
		button1.Size = UDim2.new(0.45, 0, 1, -4)
		button1.Position = UDim2.new(0, 0, 0, 0)
		button1.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
		button1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		button1.BorderSizePixel = 1
		button1.Text = name
		button1.BackgroundTransparency = 1
		button1.TextColor3 = Color3.fromRGB(255,255,255)
		button1.Font = Enum.Font.Gotham
		button1.Parent = horizontalframe
		button1.TextSize = 14

		button1.MouseButton1Click:Connect(function()
	        if callback then
	            callback()
	        end
	    end)
    
		button1.MouseEnter:Connect(function()
			move_line(button1)
		    TweenService:Create(shitline,TweenInfo.new(0.15),{ BackgroundTransparency = 0 }):Play()
		end)
		
		button1.MouseLeave:Connect(function()
		    TweenService:Create(shitline,TweenInfo.new(0.15),{ BackgroundTransparency = 1 }):Play()
		end)
		
		table.insert(buttons, button1)
	end
	
	return main, buttons
end

return modules
--[[
local mainUI, buttons = modules:GetOuttaHere()

buttons:SetButton("Yes", function()
    mainUI:Destroy()
end)

buttons:SetButton("No", function()
    print("Cancelled")
end)

]]
