print( "Hello" );

OpenPK = OpenPK;
OpenPK.WallJump = {};
OpenPK.WallJump.Hooks = {};
OpenPK.WallJump.Config = {};
OpenPK.WallJump.Config.WallJumpSound = "physics/concrete/rock_impact_hard";
OpenPK.WallJump.Config.Dist = 35;
OpenPK.WallJump.Config.HRebound = 130;
OpenPK.WallJump.Config.VRebound = 90;

function OpenPK.WallJump.KeyCheck( client )
	--you can't walljump without jumping,
	--nerd. kappa
	if( !client:KeyDown( IN_JUMP ) ) then
		return;
	end;
	--if( client:KeyDown( IN_MOVERIGHT ))
end;

function OpenPK.WallJump.SetVelocity( client, dir, lobby )
	/*
		Lobby:
			Config:
				WallJump:
					HRebound: 500,
					VRebound: 300
	*/

	if( client:IsValid() ) then
		local vel = client:GetVelocity();
		local right = client:GetRight():GetNormalized();
		local hRebound = OpenPK.WallJump.Config.HRebound;
		local vRebound = OpenPK.WallJump.Config.VRebound;
		
		if( lobby ~= nil ) then
			hRebound = lobby.Config.WallJump.hRebound;
			vRebound = lobby.Config.WallJump.vRebound;
		else

		end;
		vel.z = vel.z + vRebound;
		vel = vel + dir * hRebound;
		OpenPK.WallJump.PlaySound( client );
		client:SetLocalVelocity( vel );
	end;
end;

function OpenPK.WallJump.PlaySound( client )
	client:EmitSound(
		OpenPK.WallJump.Config.WallJumpSound .. 
			math.random( 1, 6 ) .. 
		".wav",
		math.random( 90, 110 ),
		math.random( 60, 80 )
	);
end;

function OpenPK.WallJump.Trace( client, dir )
	local trace = {};
	trace.start = client:GetPos();
	trace.endpos = trace.start - dir * OpenPK.WallJump.Config.Dist;
	trace = util.TraceLine( trace );
	if( trace.Fraction < 1.0 && !trace.HitSky ) then
		return true;
	end;
	return false;
end;

function OpenPK.WallJump.Hooks.KeyPress( client, key )
	local dir = Vector( 0, 0, 0 );
	if( !client:KeyDown( IN_JUMP ) ) then
		return;
	end;
	if( client:KeyDown( IN_FORWARD ) ) then
		dir = dir + client:GetForward();
	elseif( client:KeyDown( IN_BACK ) ) then
		dir = dir -client:GetForward();
	end;
	if( client:KeyDown( IN_MOVERIGHT ) ) then
		dir = client:GetRight();
	end;
	if( client:KeyDown( IN_MOVELEFT ) and !client:KeyDown( IN_MOVERIGHT ) ) then
		dir = -client:GetRight();
	elseif( client:KeyDown( IN_MOVELEFT ) and client:KeyDown( IN_MOVERIGHT ) ) then
		dir = -client:GetRight();
		if( !OpenPK.WallJump.Trace( client, dir ) ) then
			dir = client:GetRight();
		end;
	end;
	local canJump = OpenPK.WallJump.Trace( client, dir );
	if( canJump ) then
		OpenPK.WallJump.SetVelocity( client, dir );
	end;
end;
hook.Add( "KeyPress", "WallJump.KeyPress", OpenPK.WallJump.Hooks.KeyPress );
