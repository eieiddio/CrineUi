
local gui = Instance.new("ScreenGui")
gui.Name = "markk"
gui.Parent = game.CoreGui

--SUBSCRIBE TO M4rkk--

local pops_folder = Instance.new("Folder")
pops_folder.Name = "popup or sum shit"
pops_folder.Parent = gui

local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local library = {
    flags = {}, 
    color = Color3.fromRGB(255, 0, 0)
}    
local flags = {toggles = {}, boxes = {}, sliders = {}, dropdowns = {}, multidropdowns = {}, keybinds = {}, colorpickers = {}}
local utility = {}

function utility.table(tbl)
    local oldtbl = tbl or {}
    local newtbl = {}
    local formattedtbl = {}


    for option, v in next, oldtbl do
        newtbl[option:lower()] = v
    end


    setmetatable(formattedtbl, {
        __newindex = function(t, k, v)
            rawset(newtbl, k:lower(), v)
        end,
        __index = function(t, k, v)
            return newtbl[k:lower()]
        end
    })


    return formattedtbl
end

function utility.tween(obj, info, properties, callback)
    local anim = TweenService:Create(obj, TweenInfo.new(unpack(info)), properties)
    anim:Play()
    if callback then
        anim.Completed:Connect(callback)
    end
end

function utility.drag(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false		
		DragPoint.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		DragPoint.InputChanged:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				DragInput = Input
			end
		end)

		UserInputService.InputChanged:Connect(function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
					Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
				}):Play()
			end
		end)
	end)
end

function utility.getLongestTextWidth(textTable, textSize, font)
    local longest = 0

    for _, text in ipairs(textTable) do
        local size = TextService:GetTextSize(
            text,
            textSize,
            font,
            Vector2.new(math.huge, math.huge)
        )

        if size.X > longest then
            longest = size.X
        end
    end

    return longest
end

