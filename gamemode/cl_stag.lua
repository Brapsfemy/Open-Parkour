include('shared.lua')

local itvision = {
 ["$pp_colour_addr"] = 0.03, 
 ["$pp_colour_addg"] = 0, 
 ["$pp_colour_addb"] = 0, 
 ["$pp_colour_brightness"] = 0, 
 ["$pp_colour_contrast"] = 1, 
 ["$pp_colour_colour"] = 1.25, 
 ["$pp_colour_mulr"] = 0, 
 ["$pp_colour_mulg"] = 0, 
 ["$pp_colour_mulb"] = 0
}

function ItVisualEffects()
	if LocalPlayer():Team() == 2 then
		DrawColorModify(itvision)
	end
end
hook.Add("RenderScreenspaceEffects", "ItVisualEffects", ItVisualEffects)

function st_infotext()
	if LocalPlayer():Team() == 2 then
		draw.DrawText("You're it!", "DermaLarge", ScrW() * 0.95, ScrH() * 0.95, Color(235, 25, 35, 255), TEXT_ALIGN_CENTER)
	end
	
	if LocalPlayer():Health() <= 25 and LocalPlayer():Health() >= 1 then
		draw.DrawText("Low Health!", "DermaLarge", ScrW() * 0.5, ScrH() * 0.25, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER)
	elseif LocalPlayer():Health() <= 1 then
		draw.DrawText("You can respawn in "..GetConVarString("st_respawntime").." seconds", "DermaLarge", ScrW() * 0.5, ScrH() * 0.25, Color(255, 201, 14, 255), TEXT_ALIGN_CENTER)
	end
end
hook.Add("HUDPaint", "st_infotext", st_infotext)

function HealthVisualEffects()
	DrawColorModify({
 ["$pp_colour_addr"] = 0, 
 ["$pp_colour_addg"] = 0, 
 ["$pp_colour_addb"] = 0, 
 ["$pp_colour_brightness"] = 0, 
 ["$pp_colour_contrast"] = 1, 
 ["$pp_colour_colour"] = LocalPlayer():Health()/100, 
 ["$pp_colour_mulr"] = 0, 
 ["$pp_colour_mulg"] = 0, 
 ["$pp_colour_mulb"] = 0
})
end
hook.Add("RenderScreenspaceEffects", "HealthVisualEffects", HealthVisualEffects)

local HideHUD = {
	CHudHealth = true, 
	CHudBattery = true, 
}

hook.Add("HUDShouldDraw", "HideHUD", function(HUDToHide)
	if (HideHUD[HUDToHide]) then
		return false
	end
end)

function ItsWallVision(ply)
	if GetConVarNumber("st_wallsight") == 0 then return end
	if LocalPlayer():Team() == 2 then
		cam.Start3D()
			for id, ply in pairs(player.GetAll()) do
				ply:DrawModel()
				if  GetConVarNumber("st_halo") == 1 then 
					halo.Add(player.GetAll(), Color(255, 0, 0), 1, 1, 1, true, true)
				end
			end
		cam.End3D()
	end
end
hook.Add("HUDPaint", "ItsWallVision", ItsWallVision)