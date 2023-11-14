--get the addon namespace
local addon, ns = ...
--get the config values
local cfg = ns.cfg
local dragFrameList = ns.dragFrameList

-- v:SetVertexColor(0.35,0.35,0.35) GREY
-- v:SetVertexColor(0.05,0.05,0.05) DARKEST

---------------------------------------
-- ACTIONS
---------------------------------------

-- REMOVING UGLY PARTS OF UI

local event_frame = CreateFrame('Frame')
local errormessage_blocks = {
	'Способность пока недоступна',
	'Выполняется другое действие',
	'Невозможно делать это на ходу',
	'Предмет пока недоступен',
	'Недостаточно',
	'Некого атаковать',
	'Заклинание пока недоступно',
	'У вас нет цели',
	'Вы пока не можете этого сделать',

	'Ability is not ready yet',
 	'Another action is in progress',
	'Can\'t attack while mounted',
	'Can\'t do that while moving',
	'Item is not ready yet',
	'Not enough',
	'Nothing to attack',
	'Spell is not ready yet',
	'You have no target',
	'You can\'t do that yet',
}
local enable
local onevent
local uierrorsframe_addmessage
local old_uierrorsframe_addmessage
function enable ()
	old_uierrorsframe_addmessage = UIErrorsFrame.AddMessage
	UIErrorsFrame.AddMessage = uierrorsframe_addmessage
end

function uierrorsframe_addmessage (frame, text, red, green, blue, id)
	for i,v in ipairs(errormessage_blocks) do
			if text and text:match(v) then
  				return
			end
	end
	old_uierrorsframe_addmessage(frame, text, red, green, blue, id)
end

function onevent (frame, event, ...)
	if event == 'PLAYER_LOGIN' then
			enable()
	end
end
event_frame:SetScript('OnEvent', onevent)
event_frame:RegisterEvent('PLAYER_LOGIN')


-- COLORING FRAMES
local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_ENTERING_WORLD")
CF:RegisterEvent("GROUP_ROSTER_UPDATE")

--Thick Target Frames

function ApplyThickness()
	
    if DarkModeUIOptions.thickness then
        
		hooksecurefunc('TargetFrame_CheckClassification', function(self, forceNormalTexture)
			local classification = UnitClassification(self.unit);
			if ( classification == "worldboss" or classification == "elite" ) then
				self.borderTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\unitframes\\UI-TargetingFrame-Elite")
				self.borderTexture:SetVertexColor(0.05,0.05,0.05)
			elseif ( classification == "rareelite" ) then
				self.borderTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\unitframes\\UI-TargetingFrame-Rare-Elite")
				self.borderTexture:SetVertexColor(0.05,0.05,0.05)
			elseif ( classification == "rare" ) then
				self.borderTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\unitframes\\UI-TargetingFrame-Rare")
				self.borderTexture:SetVertexColor(0.05,0.05,0.05)
			else
				self.borderTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\unitframes\\UI-TargetingFrame")
				self.borderTexture:SetVertexColor(0.05,0.05,0.05)
			end
		end)

		--Player Name

		PlayerFrame.name:ClearAllPoints()
		PlayerFrame.name:SetPoint('TOP', PlayerFrameHealthBar, 0,15)
		
		--Rest Glow

		PlayerStatusTexture:SetTexture()
		PlayerRestGlow:SetAlpha(0)

		--Player Frame

		function DarkModeUIPlayerFrame(self)
			PlayerFrameTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\unitframes\\UI-TargetingFrame");
			self.name:Hide();
			self.name:ClearAllPoints();
			self.name:SetPoint("CENTER", PlayerFrame, "CENTER",50.5, 36);
			self.healthbar:SetPoint("TOPLEFT",106,-24);
			self.healthbar:SetHeight(26);
			self.healthbar.LeftText:ClearAllPoints();
			self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"LEFT",8,0);
			self.healthbar.RightText:ClearAllPoints();
			self.healthbar.RightText:SetPoint("RIGHT",self.healthbar,"RIGHT",-5,0);
			self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
			self.manabar:SetPoint("TOPLEFT",106,-52);
			self.manabar:SetHeight(13);
			self.manabar.LeftText:ClearAllPoints();
			self.manabar.LeftText:SetPoint("LEFT",self.manabar,"LEFT",8,0);
			self.manabar.RightText:ClearAllPoints();
			self.manabar.RightText:SetPoint("RIGHT",self.manabar,"RIGHT",-5,0);
			self.manabar.TextString:SetPoint("CENTER",self.manabar,"CENTER",0,0);
			PlayerFrameGroupIndicatorText:ClearAllPoints();
			PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame,"TOP",0,-20);
			PlayerFrameGroupIndicatorLeft:Hide();
			PlayerFrameGroupIndicatorMiddle:Hide();
			PlayerFrameGroupIndicatorRight:Hide();
		end
		hooksecurefunc("PlayerFrame_ToPlayerArt", DarkModeUIPlayerFrame)

		--Target Frame

		function DarkModeUITargetFrame (self, forceNormalTexture)
			local classification = UnitClassification(self.unit);
			self.highLevelTexture:SetPoint("CENTER", self.levelText, "CENTER", 0,0);
			self.nameBackground:Hide();
			self.name:SetPoint("LEFT", self, 15, 36);
			self.healthbar:SetSize(119, 26);
			self.healthbar:SetPoint("TOPLEFT", 5, -24);
			self.manabar:SetPoint("TOPLEFT", 7, -52);
			self.manabar:SetSize(119, 13);

			if IsAddOnLoaded("ModernTargetFrame") then
				TargetFrameTextureFrameDeadText:SetAlpha(0)
				self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
				self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -5, 0);
				self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
				self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 8, 0);
				self.manabar.RightText:ClearAllPoints();
				self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", -5, 0);
				self.manabar.TextString:SetPoint("CENTER", self.manabar, "CENTER", 0, 0);

			end

			if ( forceNormalTexture ) then
				self.haveElite = nil;
				self.Background:SetSize(119,42);
				self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 35);
			else
				self.haveElite = true;
				self.Background:SetSize(119,42);
			end
			self.healthbar.lockColor = true;
			
		end
		hooksecurefunc("TargetFrame_CheckClassification", DarkModeUITargetFrame)

		--Target of Target Frame Texture

		TargetFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\unitframes\\UI-TargetofTargetFrame");
		TargetFrameToTHealthBar:SetHeight(8)

	else
		if IsAddOnLoaded("FormatFix") then
			TargetFrameTextureFrameDeadText:SetAlpha(0)
		end
		hooksecurefunc('TargetFrame_CheckClassification', function(self, forceNormalTexture)
			local classification = UnitClassification(self.unit);
		    if ( classification == "worldboss" or classification == "elite" ) then
			   self.borderTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\target\\elite")
			   self.borderTexture:SetVertexColor(0.05,0.05,0.05)
		    elseif ( classification == "rareelite" ) then
			   self.borderTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\target\\rare-elite")
			   self.borderTexture:SetVertexColor(0.05,0.05,0.05)
		    elseif ( classification == "rare" ) then
			   self.borderTexture:SetTexture("Interface\\Addons\\DarkModeUI\\textures\\target\\rare")
			   self.borderTexture:SetVertexColor(0.05,0.05,0.05)
		    else
			   self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
			   self.borderTexture:SetVertexColor(0.05,0.05,0.05)
			end
 	    end)
	end