function library:Load(opts)
    local options = utility.table(opts)
    local name = options.name or "Kram Library"
    
	local main = Instance.new("Frame")
	main.Name = "main"
	main.Size = UDim2.new(0, 360, 0, 260)
	main.Position = UDim2.new(0, 0, 0, 0)
	main.BackgroundColor3 = Color3.fromRGB(0,0,0)
	main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	main.BorderSizePixel = 0
	main.Active = true
	main.BackgroundTransparency = 0
	
	main.Parent = gui -- change this to gui
	
	
	local main_corner = Instance.new("UICorner")
	main_corner.Name = "main_corner"
	main_corner.CornerRadius = UDim.new(0, 10)
	main_corner.Parent = main
	
	
	local topbar = Instance.new("Frame")
	topbar.Name = "topbar"
	topbar.Size = UDim2.new(1, 0, 0, 35)
	topbar.Position = UDim2.new(0, 0, 0, 0)
	topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	topbar.BorderSizePixel = 0
	topbar.Active = true
	topbar.BackgroundTransparency = 1
	topbar.Parent = main -- change this to gui
	
	utility.drag(topbar, main)
	
	local top_title = Instance.new("TextLabel")
	top_title.Name = "top_title"
	top_title.Size = UDim2.new(0, 5, 1, 0)
	top_title.Position = UDim2.new(0, 0, 0, 0)
	top_title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	top_title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	top_title.BorderSizePixel = 1
	top_title.Text = name
	top_title.BackgroundTransparency = 1
	top_title.TextColor3 = Color3.fromRGB(255,255,255)
	top_title.Font = Enum.Font.Gotham
	top_title.Parent = topbar
	top_title.TextXAlignment = "Left"
	top_title.TextSize = 14
	
	local top_padding = Instance.new("UIPadding")
	top_padding.Name = "top_padding"
	top_padding.PaddingLeft = UDim.new(0, 10)
	top_padding.PaddingRight = UDim.new(0, 6)
	top_padding.Parent = topbar
	
	
	local tabs = Instance.new("Frame")
	tabs.Name = "tabs"
	tabs.Size = UDim2.new(1, -20, 0, 30)
	tabs.Position = UDim2.new(0, 10, 0, 40)
	tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tabs.BorderSizePixel = 0
	tabs.Active = true
	tabs.BackgroundTransparency = 1
	tabs.Parent = main
	
	
		local tab_layout = Instance.new("UIListLayout")
	tab_layout.Name = "tab_layout"
	tab_layout.FillDirection = "Horizontal"
	tab_layout.SortOrder = Enum.SortOrder.LayoutOrder
	tab_layout.Padding = UDim.new(0, 3)
	tab_layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	tab_layout.VerticalAlignment = Enum.VerticalAlignment.Center
	tab_layout.Parent = tabs
	
	
	local sections = {}
	
	local containers = Instance.new("Frame")
	containers.Name = "_cons"
	containers.Size = UDim2.new(1, -20, 1, -85)
	containers.Position = UDim2.new(0, 10, 0, 75)
	containers.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	containers.BackgroundTransparency = 1
	containers.Parent = main
	
	local function slideFadeIn(frame)
	    frame.Position = frame.Position + UDim2.new(0, 20, 0, 0)
	    frame.BackgroundTransparency = 1
	    frame.Visible = true
	
	    TweenService:Create(
	        frame,
	        TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	        {
	            Position = frame.Position - UDim2.new(0, 20, 0, 0),
	            BackgroundTransparency = 1
	        }
	    ):Play()
	end

	function sections:Tab(poop)
		local options = utility.table(poop)
		local name = options.name or "Tabbed woshiee"
		
		local sectionData = utility.table()
		
		local tabbutton = Instance.new("TextButton")
		tabbutton.Name = "tabbutton"
		tabbutton.Size = UDim2.new(0, 30, 1, 0)
		tabbutton.Position = UDim2.new(0, 0, 0, 0)
		tabbutton.AutomaticSize = "X"
		tabbutton.BackgroundColor3 = Color3.fromRGB(15,15,15)
		tabbutton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tabbutton.TextColor3 = Color3.fromRGB(255,255,255)
		tabbutton.Text = name
		tabbutton.TextSize = 13
		tabbutton.Font = Enum.Font.Gotham
		tabbutton.BackgroundTransparency = 0
		tabbutton.Parent = tabs
		
		local tabbutton_corner = Instance.new("UICorner")
		tabbutton_corner.Name = "tabbutton_corner"
		tabbutton_corner.CornerRadius = UDim.new(0, 10)
		tabbutton_corner.Parent = tabbutton
		
		local tabbutton_padding = Instance.new("UIPadding")
		tabbutton_padding.Name = "tabbutton_padding"
		tabbutton_padding.PaddingLeft = UDim.new(0, 5)
		tabbutton_padding.PaddingRight = UDim.new(0, 5)
		tabbutton_padding.Parent = tabbutton
		
		sectionData.container = Instance.new("ScrollingFrame")
		sectionData.container.Name = name.."_con"
		sectionData.container.Size = UDim2.new(1, 0, 1, 0)
		sectionData.container.BackgroundTransparency = 1
		sectionData.container.Visible = #sections == 0
		sectionData.container.Parent = containers
		sectionData.container.ScrollBarThickness = 1
		sectionData.container.ScrollingDirection = Enum.ScrollingDirection.Y
		
		local con_padding = Instance.new("UIPadding")
		con_padding.Name = "con_padding"
		con_padding.PaddingLeft = UDim.new(0, 2)
		con_padding.PaddingRight = UDim.new(0, 2)
		con_padding.Parent = sectionData.container
		
		local section_list = Instance.new("UIListLayout")
		section_list.Name = "section_list"
		section_list.SortOrder = Enum.SortOrder.LayoutOrder
		section_list.Padding = UDim.new(0, 2)
		section_list.HorizontalAlignment = Enum.HorizontalAlignment.Left
		section_list.VerticalAlignment = Enum.VerticalAlignment.Top
		section_list.Parent = sectionData.container
		
		section_list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	        sectionData.container.CanvasSize = UDim2.new(
	            0, 0,
	            0, section_list.AbsoluteContentSize.Y + 20
	        )
	    end)
	    
	    tabbutton.MouseButton1Click:Connect(function()
	        for _, s in ipairs(sections) do
	            s.container.Visible = false
	        end
	        slideFadeIn(sectionData.container)
	    end)
	
	    table.insert(sections, sectionData)
	    
	    function sectionData:Toggle(opts)             
			local options = utility.table(opts)
	        local name = options.name or "Toggle"
	        local value = options.value or false
	        local flag = options.flag 
	        local callback = options.callback or function() end
	        
	        callback(value)
	        
			local toggle_main = Instance.new("ImageButton")
			toggle_main.Name = "toggle_main"
			toggle_main.Size = UDim2.new(0, 0, 0, 26)
			toggle_main.Position = UDim2.new(0, 10, 0, 10)
			toggle_main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			toggle_main.AutomaticSize = "X"
			toggle_main.BackgroundTransparency = 1
			toggle_main.Parent = sectionData.container 
			
				local layout = Instance.new("UIListLayout")
			layout.Name = "layout"
			layout.FillDirection = "Horizontal"
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0, 5)
			layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			layout.VerticalAlignment = Enum.VerticalAlignment.Center
			layout.Parent = toggle_main
			
			local box = Instance.new("Frame")
			box.Name = "box"
			box.Size = UDim2.new(0, 22, 0, 22)
			box.Position = UDim2.new(0, 0, 0, 0)
			box.BackgroundColor3 = Color3.fromRGB(15,15,15)
			box.BackgroundTransparency = 0
			
			box.Parent = toggle_main
			
			local check = Instance.new("ImageLabel")
			check.Name = "check"
			check.Size = UDim2.new(0, 22, 0, 22)
			check.Position = UDim2.new(0, 0, 0, 0)
			check.BackgroundColor3 = Color3.fromRGB(15,15,15)
			check.ImageColor3 = Color3.fromRGB(15,15,15)
			check.Image = "rbxassetid://130396712201457"
			check.ImageTransparency = value and 0 or 1
			check.ScaleType = Enum.ScaleType.Stretch
			check.BackgroundTransparency = 1
			check.Parent = box
			
			local title = Instance.new("TextLabel")
			title.Name = "title"
			title.Size = UDim2.new(0, 0, 1, 0)
			title.AutomaticSize = "X"
			title.Position = UDim2.new(0, 0, 0, 0)
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title.BorderSizePixel = 1
			title.Text = name
			title.BackgroundTransparency = 1
			title.TextColor3 = Color3.fromRGB(255,255,255)
			title.Font = Enum.Font.Gotham
			title.TextSize = 13
			title.TextXAlignment = "Left"
			title.Parent = toggle_main
			
			local check_corner = Instance.new("UICorner")
			check_corner.Name = "check_corner"
			check_corner.CornerRadius = UDim.new(0, 5)
			check_corner.Parent = box
			local ischecked = false
			
			local function setState(v)
	            value = v     
	            if v then
	                utility.tween(box, {0.2}, {BackgroundColor3 = Color3.fromRGB(255,255,255)})
	            else
	                utility.tween(box, {0.2}, {BackgroundColor3 = Color3.fromRGB(15,15,15)})
	            end
	
	            
	            callback(v)
	        end
			
			toggle_main.MouseButton1Click:Connect(function()
				value = not value
				setState(value)
			end)
			return options, toggle_main
		end
			
		function sectionData:Button(opts)        
            local options = utility.table(opts)
            local name = options.name
            local callback = options.callback
    
			local button_main = Instance.new("ImageLabel")
			button_main.Name = "button_main"
			button_main.Size = UDim2.new(0, 0, 0, 26)
			button_main.Position = UDim2.new(0, 10, 0, 10)
			button_main.AutomaticSize = "X"
			button_main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			button_main.ImageColor3 = Color3.fromRGB(255, 255, 255)
			button_main.BackgroundTransparency = 1
			button_main.Parent = sectionData.container
			
			local title = Instance.new("TextButton")
			title.Name = "title"
			title.Size = UDim2.new(0, 0, 1, -4)
			title.Position = UDim2.new(0, 2, 0, 2)
			title.AutomaticSize = "X"
			title.BackgroundColor3 = Color3.fromRGB(15,15,15)
			title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title.BorderSizePixel = 1
			title.Text = name
			title.BackgroundTransparency = 0
			title.TextColor3 = Color3.fromRGB(255,255,255)
			title.Font = Enum.Font.Gotham
			title.Parent = button_main
			title.TextSize = 13
			
			local button_padding = Instance.new("UIPadding")
			button_padding.Name = "button_padding"
			button_padding.PaddingLeft = UDim.new(0, 8)
			button_padding.PaddingRight = UDim.new(0, 8)
			button_padding.Parent = title
			
			local button_corner = Instance.new("UICorner")
			button_corner.Name = "button_corner"
			button_corner.CornerRadius = UDim.new(0, 5)
			button_corner.Parent = title
			
			title.MouseButton1Click:Connect(function()
                callback()
            end)
            
            return options
        end
              
		function sectionData:Dropdown(opts)
            local options = utility.table(opts)
            local name = options.name or "Dropdown"
            local content = options.content or {}
            local multiChoice = options.multiChoice or false
			local default = options.default or (multiChoice and {} or nil)
            local flag = options.flag
            local callback = options.callback or function() end
			callback(default)
			
			local current = default
            local chosen = {}
			local dropdown_main = Instance.new("ImageButton")
			dropdown_main.Name = "dropdown_main"
			dropdown_main.Size = UDim2.new(0, 0, 0, 26)
			dropdown_main.Position = UDim2.new(0, 10, 0, 10)
			dropdown_main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			dropdown_main.AutomaticSize = "X"
			dropdown_main.BackgroundTransparency = 1
			dropdown_main.Parent = sectionData.container 
			
				local layout = Instance.new("UIListLayout")
			layout.Name = "layout"
			layout.FillDirection = "Horizontal"
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0, 5)
			layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			layout.VerticalAlignment = Enum.VerticalAlignment.Center
			layout.Parent = dropdown_main
			
			-- # this will be optional like no title or with title sum shit yan yeah 
			if name ~= nil or name == "" then
				local title = Instance.new("TextLabel")
				title.Name = "title"
				title.Size = UDim2.new(0, 0, 1, -4)
				title.Position = UDim2.new(0, 2, 0, 2)
				title.AutomaticSize = "X"
				title.BackgroundColor3 = Color3.fromRGB(15,15,15)
				title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title.BorderSizePixel = 1
				title.Text = name
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.fromRGB(255,255,255)
				title.Font = Enum.Font.Gotham
				title.Parent = dropdown_main
				title.TextSize = 13
			end
			
			local frame = Instance.new("ImageButton")
			frame.Name = "frame"
			frame.Size = UDim2.new(0, 0, 1, -4)
			frame.Position = UDim2.new(0, 2, 0, 2)
			frame.AutomaticSize = "X"
			frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
			frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			frame.BorderSizePixel = 1
			frame.BackgroundTransparency = 0
			frame.Parent = dropdown_main
			
			local frame_corner = Instance.new("UICorner")
			frame_corner.Name = "frame_corner"
			frame_corner.CornerRadius = UDim.new(0, 5)
			frame_corner.Parent = frame
			
			local layout = Instance.new("UIListLayout")
			layout.Name = "layout"
			layout.FillDirection = "Horizontal"
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0, 5)
			layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			layout.VerticalAlignment = Enum.VerticalAlignment.Center
			layout.Parent = frame
			
			local value = Instance.new("TextLabel")
			value.Name = "value"
			value.Size = UDim2.new(0, 0, 1, 0)
			value.Position = UDim2.new(0, 0, 0, 0)
			value.BackgroundColor3 = Color3.fromRGB(15,15,15)
			value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			value.BorderSizePixel = 1
			value.Text = multiChoice and (#default > 0 and table.concat(default, ", ") or "none") or (default or "none")
			value.BackgroundTransparency = 1
			value.TextColor3 = Color3.fromRGB(255,255,255)
			value.Font = Enum.Font.Gotham
			value.Parent = frame
			value.TextSize = 13
			
			local button_padding = Instance.new("UIPadding")
			button_padding.Name = "button_padding"
			button_padding.PaddingLeft = UDim.new(0, 8)
			button_padding.Parent = frame
			
			local check = Instance.new("ImageLabel")
			check.Name = "check"
			check.Size = UDim2.new(0, 22, 1, 0)
			check.Position = UDim2.new(0, 0, 0, 0)
			check.BackgroundColor3 = Color3.fromRGB(15,15,15)
			check.ImageColor3 = Color3.fromRGB(255,255,255)
			check.Image = "rbxassetid://110297980326935"
			check.ImageTransparency = 0
			check.ScaleType = Enum.ScaleType.Stretch
			check.BackgroundTransparency = 1
			check.Parent = frame
			
			
			local dropdown_main = Instance.new("Frame")
			dropdown_main.ZIndex = 5
			dropdown_main.Name = "dropdown_main"
			dropdown_main.Size = UDim2.new(0, 170, 0, 0)
			dropdown_main.Position = UDim2.new(0, 0, 0, 0)
			dropdown_main.AutomaticSize = "Y"
			dropdown_main.BackgroundColor3 = Color3.fromRGB(16,16,16)
			dropdown_main.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dropdown_main.BorderSizePixel = 0
			dropdown_main.Active = true
			dropdown_main.BackgroundTransparency = 0
			dropdown_main.Visible = false
			dropdown_main.Parent = pops_folder -- change this to gui
			
			
			local dropdown_corner = Instance.new("UICorner")
			dropdown_corner.Name = "dropdown_corner"
			dropdown_corner.CornerRadius = UDim.new(0, 10)
			dropdown_corner.Parent = dropdown_main
			
			
			local dropdown_padding = Instance.new("UIPadding")
			dropdown_padding.Name = "dropdown_padding"
			dropdown_padding.PaddingTop = UDim.new(0, 5)
			dropdown_padding.PaddingBottom = UDim.new(0, 5)
			dropdown_padding.PaddingLeft = UDim.new(0, 5)
			dropdown_padding.PaddingRight = UDim.new(0, 5)
			dropdown_padding.Parent = dropdown_main
			
			
			local dropdown_content = Instance.new("ScrollingFrame")
			dropdown_content.ZIndex = 5
			dropdown_content.Name = "dropdown_content"
			dropdown_content.Size = UDim2.new(1, 0, 0, 0)
			dropdown_content.Position = UDim2.new(0, 0, 0, 0)
			dropdown_content.AutomaticSize = "Y"
			dropdown_content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			dropdown_content.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dropdown_content.BorderSizePixel = 1
			dropdown_content.ScrollBarThickness = 1
			dropdown_content.ScrollingEnabled = false
			dropdown_content.BackgroundTransparency = 1
			dropdown_content.Parent = dropdown_main
			
			
			local dropdown_list = Instance.new("UIListLayout")
			dropdown_list.Name = "dropdown_list"
			dropdown_list.SortOrder = Enum.SortOrder.LayoutOrder
			dropdown_list.Padding = UDim.new(0, 1)
			dropdown_list.HorizontalAlignment = Enum.HorizontalAlignment.Center
			dropdown_list.VerticalAlignment = Enum.VerticalAlignment.Top
			dropdown_list.Parent = dropdown_content
			
			
			
			frame.MouseButton1Click:connect(function()
				dropdown_main.Visible = true
				
				local boxPos = frame.AbsolutePosition
				local boxSize = frame.AbsoluteSize
				
				dropdown_main.Position = UDim2.fromOffset(
				    boxPos.X + boxSize.X / 2,
				    boxPos.Y + boxSize.Y / 2
				)
				dropdown_main.AnchorPoint = Vector2.new(0.5, 0.5)
			end)
			
			UserInputService.InputBegan:Connect(function(input, gpe)
			    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)  and dropdown_main.Visible then
			        local mousePos = UserInputService:GetMouseLocation()
			        mousePos = Vector2.new(mousePos.X, mousePos.Y - 40)
			        local pos = dropdown_main.AbsolutePosition
			        local size = dropdown_main.AbsoluteSize
			        if not (mousePos.X >= pos.X and mousePos.X <= pos.X + size.X and mousePos.Y >= pos.Y and mousePos.Y <= pos.Y + size.Y) then
			            dropdown_main.Visible = false
			        else
			            if gpe then return end
			        end
			    end
			end)
			
			local function selectObj(obj, bool)
		        for i, v in next, dropdown_content:GetChildren() do
		            if v:IsA("ImageButton") then
		                
		                v.title.Font = Enum.Font.Gotham
		            end
		        end
		
		
		        obj.title.Font = bool and Enum.Font.GothamSemibold or Enum.Font.Gotham
		        
		        value.TextColor3 = bool and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
		    end
		
		
		    local function multiSelectObj(obj, bool)
		        obj.title.Font = bool and Enum.Font.GothamSemibold or Enum.Font.Gotham
		        if obj:FindFirstChild("checked") then
		            obj:FindFirstChild("checked").Visible = bool and true or false
		        end
		        if obj:FindFirstChild("title") then
		            obj:FindFirstChild("title").Size = bool and UDim2.new(1, -30, 1, 0) or UDim2.new(1, 0, 1, 0)
				    obj:FindFirstChild("title").Position = bool and UDim2.new(0, 30, 0, 0) or UDim2.new(0, 0, 0, 0)
				end
		        
		    end
		
			local function updateValueText()
			    if not multiChoice then
			        local longestWidth = utility.getLongestTextWidth(
			            content,
			            value.TextSize,
			            value.Font
			        )
			        value.Text = current or "NONE"
			        value.Size = UDim2.new(0, longestWidth, 1, 0)
			    else
			        local maxWidth = 140
			        local textStr = #chosen > 0 and table.concat(chosen, ", ") or "none"
			        local textWidth = TextService:GetTextSize(textStr, value.TextSize, value.Font, Vector2.new(math.huge, math.huge)).X
			
			        if textWidth > maxWidth then
			            local truncatedText = ""
			            for i, word in ipairs(chosen) do
			                local testText = truncatedText ~= "" and truncatedText .. ", " .. word or word
			                local testWidth = TextService:GetTextSize(testText, value.TextSize, value.Font, Vector2.new(math.huge, math.huge)).X
			                if testWidth > maxWidth then
			                    truncatedText = truncatedText .. ".."
			                    break
			                else
			                    truncatedText = testText
			                end
			            end
			            value.Text = truncatedText
			        else
			            value.Text = textStr
			        end
			
			        value.Size = UDim2.new(0, maxWidth, 1, 0)
			    end
			end
			
			local function createOption(opt)
			
				local option = Instance.new("ImageButton")
				option.ZIndex = 6
				option.Name = opt
				option.Size = UDim2.new(1, 0, 0, 20)
				option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				option.BackgroundTransparency = 1
				option.Parent =dropdown_content
				
				local option_padding = Instance.new("UIPadding")
				option_padding.Name = "option_padding"
				option_padding.PaddingTop = UDim.new(0, 5)
				option_padding.PaddingBottom = UDim.new(0, 5)
				option_padding.PaddingLeft = UDim.new(0, 5)
				option_padding.PaddingRight = UDim.new(0, 5)
				option_padding.Parent =option
				
					local option_horizontal = Instance.new("UIListLayout")
				option_horizontal.Name = "option_horizontal"
				option_horizontal.FillDirection ="Horizontal"
				option_horizontal.SortOrder = Enum.SortOrder.LayoutOrder
				option_horizontal.Padding = UDim.new(0, 5)
				option_horizontal.HorizontalAlignment = Enum.HorizontalAlignment.Left
				option_horizontal.VerticalAlignment = Enum.VerticalAlignment.Center
				option_horizontal.Parent = option
				
				
				local checked = Instance.new("ImageLabel")
				checked.ZIndex = 6
				checked.Name = "checked"
				checked.Size = UDim2.new(0, 20, 0, 20)
				checked.Position = UDim2.new(0, 0, 0, 0)
				checked.Visible = false
				checked.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				checked.ImageColor3 = Color3.fromRGB(255, 255, 255)
				checked.Image = "rbxassetid://130396712201457"
				checked.ImageTransparency = 0
				checked.ScaleType = Enum.ScaleType.Stretch
				checked.BackgroundTransparency = 1
				checked.Parent = option
				
				local title = Instance.new("TextLabel")
				title.ZIndex = 6
				title.Name = "title"
				title.Size = UDim2.new(1, 0, 1, 0)
				title.Position = UDim2.new(0, 0, 0, 0)
				title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title.BorderSizePixel = 1
				title.Text = tostring(opt)
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.fromRGB(255,255,255)
				title.Font = Enum.Font.Gotham
				title.TextXAlignment = "Left"
				title.Parent = option
				title.TextSize = 14
			
			    return option
			end
			
			local function handleClick(opt, Option)
			    if not multiChoice then
			        if current ~= opt then
			            current = opt
			            selectObj(Option, true)
			            if flag then library.flags[flag] = opt end
			            callback(opt)
			        else
			            current = nil
			            selectObj(Option, false)
			            if flag then library.flags[flag] = nil end
			            callback(nil)
			        end
			    else
			        local idx = table.find(chosen, opt)
			        if not idx then
			            table.insert(chosen, opt)
			            multiSelectObj(Option, true)
			        else
			            table.remove(chosen, idx)
			            multiSelectObj(Option, false)
			        end
			
			        if flag then library.flags[flag] = chosen end
			        callback(chosen)
			    end	
			    updateValueText()
			end
			
			local dropdownTypes = utility.table()
			updateValueText()
			
			for _, opt in ipairs(content) do
			    local Option = createOption(opt)
			    Option.MouseButton1Click:Connect(function()
			        handleClick(opt, Option)
			    end)
			end
				
			function dropdownTypes:Set(opt)
			    if not opt then
			        current = nil
			        table.clear(chosen)
			
			        for _, v in ipairs(dropdown_content:GetChildren()) do
			            if v:IsA("ImageButton") then
			                if v:FindFirstChild("checked") then
			                    v.checked.Visible = false
			                end
			                if v:FindFirstChild("title") then
			                    v.title.Font = Enum.Font.Gotham
			                    v.title.Position = UDim2.new(0,0,0,0)
			                    v.title.Size = UDim2.new(1,0,1,0)
			                end
			            end
			        end
			
			        updateValueText()
			        return
			    end
			
			    if not multiChoice then
			        current = opt
			        for _, v in ipairs(dropdown_content:GetChildren()) do
			            selectObj(v, v.Name == opt)
			        end
			        updateValueText()
			        callback(opt)
			    else
			        table.clear(chosen)
			        for _, v in ipairs(opt) do
			            if table.find(content, v) then
			                table.insert(chosen, v)
			                local btn = dropdown_content:FindFirstChild(v)
			                if btn then
			                    multiSelectObj(btn, true)
			                end
			            end
			        end
			        updateValueText()
			        callback(chosen)
			    end
			end
			
			function dropdownTypes:Add(opt)
			    table.insert(content, opt)
			    local Option = createOption(opt)
			    Option.MouseButton1Click:Connect(function()
			        handleClick(opt, Option)
			    end)
			end
			
			function dropdownTypes:Remove(opt)
			    if not table.find(content, opt) then return end
			
			    table.remove(content, table.find(content, opt))
			
			    local obj = dropdown_content:FindFirstChild(opt)
			    if obj then obj:Destroy() end
			
			    if not multiChoice then
			        if current == opt then
			            dropdownTypes:Set(nil)
			        end
			    else
			        local idx = table.find(chosen, opt)
			        if idx then
			            table.remove(chosen, idx)
			            value.Text = #chosen > 0 and table.concat(chosen, ", ") or "NONE"
			        end
			    end
			end
			
			function dropdownTypes:Refresh(tbl)
			    content = tbl
			    dropdown_content:ClearAllChildren()
			    dropdownTypes:Set(nil)
			
			    for _, opt in ipairs(content) do
			        local Option = createOption(opt)
			        Option.MouseButton1Click:Connect(function()
			            handleClick(opt, Option)
			        end)
			    end
			end
			
			
			if flag then
		        if not multiChoice then
		            flags.dropdowns[flag] = function(opt)
		                dropdownTypes:Set(opt)
		            end
		        else
		            flags.multidropdowns[flag] = function(opt)
		                dropdownTypes:Set(opt)
		            end
		        end
		    end
			
			return dropdownTypes
		end
		
        function sectionData:Slider(opts)
            local options = utility.table(opts)
            local name = options.name or "Slider"
            local valuetext = options.valuetext or "Slider"
            local min = options.min or 0
            local max = options.max or 100
            local default = options.default or math.clamp(0, min, max)
            local decimals = options.decimals or 0.1
            local flag = options.flag
            local callback = options.callback or function() end


            decimals = math.floor(10^decimals)
            
            callback(default)
            local sliding = false
            
            local slider_main = Instance.new("ImageButton")
			slider_main.Name = "slider_main"
			slider_main.Size = UDim2.new(0, 0, 0, 26)
			slider_main.Position = UDim2.new(0, 10, 0, 10)
			slider_main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			slider_main.AutomaticSize = "X"
			slider_main.BackgroundTransparency = 1
			slider_main.Parent = sectionData.container 
			
				local layout = Instance.new("UIListLayout")
			layout.Name = "layout"
			layout.FillDirection = "Horizontal"
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0, 5)
			layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			layout.VerticalAlignment = Enum.VerticalAlignment.Center
			layout.Parent = slider_main
			
			if name ~= nil or name == "" then
				local title = Instance.new("TextLabel")
				title.Name = "title"
				title.Size = UDim2.new(0, 0, 1, -4)
				title.Position = UDim2.new(0, 2, 0, 2)
				title.AutomaticSize = "X"
				title.BackgroundColor3 = Color3.fromRGB(15,15,15)
				title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title.BorderSizePixel = 1
				title.Text = name
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.fromRGB(255,255,255)
				title.Font = Enum.Font.Gotham
				title.Parent = slider_main
				title.TextSize = 13
			end
			
			
			local frame = Instance.new("Frame")
			frame.Name = "frame"
			frame.Size = UDim2.new(0, 140, 1, -6)
			frame.Position = UDim2.new(0, 2, 0.5, 0)
			frame.AnchorPoint = Vector2.new(0,0.5)
			frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
			frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			frame.BorderSizePixel = 1
			frame.BackgroundTransparency = 0
			frame.Parent = slider_main
			
			local frame_corner = Instance.new("UICorner")
			frame_corner.Name = "frame_corner"
			frame_corner.CornerRadius = UDim.new(0, 5)
			frame_corner.Parent = frame
			
			local frame_stroke = Instance.new("UIStroke")
			frame_stroke.Parent = frame
			frame_stroke.Color = Color3.fromRGB(106, 13, 173) -- outline color
			frame_stroke.Thickness = 1
			frame_stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				
			
			local slider_fill = Instance.new("Frame")
			slider_fill.Name = "slider_fill"
			slider_fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			slider_fill.Position = UDim2.new(0, 0, 0.5, 0)
			slider_fill.AnchorPoint = Vector2.new(0,0.5)
			slider_fill.BackgroundColor3 = Color3.fromRGB(106, 13, 173)
			slider_fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
			slider_fill.BorderSizePixel = 1
			slider_fill.BackgroundTransparency = 0
			slider_fill.Parent = frame
			frame_corner:Clone().Parent = slider_fill
			
			local value = Instance.new("TextLabel")
			value.Name = "value"
			value.Size = UDim2.new(1, 0, 1, 0)
			value.Position = UDim2.new(0, 0, 0, 0)
			value.BackgroundColor3 = Color3.fromRGB(15,15,15)
			value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			value.BorderSizePixel = 1
			value.Text = default
			value.BackgroundTransparency = 1
			value.TextColor3 = Color3.fromRGB(255,255,255)
			value.Font = Enum.Font.Gotham
			value.Parent = frame
			value.TextSize = 13
		
			local function slide(input)
                local sizeX = math.clamp(
				    (input.Position.X - frame.AbsolutePosition.X) / frame.AbsoluteSize.X,
				    0,
				    1
				)
 
               
                default = math.floor((((max - min) * sizeX) + min) * decimals) / decimals
                slider_fill:TweenSize(UDim2.new((default - min) / (max - min), 0, 1, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)


                if flag then 
                    library.flags[flag] = default
                end


                callback(default)
                
                value.Text = tostring(default)
            end


            frame.InputBegan:Connect(function(input)
			    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			        sliding = true
			        slide(input)
			    end
			end)
			
			frame.InputEnded:Connect(function(input)
			    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			        sliding = false
			    end
			end)
			
			UserInputService.InputChanged:Connect(function(input)
			    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and sliding then
			        slide(input)
			    end
			end)
			
	        local sliderTypes = utility.table()


            function sliderTypes:Show()
                slider_main.Visible = true
            end


            function sliderTypes:Hide()
                slider_main.Visible = false
            end


            

            function sliderTypes:Set(num)
                num = math.floor(math.clamp(num, min, max) * decimals) / decimals
                default = num
                slider_fill:TweenSize(UDim2.new((default - min) / (max - min), 0, 1, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
                
                if flag then 
                    library.flags[flag] = default
                end


                callback(default)
            end


            function sliderTypes:SetMin(num)
                min = num
                default = math.floor(math.clamp(default, min, max) * decimals) / decimals
                slider_fill:TweenSize(UDim2.new((default - min) / (max - min), 0, 1, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)


                if flag then 
                    library.flags[flag] = default
                end


                callback(default)
            end


            function sliderTypes:SetMax(num)
                max = num
                default = math.floor(math.clamp(default, min, max) * decimals) / decimals
                slider_fill:TweenSize(UDim2.new((default - min) / (max - min), 0, 1, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)


                if flag then 
                    library.flags[flag] = default
                end


                callback(default)
            end


            if flag then
                flags.sliders[flag] = function(num)
                    sliderTypes:Set(num)
                end
            end
            
            return sliderTypes
        end
        
        function sectionData:HorizontalFrame()
            
	        local horizontal_frame = Instance.new("ImageButton")
			horizontal_frame.Name = "horizontal_frame"
			horizontal_frame.Size = UDim2.new(0, 0, 0, 28)
			horizontal_frame.Position = UDim2.new(0, 10, 0, 10)
			horizontal_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			horizontal_frame.AutomaticSize = "X"
			horizontal_frame.BackgroundTransparency = 1
			horizontal_frame.Parent = sectionData.container 
			
			local layout = Instance.new("UIListLayout")
			layout.Name = "layout"
			layout.FillDirection = "Horizontal"
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0, 10)
			layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			layout.VerticalAlignment = Enum.VerticalAlignment.Center
			layout.Parent = horizontal_frame
			
			local horizontalData = {}
			function horizontalData:AddButton(opts)
				local options = utility.table(opts)
	            local name = options.name or "Weird Shit"
				local callback = options.callback
				
				local frame = Instance.new("ImageButton")
				frame.Name = "frame"
				frame.Size = UDim2.new(0, 50, 1, -4)
				frame.Position = UDim2.new(0, 0, 0, 0)
				frame.AutomaticSize = "X"
				frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
				frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				frame.BorderSizePixel = 1
				frame.BackgroundTransparency = 0
				frame.Parent = horizontal_frame
				
				local frame_corner = Instance.new("UICorner")
				frame_corner.Name = "frame_corner"
				frame_corner.CornerRadius = UDim.new(0, 10)
				frame_corner.Parent = frame
				
				local frame_stroke = Instance.new("UIStroke")
				frame_stroke.Parent = frame
				frame_stroke.Color = Color3.fromRGB(255,255,255) -- outline color
				frame_stroke.Thickness = 1
				frame_stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				
				local title = Instance.new("TextLabel")
				title.Name = "title"
				title.Size = UDim2.new(0, 50, 1, 0)
				title.AutomaticSize = "X"
				title.Position = UDim2.new(0, 0, 0, 0)
				title.BackgroundColor3 = Color3.fromRGB(15,15,15)
				title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				title.BorderSizePixel = 1
				title.Text = name
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.fromRGB(255,255,255)
				title.Font = Enum.Font.Gotham
				title.Parent = frame
				title.TextSize = 13
				
				local button_padding = Instance.new("UIPadding")
				button_padding.Name = "button_padding"
				button_padding.PaddingLeft = UDim.new(0, 5)
				button_padding.PaddingRight = UDim.new(0, 5)
				button_padding.Parent = frame
				
				frame.MouseButton1Click:Connect(function()
	                callback()
	            end)
	
				frame.MouseEnter:Connect(function()
				    utility.tween(frame, {0.1}, {BackgroundColor3 = Color3.fromRGB(255,255,255)})
		            utility.tween(title, {0.1}, {TextColor3 = Color3.fromRGB(15,15,15)})          
				end)
				
				frame.MouseLeave:Connect(function()
				    utility.tween(frame, {0.1}, {BackgroundColor3 = Color3.fromRGB(15,15,15)})
		            utility.tween(title, {0.1}, {TextColor3 = Color3.fromRGB(255,255,255)})          
				end)
            
				return options
			end
			
			function horizontalData:Toggle(...)
				local data, object
				local ret = {sectionData:Toggle(...)}
				if typeof(ret[1]) == "table" then
					data = ret[1]
					object = ret[2]
					object.Parent = horizontal_frame
					return data, object
				else
					object = ret[1]
					object.Parent = horizontal_frame
					return object
				end
			end
			
			function horizontalData:Show()
                horizontal_frame.Visible = true
            end


            function horizontalData:Hide()
                horizontal_frame.Visible = false
            end
			
			return horizontalData
        end
        
		
		return sectionData
	end
	return sections
end

return library

--[[
local Window = library:Load({ name = "Big Dih Mark" })

local Tab = Window:Tab({ name = "Elements" })
local Tab2 = Window:Tab({ name = "Weird Shit" })

Tab:Toggle({
    name = "Toggle Me",
    callback = function(v) print(v) end
})

Tab:Button({
    name = "Click Me",
    callback = function() print("clicked") end
})

Tab:Dropdown({
    name = "Dih",
    content = {"Soft", "Hard", "Angry(veiny showing)"},
    default = "Easy",
    callback = function(v) print(v) end
})

Tab:Dropdown({
    name = "Fuh Style",
    content = {"Doggy","Cow","SixSeven"},
    multiChoice = true,
    default = {"Apple"}
})

Tab:Slider({
    name = "Dih Size(inches)",
    min = 0,
    max = 100,
    default = 25,
    decimals = 0,
    flag = "speed",
    callback = function(value)
        print("Slider value:", value)
    end
})

local row = Tab:HorizontalFrame()

local row2 = Tab:HorizontalFrame()

row:AddButton({
    name = "Show",
    callback = function()
        row2:Show()
    end
})

row:AddButton({
    name = "Hide",
    callback = function()
        row2:Hide()
    end
})

row:AddButton({
    name = "Button 3",
    callback = function()
        print("Button 3 clicked")
    end
})

row2:Hide()

row2:AddButton({
    name = "Click me",
    callback = function()
        print("Button 1 clicked")
    end
})

row2:AddButton({
    name = "Click me!!",
    callback = function()
        print("Button 2 clicked")
    end
})

row2:AddButton({
    name = "Click me!!",
    callback = function()
        print("Button 3 clicked")
    end
})


row2:Toggle({
    name = "Enable Feature",
    value = false,
    callback = function(state)
        if state then
            print("Feature Enabled")
        else
            print("Feature Disabled")
        end
    end
})

]]
