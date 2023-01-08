local Global = getgenv and getgenv() or _G
	
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local Player = Players.LocalPlayer
	local Character = Player.Character
	local Mouse = Player:GetMouse()

	local MouseDown = false;
	local FlingEnabled = false
	getgenv().isnetworkowner = isnetworkowner or function(part) return part.ReceiveAge == 0 end 
	--[[
		part.ReceiveAge is the time in seconds since the last time the physics of a basepart has updated, if 0 then theres no physics (its anchored)
		in the context of exploiting, 0 means that the player is simulating physics on the basepart, and therefore owns it
	]]
	Mouse.Button1Down:Connect(function() MouseDown=true end)
	Mouse.Button1Up:Connect(function() MouseDown=false end)
	
	
	do -- Settings
		Global.Fling = Character.Humanoid.RigType == Enum.HumanoidRigType.R15 and 'LowerTorso' or Global.Reanimation == "PermaDeath" and 'HumanoidRootPart' or 'Right Arm'
		Global.ShowReal = true
		Global.GodMode = Global.Reanimation == 'PermaDeath' and true or false
		Global.Velocity = -35
		Global.Collisions = true
		Global.AntiSleep = true
		Global.MovementVelocity = false
		Global.ArtificialHeartBeat = true
		Global.EnableSpin = true
	end
	
	do -- idk what the fuck this code is so im just gonna include it
		if Global.___hooked ~= true then
			local ___old;
			local w = game:GetService('Workspace') --synapse when the
			___old=hookmetamethod(game,'__index',newcclosure(function(s,k)
				if checkcaller() and s==w and k== 'non' then
					return Global.CloneRig
				end 
				return ___old(s,k)
			end))
			Global.___hooked=true 
		end
	end
	--local Event = Global.MiliWait
	
	loadstring(game:HttpGet("https://raw.githubusercontent.com/CenteredSniper/Kenzen/master/newnetlessreanimate.lua",true))()
	
	
	
	do -- Replace Arm for Non-Perma Reanimate
		if Global.Reanimation == "Simple" and Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then 
			local ReplacementHat
			for i,Hat in ipairs(Global.RealRig:GetChildren()) do
				if Hat:IsA("Accessory") then
					local Texture = Hat.Handle:FindFirstChildOfClass("SpecialMesh")
					if Texture then
						for i,v in ipairs(SplitTorsoHats) do
							if v[1] == string.match(Texture.TextureId,"%d+") then
								table.remove(SplitTorsoHats,i)
								ReplacementHat = {Hat.Handle,v[2]}
							end
						end
					end
				end
			end
			if ReplacementHat then
				ReplacementHat[1].CloneHat.Value.AccessoryWeld.Part1 = Player.Character["Right Arm"]
				ReplacementHat[1].CloneHat.Value.AccessoryWeld.C0=ReplacementHat[2]
				ReplacementHat[1]:FindFirstChildOfClass("SpecialMesh"):Destroy()
			end
		end
	end
