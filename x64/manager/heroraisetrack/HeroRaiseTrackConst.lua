slot0 = {
	HeroRaiseRotate = {
		[11] = Vector3(0, 130, 0),
		[60] = Vector3(0, 130, 0),
		[61] = Vector3(0, 130, 0)
	},
	ViewType = {
		null = "null",
		heroRaiseCommon = "heroRaiseCommon"
	},
	HeroRaiseType = {
		weapon = 3,
		astrolabe = 5,
		transition = 7,
		attr_promption = 11,
		chip_management = 61,
		equip = 4,
		chip = 6,
		skill = 2,
		skill_details = 21,
		attr = 1
	},
	HeroServantType = {
		weapon = 1,
		servant = 2
	},
	HeroRaiseName = {
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"VirtualCamera_Property",
		"VirtualCamera_Property_Transcend",
		"VirtualCamera_Property_Break",
		"VirtualCamera_Property_Files",
		"VirtualCamera_Property_Skin",
		nil,
		nil,
		nil,
		nil,
		nil,
		"VirtualCamera_Skill",
		"VirtualCamera_Skill_Details",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"VirtualCamera_Weapon",
		"VirtualCamera_Weapon_Break",
		"VirtualCamera_Weapon_WeaponServant",
		[40.0] = "VirtualCamera_Engraving",
		[60.0] = "VirtualCamera_Chip",
		[50.0] = "VirtualCamera_GodHood",
		[70.0] = "VirtualCamera_Transition",
		[61.0] = "VirtualCamera_Chip_Management",
		[51.0] = "VirtualCamera_GodHood_Adjust"
	},
	HeroRaiseIdleAniName = "action1_1"
}
HERO_RAISE_ROTATE_TIME = 0.2
ASTROLABE_COLOR_TIME = 0.2
ASTROLABE_COLOR = {
	0.35294117647058826,
	0.39215686274509803,
	0.5098039215686274
}
slot0.HeroAniName = {
	[21.0] = "Skill_Details",
	[61.0] = "Chip_Management",
	[11.0] = "Property_Transcend",
	[12.0] = "Property_Break",
	[50.0] = "GodHood",
	[13.0] = "Property_Files",
	[10] = slot0.HeroRaiseIdleAniName,
	[14] = slot0.HeroRaiseIdleAniName,
	[20] = slot0.HeroRaiseIdleAniName,
	[40] = slot0.HeroRaiseIdleAniName,
	[60] = slot0.HeroRaiseIdleAniName
}
slot0.ModelState = {
	weapon = 3,
	hero = 2,
	none = 1
}

return slot0
