include( "commands.lua" )

GM.Name = "Open Parkour"
GM.Author = "Axarator"
GM.Email = "N/A"
GM.Website = "N/A"

util.PrecacheModel("models/player/kleiner.mdl")

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

team.SetUp( 1, "Parkour", Color(100,255,100))
team.SetUp( 2, "Deathmatch", Color(254,0,0))
team.SetUp( 3, "Tag", Color(200,200,0))

CreateConVar("st_weapon", "weapon_fists", FCVAR_REPLICATED, "The Weapon every Player has. def. weapon_fists")
CreateConVar("st_wallsight", "1", FCVAR_REPLICATED, "Enable/Disable seeing players trough walls if you're it. def. 1")
CreateClientConVar("st_halo", 0, true, true)
CreateConVar("st_respawntime", "15", FCVAR_REPLICATED, "How long a player has to wait until he can respawn. def. 15")
CreateConVar("st_allowsuicide", "0", FCVAR_REPLICATED, "Allow/Disallow the command 'kill'? def. 0")
CreateConVar("st_maxits", "1", FCVAR_REPLICATED, "Set how many players can be it. There will never be more total its then set here unless you set st_un_it_player to 0. You can't have this lower then st_minits. def. 1")
CreateConVar("st_un_it_player", "1", FCVAR_REPLICATED, "Should the player lose its 'It' status when he hits another player? Other values then 1/0 may lead to unwanted side effects. def. 1")
CreateConVar("st_minits", "1",  FCVAR_REPLICATED, "Set how many players will be it. There will never less players be it then set here. If you rise this value it'll also rise the value of st_maxits but if you lower it, it won't. You'll need to lower st_maxits yourself. def. 1")
CreateConVar("st_freezetime", "3",  FCVAR_REPLICATED, "Set how long the player should be frozen after being hit. def. 3")


team.SetUp(4, "Not it", Color(0, 165, 235, 255 ))
team.SetUp(5, "It", Color(235, 25, 35, 255))
