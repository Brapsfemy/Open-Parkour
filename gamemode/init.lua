OpenPK = GM or GAMEMODE or {};

--Initial addcsluafile
--Addcsluafile libraries.lua
AddCSLuaFile( "libraries.lua" );

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )


--Initial includes
--include Libraries.lua
include( "libraries.lua" );

include(		"shared.lua")
include(		"sv_walljump.lua")
include(		"sv_wallslide.lua")
include(		"sv_tag.lua")


hook.Add("Initialize", "Set Cvars", function()
	RunConsoleCommand("sv_gravity", 300)
	RunConsoleCommand("sv_sticktoground", 0)
	RunConsoleCommand("sv_airaccelerate", 25)
	RunConsoleCommand("mp_falldamage", 0)
end)

CreateConVar( "pk_regentime", "1" , 0, "time for health to regen one unit" )
CreateConVar( "pk_regenamount", "1" , 0, "amount health regenerates in one unit" )
CreateConVar( "red", "255" , 0, "red amount in trail and hud" )
CreateConVar( "green", "255" , 0, "green amount in trail and hud" )
CreateConVar( "blue", "255" , 0, "blue amount in trail and hud" )
CreateConVar( "botname", "Bot" , 0, "Name of bot" )
CreateConVar( "player_tag", "your tag here" , 0, "Your player tag" )



red = GetConVarString("red") 
blue = GetConVarString("blue")
green = GetConVarString("green")
botname = GetConVarString("botname")
new_team = ""
nickname = ""
player_tag = GetConVarString("player_tag")


function GM:PlayerConnect( name, ip )
    print("Player: " .. name .. ", has entered the game")
end

function GM:PlayerInitialSpawn( ply )
    print("Player: " .. ply:Nick() .. ", has spawned.")
	ply:SetModel("models/player/kleiner.mdl")
	ply:SetTeam( 1 )
	ply:ConCommand( "sv_gravity 300" )
	ply:ConCommand( "sv_sticktoground 0" )
	ply:SetWalkSpeed( 500 )
	util.SpriteTrail(ply, 0, Color(0,100,50,100), false, 50, 30, 4, 1/(15+1)*0.5, "trails/laser.vmt")
	ply:SetNWInt("nigger_status", "Tracuer")
	ply:SetNWInt("fuckshitfuck", "Noob")

end

function GM:PlayerShouldTakeDamage( victim, ply )
if ply:IsPlayer() then -- check the attacker is player 	
if( ply:Team() == victim:Team() ) then -- check the teams are equal and that friendly fire is off.
		return true -- do not damage the player
	end
end
 
	return false -- damage the player
end


function GM:PlayerLoadout(ply) --"The weapons/items that the player spawns with" function
 
	ply:StripWeapons() -- This command strips all weapons from the player.
	

	if ply:Team() == 1 then --If the player is on team "Guest"...
		ply:StripWeapons()
    	

 
	elseif ply:Team() == 2 then -- Otherwise, if the player is on team "Another Guest"...
		ply:Give("weapon_357")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_extinguisher")
		ply:Give("weapon_brickbat")
		ply:Give("weapon_alyxgun")
		ply:Give("weapon_crossbow")

        elseif ply:Team() == 3 then -- Otherwise, if the player is on team "Another Guest"...
		ply:StripWeapons()
	end
			if ply:IsAdmin() then 
	ply:Give("weapon_physgun")
	ply:Give("weapon_physcannon")
	ply:Give("weapon_crowbar")
	ply:Give("weapon_frag")
	ply:Give("weapon_slam")
	ply:Give("weapon_fists")
end
	ply:Give("weapon_fists")
 
end



RegenerateAmount = GetConVarString("pk_regenamount")
RegenerateTime = GetConVarString("pk_regentime")
RegenerateMax = 100

function RegenerateHealth()
   for k,v in pairs(player.GetAll()) do
      if v:Alive() and v:OnGround() and v:Health() < RegenerateMax then
         v:SetHealth(math.min(v:Health() + RegenerateAmount, math.max(100,RegenerateMax)))
      end
   end
   timer.Simple(RegenerateTime, RegenerateHealth)
   end
RegenerateHealth()

function chat_team()
PrintMessage( HUD_PRINTTALK, "Player " .. nickname .. " has joined " .. new_team .. "" )
end

function team_1( ply )
    nickname = "tracuer " .. ply:Nick() .. ""
    new_team = "parkour"
	ply:SetNWInt("nigger_status", "Tracuer")
    chat_team()
    ply:SetTeam( 1 )
    ply:Kill()
end
 
function team_2( ply )
    nickname = "fighter " .. ply:Nick() .. ""
    new_team = "deathmatch"
	ply:SetNWInt("nigger_status", "Fighter")
    chat_team()
    ply:SetTeam( 2 )
	ply:Kill()
end
function team_3( ply )
    nickname = "fast " .. ply:Nick() .. ""
    new_team = "tag"
    chat_team()
    ply:SetTeam( 3 )
	tag()
	ply:Kill()
end

	hook.Add( "PlayerSay", "setammo", function( ply, text, public )
	text = string.lower( text ) -- Make the chat message entirely lowercase
	if ( text == "!setammo" ) then
		ply:SetAmmo( 99999, ply:GetActiveWeapon():GetPrimaryAmmoType() )
		return ""
	end
end )

	hook.Add( "PlayerSay", "set_tag", function( ply, text, public )
	text = string.lower( text ) -- Make the chat message entirely lowercase
	if ( text == "!updt_tag" ) then
		ply:SetNWInt("fuckshitfuck", player_tag)
		return ""
	end
end )





function add_bot()
player.CreateNextBot( botname )
end

function GM:ShowHelp( ply ) -- This hook is called everytime F1 is pressed.
    umsg.Start( "MyMenu", ply ) -- Sending a message to the client.
    umsg.End()
end
 
concommand.Add( "parkour", team_1 )
concommand.Add( "pkdeathmatch", team_2 )
concommand.Add( "pktag", team_3 )
concommand.Add( "add_bot", add_bot )

	

		
		
OpenPK.Libraries:Load();
OpenPK.Vgui:Load();
OpenPK.Minigame:Load();


