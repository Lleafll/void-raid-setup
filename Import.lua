local addonName, VRS = ...

local function createImportFrame(self)
  self.ImportFrame = CreateFrame("EditBox", addonName.."Import", UIParent, "ChatFrameEditBoxTemplate")
end

function VRS:OpenImportFrame()
  if not self.ImportFrame then
    createImportFrame(self)
  end
  self.ImportFrame:Show()
end

function VRS:Import()
  if not self.ImportFrame:IsShown() then
    return
  end
  local input = self.ImportFrame:GetText()
  local inputFunc = loadstring("return "..input)
  local inputTable = inputFunc()
  if not type(inputTable) == "table" then  -- maybe replace with assert
    -- raise error message
  else
    self.db = inputTable
    self.ImportFrame:Close()
  end
end
