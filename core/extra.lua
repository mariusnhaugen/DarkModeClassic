-- BANK
local a, b, c, d, e = BankFrame:GetRegions()
for _, v in pairs({b}) do
   v:SetVertexColor(0.35,0.35,0.35)
end

--PAPERDOLL/Characterframe
local a, b, c, d, _, e = PaperDollFrame:GetRegions()
for _, v in pairs({a, b, c, d, e}) do
   v:SetVertexColor(0.35,0.35,0.35)
end

-- Reputation Frame
local a, b, c, d = ReputationFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
    v:SetVertexColor(0.35,0.35,0.35)
end

-- HONOR Frame
local a, b, c, d = HonorFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
	v:SetVertexColor(0.35,0.35,0.35)
end

-- MERCHANT
local _, a, b, c, d, _, _, _, e, f, g, h, j, k = MerchantFrame:GetRegions()
for _, v in pairs({a, b, c ,d, e, f, g, h, j, k}) do
	v:SetVertexColor(0.35,0.35,0.35)
end
--MerchantPortrait
for i, v in pairs({
    MerchantFramePortrait
}) do
   v:SetVertexColor(1, 1, 1)
end

--PETPAPERDOLL/PET Frame
local a, b, c, d, _ = PetPaperDollFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
	v:SetVertexColor(0.35,0.35,0.35)
end

-- SPELLBOOK
local _, a, b, c, d = SpellBookFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
    v:SetVertexColor(0.35,0.35,0.35)
end

SpellBookFrame.Material = SpellBookFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
SpellBookFrame.Material:SetTexture[[Interface\AddOns\DarkModeUI\textures\quest\QuestBG.tga]]
SpellBookFrame.Material:SetWidth(547)
SpellBookFrame.Material:SetHeight(541)
SpellBookFrame.Material:SetPoint('TOPLEFT', SpellBookFrame, 22, -74)
SpellBookFrame.Material:SetVertexColor(0.7,0.7,0.7)

--Character Tabs

local a, b, c, d, e, f, g, h = CharacterFrameTab1:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = CharacterFrameTab2:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = CharacterFrameTab3:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = CharacterFrameTab4:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = CharacterFrameTab5:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

-- Social Frame

local a, b, c, d, e, f, g, _, i, j, k, l, n, o, p, q, r, _, _ = FriendsFrame:GetRegions()
for _, v in pairs({
	a, b, c, d, e, f, g, h, i, j, k, l, n, o, p, q, r,
	FriendsFrameInset:GetRegions(),
	WhoFrameListInset:GetRegions()
}) do
	v:SetVertexColor(0.35,0.35,0.35)
end

FriendsFrameInsetInsetBottomBorder:SetVertexColor(0.35,0.35,0.35)
WhoFrameEditBoxInset:GetRegions():SetVertexColor(0.35,0.35,0.35)
WhoFrameDropDownLeft:SetVertexColor(0.5,0.5,0.5)
WhoFrameDropDownMiddle:SetVertexColor(0.5,0.5,0.5)
WhoFrameDropDownRight:SetVertexColor(0.5,0.5,0.5)

local a, b, c, d, e, f, g, h, i = WhoFrameEditBoxInset:GetRegions()
for _, v in pairs({a, b, c, d, e, f, g, h, i}) do
	v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = FriendsFrameTab1:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = FriendsFrameTab2:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = FriendsFrameTab3:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = FriendsFrameTab4:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

--Mailbox

for i, v in pairs({
	MailFrameBg,
    MailFrameBotLeftCorner,
	MailFrameBotRightCorner,
	MailFrameBottomBorder,
	MailFrameBtnCornerLeft,
	MailFrameBtnCornerRight,
	MailFrameButtonBottomBorder,
	MailFrameLeftBorder,
	MailFramePortraitFrame,
	MailFrameRightBorder,
	MailFrameTitleBg,
	MailFrameTopBorder,
	MailFrameTopLeftCorner,
	MailFrameTopRightCorner,
	MailFrameInsetInsetBottomBorder,
	MailFrameInsetInsetBotLeftCorner,
	MailFrameInsetInsetBotRightCorner,
	
}) do
   v:SetVertexColor(0.35,0.35,0.35)
end


local a, b, c, d, e, f, g, h = MailFrameTab1:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = MailFrameTab2:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

-- Gossip Frame
local a, b, c, d, e, f, g, h, i = GossipFrameGreetingPanel:GetRegions()
	for _, v in pairs({a, b, c, d, e, f, g, h, i}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

GossipFrameGreetingPanel.Material = GossipFrameGreetingPanel:CreateTexture(nil, 'OVERLAY', nil, 7)
GossipFrameGreetingPanel.Material:SetTexture[[Interface\AddOns\DarkModeUI\textures\quest\QuestBG.tga]]
GossipFrameGreetingPanel.Material:SetWidth(514)
GossipFrameGreetingPanel.Material:SetHeight(522)
GossipFrameGreetingPanel.Material:SetPoint('TOPLEFT', GossipFrameGreetingPanel, 22, -74)
GossipFrameGreetingPanel.Material:SetVertexColor(0.7,0.7,0.7)

-- Quest Frame

local a, b, c, d, e, f, g, h, i = QuestFrameDetailPanel:GetRegions()
	for _, v in pairs({a, b, c, d, e, f, g, h, i}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

QuestFrameDetailPanel.Material = QuestFrameDetailPanel:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestFrameDetailPanel.Material:SetTexture[[Interface\AddOns\DarkModeUI\textures\quest\QuestBG.tga]]
QuestFrameDetailPanel.Material:SetWidth(514)
QuestFrameDetailPanel.Material:SetHeight(522)
QuestFrameDetailPanel.Material:SetPoint('TOPLEFT', QuestFrameDetailPanel, 22, -74)
QuestFrameDetailPanel.Material:SetVertexColor(0.7,0.7,0.7)

local a, b, c, d, e, f, g, h, i = QuestFrameProgressPanel:GetRegions()
	for _, v in pairs({a, b, c, d, e, f, g, h, i}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

QuestFrameProgressPanel.Material = QuestFrameProgressPanel:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestFrameProgressPanel.Material:SetTexture[[Interface\AddOns\DarkModeUI\textures\quest\QuestBG.tga]]
QuestFrameProgressPanel.Material:SetWidth(514)
QuestFrameProgressPanel.Material:SetHeight(522)
QuestFrameProgressPanel.Material:SetPoint('TOPLEFT', QuestFrameProgressPanel, 22, -74)
QuestFrameProgressPanel.Material:SetVertexColor(0.7,0.7,0.7)