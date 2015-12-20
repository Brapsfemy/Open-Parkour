function WallSlide(ply)	
	 
	

	local tr = ply:GetEyeTrace()
	if !tr.Hit then return end
	
	local HitDistance = tr.HitPos:Distance(tr.StartPos)
	if (HitDistance > 8) then
		local vForward = ply:GetForward():GetNormalized()
		local vVelocity = ply:GetVelocity()
		
			if ( ply:KeyDown(IN_FORWARD) and vVelocity.z < 0 ) then

		

			local F = ply:GetForward() F.z = 0

			vForward = F:GetNormalized()

		

			local tracedata = {}

			tracedata.start = ply:GetPos()

			tracedata.endpos = ply:GetPos()+(vForward*24)

			tracedata.filter = ply

			local tr = util.TraceLine(tracedata)
			
			if (tr.Fraction < 1.0) then
				vVelocity.z = 0.5

				ply:SetLocalVelocity(vVelocity)
				
			end



		end
		
		if ( ply:KeyDown(IN_FORWARD) and vVelocity.z < 0 ) then

		

			local F = ply:GetForward() F.z = 0

			vForward = F:GetNormalized()

		

			local tracedata = {}

			tracedata.start = ply:GetPos()

			tracedata.endpos = ply:GetPos()+(vForward*24)

			tracedata.filter = ply

			local tr = util.TraceLine(tracedata)
			
			if (tr.Fraction < 1.0) then
				vVelocity.z = 0.5

				ply:SetLocalVelocity(vVelocity)
				
			end
		end

	end
end
hook.Add("KeyPress", "WallSlide", WallSlide)
