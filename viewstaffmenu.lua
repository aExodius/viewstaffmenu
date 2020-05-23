PLUGIN.name = "View Staff Menu"
PLUGIN.author = "Created by Exodius"
PLUGIN.desc = "Allows players to view the amount of staff online!"

if (SERVER) then
	util.AddNetworkString("viewStaffmenu")
end

ix.command.Add("viewstaff", {
	OnRun = function(self, client)
		net.Start("viewStaffmenu")
		net.Send(client)
	end
})

if (CLIENT) then
	net.Receive("viewStaffmenu",function()
		local background = vgui.Create("DFrame")
		background:SetSize(ScrW() / 2, ScrH() / 2)
		background:Center()
		background:SetTitle("View Staff")
		background:MakePopup()
		background:IsDraggable(false)
		background:ShowCloseButton(true)

		scroll = background:Add("DScrollPanel")
		scroll:Dock(FILL)
		
		local staffListing = scroll:Add("DListView")
			staffListing:SetTall(36)
			staffListing:Dock(TOP)
			staffListing:DockMargin(5, 5, 5, 0)
		    staffListing:SetMultiSelect( false )
		    staffListing:AddColumn( "Player" )
		    staffListing:AddColumn( "SteamID64" )
		    staffListing:AddColumn( "SteamID" )
		    staffListing:AddColumn( "Rank" )

			for k,v in pairs(player.GetAll()) do 
				local ply = LocalPlayer()
				if ply:IsAdmin() then ply:GetUserGroup()

		    	staffListing:AddLine(v:Nick(), v:SteamID64(), v:SteamID(), v:GetUserGroup()) end
		    end

		   staffListing.Paint = function()
		      surface.SetDrawColor( 0, 125, 255, 255 )
		      surface.DrawRect( 0, 0, background:GetWide(), background:GetTall() )
			  surface.SetDrawColor( 0, 0, 0, 255 )
		      staffListing:DrawOutlinedRect()
		   end

	end)
end