end

--Health and Mana Text Shadows

PlayerFrameHealthBar.TextString:SetShadowOffset(1,-1)
PlayerFrameHealthBar.TextString:SetShadowColor(0,0,0)
PlayerFrameHealthBar.LeftText:SetShadowOffset(1,-1)
PlayerFrameHealthBar.LeftText:SetShadowColor(0,0,0)
PlayerFrameHealthBar.RightText:SetShadowOffset(1,-1)
PlayerFrameHealthBar.RightText:SetShadowColor(0,0,0)

PlayerFrameManaBar.TextString:SetShadowOffset(1,-1)
PlayerFrameManaBar.TextString:SetShadowColor(0,0,0)
PlayerFrameManaBar.LeftText:SetShadowOffset(1,-1)
PlayerFrameManaBar.LeftText:SetShadowColor(0,0,0)
PlayerFrameManaBar.RightText:SetShadowOffset(1,-1)
PlayerFrameManaBar.RightText:SetShadowColor(0,0,0)

PetFrameHealthBar.TextString:SetShadowOffset(1,-1)
PetFrameHealthBar.TextString:SetShadowColor(0,0,0)
PetFrameHealthBar.LeftText:SetShadowOffset(1,-1)
PetFrameHealthBar.LeftText:SetShadowColor(0,0,0)
PetFrameHealthBar.RightText:SetShadowOffset(1,-1)
PetFrameHealthBar.RightText:SetShadowColor(0,0,0)

PetFrameManaBar.TextString:SetShadowOffset(1,-1)
PetFrameManaBar.TextString:SetShadowColor(0,0,0)
PetFrameManaBar.LeftText:SetShadowOffset(1,-1)
PetFrameManaBar.LeftText:SetShadowColor(0,0,0)
PetFrameManaBar.RightText:SetShadowOffset(1,-1)
PetFrameManaBar.RightText:SetShadowColor(0,0,0)

if IsAddOnLoaded("ModernTargetFrame") then

	TargetFrameHealthBar.TextString:SetShadowOffset(1,-1)
	TargetFrameHealthBar.TextString:SetShadowColor(0,0,0)
	TargetFrameHealthBar.LeftText:SetShadowOffset(1,-1)
	TargetFrameHealthBar.LeftText:SetShadowColor(0,0,0)
	TargetFrameHealthBar.RightText:SetShadowOffset(1,-1)
	TargetFrameHealthBar.RightText:SetShadowColor(0,0,0)

	TargetFrameManaBar.TextString:SetShadowOffset(1,-1)
	TargetFrameManaBar.TextString:SetShadowColor(0,0,0)
	TargetFrameManaBar.LeftText:SetShadowOffset(1,-1)
	TargetFrameManaBar.LeftText:SetShadowColor(0,0,0)
	TargetFrameManaBar.RightText:SetShadowOffset(1,-1)
	TargetFrameManaBar.RightText:SetShadowColor(0,0,0)

end

function ApplyFonts()

	MinimapZoneText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_StringSize+2, DarkModeUI_StringType)

	TargetFrameTextureFrameName:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_StringSize, DarkModeUI_StringType)
	PetName:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_StringSize, DarkModeUI_StringType)
	PlayerName:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_StringSize, DarkModeUI_StringType)
	TargetFrameToTTextureFrameName:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_StringSize-2, DarkModeUI_StringType)

	CastingBarFrame.Text:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_StringSize, DarkModeUI_StringType)

    if not IsAddOnLoaded("FormatFix") then

		PlayerFrameHealthBar.TextString:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
		PlayerFrameHealthBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
		PlayerFrameHealthBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
	
		PlayerFrameManaBar.TextString:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
		PlayerFrameManaBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
		PlayerFrameManaBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
	
		PetFrameHealthBar.TextString:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize-2, DarkModeUI_NumericalsType)
		PetFrameHealthBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize-2, DarkModeUI_NumericalsType)
		PetFrameHealthBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize-2, DarkModeUI_NumericalsType)
	
		PetFrameManaBar.TextString:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize-2, DarkModeUI_NumericalsType)
		PetFrameManaBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize-2, DarkModeUI_NumericalsType)
		PetFrameManaBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize-2, DarkModeUI_NumericalsType)
		
		if IsAddOnLoaded("ModernTargetFrame") then
			TargetFrameHealthBar.TextString:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
			TargetFrameHealthBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
			TargetFrameHealthBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
	
			TargetFrameManaBar.TextString:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
			TargetFrameManaBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
			TargetFrameManaBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", DarkModeUI_NumSize, DarkModeUI_NumericalsType)
		end
	end
end

function ApplyFormat()

	if DarkModeUIOptions.format then

		local BarFormatFuncs={
			[PlayerFrameHealthBar]=function(self,textstring,val,min,max)
				textstring:SetText(AbbreviateLargeNumbers(val));
			end;
			[TargetFrameHealthBar]=function(self,textstring,val,min,max)
				if not DarkModeUIOptions.percent then textstring:SetText(AbbreviateLargeNumbers(val));
				elseif max==100 then textstring:SetText(AbbreviateLargeNumbers(val).."%");
				else textstring:SetFormattedText("%s | %.0f",AbbreviateLargeNumbers(val),100*val/max); end
			end;
		}

		BarFormatFuncs[PlayerFrameManaBar]=BarFormatFuncs[PlayerFrameHealthBar];
		BarFormatFuncs[TargetFrameManaBar]=BarFormatFuncs[PlayerFrameHealthBar];
		BarFormatFuncs[PetFrameHealthBar]=BarFormatFuncs[PlayerFrameHealthBar];
		BarFormatFuncs[PetFrameManaBar]=BarFormatFuncs[PlayerFrameHealthBar];

		hooksecurefunc("TextStatusBar_UpdateTextStringWithValues",function(self,...)
			if BarFormatFuncs[self] then
				if GetCVar("statusTextDisplay") == "NUMERIC" then
					BarFormatFuncs[self](self,...);
					(...):Show();
				end
			end
		end);
	end
