--Menu
local PANEL = {};

function PANEL:Init()
	self.Title = "OpenPK Menu";
	self.AnimateTime = 0.5;
	self:SetSize( ScrW() / 4, ScrH() );
	self:SetPos( -self:GetWide(), 0 );
	self:MoveTo( 0, 0, self.AnimateTime, 0, -1 );
	self.Container = vgui.Create( "DIconLayout", self );
	self.Container:SetPos( 0, 53 );
	self.Container:SetSize( self:GetWide(), self:GetTall() - 53 );
	self.Container:SetSpaceY( 1 );
end;

function PANEL:AddPanel( panel )
	self.Container:AddPanel( panel );
end;

function PANEL:Add( panelType )
	local panel = self.Container:Add( panelType );
	panel:MoveToFront();
	return panel;
end;

function PANEL:StartRemove()
	self:MoveTo( -self:GetWide(), 0, self.AnimateTime, 0, -1, function()
		self:Remove();
		Container.Menu = nil;
	end );
end;

function PANEL:SetSubMenu( panel )
	if( self.SubMenu ) then
		if( self.SubMenu:IsValid() ) then
			self.SubMenu:Remove();
		end;
	end;
	self.SubMenu = panel;
end;

function PANEL:SubMenuOpen()
	if( self.SubMenu ) then
		if( self.SubMenu:IsValid() ) then

		end;
	end;
end;

function PANEL:Paint( w, h )
	
	--Background
	surface.SetDrawColor( Color( 20, 20, 20, 170 ) );
	surface.DrawRect( 0, 0, w, h );
	
	--Title Bar
	surface.SetDrawColor( Color( 80, 70, 70, 170 ) );
	surface.DrawRect( 0, 0, w, 50 );
	
	--Title Line
	surface.SetDrawColor( Color( 80, 70, 70 ) );
	surface.DrawLine( 0, 50, self:GetWide() - 1, 50 );
	surface.SetDrawColor( Color( 70, 60, 60 ) );
	surface.DrawLine( 0, 51, self:GetWide() - 1, 51 );
	
	--Outline
	surface.SetDrawColor( Color( 80, 70, 70 ) );
	surface.DrawOutlinedRect( 0, 0, w, h );
	
	--Title
	--text font x y color xalign yalign width color 
	draw.SimpleTextOutlined(
		self.Title,
		"OpenPK_Huge",
		w / 2,
		25,
		Color( 255, 255, 255 ),
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_CENTER,
		1,
		Color( 70, 70, 60 )
	);
end;

vgui.Register( "OpenPK_Menu", PANEL );