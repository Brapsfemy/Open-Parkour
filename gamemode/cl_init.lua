OpenPK = GM or GAMEMODE or {};

--Initial includes
include( "libraries.lua" );
include( "shared.lua" )
include("cl_scoreboard.lua")

surface.CreateFont( "HudLarge", { font = "DermaLarge", size = 50, weight = 700, antialias = true } )
surface.CreateFont( "HudMedium", { font = "DermaLarge", size = 30, weight = 700, antialias = true } )
surface.CreateFont( "HudSmall", { font = "DermaLarge", size = 20, weight = 300, antialias = true } )

 function GM:HUDPaint()
 	if( Container ) then
 		if( Container.Menu ~= nil ) then
 			return;
 		end;
 	end;
local Ply = LocalPlayer()
local Spec = Ply:GetObserverTarget()
if IsValid( Spec ) and Spec:IsPlayer() then
Ply = Spec
end 






CreateConVar( "red", "255" , 0, "red amount in trail and hud" )
CreateConVar( "green", "255" , 0, "green amount in trail and hud" )
CreateConVar( "blue", "255" , 0, "blue amount in trail and hud" )

red = GetConVarString("red")
blue = GetConVarString("blue")
green = GetConVarString("green")


local Vel = Ply:GetVelocity()
local Speed = math.Round( Vector( Vel.x, Vel.y, 0 ):Length() / 10 )
if Speed < 8 then Speed = 0 end
draw.SimpleTextOutlined( Speed, "HudMedium", ScrW() - 940 , ScrH() - 520, Color(red, green, blue), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 44, 62, 80 ) )

end

function HoveringNames()


	local ply = LocalPlayer()
	for _, target in pairs(player.GetAll()) do
		if target:Alive() then
		
			local name = target:Nick()
			local targetPos = target:GetPos() + Vector(0,0,64)
			local targetDistance = math.floor((ply:GetPos():Distance( targetPos ))/40)
			local targetScreenpos = targetPos:ToScreen()
			
			if target == LocalPlayer() then name = "" else name = target:Nick() end
			
			surface.SetTextColor(team.GetColor(target:Team()))
	        surface.SetFont("HudMedium")
			surface.SetTextPos(tonumber(targetScreenpos.x), tonumber(targetScreenpos.y))
			surface.DrawText(name)

			
		end
	end
end
hook.Add("HUDPaint", "HoveringNames", HoveringNames)

function set_team()
 
local frame = vgui.Create( "DFrame" )
frame:SetPos( ScrW() / 4, ScrH() / 2 )
frame:SetSize( 650, 400 )
frame:SetTitle( "Minigames" )
frame:SetVisible( true )
frame:SetDraggable( false )
frame:ShowCloseButton( false )
frame:MakePopup()
function frame:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 231, 76, 60, 150 ) )
end
 
team_1 = vgui.Create( "DButton", frame )
team_1:SetPos( frame:GetTall() / 2, 50 )
team_1:SetSize( 100, 50 )
team_1:SetText( "Parkour" )
team_1.DoClick = function()
    RunConsoleCommand( "parkour" )
	frame:SetVisible( false )
end
 
team_2 = vgui.Create( "DButton", frame )
team_2:SetPos( frame:GetTall() / 2, 100 )
team_2:SetSize( 100, 50 )
team_2:SetText( "Deathmatch" )
team_2.DoClick = function()
    RunConsoleCommand( "pkdeathmatch" )
	frame:SetVisible( false )
end
team_3 = vgui.Create( "DButton", frame )
team_3:SetPos( frame:GetTall() / 2, 150 )
team_3:SetSize( 100, 50 )
team_3:SetText( "Tag" )
team_3.DoClick = function()
    RunConsoleCommand( "pktag" )
	frame:SetVisible( false )
end
end
usermessage.Hook("MyMenu", set_team)
concommand.Add( "team_menu", set_team )

OpenPK.Libraries:Load();
OpenPK.Vgui:Load();
OpenPK.Minigame:Load();
