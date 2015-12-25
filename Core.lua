local addonName, addonTable = ...
VoidRaidSetup = LibStub("AceAddon-3.0"):NewAddon(addonTable, addonName, "AceEvent-3.0")

--[[needed events:
  RAID_ROSTER_UPDATE
  GROUP_ROSTER_UPDATE?
  GROUP_JOINED?
]]--

