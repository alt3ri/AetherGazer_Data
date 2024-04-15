slot0 = {}
slot1 = slot0
Filter_Tags_Define = {
	MECHAINISM4 = 28,
	FURNITURETYPE1 = 29,
	Star4 = 11,
	ARRT2 = 22,
	ARRT14 = 21,
	DESCending = 16,
	ARRT4 = 18,
	ARRT0 = 17,
	ARRT8 = 19,
	Race3 = 3,
	Race2 = 2,
	Race4 = 4,
	Race9 = 6,
	FURNITURETYPE6 = 34,
	FURNITURETYPE7 = 35,
	FURNITURETYPE8 = 36,
	Beyond = 7,
	FURNITURETYPE9 = 37,
	FURNITURETYPEALL = 38,
	FURNITURETYPE3 = 31,
	ARRT10 = 24,
	CallName = 9,
	FURNITURETYPE5 = 33,
	Star3 = 10,
	MECHAINISM1 = 25,
	Race5 = 5,
	ARRT12 = 23,
	Race1 = 1,
	FURNITURETYPE2 = 30,
	MECHAINISM2 = 26,
	FURNITURETYPE4 = 32,
	Equip = 8,
	MECHAINISM3 = 27,
	StarLevel = 14,
	Train = 13,
	Star5 = 12,
	ARRT6 = 20,
	ASCending = 15
}
Filter_Group_Mode = {
	SingleMode = 2,
	MultiMode = 1
}
Filter_Group_Define = {
	RACE = {
		title = "FILTER_RACE",
		groupID = 1,
		mode = Filter_Group_Mode.MultiMode,
		tags = {
			Filter_Tags_Define.Race1,
			Filter_Tags_Define.Race2,
			Filter_Tags_Define.Race3,
			Filter_Tags_Define.Race4,
			Filter_Tags_Define.Race5,
			Filter_Tags_Define.Race9
		}
	},
	SERVANT_ADD = {
		title = "FILTER_SERVANT_ADD",
		groupID = 2,
		mode = Filter_Group_Mode.MultiMode,
		tags = {
			Filter_Tags_Define.Beyond,
			Filter_Tags_Define.Equip,
			Filter_Tags_Define.CallName
		}
	},
	RARITY = {
		title = "FILTER_RARITY",
		groupID = 3,
		mode = Filter_Group_Mode.MultiMode,
		tags = {
			Filter_Tags_Define.Star3,
			Filter_Tags_Define.Star4,
			Filter_Tags_Define.Star5
		}
	},
	TYPE = {
		title = "TIP_TYPE",
		groupID = 4,
		mode = Filter_Group_Mode.SingleMode,
		tags = {
			Filter_Tags_Define.StarLevel,
			Filter_Tags_Define.Train
		}
	},
	SORT = {
		title = "TIP_SORT",
		groupID = 5,
		mode = Filter_Group_Mode.SingleMode,
		tags = {
			Filter_Tags_Define.ASCending,
			Filter_Tags_Define.DESCending
		}
	},
	ARRT = {
		title = "EQUIP_TYPE_1",
		groupID = 6,
		mode = Filter_Group_Mode.MultiMode,
		tags = {
			Filter_Tags_Define.ARRT0,
			Filter_Tags_Define.ARRT4,
			Filter_Tags_Define.ARRT8,
			Filter_Tags_Define.ARRT6,
			Filter_Tags_Define.ARRT14,
			Filter_Tags_Define.ARRT2,
			Filter_Tags_Define.ARRT12,
			Filter_Tags_Define.ARRT10
		}
	},
	MECHAINISMTYPE = {
		title = "TIP_TYPE",
		groupID = 7,
		mode = Filter_Group_Mode.MultiMode,
		tags = {
			Filter_Tags_Define.MECHAINISM1,
			Filter_Tags_Define.MECHAINISM2,
			Filter_Tags_Define.MECHAINISM3,
			Filter_Tags_Define.MECHAINISM4
		}
	},
	DECOMPOSE_RARITY = {
		title = "FILTER_RARITY",
		groupID = 8,
		mode = Filter_Group_Mode.MultiMode,
		tags = {
			Filter_Tags_Define.Star3,
			Filter_Tags_Define.Star4
		}
	},
	DECOMPOSE_SERVANT_ADD = {
		title = "FILTER_SERVANT_ADD",
		groupID = 9,
		mode = Filter_Group_Mode.MultiMode,
		tags = {
			Filter_Tags_Define.Beyond
		}
	},
	DORM_FURNITURE_TYPE = {
		title = "DORM_ALL_FURNITURE",
		groupID = 10,
		mode = Filter_Group_Mode.SingleMode,
		tags = {
			Filter_Tags_Define.FURNITURETYPE1,
			Filter_Tags_Define.FURNITURETYPE2,
			Filter_Tags_Define.FURNITURETYPE3,
			Filter_Tags_Define.FURNITURETYPE4,
			Filter_Tags_Define.FURNITURETYPE5,
			Filter_Tags_Define.FURNITURETYPE6,
			Filter_Tags_Define.FURNITURETYPE7,
			Filter_Tags_Define.FURNITURETYPE8,
			Filter_Tags_Define.FURNITURETYPE9,
			Filter_Tags_Define.FURNITURETYPEALL
		}
	}
}
Filter_Root_Define = {
	Servant_Filter_List = {
		filter_id = 1,
		groupList = {
			Filter_Group_Define.RACE.groupID,
			Filter_Group_Define.RARITY.groupID,
			Filter_Group_Define.SERVANT_ADD.groupID
		}
	},
	Equip_Filter_List = {
		filter_id = 2,
		groupList = {
			Filter_Group_Define.TYPE.groupID,
			Filter_Group_Define.SORT.groupID
		}
	},
	Hero_Filter_List = {
		filter_id = 3,
		groupList = {
			Filter_Group_Define.RACE.groupID,
			Filter_Group_Define.ARRT.groupID,
			Filter_Group_Define.MECHAINISMTYPE.groupID
		}
	},
	Weapon_LevelUp_Cost_List = {
		filter_id = 4,
		groupList = {
			Filter_Group_Define.TYPE.groupID,
			Filter_Group_Define.SORT.groupID
		}
	},
	Decompose_Servant_Filter_List = {
		filter_id = 5,
		groupList = {
			Filter_Group_Define.RACE.groupID,
			Filter_Group_Define.DECOMPOSE_RARITY.groupID,
			Filter_Group_Define.DECOMPOSE_SERVANT_ADD.groupID
		}
	},
	Mail_Filter_List = {
		filter_id = 6,
		groupList = {
			Filter_Group_Define.RACE.groupID
		}
	},
	DORM_SHOP_Filter_List = {
		filter_id = 7,
		groupList = {
			Filter_Group_Define.DORM_FURNITURE_TYPE.groupID
		}
	}
}