end

if not IsAddOnLoaded("FormatFix") then
	PetFrameManaBar.TextString:AdjustPointsOffset(0,4)
	PetFrameManaBar.LeftText:AdjustPointsOffset(0,4)
	PetFrameManaBar.RightText:AdjustPointsOffset(0,4)
end

	function ColorRaid()
		for g = 1, NUM_RAID_GROUPS do
			local group = _G["CompactRaidGroup"..g.."BorderFrame"]
			if group then
				for _, region in pairs({group:GetRegions()}) do
					if region:IsObjectType("Texture") then
						region:SetVertexColor(0.05,0.05,0.05)
					end
				end
			end

			for m = 1, 5 do
				local frame = _G["CompactRaidGroup"..g.."Member"..m]
				if frame then
					groupcolored = true
					for _, region in pairs({frame:GetRegions()}) do
						if region:GetName():find("Border") then
							region:SetVertexColor(0.05,0.05,0.05)
						end
					end
				end
				local frame = _G["CompactRaidFrame"..m]
				if frame then
					singlecolored = true
					for _, region in pairs({frame:GetRegions()}) do
						if region:GetName():find("Border") then
							region:SetVertexColor(0.05,0.05,0.05)
						end
					end
				end
			end
		end

		for _, region in pairs({CompactRaidFrameContainerBorderFrame:GetRegions()}) do
			if region:IsObjectType("Texture") then
				region:SetVertexColor(0.05,0.05,0.05)
			end
		end
	end

	CF:SetScript("OnEvent", function(self, event)
		ColorRaid()
		CF:SetScript("OnUpdate", function()
			if CompactRaidGroup1 and not groupcolored == true then
				ColorRaid()
			end
			if CompactRaidFrame1 and not singlecolored == true then
				ColorRaid()
			end
		end)
		if event == "GROUP_ROSTER_UPDATE" then return end
		if not (IsAddOnLoaded("Shadowed Unit Frames")
				or IsAddOnLoaded("PitBull Unit Frames 4.0")
				or IsAddOnLoaded("X-Perl UnitFrames")) then
			
            for i, v in pairs({
				PlayerFrameTexture,
				PlayerFrameAlternateManaBarBorder,
				PlayerFrameAlternateManaBarLeftBorder,
				PlayerFrameAlternateManaBarRightBorder,
				PlayerFrameAlternatePowerBarBorder,
				PlayerFrameAlternatePowerBarLeftBorder,
				PlayerFrameAlternatePowerBarRightBorder,
  				PetFrameTexture,
				PartyMemberFrame1Texture,
				PartyMemberFrame2Texture,
				PartyMemberFrame3Texture,
				PartyMemberFrame4Texture,
				PartyMemberFrame1PetFrameTexture,
				PartyMemberFrame2PetFrameTexture,
				PartyMemberFrame3PetFrameTexture,
				PartyMemberFrame4PetFrameTexture,
   				TargetFrameToTTextureFrameTexture,
				FocusFrameToTTextureFrameTexture,
				CastingBarFrame.Border,
				TargetFrameSpellBar.Border,
        		MirrorTimer1Border,
        		MirrorTimer2Border,
        		MirrorTimer3Border,
			}) do
                v:SetVertexColor(0.05,0.05,0.05)
			end

			for _, region in pairs({CompactRaidFrameManager:GetRegions()}) do
				if region:IsObjectType("Texture") then
					region:SetVertexColor(0.05,0.05,0.05)
				end
			end

			for _, region in pairs({CompactRaidFrameManagerContainerResizeFrame:GetRegions()}) do
				if region:GetName():find("Border") then
					region:SetVertexColor(0.05,0.05,0.05)
				end
			end

			CompactRaidFrameManagerToggleButton:SetNormalTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidPanel-Toggle")

			hooksecurefunc("GameTooltip_ShowCompareItem", function(self, anchorFrame)
				if self then
					local shoppingTooltip1, shoppingTooltip2 = unpack(self.shoppingTooltips)
					shoppingTooltip1:SetBackdropBorderColor(0.05,0.05,0.05)
					shoppingTooltip2:SetBackdropBorderColor(0.05,0.05,0.05)
				end
			end)

			GameTooltip:SetBackdropBorderColor(0.05,0.05,0.05)
			GameTooltip.SetBackdropBorderColor = function() end

			for i, v in pairs({
				PlayerPVPIcon,
				TargetFrameTextureFramePVPIcon,
			}) do
				v:SetAlpha(0.35)
			end

			for i=1, 4 do
				_G["PartyMemberFrame"..i.."Portrait"]:AdjustPointsOffset(0, -2)
				_G["PartyMemberFrame"..i.."PVPIcon"]:SetAlpha(0)
				_G["PartyMemberFrame"..i.."NotPresentIcon"]:Hide()
				_G["PartyMemberFrame"..i.."NotPresentIcon"].Show = function() end
			end

			PlayerFrameGroupIndicator:SetAlpha(0)
			PlayerHitIndicator:SetText(nil)
			PlayerHitIndicator.SetText = function() end
			PetHitIndicator:SetText(nil)
			PetHitIndicator.SetText = function() end
		else
			CastingBarFrameBorder:SetVertexColor(0.05,0.05,0.05)
		end
	end)

 -- COLORING THE MAIN BAR
for i, v in pairs({
    MainMenuBarTexture0,
    MainMenuBarTexture1,
    MainMenuBarTexture2,
    MainMenuBarTexture3,
    MainMenuMaxLevelBar0,
    MainMenuMaxLevelBar1,
    MainMenuMaxLevelBar2,
    MainMenuMaxLevelBar3,
	MainMenuXPBarTexture0,
    MainMenuXPBarTexture1,
	MainMenuXPBarTexture2,
	MainMenuXPBarTexture3,
	MainMenuXPBarTexture4,
	ReputationWatchBar.StatusBar.WatchBarTexture0,
    ReputationWatchBar.StatusBar.WatchBarTexture1,
    ReputationWatchBar.StatusBar.WatchBarTexture2,
    ReputationWatchBar.StatusBar.WatchBarTexture3,
	ReputationWatchBar.StatusBar.XPBarTexture0,
    ReputationWatchBar.StatusBar.XPBarTexture1,
    ReputationWatchBar.StatusBar.XPBarTexture2,
    ReputationWatchBar.StatusBar.XPBarTexture3,
}) do
   v:SetVertexColor(0,0,0)
