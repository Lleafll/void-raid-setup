local addonName, VRS = ...

local function createImportFrame(self)
  self.ImportFrame = CreateFrame("EditBox", addonName.."Import", UIParent, "ChatFrameEditBoxTemplate")  -- possible template: ChatFrameEditBoxTemplate?
  self.ImportFrame:SetPoint("CENTER")
  self.ImportFrame:SetHeight(200)
  self.ImportFrame:SetWidth(200)
  self.ImportFrame:Hide()
  self.ImportFrame:SetAutoFocus(true)
  self.ImportFrame:SetScript("OnEnterPressed", function(self)
	-- debug
	print("Enter pressed")
    local input = self:GetText()
	-- debug
	print(input)
    local inputFunc, errorMessage = loadstring("return "..input)
	if not inputFunc then
	  print("Wrong Data Format!")
	  print(errorMessage)
	  return
	end
    local inputTable = inputFunc()
	-- debug
	--print(type(inputTable))
    if type(inputTable) == "table" then  -- maybe replace with assert
	  -- debug
	  print(inputTable.name, inputTable.players, inputTable.bosses)
	  if not inputTable.bosses or not inputTable.name or not inputTable.players then
	    print("Wrong Table Format!")
	    return
	  end
      VRS.db = inputTable
      self:Hide()
      VRS.Frame:Update()  -- maybe check if shown
	  return
    else
      print("No Table supplied!")
	end
  end)
  self.ImportFrame:SetScript("OnEscapePressed", function(self)
    -- debug
	--print("Escape pressed")
    self:Hide()
  end)
end

function VRS:OpenImportFrame()
  if not self.ImportFrame then
    createImportFrame(self)
  end
  self.ImportFrame:Show()
end
