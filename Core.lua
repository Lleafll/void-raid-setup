local addonName, VRS = ...

local raidSize = 4  -- number of groups in raid

function VRS:InitializeFrame()
  self.Frame = CreateFrame("Frame", addonName.."Frame", RaidFrame)  -- change parent to raid options menu
  self.Frame:SetPoint("TOPLEFT", RaidFrame, "BOTTOMLEFT", 0, -50)
  self.Frame:SetPoint("TOPRIGHT", RaidFrame, "BOTTOMRIGHT", 0, -50)
  self.Frame:SetHeight(200)
  self.Frame:SetBackdropColor(1, 1, 1, 1)
  self.Frame:Show()
  function self.Frame:Update()
    local setupString = ""
    local standbyString = ""
    VRS.db.selectedBoss = VRS.db.selectedBoss or 1
    local bossTable = VRS.db.bosses[VRS.db.selectedBoss]
    for i = 1, GetNumGroupMembers() do
      local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
	  if name then
	    local playerKey = VRS.db.players[name]  -- might need to split server string
		local playerInSetup = bossTable.setup[playerKey]
		if subgroup <= raidSize and not playerInSetup then
		  standbyString = standbyString .. name .. "\n"
		elseif subgroup > raidSize and playerInSetup then
		  setupString = setupString .. name .. "\n"
		end
	  end
    end
    local notInRaidString = ""
    for name, key in pairs(VRS.db.players) do
      if bossTable.setup[key] and not UnitInRaid(name) then  -- might not work crossrealm
        notInRaidString = notInRaidString .. name .. "\n"
      end
    end
    
    -- set self.db.name as VRS Frame title
    if setupString == "" then
      setupString = "-\n"
    end
    if notInRaidString ~= "" then
      setupString = setupString .. "\nNot in Raid:\n" .. notInRaidString
    end
    if standbyString == "" then
      standbyString = "-\n"
    end
    setupString = "Move to Setup:\n"..setupString
    standbyString = "Move to Standby:\n" .. standbyString
    VRS.Frame.Setup:SetText(setupString)
    VRS.Frame.Standby:SetText(standbyString)
  end
  self.Frame:RegisterEvent("OnShow", "Update")
  self.Frame:RegisterEvent("RAID_ROSTER_UPDATE", "Update")
  --[[needed events:
    GROUP_ROSTER_UPDATE?
    GROUP_JOINED?
    when killing preceding boss?
  ]]--
  
  self.Frame.Dropdown = CreateFrame("Button", addonName.."FrameDropDownMenu", self.Frame, "UIDropDownMenuTemplate")
  self.Frame.Dropdown:SetPoint("TOP")
  self.Frame.Dropdown:Show()
  UIDropDownMenu_Initialize(self.Frame.Dropdown, function(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
      local id = self:GetID()
      UIDropDownMenu_SetSelectedID(VRS.Frame.Dropdown, id)
      VRS.db.selectedBoss = id
      VRS.Frame:Update()
    end
    for k, v in pairs(VRS.db.bosses) do
      info.text = v.name
      info.value = k
      UIDropDownMenu_AddButton(info)
    end
  end)
  UIDropDownMenu_SetWidth(self.Frame.Dropdown, 200)
  UIDropDownMenu_SetButtonWidth(self.Frame.Dropdown, 248)
  UIDropDownMenu_SetSelectedID(self.Frame.Dropdown, self.db.selectedBoss or 1)
  UIDropDownMenu_JustifyText(self.Frame.Dropdown, "LEFT")

  self.Frame.Setup = self.Frame:CreateFontString()
  self.Frame.Setup:SetPoint("TOPLEFT", 0, -50)
  self.Frame.Setup:SetPoint("TOPRIGHT", self.Frame, "TOP", 0, -50)
  self.Frame.Setup:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 0, 50)
  self.Frame.Setup:SetFontObject("GameFontNormal")
  self.Frame.Setup:SetText("Move to Setup:")
  self.Frame.Setup:Show()

  self.Frame.Standby = self.Frame:CreateFontString()
  self.Frame.Standby:SetPoint("TOPRIGHT", 0, -50)
  self.Frame.Standby:SetPoint("TOPLEFT", self.Frame, "TOP", 0, -50)
  self.Frame.Standby:SetPoint("BOTTOMRIGHT", self.Frame, "BOTTOMRIGHT", 0, 50)
  self.Frame.Standby:SetFontObject("GameFontNormal")
  self.Frame.Standby:SetText("Move to Raid:")
  self.Frame.Standby:Show()

  self.Frame.Auto = CreateFrame("Button", self.Frame)  -- look for appropriate button template
  self.Frame.Auto:SetPoint("BOTTOM")
  self.Frame.Auto:SetText("Auto Sort")
  self.Frame.Auto:Show()
  self.Frame.Auto:RegisterEvent("OnClick", function()
    -- Auto Sort
  end)
end
