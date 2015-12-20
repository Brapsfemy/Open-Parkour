--Container
--We want to parent everything to this because
--When we reload the gamemode, we don't want to lose track
--Of all the panels we created
--So if we parent everything to this, it makes it simple to
--Remove all the OpenPK panels and reload them
local PANEL = {};

function PANEL:Init()
	self:SetSize( ScrW(), ScrH() );
	self:Center();
end;

function PANEL:Remove()
	gui.EnableScreenClicker( false );
end;

function PANEL:Paint( w, h )
	--Don't paint because we're the container
end;

vgui.Register( "OpenPK_Container", PANEL );
