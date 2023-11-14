  -- // Dark Mode UI (Classic WoW Season of Mastery)
  -- // Lorti - 2016
  -- // Sinope - 2021
  -- // Johnnieboi - 2021
  
  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...

  --generate a holder for the config data
  local cfg = CreateFrame("Frame")

  -----------------------------
  -- CONFIG
  -----------------------------

-- action bars settings

  cfg.textures = {
    normal            = "Interface\\AddOns\\DarkModeUI\\textures\\gloss",
    flash             = "Interface\\AddOns\\DarkModeUI\\textures\\flash",
    hover             = "Interface\\AddOns\\DarkModeUI\\textures\\hover",
    pushed            = "Interface\\AddOns\\DarkModeUI\\textures\\pushed",
    checked           = "Interface\\AddOns\\DarkModeUI\\textures\\checked",
    equipped          = "Interface\\AddOns\\DarkModeUI\\textures\\gloss_grey",
    buttonback        = "Interface\\AddOns\\DarkModeUI\\textures\\button_background",
    buttonbackflat    = "Interface\\AddOns\\DarkModeUI\\textures\\button_background_flat",
    outer_shadow      = "Interface\\AddOns\\DarkModeUI\\textures\\outer_shadow",
  }

  cfg.background = {
    showbg            = true,   --show a background image?
    showshadow        = true,   --show an outer shadow?
    useflatbackground = false,  --true uses plain flat color instead
    backgroundcolor   = { r = 0.2, g = 0.2, b = 0.2, a = 0.3 },
    shadowcolor       = { r = 0, g = 0, b = 0, a = 0.9 },
    classcolored      = false,
    inset             = 5,
  }

  cfg.color = {
    normal            = { r = 0.37, g = 0.3, b = 0.3, },
    equipped          = { r = 0.1, g = 0.5, b = 0.1, },
    classcolored      = false,
  }

  cfg.hotkeys = {
    show             = true,
    fontsize         = 12,
    pos1             = { a1 = "TOPRIGHT", x = 0, y = 0 },
    pos2             = { a1 = "TOPLEFT", x = 0, y = 0 }, --important! two points are needed to make the hotkeyname be inside of the button
  }

  cfg.macroname = {
    show             = true,
    fontsize         = 12,
    pos1             = { a1 = "BOTTOMLEFT", x = 0, y = 0 },
    pos2             = { a1 = "BOTTOMRIGHT", x = 0, y = 0 }, --important! two points are needed to make the macroname be inside of the button
  }

  cfg.itemcount = {
    show             = true,
    fontsize         = 12,
    pos1             = { a1 = "BOTTOMRIGHT", x = 0, y = 0 },
  }

  cfg.cooldown = {
    spacing          = 0,
  }

  cfg.font = STANDARD_TEXT_FONT

  --adjust the oneletter abbrev?
  cfg.adjustOneletterAbbrev = true
  
  --scale of the consolidated tooltip
  cfg.consolidatedTooltipScale = 1.2
  
  --combine buff and debuff frame - should buffs and debuffs be displayed in one single frame?
  --if you disable this it is intended that you unlock the buff and debuffs and move them apart!
  cfg.combineBuffsAndDebuffs = true

-- buff frame settings

  cfg.buffFrame = {
    pos                 = { a1 = "TOPRIGHT", af = "Minimap", a2 = "TOPLEFT", x = -35, y = 0 },
    gap                 = 30, --gap between buff and debuff rows
    userplaced          = true, --want to place the bar somewhere else?
    rowSpacing          = 10,
    colSpacing          = 7,
    buttonsPerRow       = 16,
    button = {
      size              = 28,
    },
    icon = {
      padding           = -2,
    },
    border = {
      texture           = "Interface\\AddOns\\DarkModeUI\\textures\\gloss",
      color             = { r = 0.4, g = 0.35, b = 0.35, },
      classcolored      = false,
    },
    background = {
      show              = true,   --show backdrop
      edgeFile          = "Interface\\AddOns\\DarkModeUI\\textures\\outer_shadow",
      color             = { r = 0, g = 0, b = 0, a = 0.9},
      classcolored      = false,
      inset             = 6,
      padding           = 4,
    },
    duration = {
      font              = STANDARD_TEXT_FONT,
      size              = 11,
      pos               = { a1 = "BOTTOM", x = 0, y = 0 },
    },
    count = {
      font              = STANDARD_TEXT_FONT,
      size              = 11,
      pos               = { a1 = "TOPRIGHT", x = 0, y = 0 },
    },
  }
  
