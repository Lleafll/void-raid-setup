local addonName, VRS = ...

local raidSize = 4  -- number of groups in raid

local function createVRSFrame(self)
  self.Frame = CreateFrame()  -- create frame for addon functionality
  self.Frame:SetPoint("TOP", "LEFT")
  self.Frame:Hide()
  function self.Frame:Update()
    local setupString = "Move to Setup:\n"
    local standbyString = "Move to Standby:\n"
    self.db.selectedBoss = self.db.selectedBoss or 1
    local bossTable = self.db.bosses[self.db.selectedBoss]
    for i in NumGroupMembers() do
      local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
      local playerKey = self.db.keys[name]  -- might need to split server string
      local playerInSetup = bossTable.setup[playerKey]
      if subgroup <= raidSize and not playerInSetup then
        standbyString = standbyString .. name .. "\n"
      elseif subgroup > raidSize and playerInSetup then
        setupString = setupString .. name .. "\n"
      end
    end
    -- set self.db.name as VRS Frame title
    self.Frame.Setup:SetText(setupString)
    self.Frame.Standby:SetText(standbyString)
  end
  self.Frame:RegisterEvent("OnShow", "Update")
  --[[needed events:
    RAID_ROSTER_UPDATE
    GROUP_ROSTER_UPDATE?
    GROUP_JOINED?
    when killing preceding boss?
  ]]--
  
  self.Frame.Dropdown = CreateFrame("Button", self.Frame, "UIDropDownMenuTemplate")
  self.Frame.Dropdown:SetPoint("TOP")
  self.Frame.Dropdown:Show()
  UIDropDownMenu_Initialize(self.Frame.Dropdown, function(self, level)
    for k, v in pairs(VRS.db.bosses) do
      local info = UIDropDownMenu_CreateInfo()
      info.text = v.name
      info.value = k
      info.func = function(self)
        local id = self:GetID()
        UIDropDownMenu_SetSelectedID(VRS.Frame.Dropdown, id)
        VRS.db.selectedBoss = id
        VRS.Frame:Update()
      end
      UIDropDownMenu_AddButton(info, level)
    end
  end)
  UIDropDownMenu_SetWidth(self.Frame.Dropdown, 100)
  UIDropDownMenu_SetButtonWidth(self.Frame.Dropdown, 124)
  UIDropDownMenu_SetSelectedID(self.Frame.Dropdown, self.db.selectedBoss or 1)
  UIDropDownMenu_JustifyText(self.Frame.Dropdown, "CENTER")

  self.Frame.Setup = CreateFrame("FontString", self.Frame)
  self.Frame.Setup:SetPoint("TOPLEFT", 0, -50)
  self.Frame.Setup:Show()

  self.Frame.Standby = CreateFrame("FontString", self.Frame)
  self.Frame.Standby:SetPoint("TOPRIGHT", 0, -50)
  self.Frame.Standby:Show()

  self.Frame.Auto = CreateFrame("Button", self.Frame)  -- look for appropriate button template
  self.Frame.Auto:SetPoint("BOTTOM")
  self.Frame.Auto:SetText("Auto Sort")
  self.Frame.Auto:Show()
  self.Frame.Auto:RegisterEvent("OnClick", function()
    -- Auto Sort
  end)
end
