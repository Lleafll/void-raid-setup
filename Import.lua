local addonName, VRS = ...

local function createImportFrame(self)
  self.ImportFrame = CreateFrame("EditBox", addonName.."Import", UIParent, "InputBoxTemplate")  -- possible template: ChatFrameEditBoxTemplate? InputBoxTemplate?
  self.ImportFrame:SetPoint("CENTER")
  self.ImportFrame:SetHeight(200)
  self.ImportFrame:SetWidth(200)
  self.ImportFrame:SetBackdropColor(1, 1, 1, 1)
  self.ImportFrame:SetResizable(true)
  self.ImportFrame:Hide()
  self.ImportFrame:SetAutoFocus(true)
  self.ImportFrame:SetScript("OnEnterPressed", function(self)
    local input = self:GetText()
    local inputFunc, errorMessage = loadstring("return "..input)
	if not inputFunc then
	  print("Wrong Data Format!")
	  print(errorMessage)
	  return
	end
    local inputTable = inputFunc()
    if type(inputTable) == "table" then  -- maybe replace with assert
	  if not inputTable.bosses or not inputTable.name or not inputTable.players then
	    print("Wrong Table Format!")
	    return
	  end
      VRS.db = inputTable
      self:Hide()
      VRS.Frame:Update()  -- maybe check if shown
	  print("Setup imported!")
    else
      print("No Table supplied!")
	end
  end)
  self.ImportFrame:SetScript("OnEscapePressed", function(self)
    self:Hide()
  end)
end

function VRS:OpenImportFrame()
  if not self.ImportFrame then
    createImportFrame(self)
  end
  self.ImportFrame:Show()
end