end

SlidingActionBarTexture0:SetVertexColor(0.4,0.4,0.4)
SlidingActionBarTexture1:SetVertexColor(0.4,0.4,0.4)

--Exhaustion Tick (Shows how far your rested XP goes)

ExhaustionTickNormal:SetVertexColor(0.2,0.2,0.2)

-- Ready Check Frame

local a, b, c = ReadyCheckListenerFrame:GetRegions()
	for _, v in pairs({b}) do
  		v:SetVertexColor(0.35,0.35,0.35)
	end

local function OnEvent(self, event, addon)

	-- RECOLOR CLOCK and STOPWATCH Frames
    if addon == "Blizzard_TimeManager" then
        TimeManagerClockButton:GetRegions():SetVertexColor(0.05,0.05,0.05)
		
		local allRegions = {StopwatchFrame:GetRegions()}
		for _, region in ipairs(allRegions) do
  			region:SetVertexColor(0.05,0.05,0.05)
		end
		StopwatchTabFrameLeft:SetVertexColor(0.35,0.35,0.35)
		StopwatchTabFrameMiddle:SetVertexColor(0.35,0.35,0.35)
		StopwatchTabFrameRight:SetVertexColor(0.35,0.35,0.35)
		StopwatchTabFrame:GetRegions():SetVertexColor(0.35,0.35,0.35)

		local a, b, c, d, e, f, g, h, i, j, k, l, n, o, p, q, r =  TimeManagerFrame:GetRegions()
		for _, v in pairs({a, b, c, d, e, f, g, h, i, j, k, l, n, o, p, q, r}) do
			v:SetVertexColor(0.35,0.35,0.35)
		end
    end

	-- RECOLOR TALENTS Frame
	if addon == "Blizzard_TalentUI" then
		local _, a, b, c, d, _, _, _, _, _, e, f, g = PlayerTalentFrame:GetRegions()
		for _, v in pairs({a, b, c, d, e, f, g}) do
			v:SetVertexColor(0.35,0.35,0.35)
		end
		local a, b, c, d, e, f, g, h = PlayerTalentFrameTab1:GetRegions()
			for _, v in pairs({a, b, c, d, e, f}) do
  				v:SetVertexColor(0.35,0.35,0.35)
		end
		local a, b, c, d, e, f, g, h = PlayerTalentFrameTab2:GetRegions()
			for _, v in pairs({a, b, c, d, e, f}) do
  				v:SetVertexColor(0.35,0.35,0.35)
		end
		local a, b, c, d, e, f, g, h = PlayerTalentFrameTab3:GetRegions()
			for _, v in pairs({a, b, c, d, e, f}) do
  				v:SetVertexColor(0.35,0.35,0.35)
		end
		PlayerTalentFramePortrait:AdjustPointsOffset(2,0)
    end

	-- RECOLOR TRADESKILL Frame
	if addon == "Blizzard_TradeSkillUI" then
		local _, a, b, c, d, _, e, f, g, h = TradeSkillFrame:GetRegions()

		for _, v in pairs({ a, b, c, d, e, f, g, h})do
			v:SetVertexColor(0.35,0.35,0.35)
		end
    end

	-- Unregister when finished recoloring.
	if (IsAddOnLoaded("Blizzard_TalentUI")
			and IsAddOnLoaded("Blizzard_TimeManager")
			and IsAddOnLoaded("Blizzard_TradeSkillUI")) then
		self:UnregisterEvent(event)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", OnEvent)

for i, v in pairs({
    MainMenuBarLeftEndCap,
    MainMenuBarRightEndCap,
    StanceBarLeft,
    StanceBarMiddle,
	StanceBarRight,
	GameMenuFrameHeader,
	GameMenuFrame.BottomEdge,
	GameMenuFrame.BottomLeftCorner,
	GameMenuFrame.BottomRightCorner,
	GameMenuFrame.LeftEdge,
	GameMenuFrame.RightEdge,
	GameMenuFrame.TopEdge,
	GameMenuFrame.TopLeftCorner,
	GameMenuFrame.TopRightCorner,
	InterfaceOptionsFrameHeader,
	InterfaceOptionsFrame.BottomEdge,
	InterfaceOptionsFrame.BottomLeftCorner,
	InterfaceOptionsFrame.BottomRightCorner,
	InterfaceOptionsFrame.LeftEdge,
	InterfaceOptionsFrame.RightEdge,
	InterfaceOptionsFrame.TopEdge,
	InterfaceOptionsFrame.TopLeftCorner,
	InterfaceOptionsFrame.TopRightCorner,
	VideoOptionsFrameHeader,
	VideoOptionsFrame.BottomEdge,
	VideoOptionsFrame.BottomLeftCorner,
	VideoOptionsFrame.BottomRightCorner,
	VideoOptionsFrame.LeftEdge,
	VideoOptionsFrame.RightEdge,
	VideoOptionsFrame.TopEdge,
	VideoOptionsFrame.TopLeftCorner,
	VideoOptionsFrame.TopRightCorner,
	AddonList.BotLeftCorner,
	AddonList.BotRightCorner,
	AddonList.BottomBorder,
	AddonList.LeftBorder,
	AddonList.RightBorder,
	AddonList.TopBorder,
	AddonList.TopLeftCorner,
	AddonList.TopRightCorner,
	AddonListBtnCornerLeft,
	AddonListBtnCornerRight,
	AddonListBg,
	MerchantFrameInsetInsetBottomBorder,
	TradeFrameBg,
	TradeFrameBottomBorder,
	TradeFrameButtonBottomBorder,
	TradeFrameLeftBorder,
	TradeFrameRightBorder,
	TradeFrameTitleBg,
	TradeFrameTopBorder,
	TradeFrameTopRightCorner,
	TradeRecipientLeftBorder,
	TradeFrameBtnCornerLeft,
	TradeFrameBtnCornerRight,
	TradeRecipientBG,
	TradeFramePortraitFrame,
	TradeRecipientPortraitFrame,
	TradeRecipientBotLeftCorner,
}) do
   v:SetVertexColor(0.35,0.35,0.35)
end

for i, v in pairs({
	AddonListEnableAllButton_RightSeparator,
	AddonListDisableAllButton_RightSeparator,
	AddonListCancelButton_LeftSeparator,
	AddonListOkayButton_LeftSeparator,
}) do
   v:SetVertexColor(0.5,0.5,0.5)
