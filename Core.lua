local addonName, VRS = ...

local setup = {}
local standby = {}

--[[needed events:
  RAID_ROSTER_UPDATE
  GROUP_ROSTER_UPDATE?
  GROUP_JOINED?
  when changing boss
  when killing preceding boss?
]]--

local function createPlayer(parent)
  
end

local function createVRSFrame(self)
  self.Frame = CreateFrame()  -- create frame for addon functionality
  self.Frame.setup = {}  -- players which need to be moved into the raid
  self.Frame.standby = {}  -- players which need to be moved out of the raid
end

function VRS:UpdateVRS()
  local bossTable = self.db[self.selectedBoss]
  for i in NumGroupMembers() do
    local = name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
    if subgroup <= 4 then
      if bossTable.setup.standby[name] then
        standby[#standby+1] = name
      end
    else
      if bossTable.setup.setup[name] then
        setup[#setup+1] = name
      end
    end
  end
  
  
end
