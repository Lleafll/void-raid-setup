local addonName, VRS = ...
LibStub("AceAddon-3.0"):NewAddon(VRS, addonName, "AceEvent-3.0")

function VRS:HandleChatCommand(command)
  self:OpenImportFrame()
end

VRS:RegisterChatCommand("vrs", "HandleChatCommand")
VRS:RegisterCharCommand("voidraidsetup", "HandleChatCommand")

function VRS:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New(addonName.."DB", {
    name = "",
    keys = {},
    bosses = {}
  }, true)
end