-- debuff frame settings

  cfg.debuffFrame = {
    pos = {
      a1 = "TOPRIGHT",
      af = "Minimap",
      a2 = "TOPLEFT",
      x = -35,
      y = -85
    },
    gap                 = 10, --gap between buff and debuff rows
    userplaced          = true, --want to place the bar somewhere else?
    rowSpacing          = 10,
    colSpacing          = 7,
    buttonsPerRow       = 10,
    button = {
      size              = 28,
    },
    icon = {
      padding           = -2,
    },
    border = {
      texture           = "Interface\\AddOns\\DarkModeUI\\textures\\gloss",
      color             = { r = 0.4, g = 0.35, b = 0.35, },
      classcolored      = false,
    },
    background = {
      show              = true,   --show backdrop
      edgeFile          = "Interface\\AddOns\\DarkModeUI\\textures\\outer_shadow",
      color             = { r = 0, g = 0, b = 0, a = 0.9},
      classcolored      = false,
      inset             = 6,
      padding           = 4,
    },
    duration = {
      font              = STANDARD_TEXT_FONT,
      size              = 11,
      pos               = { a1 = "BOTTOM", x = 0, y = 0 },
    },
    count = {
      font              = STANDARD_TEXT_FONT,
      size              = 11,
      pos               = { a1 = "TOPRIGHT", x = 0, y = 0 },
    },
  }

--Config

DarkModeUIOptions = {thickness, flatbars, classbars, castbar, classportraits, statstracker, partybuffs, stancebar, petbarbackground, petbarhotkey, barhotkey, leatrixquest, buffborder, format, percent, stringtype, numericaltype}

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function f:PLAYER_LOGIN()

    if DarkModeUIOptions.thickness == nil then
    	DarkModeUIOptions.thickness = false
    end
    
	if DarkModeUIOptions.flatbars == nil then
		DarkModeUIOptions.flatbars = false
	end

	if DarkModeUIOptions.classbars == nil then
		DarkModeUIOptions.classbars = false
	end

	if DarkModeUIOptions.castbar == nil then
		DarkModeUIOptions.castbar = false
	end

	if DarkModeUIOptions.classportraits == nil then
		DarkModeUIOptions.classportraits = false
	end

	if DarkModeUIOptions.statstracker == nil then
		DarkModeUIOptions.statstracker = false
	end

	if DarkModeUIOptions.partybuffs == nil then
		DarkModeUIOptions.partybuffs = false
	end

  if DarkModeUIOptions.buffborder == nil then
		DarkModeUIOptions.buffborder = true
	end

	if DarkModeUIOptions.format == nil then
		DarkModeUIOptions.format = false
	end

  if DarkModeUIOptions.percent == nil then
		DarkModeUIOptions.percent = false
	end

	if DarkModeUIOptions.stancebar == nil then
		DarkModeUIOptions.stancebar = false
	end

	if DarkModeUIOptions.petbarbackground == nil then
		DarkModeUIOptions.petbarbackground = false
	end

	if DarkModeUIOptions.petbarhotkey == nil then
		DarkModeUIOptions.petbarhotkey = false
	end

	if DarkModeUIOptions.barhotkey == nil then
		DarkModeUIOptions.barhotkey = false
	end

	if DarkModeUIOptions.leatrixquest == nil then
		DarkModeUIOptions.leatrixquest = false
	end

	if DarkModeUI_StringSize == nil then
		DarkModeUI_StringSize = 12
	end

	if DarkModeUIOptions.stringtype == nil then
		DarkModeUIOptions.stringtype = true
	end
	
	if DarkModeUI_NumSize == nil then
		DarkModeUI_NumSize = 12
	end

	if DarkModeUIOptions.numericaltype == nil then
		DarkModeUIOptions.numericaltype = true
	end

    f.optionsPanel = f:CreateGUI()
    
  ApplyThickness()
	ApplyFlatBars()
	ApplyClassBars()
	ApplyCastBar()
	ApplyClassPortraits()
	ApplyStatsTracker()
	ApplyPartyBuffs()
	ApplyStanceBar()
	ApplyPetBarBackground()
	ApplyPetBarHotkey()
	ApplyBarHotkey()
	ApplyFonts()
  ApplyFormat()
	if IsAddOnLoaded("Leatrix_Plus") then
		ApplyLeatrixQuest()
	end
