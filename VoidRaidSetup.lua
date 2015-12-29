local addonName, VRS = ...
LibStub("AceAddon-3.0"):NewAddon(VRS, addonName, "AceEvent-3.0", "AceConsole-3.0")

function VRS:HandleChatCommand(command)
  self:OpenImportFrame()
end
VRS:RegisterChatCommand("vrs", "HandleChatCommand")
VRS:RegisterChatCommand("voidraidsetup", "HandleChatCommand")

function VRS:OnInitialize()
  local VRSDB = LibStub("AceDB-3.0"):New(addonName.."DB", {
    global = {
	  name = "",
      players = {},
	  bosses = {{name="No Bosses Loaded", setup={}}}
	}
  }, true)
  self.db = VRSDB.global
  self:InitializeFrame()
end