function slot1.GetFilterList(slot0)
	return uv0.GetGroupCfg(slot0).tags or {}
end

function slot1.GetFilterTagCfg(slot0)
	return CommonFilterCfg[slot0]
end

function slot1.GetFilterCfg(slot0)
	if not uv0.Filter_Cfg then
		uv0.Filter_Cfg = {}

		for slot4, slot5 in pairs(Filter_Root_Define) do
			uv0.Filter_Cfg[slot5.filter_id] = slot5
		end
	end

	return uv0.Filter_Cfg[slot0]
end

function slot1.GetFilterGroups(slot0)
	return uv0.GetFilterCfg(slot0).groupList
end

function slot1.GetGroupCfg(slot0)
	if not uv0.Filter_Group_Cfg then
		uv0.Filter_Group_Cfg = {}

		for slot4, slot5 in pairs(Filter_Group_Define) do
			uv0.Filter_Group_Cfg[slot5.groupID] = slot5
		end
	end

	return uv0.Filter_Group_Cfg[slot0]
end

function slot1.GetTagIndexAtGroup(slot0, slot1)
	if uv0.GetGroupCfg(slot0) then
		if not slot2.tagIndex then
			slot2.tagIndex = {}

			for slot6, slot7 in ipairs(slot2.tags) do
				slot2.tagIndex[slot7] = slot6 - 1
			end
		end

		return slot2.tagIndex[slot1] or -1
	end

	return -1
end

return slot0