end

function f:CreateGUI()
    local Panel=CreateFrame("Frame")
    Panel.name="Dark Mode Classic";
    InterfaceOptions_AddCategory(Panel);

    local title=Panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
    title:SetPoint("TOPLEFT",12,-15);
    title:SetText("Dark Mode Classic");
    title:SetFont("Fonts\\FRIZQT__.TTF", 30, "THICKOUTLINE");

    local ThickFramesButton = CreateFrame("CheckButton", "ThickFramesButton_Name", Panel, "ChatConfigCheckButtonTemplate")
    ThickFramesButton:SetPoint("TOPLEFT", 10, -60)
    ThickFramesButton_NameText:SetText("Thick Frames")
	  ThickFramesButton_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    ThickFramesButton:SetChecked(DarkModeUIOptions.thickness)
    ThickFramesButton:SetScript("OnClick", function(ThickFramesButton)
        DarkModeUIOptions.thickness = ThickFramesButton:GetChecked()
        ApplyThickness()
    end)

	local FlatBarsButton = CreateFrame("CheckButton", "FlatBarsButton_Name", Panel, "ChatConfigCheckButtonTemplate")
    FlatBarsButton:SetPoint("TOPLEFT", 10, -90)
    FlatBarsButton_NameText:SetText("Flat Bar Textures")
	  FlatBarsButton_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    FlatBarsButton:SetChecked(DarkModeUIOptions.flatbars)
    FlatBarsButton:SetScript("OnClick", function(FlatBarsButton)
        DarkModeUIOptions.flatbars = FlatBarsButton:GetChecked()
        ApplyFlatBars()
    end)

	local ClassBarsButton = CreateFrame("CheckButton", "ClassBarsButton_Name", Panel, "ChatConfigCheckButtonTemplate")
    ClassBarsButton:SetPoint("TOPLEFT", 10, -120)
    ClassBarsButton_NameText:SetText("Class Health Bars")
	  ClassBarsButton_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    ClassBarsButton:SetChecked(DarkModeUIOptions.classbars)
    ClassBarsButton:SetScript("OnClick", function(ClassBarsButton)
        DarkModeUIOptions.classbars = ClassBarsButton:GetChecked()
        ApplyClassBars()
    end)

	local CastBarButton = CreateFrame("CheckButton", "CastBarButton_Name", Panel, "ChatConfigCheckButtonTemplate")
    CastBarButton:SetPoint("TOPLEFT", 10, -150)
    CastBarButton_NameText:SetText("Smooth Corners Cast Bar")
	  CastBarButton_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    CastBarButton:SetChecked(DarkModeUIOptions.castbar)
    CastBarButton:SetScript("OnClick", function(CastBarButton)
        DarkModeUIOptions.castbar = CastBarButton:GetChecked()
        ApplyCastBar()
    end)

	local ClassPortraits = CreateFrame("CheckButton", "ClassPortraits_Name", Panel, "ChatConfigCheckButtonTemplate")
    ClassPortraits:SetPoint("TOPLEFT", 10, -180)
    ClassPortraits_NameText:SetText("Class Portraits")
  	ClassPortraits_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    ClassPortraits:SetChecked(DarkModeUIOptions.classportraits)
    ClassPortraits:SetScript("OnClick", function(ClassPortraits)
        DarkModeUIOptions.classportraits = ClassPortraits:GetChecked()
        ApplyClassPortraits()
    end)

	local StatsTracker = CreateFrame("CheckButton", "StatsTracker_Name", Panel, "ChatConfigCheckButtonTemplate")
    StatsTracker:SetPoint("TOPLEFT", 10, -210)
    StatsTracker_NameText:SetText("System Stats Tracker (fps/ms)")
	  StatsTracker_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    StatsTracker:SetChecked(DarkModeUIOptions.statstracker)
    StatsTracker:SetScript("OnClick", function(StatsTracker)
        DarkModeUIOptions.statstracker = StatsTracker:GetChecked()
        ApplyStatsTracker()
    end)

	local PartyBuffs = CreateFrame("CheckButton", "PartyBuffs_Name", Panel, "ChatConfigCheckButtonTemplate")
    PartyBuffs:SetPoint("TOPLEFT", 10, -240)
    PartyBuffs_NameText:SetText("Show Party Frame Buffs")
	  PartyBuffs_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    PartyBuffs:SetChecked(DarkModeUIOptions.partybuffs)
    PartyBuffs:SetScript("OnClick", function(PartyBuffs)
        DarkModeUIOptions.partybuffs = PartyBuffs:GetChecked()
        ApplyPartyBuffs()
    end)

  local BuffBorder = CreateFrame("CheckButton", "BuffBorder_Name", Panel, "ChatConfigCheckButtonTemplate")
    BuffBorder:SetPoint("TOPLEFT", 10, -270)
    BuffBorder_NameText:SetText("Buff Borders")
    BuffBorder_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    BuffBorder.tooltip = "Adds borders to debuffs, eg. Poisons=Green, Disease=Yellow, etc. Weapon buffs always show"
    BuffBorder:SetChecked(DarkModeUIOptions.buffborder)
    BuffBorder:SetScript("OnClick", function(BuffBorder)
        DarkModeUIOptions.buffborder = BuffBorder:GetChecked()
    end)

  local Format = CreateFrame("CheckButton", "Format_Name", Panel, "ChatConfigCheckButtonTemplate")
    Format:SetPoint("TOPLEFT", 10, -300)
    Format_NameText:SetText("Current HP/Mana Value Format")
    Format_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    Format.tooltip = "Shows health and mana as current value (Needs Status Text under Display in Interface Options set to Numeric Value)"
    Format:SetChecked(DarkModeUIOptions.format)
    Format:SetScript("OnClick", function(Format)
        DarkModeUIOptions.format = Format:GetChecked()
        ApplyFormat()
    end)

  local Percent = CreateFrame("CheckButton", "Percent_Name", Panel, "ChatConfigCheckButtonTemplate")
    Percent:SetPoint("TOPLEFT", 10, -330)
    Percent_NameText:SetText("Target HP as Current Value and Percent")
    Percent_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    Percent.tooltip = "Requires the above option checked, Modern TargetFrame Addon, and Status Text set to Numeric Value"
    Percent:SetChecked(DarkModeUIOptions.percent)
    Percent:SetScript("OnClick", function(Percent)
        DarkModeUIOptions.percent = Percent:GetChecked()
    end)

	local StanceBar = CreateFrame("CheckButton", "StanceBar_Name", Panel, "ChatConfigCheckButtonTemplate")
    StanceBar:SetPoint("TOPLEFT", 300, -60)
    StanceBar_NameText:SetText("Hide Stance Bar (Turns invisible)")
	  StanceBar_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    StanceBar:SetChecked(DarkModeUIOptions.stancebar)
    StanceBar:SetScript("OnClick", function(StanceBar)
        DarkModeUIOptions.stancebar = StanceBar:GetChecked()
        ApplyStanceBar()
    end)

	local PetBarBackground = CreateFrame("CheckButton", "PetBarBackground_Name", Panel, "ChatConfigCheckButtonTemplate")
    PetBarBackground:SetPoint("TOPLEFT", 300, -90)
    PetBarBackground_NameText:SetText("Hide Pet Bar Background")
  	PetBarBackground_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    PetBarBackground.tooltip = "Hides the background that shows behind pet bars when the bottom left actionbar isn't activated"
    PetBarBackground:SetChecked(DarkModeUIOptions.petbarbackground)
    PetBarBackground:SetScript("OnClick", function(PetBarBackground)
        DarkModeUIOptions.petbarbackground = PetBarBackground:GetChecked()
        ApplyPetBarBackground()
    end)

	local BarHotkey = CreateFrame("CheckButton", "BarHotkey_Name", Panel, "ChatConfigCheckButtonTemplate")
    BarHotkey:SetPoint("TOPLEFT", 300, -120)
    BarHotkey_NameText:SetText("Hide Player Bar Hotkeys")
  	BarHotkey_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    BarHotkey:SetChecked(DarkModeUIOptions.barhotkey)
    BarHotkey:SetScript("OnClick", function(BarHotkey)
        DarkModeUIOptions.barhotkey = BarHotkey:GetChecked()
        ApplyBarHotkey()
    end)

	local PetBarHotkey = CreateFrame("CheckButton", "PetBarHotkey_Name", Panel, "ChatConfigCheckButtonTemplate")
    PetBarHotkey:SetPoint("TOPLEFT", 300, -150)
    PetBarHotkey_NameText:SetText("Hide Pet Bar Hotkeys")
  	PetBarHotkey_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    PetBarHotkey:SetChecked(DarkModeUIOptions.petbarhotkey)
    PetBarHotkey:SetScript("OnClick", function(PetBarHotkey)
        DarkModeUIOptions.petbarhotkey = PetBarHotkey:GetChecked()
        ApplyPetBarHotkey()
    end)

	local LeatrixQuest = CreateFrame("CheckButton", "LeatrixQuest_Name", Panel, "ChatConfigCheckButtonTemplate")
    LeatrixQuest:SetPoint("TOPLEFT", 300, -180)
    LeatrixQuest_NameText:SetText("Leatrix Enhanced Quest Log")
  	LeatrixQuest_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    LeatrixQuest.tooltip = "Compatibility fix for Leatrix Plus' Extended Quest Log setting"
    LeatrixQuest:SetChecked(DarkModeUIOptions.leatrixquest)
    LeatrixQuest:SetScript("OnClick", function(LeatrixQuest)
        DarkModeUIOptions.leatrixquest = LeatrixQuest:GetChecked()
        ApplyLeatrixQuest()
    end)

	local StringType = CreateFrame("CheckButton", "StringType_Name", Panel, "ChatConfigCheckButtonTemplate")
    StringType:SetPoint("TOPLEFT", 300, -210)
    StringType_NameText:SetText("Names Outline")
  	StringType_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    StringType:SetChecked(DarkModeUIOptions.stringtype)
    StringType:SetScript("OnClick", function(StringType)
      DarkModeUIOptions.stringtype = StringType:GetChecked()
		if DarkModeUIOptions.stringtype then
			DarkModeUI_StringType = "OUTLINE"
		else
			DarkModeUI_StringType = "THIN"
		end
        ApplyFonts()
    end)
	    DarkModeUIOptions.stringtype = StringType:GetChecked()
		if DarkModeUIOptions.stringtype then
			DarkModeUI_StringType = "OUTLINE"
		else
			DarkModeUI_StringType = "THIN"
		end
        ApplyFonts()

	local NumericalsType = CreateFrame("CheckButton", "NumericalsType_Name", Panel, "ChatConfigCheckButtonTemplate")
    NumericalsType:SetPoint("TOPLEFT", 300, -240)
    NumericalsType_NameText:SetText("Health/Mana Value Outline")
  	NumericalsType_NameText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
    NumericalsType:SetChecked(DarkModeUIOptions.numericaltype)
    NumericalsType:SetScript("OnClick", function(NumericalsType)
      DarkModeUIOptions.numericaltype = NumericalsType:GetChecked()
		if DarkModeUIOptions.numericaltype then
			DarkModeUI_NumericalsType = "OUTLINE"
		else
			DarkModeUI_NumericalsType = "THIN"
		end
        ApplyFonts()
    end)
	    DarkModeUIOptions.numericaltype = NumericalsType:GetChecked()
		if DarkModeUIOptions.numericaltype then
			DarkModeUI_NumericalsType = "OUTLINE"
		else
			DarkModeUI_NumericalsType = "THIN"
		end
        ApplyFonts()

	local note=Panel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    note:SetPoint("TOPLEFT",10, -360);
    note:SetText("Note: Reload after changing any of these by typing /reload into your chat");
    note:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");

	local note=Panel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    note:SetPoint("TOPLEFT",10, -380);
    note:SetText("The tracker showing your fps and latency can be moved by alt+click and dragging");
    note:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");

	local recommended=Panel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    recommended:SetPoint("TOP",10, -420);
    recommended:SetText("Recommended Addons:\n\nModern TargetFrame to show target frame health and mana text\n\nKuiNameplates or any nameplate addon to darken nameplates\n\nLeatrix Plus to hide chat buttons, bigger questlog, and much more\n\nBartender4 and Dominos Action Bars are supported\n\nTo get my fonts, check the Curseforge page description for instructions");
    recommended:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE");

	local name = "StringSizeSlider"
        local template = "OptionsSliderTemplate"
        local StringSizeSlider = CreateFrame("Slider", name, Panel, template)
        StringSizeSlider:SetPoint("TOPLEFT",300, -290)
        StringSizeSlider.textLow = _G[name.."Low"]
        StringSizeSlider.textHigh = _G[name.."High"]
        StringSizeSlider.text = _G[name.."Text"]
        StringSizeSlider:SetMinMaxValues(8, 16)
        StringSizeSlider.minValue, StringSizeSlider.maxValue = StringSizeSlider:GetMinMaxValues()
        StringSizeSlider.textLow:SetText(StringSizeSlider.minValue)
        StringSizeSlider.textHigh:SetText(StringSizeSlider.maxValue)
        StringSizeSlider:SetValue(DarkModeUI_StringSize)
        StringSizeSlider.text:SetText("Text Font Size: "..StringSizeSlider:GetValue(DarkModeUI_StringSize))
        StringSizeSlider:SetValueStep(1)
        StringSizeSlider:SetObeyStepOnDrag(true);
        StringSizeSlider:SetScript("OnValueChanged", function(self,event,arg1)
            StringSizeSlider.text:SetText("Font Size: "..StringSizeSlider:GetValue(DarkModeUI_StringSize))
            DarkModeUI_StringSize = StringSizeSlider:GetValue()
            ApplyFonts()
        end)

	local name = "NumSizeSlider"
        local template = "OptionsSliderTemplate"
        local NumSizeSlider = CreateFrame("Slider", name, Panel, template)
        NumSizeSlider:SetPoint("TOPLEFT", 460, -290)
        NumSizeSlider.textLow = _G[name.."Low"]
        NumSizeSlider.textHigh = _G[name.."High"]
        NumSizeSlider.text = _G[name.."Text"]
        NumSizeSlider:SetMinMaxValues(8, 16)
        NumSizeSlider.minValue, NumSizeSlider.maxValue = NumSizeSlider:GetMinMaxValues()
        NumSizeSlider.textLow:SetText(NumSizeSlider.minValue)
        NumSizeSlider.textHigh:SetText(NumSizeSlider.maxValue)
        NumSizeSlider:SetValue(DarkModeUI_NumSize)
        NumSizeSlider.text:SetText("Numericals Font Size: "..NumSizeSlider:GetValue(DarkModeUI_NumSize))
        NumSizeSlider:SetValueStep(1)
        NumSizeSlider:SetObeyStepOnDrag(true);
        NumSizeSlider:SetScript("OnValueChanged", function(self,event,arg1)
            NumSizeSlider.text:SetText("Font Size: "..NumSizeSlider:GetValue(DarkModeUI_NumSize))
            DarkModeUI_NumSize = NumSizeSlider:GetValue()
            ApplyFonts()
        end)

    return Panel

end

  -----------------------------
  -- HANDOVER
  -----------------------------

  --hand the config to the namespace for usage in other lua files (remember: those lua files must be called after the cfg.lua)
  ns.cfg = cfg