local addonName, VRS = ...

local function createImportFrame(self)
  self.ImportFrame = CreateFrame("EditBox", addonName.."Import", UIParent, "ChatFrameEditBoxTemplate")
  self.ImportFrame:SetAutoFocus(true)
  self.ImportFrame:RegisterEvent("OnEnterPressed", function(self)
    local input = self:GetText()
    local inputFunc = loadstring("return "..input)
    local inputTable = inputFunc()
    if not type(inputTable) == "table" then  -- maybe replace with assert
      -- raise error message
    else
      VRS.db = inputTable
      self:Hide()
      VRS.Frame:Update()  -- maybe check if shown
    end
  end)
  self.ImportFrame:RegisterEvent("OnEscapePressed", function(self)
    self:Hide()
  end)
end

function VRS:OpenImportFrame()
  if not self.ImportFrame then
    createImportFrame(self)
  end
  self.ImportFrame:Show()
end
