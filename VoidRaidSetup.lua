local addonName, VRS = ...
LibStub("AceAddon-3.0"):NewAddon(VRS, addonName, "AceEvent-3.0")

function VRS:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New(addonName.."DB", nil, true)
end
