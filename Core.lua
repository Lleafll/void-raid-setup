local addonName, VRS = ...

--[[needed events:
  RAID_ROSTER_UPDATE
  GROUP_ROSTER_UPDATE?
  GROUP_JOINED?
  when changing boss
  when killing preceding boss?
]]--

local function createVRSFrame(self)
  self.Frame = CreateFrame()  -- create frame for addon functionality here
end
