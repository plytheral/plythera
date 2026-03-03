if not game:IsLoaded() then game.Loaded:Wait() end 
local plr = game.Players.LocalPlayer

local sad = "Iihn983h 98djSAIODishd983nr909q weiud)J(3ruiosJD(3r"
local wyd = "[Boxten]: anomalous behavior detected"

local what
local why

local function ok(content)
	return typeof(content) == "string" and content:find(sad, 1, true)
end

if setclipboard or toclipboard then
	local func = setclipboard or toclipboard
	what = hookfunction(func, function(content)
		if ok(content) then
			return plr:Kick(wyd)
		end
		return what(content)
	end)
end

if writefile then
	why = hookfunction(writefile, function(filename, content)
		if ok(filename) or ok(content) then
			return plr:Kick(wyd)
		end
		return why(filename, content)
	end)
end

local success, n = pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/plytheral/plythera/refs/heads/main/plyth%201.lua")))
if not success then warn("[Boxten]: failed to load notif lib") return end

local folder = "Boxten Sex GUI"

local function huh()
	local succ, err = pcall(function()
		if isfolder and not isfolder(folder) then
			if makefolder then makefolder(folder) end
		end
		loadstring(game:HttpGet("https://raw.githubusercontent.com/plytheral/plythera/refs/heads/main/plyth%203.lua"))()
	end)

	if succ and n then
		print("[Boxten]: init success")
		getgenv().boxtensexguiloaded = true
	else
		n("An error has occured. Check console.")
		warn("[Boxten]: init fail:", err)
	end
end

if getgenv().boxtensexguiloaded then 
	if typeof(n) == "function" then
		n("Boxten Sex GUI has already been executed. Execute the script again to ignore this message.") 
	end
	getgenv().boxtensexguiloaded = false 
	return 
end

huh()
