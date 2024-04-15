slot0 = class("NewHeroListFilterView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.isSelfHero_ = true
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.curOrder_ = "desc"
	slot0.isAll_ = true
	slot0.available_ = true
	slot0.curSortType_ = 0
	slot0.curSortRace_ = {}
	slot0.curAttackType_ = {}
	slot0.curEnergyType_ = {}

	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitDropdownData(slot0)
	slot0.sortTypeDropdown_.itemText.color = Color.New(0, 0, 0, 1)

	slot0.sortTypeDropdown_.options:Clear()

	slot0.dropDownText_ = {}

	if slot0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		slot0:AddDropDownOption("TIP_UNLOCK_HERO")
		slot0:AddDropDownOption("TIP_RARE")
	else
		slot0:AddDropDownOption("TIP_UPGRADE")
		slot0:AddDropDownOption("TIP_RARE")
	end

	if slot0.heroViewProxy_.isSelf then
		slot0:AddDropDownOption("TIP_FAVOR")
		slot0:AddDropDownOption("TIP_CLEARTIMES")
	end

	slot0:RefreshDropDownOptions()
end

function slot0.AddDropDownOption(slot0, slot1)
	slot0.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", GetTips(slot1), nil)))

	slot0.dropDownText_[#slot0.dropDownText_ + 1] = GetTips(slot1)
end

function slot0.RefreshDropDownOptions(slot0)
	if slot0.dropDownText_ then
		slot1 = "<color=#FFFFFF>%s</color>"

		for slot6 = 1, slot0.sortTypeDropdown_.options.Count do
			if slot6 - 1 == slot0.sortTypeDropdown_.value then
				slot0.sortTypeDropdown_.options[slot6 - 1].text = slot0.dropDownText_[slot6]
			else
				slot0.sortTypeDropdown_.options[slot6 - 1].text = string.format(slot1, slot0.dropDownText_[slot6])
			end
		end
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroSorter_ = HeroSorter.New()
	slot0.orderController_ = ControllerUtil.GetController(slot0.transform_, "order")

	if slot0.filterController_ then
		slot0.filterColorController_ = slot0.filterController_:GetController("color")
	end
end

function slot0.OnTop(slot0)
	slot0:RefreshDropDownOptions()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		uv0:SortListByOrder(uv0.orderController_:GetSelectedState() == "asc" and "desc" or "asc")
	end)
	slot0:AddToggleListener(slot0.sortTypeDropdown_, function (slot0)
		uv0:RefreshDropDownOptions()
		uv0:SortListByType(slot0)
	end)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Hero_Filter_List
		})
	end)
end

function slot0.SetAvailable(slot0, slot1)
	slot0.available_ = slot1
end

function slot0.SortListByOrder(slot0, slot1)
	slot0.curOrder_ = slot1

	slot0.orderController_:SetSelectedState(slot1)

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.SortListByType(slot0, slot1)
	slot0.curSortType_ = slot1

	HeroData:SaveSortType(slot1)

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.RefreshSort(slot0, slot1)
	if not slot0.available_ then
		return
	end

	slot0.displayHeroDataList_ = HeroTools.GetHeroShowData(slot0.heroDataList_, slot1)

	slot0:UpdateList()
	slot0:RenderFilterBtn()
end

function slot0.SetHeroIdList(slot0, slot1, slot2, slot3)
	if #slot1 > 0 and type(slot1[1]) ~= "table" then
		slot1 = HeroTools.FormatFilterHeroDataList(slot0.heroViewProxy_:GetViewDataType(), slot1, slot2, slot3)
	end

	slot0.heroDataList_ = slot1
	slot0.displayHeroDataList_ = {}

	for slot7, slot8 in ipairs(slot1) do
		if not HeroTools.GetIsHide(slot8.id) then
			table.insert(slot0.displayHeroDataList_, slot8)
		end
	end

	slot0:RefreshSort()
end

