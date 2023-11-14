-- Dropdown Lists

for i, v in pairs({
	DropDownList1MenuBackdrop.NineSlice.BottomEdge,
	DropDownList1MenuBackdrop.NineSlice.BottomLeftCorner,
	DropDownList1MenuBackdrop.NineSlice.BottomRightCorner,
	DropDownList1MenuBackdrop.NineSlice.LeftEdge,
	DropDownList1MenuBackdrop.NineSlice.RightEdge,
	DropDownList1MenuBackdrop.NineSlice.TopEdge,
	DropDownList1MenuBackdrop.NineSlice.TopLeftCorner,
	DropDownList1MenuBackdrop.NineSlice.TopRightCorner,
	DropDownList2MenuBackdrop.NineSlice.BottomEdge,
	DropDownList2MenuBackdrop.NineSlice.BottomLeftCorner,
	DropDownList2MenuBackdrop.NineSlice.BottomRightCorner,
	DropDownList2MenuBackdrop.NineSlice.LeftEdge,
	DropDownList2MenuBackdrop.NineSlice.RightEdge,
	DropDownList2MenuBackdrop.NineSlice.TopEdge,
	DropDownList2MenuBackdrop.NineSlice.TopLeftCorner,
	DropDownList2MenuBackdrop.NineSlice.TopRightCorner,
}) do
	v:SetVertexColor(0,0,0)
end

-- Color Picker Frame

for i, v in pairs({
	ColorPickerFrame.BottomEdge,
	ColorPickerFrame.BottomLeftCorner,
	ColorPickerFrame.BottomRightCorner,
	ColorPickerFrame.LeftEdge,
	ColorPickerFrame.RightEdge,
	ColorPickerFrame.TopEdge,
	ColorPickerFrame.TopLeftCorner,
	ColorPickerFrame.TopRightCorner,
	ColorPickerFrameHeader,
}) do
	v:SetVertexColor(0.35,0.35,0.35)
end

-- Keyring

local a, b, c, d = KeyRingButton:GetRegions()
	for _, v in pairs({b}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

-- Action Bar Arrows

local a, b, c, d = ActionBarUpButton:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.5,0.5,0.5)
end

local a, b, c, d = ActionBarDownButton:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.5,0.5,0.5)
end

MainMenuBarPageNumber:SetVertexColor(0.35,0.35,0.35)

-- Micro Buttons

local a, b, c, d = CharacterMicroButton:GetRegions()
	for _, v in pairs({b, c}) do
  		v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d = SpellbookMicroButton:GetRegions()
	for _, v in pairs({b}) do
  		v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d = TalentMicroButton:GetRegions()
	for _, v in pairs({b}) do
	  	v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d = QuestLogMicroButton:GetRegions()
	for _, v in pairs({b}) do
  		v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d = SocialsMicroButton:GetRegions()
	for _, v in pairs({b}) do
  		v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d = LFGMicroButton:GetRegions()
	for _, v in pairs({b}) do
  		v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d = MainMenuMicroButton:GetRegions()
	for _, v in pairs({c}) do
  		v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d = HelpMicroButton:GetRegions()
	for _, v in pairs({b}) do
  		v:SetVertexColor(0.65,0.65,0.65)
end

local a, b, c, d, e, f, g, h = BattlefieldFrame:GetRegions()
for _, v in pairs({b, c, d, e}) do
	v:SetVertexColor(0.35,0.35,0.35)
end