end

 -- RECOLOR MINIMAP
for i, v in pairs({
	MinimapBorder,
	MinimapBorderTop,
	MiniMapMailBorder,
	MiniMapTrackingBorder,
	LootFrameInsetBg,
    LootFrameTitleBg,
	MerchantFrameTitleBg,
	MiniMapBattlefieldBorder,
	MiniMapLFGBorder,
	BuybackBG,
	MerchantBuyBackItemNameFrame,
}) do
   v:SetVertexColor(0.05,0.05,0.05)
end

local a, b, c, d, e, f, g, h = MerchantFrameTab1:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = MerchantFrameTab2:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

for i, v in pairs({
    PVPReadyDialog.BottomEdge,
	PVPReadyDialog.BottomLeftCorner,
	PVPReadyDialog.BottomRightCorner,
	PVPReadyDialog.LeftEdge,
	PVPReadyDialog.RightEdge,
	PVPReadyDialog.TopEdge,
	PVPReadyDialog.TopLeftCorner,
	PVPReadyDialog.TopRightCorner,
}) do
   v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f = GuildFrame:GetRegions()
for _, v in pairs({e, f}) do
   v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d, e, f, g, h = MerchantFrameTab2:GetRegions()
	for _, v in pairs({a, b, c, d, e, f}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

for i, v in pairs({
	--LOOT FRAME
    LootFrameBg,
	LootFrameRightBorder,
    LootFrameLeftBorder,
    LootFrameTopBorder,
    LootFrameBottomBorder,
	LootFrameTopRightCorner,
    LootFrameTopLeftCorner,
    LootFrameBotRightCorner,
    LootFrameBotLeftCorner,
	LootFrameInsetInsetTopRightCorner,
	LootFrameInsetInsetTopLeftCorner,
	LootFrameInsetInsetBotRightCorner,
	LootFrameInsetInsetBotLeftCorner,
    LootFrameInsetInsetRightBorder,
    LootFrameInsetInsetLeftBorder,
    LootFrameInsetInsetTopBorder,
    LootFrameInsetInsetBottomBorder,
	LootFramePortraitFrame,
	--EACH BAG
	ContainerFrame1BackgroundTop,
	ContainerFrame1BackgroundMiddle1,
	ContainerFrame1BackgroundBottom,

	ContainerFrame2BackgroundTop,
	ContainerFrame2BackgroundMiddle1,
	ContainerFrame2BackgroundBottom,

	ContainerFrame3BackgroundTop,
	ContainerFrame3BackgroundMiddle1,
	ContainerFrame3BackgroundBottom,

	ContainerFrame4BackgroundTop,
	ContainerFrame4BackgroundMiddle1,
	ContainerFrame4BackgroundBottom,

	ContainerFrame5BackgroundTop,
	ContainerFrame5BackgroundMiddle1,
	ContainerFrame5BackgroundBottom,
	
	ContainerFrame6BackgroundTop,
	ContainerFrame6BackgroundMiddle1,
	ContainerFrame6BackgroundBottom,
	  
	ContainerFrame7BackgroundTop,
	ContainerFrame7BackgroundMiddle1,
	ContainerFrame7BackgroundBottom,
	  
	ContainerFrame8BackgroundTop,
	ContainerFrame8BackgroundMiddle1,
	ContainerFrame8BackgroundBottom,
	  
	ContainerFrame9BackgroundTop,
	ContainerFrame9BackgroundMiddle1,
	ContainerFrame9BackgroundBottom,
	  
	ContainerFrame10BackgroundTop,
	ContainerFrame10BackgroundMiddle1,
	ContainerFrame10BackgroundBottom,
	  
	ContainerFrame11BackgroundTop,
	ContainerFrame11BackgroundMiddle1,
	ContainerFrame11BackgroundBottom,

	-- Frames that's not colored for some reason
	MerchantFrameTopBorder,
	MerchantFrameBtnCornerRight,
	MerchantFrameBtnCornerLeft,
	MerchantFrameBottomRightBorder,
	MerchantFrameBottomLeftBorder,
	MerchantFrameButtonBottomBorder,
	MerchantFrameBg,
}) do
   v:SetVertexColor(0.35,0.35,0.35)
end

-- Skilltab
local a, b, c, d, e, f = SkillFrame:GetRegions()
	for _, v in pairs({a, b, c ,d, e, f}) do
		v:SetVertexColor(0.35,0.35,0.35)
end

for _, v in pairs({ReputationDetailCorner, ReputationDetailDivider}) do
    v:SetVertexColor(0.35,0.35,0.35)
end

-- Scroll Frames

local a, b = SkillListScrollFrame:GetRegions()
	for _, v in pairs({a, b}) do
		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b = SkillDetailScrollFrame:GetRegions()
	for _, v in pairs({a, b}) do
		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c = FriendsFrameFriendsScrollFrame:GetRegions()
	for _, v in pairs({a, b,c }) do
		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b = ReputationListScrollFrame:GetRegions()
	for _, v in pairs({a, b}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b = WhoListScrollFrame:GetRegions()
	for _, v in pairs({a, b}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b = GuildListScrollFrame:GetRegions()
	for _, v in pairs({a, b}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c = QuestProgressScrollFrame:GetRegions()
	for _, v in pairs({a, b, c}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c = QuestGreetingScrollFrame:GetRegions()
	for _, v in pairs({a, b, c}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c = QuestRewardScrollFrame:GetRegions()
	for _, v in pairs({a, b, c}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c = GossipGreetingScrollFrame:GetRegions()
	for _, v in pairs({a, b, c}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c = QuestDetailScrollFrame:GetRegions()
	for _, v in pairs({a, b, c}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

--Spellbook Bottom Tabs

local a, b, c, d = SpellBookFrameTabButton1:GetRegions()
	for _, v in pairs({b, d}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d = SpellBookFrameTabButton2:GetRegions()
	for _, v in pairs({b, d}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

--Spellbook Side Tabs

local a, b, c, d = SpellBookSkillLineTab1:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d = SpellBookSkillLineTab2:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d = SpellBookSkillLineTab3:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d = SpellBookSkillLineTab4:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d = SpellBookSkillLineTab5:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d = SpellBookSkillLineTab6:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

local a, b, c, d = SpellBookSkillLineTab7:GetRegions()
	for _, v in pairs({a}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

-- Flight Frame

local vectors = {TaxiFrame:GetRegions()}
for i = 2, 5 do
  vectors[i]:SetVertexColor(0.35,0.35,0.35)
end
local g = select(7, TaxiFrame:GetRegions())
g:SetVertexColor(0.7, 0.7, 0.7)

-- Quest Log Frame
local _, _, a, b, c, d = QuestLogFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
	v:SetVertexColor(0.35,0.35,0.35)
end
 
QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestLogFrame.Material:SetTexture[[Interface\AddOns\DarkModeUI\textures\quest\QuestBG.tga]]
QuestLogFrame.Material:SetWidth(514)

if IsAddOnLoaded("Leatrix_Plus") then

	function ApplyLeatrixQuest()
	
		if DarkModeUIOptions.leatrixquest then
	
			QuestLogFrame.Material:SetHeight(510)
	
		else 
			QuestLogFrame.Material:SetHeight(400)
		end
	end
else
	QuestLogFrame.Material:SetHeight(400)
end

QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame, 0, 0)
QuestLogFrame.Material:SetVertexColor(0.7,0.7,0.7)

-- Quest Reward/Hand-in Frame

local a, b, c, d, e, f, g, h, i = QuestFrameRewardPanel:GetRegions()
	for _, v in pairs({a, b, c, d, e, f, g, h, i}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

QuestFrameRewardPanel.Material = QuestFrameRewardPanel:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestFrameRewardPanel.Material:SetTexture[[Interface\AddOns\DarkModeUI\textures\quest\QuestBG.tga]]
QuestFrameRewardPanel.Material:SetWidth(514)
QuestFrameRewardPanel.Material:SetHeight(522)
QuestFrameRewardPanel.Material:SetPoint('TOPLEFT', QuestFrameRewardPanel, 22, -74)
QuestFrameRewardPanel.Material:SetVertexColor(0.7,0.7,0.7)

-- Quest Frame

local a, b, c, d, e, f, g, h, i, j = QuestFrameGreetingPanel:GetRegions()
	for _, v in pairs({a, b, c, d, e, f, g, h, i, j}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

QuestFrameGreetingPanel.Material = QuestFrameGreetingPanel:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestFrameGreetingPanel.Material:SetTexture[[Interface\AddOns\DarkModeUI\textures\quest\QuestBG.tga]]
QuestFrameGreetingPanel.Material:SetWidth(514)
QuestFrameGreetingPanel.Material:SetHeight(522)
QuestFrameGreetingPanel.Material:SetPoint('TOPLEFT', QuestFrameGreetingPanel, 22, -74)
QuestFrameGreetingPanel.Material:SetVertexColor(0.7,0.7,0.7)

-- Dressing Room Frame

local a, b, c, d, e, f, g, h, i, j = DressUpFrame:GetRegions()
	for _, v in pairs({b, c, d, e}) do
  		v:SetVertexColor(0.35,0.35,0.35)
end

--Target of Target And Pet Frame Alignments

TargetFrameToTBackground:AdjustPointsOffset(2,2)
TargetFrameToTPortrait:SetScale(1.1)
TargetFrameToTPortrait:AdjustPointsOffset(-3,3)
PetFrameHealthBar:AdjustPointsOffset(-1,-1)
PetFrameManaBar:AdjustPointsOffset(-1,-1)

--Minimap Alignment & Hiding World Map Button and Top Border

MiniMapWorldMapButton:SetAlpha(0)
MinimapBorderTop:SetAlpha(0)
MinimapZoneText:SetPoint('CENTER', Minimap, 'TOP', 0, 10)
MinimapZoneText:SetShadowOffset(2,-2)
MinimapZoneText:SetShadowColor(0,0,0)

--Tooptip HP Bar Alignment

GameTooltipStatusBar:AdjustPointsOffset(0,8)
GameTooltipStatusBar:SetSize(1,2)

--System Counter

StatsFrame = CreateFrame("Frame", "StatsFrame", UIParent)

StatsFrame:ClearAllPoints()
StatsFrame:SetPoint('TOPLEFT', UIParent, "TOPLEFT")
StatsFrame:SetClampedToScreen(true)
StatsFrame:SetMovable(true)
StatsFrame:SetUserPlaced(true)
StatsFrame:SetFrameLevel(4)
StatsFrame:SetScript("OnMouseDown",	function()
		if (IsAltKeyDown()) then
			StatsFrame:ClearAllPoints()
			StatsFrame:StartMoving()
		end
	end
)
StatsFrame:SetScript("OnMouseUp", function()
	StatsFrame:StopMovingOrSizing()
end)

local DarkModeUI=CreateFrame("Frame")
DarkModeUI:RegisterEvent("PLAYER_LOGIN")
DarkModeUI:SetScript("OnEvent", function(self, event)

local font = STANDARD_TEXT_FONT
local fontSize = 12
local fontFlag = "OUTLINE"
local textAlign = "CENTER"
local customColor = UnitClass

local color
if customColor == false then
	color = {r = 1, g = 1, b = 1}
else
	local _, class = UnitClass("player")
	color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
end

local function getFPS()
	return "|c00ffffff" .. floor(GetFramerate()) .. "|r fps"
end

local function getLatencyWorld()
	return "|c00ffffff" .. select(4, GetNetStats()) .. "|r ms"
end

local function getLatency()
	return "|c00ffffff" .. select(3, GetNetStats()) .. "|r ms"
end

StatsFrame:SetWidth(50)
StatsFrame:SetHeight(fontSize)
StatsFrame.text = StatsFrame:CreateFontString(nil, "BACKGROUND")
StatsFrame.text:SetPoint(textAlign, StatsFrame)
StatsFrame.text:SetFont(font, 12, fontFlag)
StatsFrame.text:SetShadowOffset(1,-1)
StatsFrame.text:SetShadowColor(0,0,0)
StatsFrame.text:SetTextColor(color.r, color.g, color.b)

local lastUpdate = 0

local function update(self, elapsed)
	lastUpdate = lastUpdate + elapsed
	if lastUpdate > 1 then
		lastUpdate = 0
		if showClock == true then
			StatsFrame.text:SetText(getFPS() .. " " .. getLatency())
		else
			StatsFrame.text:SetText(getFPS() .. " " .. getLatency())
		end
		self:SetWidth(StatsFrame.text:GetStringWidth())
		self:SetHeight(StatsFrame.text:GetStringHeight())
	end
end

StatsFrame:SetScript("OnUpdate", update)

end)

function ApplyStatsTracker()
	
    if not DarkModeUIOptions.statstracker then

		StatsFrame:Hide()

	end
end

--Player, Target, and Target Name Background Bar Textures

function ApplyFlatBars()
	
    if DarkModeUIOptions.flatbars then
        
		TargetFrameNameBackground:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat")
		PlayerFrame.healthbar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat");
		TargetFrame.healthbar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat");

		--Party Frames Health Bar Textures

		for i=1, 4 do
			_G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat")
		end

		--Mirror Timers Textures (Breath meter, etc)

		MirrorTimer1StatusBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat")
		MirrorTimer2StatusBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat")
		MirrorTimer3StatusBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat")

		--Castbar Bar Texture

		CastingBarFrame:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat")

		--Pet Frame Bar Textures

		PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat");
		TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat");

		--Tooltip Health Bar Texture

		GameTooltipStatusBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat")

		--XP and Rep Bar Textures

		ReputationWatchBar.StatusBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat");
		MainMenuExpBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat");

		--Mana Bar Texture

		function DarkModeUIManaTexture (manaBar)
			local powerType, powerToken, altR, altG, altB = UnitPowerType(manaBar.unit);
			local info = PowerBarColor[powerToken];
			if ( info ) then
				if ( not manaBar.lockColor ) then
						manaBar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\flat");
				end
			end
		end
		hooksecurefunc("UnitFrameManaBar_UpdateType", DarkModeUIManaTexture)
	end
end

--Castbar

function ApplyCastBar()
	
    if DarkModeUIOptions.castbar then

		CastingBarFrame:SetScale(1)
		CastingBarFrame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
		CastingBarFrame.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")
		CastingBarFrame.Spark:SetHeight(50)
		CastingBarFrame.Text:ClearAllPoints()
		CastingBarFrame.Text:SetPoint("CENTER", 0, 1)
		CastingBarFrame.Border:SetWidth(CastingBarFrame.Border:GetWidth() + 4)
		CastingBarFrame.Flash:SetWidth(CastingBarFrame.Flash:GetWidth() + 4)
		CastingBarFrame.BorderShield:SetWidth(CastingBarFrame.BorderShield:GetWidth() + 4)
		CastingBarFrame.Border:SetPoint("TOP", 0, 26)
		CastingBarFrame.Flash:SetPoint("TOP", 0, 26)
		CastingBarFrame.BorderShield:SetPoint("TOP", 0, 26)
		
	end
end



--Combo Points

local a, b, c = ComboPoint1:GetRegions()
for _, v in pairs({a}) do
	v:SetVertexColor(0.05,0.05,0.05)
end

local a, b, c = ComboPoint2:GetRegions()
for _, v in pairs({a}) do
	v:SetVertexColor(0.05,0.05,0.05)
end

local a, b, c = ComboPoint3:GetRegions()
for _, v in pairs({a}) do
	v:SetVertexColor(0.05,0.05,0.05)
end

local a, b, c = ComboPoint4:GetRegions()
for _, v in pairs({a}) do
	v:SetVertexColor(0.05,0.05,0.05)
end

local a, b, c = ComboPoint5:GetRegions()
for _, v in pairs({a}) do
	v:SetVertexColor(0.05,0.05,0.05)
end

--Chat Editbox

ChatFrame1EditBoxLeft:SetVertexColor(0.2,0.2,0.2)
ChatFrame1EditBoxMid:SetVertexColor(0.2,0.2,0.2)
ChatFrame1EditBoxRight:SetVertexColor(0.2,0.2,0.2)

--Class Portraits

function ApplyClassPortraits()
	
    if DarkModeUIOptions.classportraits then

		hooksecurefunc("UnitFramePortrait_Update",function(self)
			if self.unit == "player" or self.unit == "pet" then
				return
			end
			if self.portrait then
				if UnitIsPlayer(self.unit) then			
					local t = CLASS_ICON_TCOORDS[select(2,UnitClass(self.unit))]
					if t then
						self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
						self.portrait:SetTexCoord(unpack(t))
					end
				else
					self.portrait:SetTexCoord(0,1,0,1)
				end
			end
		end);
	end
end
--Chat Tabs - Doesn't work on whisper tabs

for i=1, 9 do
	_G["ChatFrame"..i.."TabLeft"]:SetVertexColor(0.25,0.25,0.25)
	_G["ChatFrame"..i.."TabMiddle"]:SetVertexColor(0.25,0.25,0.25)
	_G["ChatFrame"..i.."TabRight"]:SetVertexColor(0.25,0.25,0.25)
end

--Popup Frames for Duels, Guild Invites, etc

for i, v in pairs({
	StaticPopup1.BottomEdge,
	StaticPopup1.BottomLeftCorner,
	StaticPopup1.BottomRightCorner,
	StaticPopup1.LeftEdge,
	StaticPopup1.RightEdge,
	StaticPopup1.TopEdge,
	StaticPopup1.TopLeftCorner,
	StaticPopup1.TopRightCorner,
	StaticPopup2.BottomEdge,
	StaticPopup2.BottomLeftCorner,
	StaticPopup2.BottomRightCorner,
	StaticPopup2.LeftEdge,
	StaticPopup2.RightEdge,
	StaticPopup2.TopEdge,
	StaticPopup2.TopLeftCorner,
	StaticPopup2.TopRightCorner,
	StaticPopup3.BottomEdge,
	StaticPopup3.BottomLeftCorner,
	StaticPopup3.BottomRightCorner,
	StaticPopup3.LeftEdge,
	StaticPopup3.RightEdge,
	StaticPopup3.TopEdge,
	StaticPopup3.TopLeftCorner,
	StaticPopup3.TopRightCorner,
	StaticPopup4.BottomEdge,
	StaticPopup4.BottomLeftCorner,
	StaticPopup4.BottomRightCorner,
	StaticPopup4.LeftEdge,
	StaticPopup4.RightEdge,
	StaticPopup4.TopEdge,
	StaticPopup4.TopLeftCorner,
	StaticPopup4.TopRightCorner,
}) do
	v:SetVertexColor(0.35,0.35,0.35)
end

for i, v in pairs({
	StaticPopup1.Center:SetScale(1.1),
	StaticPopup2.Center:SetScale(1.1),
	StaticPopup3.Center:SetScale(1.1),
	StaticPopup4.Center:SetScale(1.1),
}) do
	v:SetVertexColor(0.35,0.35,0.35)
end

--Class Color Healthbars

function ApplyClassBars()
	
    if DarkModeUIOptions.classbars then
        
		function Healthcolor(healthbar, unit)
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
				_, class = UnitClass(unit);
				local c = RAID_CLASS_COLORS[class];
				healthbar:SetStatusBarColor(c.r, c.g, c.b);
			elseif UnitIsPlayer(unit) and (not UnitIsConnected(unit)) then
				healthbar:SetStatusBarColor(0.5,0.5,0.5);
			else
				healthbar:SetStatusBarColor(0,0.9,0);
			end
		end
		hooksecurefunc("UnitFrameHealthBar_Update", Healthcolor)
		hooksecurefunc("HealthBar_OnValueChanged", function(self)
			Healthcolor(self, self.unit)
		end)
	end
end

--Hiding Pet Bar Background

function ApplyPetBarBackground()
	
    if DarkModeUIOptions.petbarbackground then

		for i, v in pairs({
			SlidingActionBarTexture0,
			SlidingActionBarTexture1
		}) do
		v:SetAlpha(0)
		end
	end
end

--Hiding Pet Bar Hotkeys

function ApplyPetBarHotkey()
	if not IsAddOnLoaded("Dominos") and not IsAddOnLoaded("Bartender4") then
		if DarkModeUIOptions.petbarhotkey then

			for i=1, 10 do
				_G["PetActionButton"..i.."HotKey"]:Hide()
			end
		end
	end
end

function ApplyBarHotkey()
	if not IsAddOnLoaded("Dominos") and not IsAddOnLoaded("Bartender4") then
		if DarkModeUIOptions.barhotkey then

			for i=1, 12 do
				_G["ActionButton"..i.."HotKey"]:Hide()
				_G["MultiBarBottomLeftButton"..i.."HotKey"]:Hide()
				_G["MultiBarBottomRightButton"..i.."HotKey"]:Hide()
				_G["MultiBarLeftButton"..i.."HotKey"]:Hide()
				_G["MultiBarRightButton"..i.."HotKey"]:Hide()
			end
		end
	end
end

--Hiding Stance Bar

function ApplyStanceBar()
	
    if DarkModeUIOptions.stancebar then
        
		StanceBarFrame:SetAlpha(0)
	end
end

--Raid Frames

local f = CreateFrame("Frame")
f:SetScript("OnEvent",function(self, event, ...)

local n, w, h = "CompactUnitFrameProfilesGeneralOptionsFrame"
h, w = _G[n .. "HeightSlider"], _G[n .. "WidthSlider"]
h:SetMinMaxValues(1, 200)
w:SetMinMaxValues(1, 200)

local function RaidFrameUpdate()
	local i, bar = 1
	repeat
    	bar = _G["CompactRaidFrame" .. i .. "HealthBar"]
		rbar = _G["CompactRaidFrame" .. i .. "PowerBar"]
		Divider = _G["CompactRaidFrame" .. i .. "HorizDivider"]
		vleftseparator = _G["CompactRaidFrame" .. i .. "VertLeftBorder"]
		vrightseparator = _G["CompactRaidFrame" .. i .. "VertRightBorder"]
		htopseparator = _G["CompactRaidFrame" .. i .. "HorizTopBorder"]
		hbotseparator = _G["CompactRaidFrame" .. i .. "HorizBottomBorder"]
		name = _G["CompactRaidFrame" .. i .. "Name"]
    
	if bar then

		if DarkModeUIOptions.flatbars == true then
			bar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\Raid-Bar-Hp-Fill")
			rbar:SetStatusBarTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\Raid-Bar-Resource-Fill")
	  	end

		vleftseparator:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\Raid-VSeparator")
		vrightseparator:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\Raid-VSeparator")
		htopseparator:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\Raid-HSeparator")
		hbotseparator:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\Raid-HSeparator")
		Divider:SetVertexColor(.3, .3, .3)
		name:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
		name:SetPoint('TOPLEFT', bar, 2, -2)
    end
    i = i + 1
  until not bar
end

	if CompactRaidFrameContainer_AddUnitFrame then
    self:UnregisterAllEvents()
		hooksecurefunc("CompactRaidFrameContainer_AddUnitFrame", RaidFrameUpdate)
		CompactRaidFrameContainerBorderFrameBorderTopLeft:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-UpperLeft")
		CompactRaidFrameContainerBorderFrameBorderTop:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-UpperMiddle")
		CompactRaidFrameContainerBorderFrameBorderTopRight:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-UpperRight")
		CompactRaidFrameContainerBorderFrameBorderLeft:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-Left")
		CompactRaidFrameContainerBorderFrameBorderRight:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-Right")
		CompactRaidFrameContainerBorderFrameBorderBottomLeft:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-BottomLeft")
		CompactRaidFrameContainerBorderFrameBorderBottom:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-BottomMiddle")
		CompactRaidFrameContainerBorderFrameBorderBottomRight:SetTexture("Interface\\AddOns\\DarkModeUI\\textures\\raid\\RaidBorder-BottomRight")
    end

--Raid Buffs

for i = 1, 4 do
	local f = _G["PartyMemberFrame" .. i]
	f:UnregisterEvent("UNIT_AURA")
	local g = CreateFrame("Frame")
	g:RegisterEvent("UNIT_AURA")
	g:SetScript(
		"OnEvent",
		function(self, event, a1)
			if a1 == f.unit then
				RefreshDebuffs(f, a1, 20, nil, 1)
			else
				if a1 == f.unit .. "pet" then
					PartyMemberFrame_RefreshPetDebuffs(f)
				end
			end
		end
	)
	local b = _G[f:GetName() .. "Debuff1"]
	b:ClearAllPoints()
	b:SetPoint("LEFT", f, "RIGHT", -7, 5)
	for j = 5, 20 do
		local l = f:GetName() .. "Debuff"
		local n = l .. j
		local c = CreateFrame("Frame", n, f, "PartyDebuffFrameTemplate")
		c:SetPoint("LEFT", _G[l .. (j - 1)], "RIGHT")
	end

function ApplyPartyBuffs()
	
	if DarkModeUIOptions.partybuffs then
			
		for i = 1, 4 do
			local f = _G["PartyMemberFrame" .. i]
			f:UnregisterEvent("UNIT_AURA")
			local g = CreateFrame("Frame")
			g:RegisterEvent("UNIT_AURA")
			g:SetScript(
				"OnEvent",
				function(self, event, a1)
					if a1 == f.unit then
						RefreshBuffs(f, a1, 20, nil, 1)
					end
				end
			)
			for j = 1, 20 do
				local l = f:GetName() .. "Buff"
				local n = l .. j
				local c = CreateFrame("Frame", n, f, "TargetBuffFrameTemplate")
				c:EnableMouse(false)
				if j == 1 then
					c:SetPoint("TOPLEFT", 48, -32)
				else
					c:SetPoint("LEFT", _G[l .. (j - 1)], "RIGHT", 1, 0)
				end
			end
		end
		
	end
end

end

end)
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")