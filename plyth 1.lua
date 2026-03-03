-------------------------------------------------------------------------------------------------------------------------------

if not game:IsLoaded() then game.Loaded:Wait() end

-------------------------------------------------------------------------------------------------------------------------------

local sg = Instance.new("ScreenGui")
sg.Parent = gethui() or game:GetService("CoreGui")
sg.ResetOnSpawn = false

-------------------------------------------------------------------------------------------------------------------------------

local n = Instance.new("TextLabel")
n.Parent = sg
n.Text = ""
n.TextColor3 = Color3.new(1, 1, 1)
n.TextStrokeColor3 = Color3.new(0, 0, 0)
n.TextStrokeTransparency = 0
n.BackgroundTransparency = 1
n.Font = Enum.Font.FredokaOne
n.Rotation = 360
n.TextSize = 22
n.TextXAlignment = Enum.TextXAlignment.Center
n.TextYAlignment = Enum.TextYAlignment.Center
n.Size = UDim2.new(0, 200, 0, 30)
n.ZIndex = 1000000000000
n.Visible = false

nextnotifz = 100000000000000
getgenv().sex_activenotifs, getgenv().sex_pendingnotifs = {}, {}
getgenv().sex_isnotifying = false

function updnotifpos() local baseY = -50 local cardnotifspacing = 22 for i, notif in ipairs(getgenv().sex_activenotifs) do local ytarget = baseY + (i - 1) * cardnotifspacing notif.Position = UDim2.new(0.5, -100, 0, ytarget) end end

function processnotif()
	if #getgenv().sex_pendingnotifs == 0 then getgenv().sex_isnotifying = false return end

	getgenv().sex_isnotifying = true local text = table.remove(getgenv().sex_pendingnotifs, 1)

	local camera = workspace.CurrentCamera
	local screenWidth = camera.ViewportSize.X
	local screenHeight = camera.ViewportSize.Y

	local startX = (screenWidth - 200) / 2

	local label = n:Clone()
	label.Text = text
	label.ZIndex = nextnotifz
	nextnotifz += 1
	label.Position = UDim2.new(0, startX, 0, 0)
	label.Parent = sg
	label.TextTransparency = 1

	local s = Instance.new("Sound")
	s.SoundId = "rbxassetid://4841731967"
	s.Volume = 0.5
	s.Parent = workspace
	s.Ended:Connect(function() s:Destroy() end)
	task.spawn(function() s:Play() end)

	table.insert(getgenv().sex_activenotifs, label) updnotifpos()

	local tin = game:GetService("TweenService"):Create(label, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
	tin:Play()

	task.delay(5, function()
		local tout = game:GetService("TweenService"):Create(label, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1})
		tout:Play() tout.Completed:Wait()
		label:Destroy() for i = #getgenv().sex_activenotifs, 1, -1 do if getgenv().sex_activenotifs[i] == label then table.remove(getgenv().sex_activenotifs, i) break end end updnotifpos()
	end)

	task.delay(0.1, processnotif)
end

cantsend = false

-------------------------------------------------------------------------------------------------------------------------------

return function(text) if not n or cantsend then return end n.Visible = true table.insert(getgenv().sex_pendingnotifs, text) if not getgenv().sex_isnotifying then processnotif() end end

-------------------------------------------------------------------------------------------------------------------------------
