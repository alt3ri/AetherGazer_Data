slot0 = class("MythicDifficultyView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_Mythic/MythicDiffcultyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.difficultyList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_difficultyList, MythicDifficultyItem)
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.rewardIndexItem), slot0.m_rewardList, CommonItemView)
	slot0.isFinalController_ = ControllerUtil.GetController(slot0.transform_, "isfinal")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_sureBtn, nil, function ()
		slot0 = 0
		slot1 = 0

		if MythicCfg.all[uv0.index] == MythicData:GetDifficulty() then
			uv0:Back()

			return
		end

		if slot1 == 0 or MythicData:GetPartitionCount() == 0 and MythicData:GetStarCount() == 0 and MythicData:GetFinalRewardNotGet() == false or _G.SkipTip.MythicDifficultyView then
			MythicAction.QueryChangeDifficulty(slot0)
		else
			ShowMessageBox({
				content = GetTips("MYTHIC_CHANGE_DIFFICULTY"),
				OkCallback = function ()
					MythicAction.QueryChangeDifficulty(uv0)
				end,
				ToggleCallback = function (slot0)
					_G.SkipTip.MythicDifficultyView = slot0
				end
			})
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	if MythicData:GetDifficulty() == 0 then
		slot0.selectDifficulty = MythicData:GetMaxDifficulty()
	else
		slot0.selectDifficulty = slot1
	end

	slot0.index = table.indexof(MythicCfg.all, slot0.selectDifficulty)

	slot0.difficultyList_:StartScroll(#MythicCfg.all, slot0.index, true)
	slot0:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0)
	slot0.curLevelID_ = MythicCfg.all[slot0.index]
	slot0.m_levelLab.text = (MythicCfg[slot0.curLevelID_].recommend_level[1] or 0) .. "-" .. (slot2[2] or 0)
	slot0.m_desLab.text = GetI18NText(slot1.desc)
	slot0.preview_reward_list = slot1.preview_reward_list

	slot0.rewardList_:StartScroll(#slot0.preview_reward_list)

	if slot1.difficulty == 2 then
		slot0.isFinalController_:SetSelectedState("true")
	else
		slot0.isFinalController_:SetSelectedState("false")

		slot0.m_difficultyLab.text = NumberTools.IntToRomam(slot0.curLevelID_)
	end
end

function slot0.OnItemClick(slot0, slot1)
	if slot0.index ~= slot1 then
		slot0.index = slot1

		for slot6, slot7 in pairs(slot0.difficultyList_:GetItemList()) do
			slot7:SetChoice(slot0.index)
		end

		slot0:Refresh()
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot1)
	slot2:RegistCallBack(function (slot0)
		uv0:OnItemClick(slot0)
	end)
	slot2:SetChoice(slot0.index)
end

function slot0.rewardIndexItem(slot0, slot1, slot2)
	clone(ItemTemplateData).id = slot0.preview_reward_list[slot1][1]

	if MythicCfg[slot0.curLevelID_].difficulty == 1 then
		slot4.number = slot3[2]
	else
		slot4.number = nil
	end

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end

	slot2:SetData(slot4)
end

function slot0.Dispose(slot0)
	slot0.difficultyList_:Dispose()
	slot0.rewardList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnMyticUpdate(slot0)
	slot0.difficultyList_:Refresh()
end

return slot0