function slot0.UpdateList(slot0)
	slot1 = GameSetting.unlock_hero_need.value

	slot0.heroSorter_:Reset()
	table.sort(slot0.displayHeroDataList_, function (slot0, slot1)
		slot2 = false
		slot3 = false

		if uv0.extraSorter_ ~= nil then
			slot4, slot3 = uv0.extraSorter_(slot0, slot1)

			if slot4 then
				return slot3
			end
		end

		slot4 = slot0.heroViewProxy:GetHeroData(slot0.id)
		slot5 = slot1.heroViewProxy:GetHeroData(slot1.id)

		if uv0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			if uv0.curSortType_ == 0 then
				slot6, slot3 = uv0:UnlockSorter(slot4, slot5)

				if slot6 then
					return slot3
				end

				slot6, slot3 = uv0:RareSorter(slot4, slot5)

				if slot6 then
					return slot3
				end

				slot6, slot3 = uv0:IDSorter(slot4, slot5)

				if slot6 then
					return slot3
				end
			elseif uv0.curSortType_ == 1 then
				slot6, slot3 = uv0:RareSorter(slot4, slot5)

				if slot6 then
					return slot3
				end

				slot6, slot3 = uv0:IDSorter(slot4, slot5)

				if slot6 then
					return slot3
				end
			end
		end

		if slot4.unlock ~= slot5.unlock then
			return slot5.unlock < slot4.unlock
		end

		if slot4.unlock == 0 and slot5.unlock == 0 and (uv1[HeroCfg[slot0.id].rare] <= slot4.piece and 1 or 0) ~= (uv1[HeroCfg[slot1.id].rare] <= slot5.piece and 1 or 0) then
			return slot9 < slot8
		end

		if uv0.heroViewProxy_.isSelf and HeroData:IsFavorite(slot0.id) ~= HeroData:IsFavorite(slot1.id) and (not slot6 or not slot7) then
			return slot6 ~= false
		end

		if uv0.curSortType_ == 0 then
			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5, slot0.heroViewProxy, slot1.heroViewProxy)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:StarSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		elseif uv0.curSortType_ == 1 then
			slot6, slot3 = uv0:StarSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5, slot0.heroViewProxy, slot1.heroViewProxy)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		elseif uv0.curSortType_ == 2 then
			slot6, slot3 = uv0:FavorSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5, slot0.heroViewProxy, slot1.heroViewProxy)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:StarSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		else
			slot6, slot3 = uv0:UseTimesSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5, slot0.heroViewProxy, slot1.heroViewProxy)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:StarSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		end

		return slot1.id < slot0.id
	end)

	if slot0.callback_ ~= nil then
		slot2 = {}

		for slot6, slot7 in ipairs(slot0.displayHeroDataList_) do
			slot2[#slot2 + 1] = slot7.id
		end

		slot0.callback_(slot2, slot0.displayHeroDataList_, slot0.curSortType_)
	end
end

function slot0.SetListChangeHandler(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.SetExtraSorter(slot0, slot1)
	slot0.extraSorter_ = slot1
end

function slot0.SetIsSelfHero(slot0, slot1)
	slot0.isSelfHero_ = slot1
end

function slot0.RenderFilterBtn(slot0)
	if slot0.filterColorController_ then
		if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Hero_Filter_List.filter_id) then
			slot0.filterColorController_:SetSelectedState("orange")
		else
			slot0.filterColorController_:SetSelectedState("normal")
		end
	end
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1

	slot0:InitDropdownData()
	slot0:RegistEventListener(COMMON_FILTER_OK, handler(slot0, slot0.RefreshSort))
	slot0:RenderFilterBtn()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.FightPowerSorter(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if ((not slot1.tempID or TempHeroData:GetBattlePower(slot1.tempID)) and slot0.heroSorter_:GetHeroPower(slot1, handler(slot3, slot3.GetBattlePower))) ~= ((not slot2.tempID or TempHeroData:GetBattlePower(slot2.tempID)) and slot0.heroSorter_:GetHeroPower(slot2, handler(slot4, slot4.GetBattlePower))) then
		if slot0.curOrder_ == "desc" then
			return true, slot6 < slot5
		else
			return true, slot5 < slot6
		end
	end

	return false, false
end

function slot0.StarSorter(slot0, slot1, slot2)
	if slot1.star ~= slot2.star then
		if slot0.curOrder_ == "desc" then
			return true, slot2.star < slot1.star
		else
			return true, slot1.star < slot2.star
		end
	end

	return false, false
end

function slot0.UnlockSorter(slot0, slot1, slot2)
	if slot1.unlock ~= slot2.unlock then
		if slot0.curOrder_ == "desc" then
			return true, slot2.unlock < slot1.unlock
		else
			return true, slot1.unlock < slot2.unlock
		end
	end

	return false, false
end

function slot0.IDSorter(slot0, slot1, slot2)
	if slot1.id ~= slot2.id then
		if slot0.curOrder_ == "desc" then
			return true, slot2.id < slot1.id
		else
			return true, slot1.id < slot2.id
		end
	end

	return false, false
end

function slot0.RareSorter(slot0, slot1, slot2)
	if HeroCfg[slot1.id].rare ~= HeroCfg[slot2.id].rare then
		if slot0.curOrder_ == "desc" then
			return true, slot4.rare < slot3.rare
		else
			return true, slot3.rare < slot4.rare
		end
	end

	return false, false
end

function slot0.LevelSorter(slot0, slot1, slot2)
	if slot1.exp ~= slot2.exp then
		if slot0.curOrder_ == "desc" then
			return true, slot2.exp < slot1.exp
		else
			return true, slot1.exp < slot2.exp
		end
	end

	return false, false
end

function slot0.FavorSorter(slot0, slot1, slot2)
	if ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[slot1.id][1]).lv ~= ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[slot2.id][1]).lv then
		if slot0.curOrder_ == "desc" then
			return true, slot4.lv < slot3.lv
		else
			return true, slot3.lv < slot4.lv
		end
	end

	return false, false
end

function slot0.UseTimesSorter(slot0, slot1, slot2)
	if slot1.clear_times ~= slot2.clear_times then
		if slot0.curOrder_ == "desc" then
			return true, slot2.clear_times < slot1.clear_times
		else
			return true, slot1.clear_times < slot2.clear_times
		end
	end

	return false, false
end

function slot0.Reset(slot0, slot1)
	slot0:RemoveAllListeners()

	slot0.curOrder_ = "desc"

	if slot1 then
		slot0.isAll_, slot0.curSortType_, slot0.curSortRace_, slot0.curAttackType_, slot0.curEnergyType_ = HeroData:GetSortValue()
	else
		slot0.isAll_ = true
		slot0.curSortType_ = 0
		slot0.curSortRace_ = {}
		slot0.curAttackType_ = {}
		slot0.curEnergyType_ = {}
	end

	slot0.sortTypeDropdown_.value = slot0.curSortType_

	slot0:RefreshDropDownOptions()
	slot0.orderController_:SetSelectedState("desc")
	slot0:AddUIListeners()
end

function slot0.Dispose(slot0)
	if slot0.heroSorter_ then
		slot0.heroSorter_:Reset()

		slot0.heroSorter_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
