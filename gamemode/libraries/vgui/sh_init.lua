if( CLIENT ) then
	surface.CreateFont( "OpenPK_Huge", {
		font = "Tahoma",
		size = 30,
		weight = 300
	} );

	surface.CreateFont( "OpenPK_Large", {
		font = "Tahoma",
		size = 26,
		weight = 300,
	} );
end;

OpenPK.Vgui = {};
OpenPK.Vgui.Hooks = {};
OpenPK.Vgui.Path = "OpenPK/gamemode/vgui/";

function OpenPK.Vgui:Load()
	self:Include();
	if( CLIENT ) then
		if( Container ) then
			local children = Container:GetChildren();
			for _,panel in pairs( children ) do
				panel:Remove();
			end;
			Container:Remove();
			Container = nil;
		end;
		Container = vgui.Create( "OpenPK_Container" );
	end;
end;

function OpenPK.Vgui:Include()
	local loadOrder = {
		"sv",
		"cl",
		"sh"
	};

	for _,prefix in pairs( loadOrder ) do
		local files, folders = file.Find( self.Path .. "*.lua", "LUA" );
		for _,file in pairs( files ) do
			OpenPK.Vgui:Handle( file );
		end;
	end;
end;

function OpenPK.Vgui:Handle( file )
	local fullPath = self.Path .. file;
	if( SERVER ) then
		AddCSLuaFile( fullPath );
	elseif( CLIENT ) then
		include( fullPath );
	end;
end;

if( CLIENT ) then

	function OpenPK.Vgui.Hooks.OnSpawnMenuOpen()
		if( Container ) then
			if( Container:IsValid() ) then
				if( Container.Menu ) then
					if( Container.Menu:IsValid() ) then
						Container.Menu:Remove();
						Container.Menu = nil;
					end;
				end;
			end;
		end;
		Container.Menu = vgui.Create( "OpenPK_Menu", Container );
		
		--Lobbies
		local button = Container.Menu:Add( "OpenPK_MenuButton" );
		button:SetText( "Lobbies" );
		button:SetColor( Color( 70, 70, 80 ) )
		
		--Settings
		local button = Container.Menu:Add( "OpenPK_MenuButton" );
		button:SetText( "Settings" );
		button:SetColor( Color( 70, 70, 70 ) );
		
		--Leaderboard
		local button = Container.Menu:Add( "OpenPK_MenuButton" );
		button:SetText( "Leaderboard" );
		button:SetColor( Color( 80, 70, 70 ) );

		--Tutorial
		local button = Container.Menu:Add( "OpenPK_MenuButton" );
		button:SetText( "Tutorial" );
		button:SetColor( Color( 70, 80, 70 ) );

		gui.EnableScreenClicker( true );
	end;
	hook.Add( "OnSpawnMenuOpen", "OpenPK.Vgui.OnSpawnMenuOpen", OpenPK.Vgui.Hooks.OnSpawnMenuOpen );

	function OpenPK.Vgui.Hooks.OnSpawnMenuClose()
		if( Container ) then
			if( Container.Menu ) then
				if( Container.Menu:IsValid() ) then
					Container.Menu:StartRemove();
				end;
			end;
		end;
		gui.EnableScreenClicker( false );
	end;
	hook.Add( "OnSpawnMenuClose", "OpenPk.Vgui.OnSpawnMenuClose", OpenPK.Vgui.Hooks.OnSpawnMenuClose );

end;