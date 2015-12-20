/*
	Open PK
	Shared - Libraries.lua
*/

OpenPK = OpenPK or GAMEMODE or GM {};

OpenPK.Libraries = {};
OpenPK.Libraries.Stored = {};
OpenPK.Libraries.Path = "OpenPK/gamemode/libraries/"

function OpenPK.Libraries:Load()
	print( "Loading!" );
	local loadOrder = {
		"sv",
		"cl",
		"sh"
	};

	local files,folders = file.Find( self.Path .. "*", "LUA" );
	for _,folder in pairs( folders ) do
		local localPath = "libraries/" .. folder .. "/";
		for _,prefix in pairs( loadOrder ) do
			local filePath = localPath .. folder .. "/";
			local files, folders = file.Find( self.Path .. folder .. "/" .. prefix .. "_*.lua", "LUA" );
			for _,file in pairs( files ) do
				OpenPK.Libraries:Handle( folder, file );
			end;
		end;
	end;
end;

function OpenPK.Libraries:Handle( folder, file )
	local prefix = string.sub( file, 1, 3 );
	local fullPath = self.Path .. folder .. "/" .. file;
	if( SERVER ) then
		if( prefix ~= "sv" ) then
			AddCSLuaFile( fullPath );
		end;
		if( prefix ~= "cl" ) then
			include( fullPath );
		end;
	elseif( CLIENT ) then
		if( prefix ~= "sv" ) then
			include( fullPath );
		end;
	end;
end;
