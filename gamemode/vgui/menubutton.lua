--OpenPK_MenuButton
local PANEL = {};

function PANEL:Init()
	local parent = self:GetParent();
	self.Text = "Button";
	self.Highlight = 20;
	self.Hovered = false;
	self.Selected = false;
	self.ColorRate = 5;
	self.Color = Color( 70, 60, 60 );
	self.DisplayColor = Color( self.Color.r, self.Color.g, self.Color.b );
	self:SetSize( parent:GetWide(), 30 );
end;

function PANEL:SetText( text )
	self.Text = text;
end;

function PANEL:SetColor( color )
	self.Color = color;
end;

function PANEL:SetOnClick( func )
	function self:OnMousePressed()
		func( self );
	end;
end;

function PANEL:OnCursorEntered()
	self.Hovered = true;
end;

function PANEL:OnCursorExited()
	self.Hovered = false;
end;

function PANEL:Think()
	if( self.Hovered or self.Selected ) then
		self.DisplayColor.r = math.Approach( self.DisplayColor.r, self.Color.r + self.Highlight, self.ColorRate );
		self.DisplayColor.g = math.Approach( self.DisplayColor.g, self.Color.g + self.Highlight, self.ColorRate );
		self.DisplayColor.b = math.Approach( self.DisplayColor.b, self.Color.b + self.Highlight, self.ColorRate );
	else
		self.DisplayColor.r = math.Approach( self.DisplayColor.r, self.Color.r, self.ColorRate );
		self.DisplayColor.g = math.Approach( self.DisplayColor.g, self.Color.g, self.ColorRate );
		self.DisplayColor.b = math.Approach( self.DisplayColor.b, self.Color.b, self.ColorRate );
	end;
end;

function PANEL:Paint( w, h )
	--Background
	surface.SetDrawColor( self.DisplayColor );
	surface.DrawRect( 0, 0, w, h );
	
	--Title
	draw.SimpleTextOutlined(
		self.Text,
		"OpenPK_Large",
		w / 2,
		h / 2,
		Color( 255, 255, 255 ),
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_CENTER,
		1,
		Color( self.DisplayColor.r - 10, self.DisplayColor.b - 10, self.DisplayColor.g - 10 )
	);
end;

vgui.Register( "OpenPK_MenuButton", PANEL );