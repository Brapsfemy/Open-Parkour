OpenPK.Minigame = {};
OpenPK.Minigame.Hooks = {};
OpenPK.Minigame.Path = "OpenPK/gamemode/minigame/";

function OpenPK.Minigame:Load()
	self:Include();
end;

function OpenPK.Minigame:Include()
	local loadOrder = {
		"sv",
		"cl",
		"sh"
	};
	local files,folders = file.Find( self.Path .. "*", "LUA" );
	for _,folder in pairs( folders ) do
		for _,prefix in pairs( loadOrder ) do
			local files, folders = file.Find( self.Path .. folder ..  "/*.lua", "LUA" );
			for _,file in pairs( files ) do
				OpenPK.Minigame:Handle( folder, file );
			end;
		end;
	end;
end;

function OpenPK.Minigame:Handle( folder, file )
	local fullPath = self.Path .. folder .. "/" ..  file;
	if( SERVER ) then
		AddCSLuaFile( fullPath );
	elseif( CLIENT ) then
		include( fullPath );
	end;
end;