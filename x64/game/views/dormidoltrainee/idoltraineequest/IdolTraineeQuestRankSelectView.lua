slot0 = class("IdolTraineeQuestRankSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestRankSelect"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.okBtnController_ = slot0.controllerEx_:GetController("btn")
	slot0.noneController_ = slot0.controllerEx_:GetController("none")
	slot0.ItemUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, CommonItemView)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in pairs(uv0.selectDic_) do
			table.insert(slot0, {
				id = slot4,
				num = slot5
			})
		end

		IdolTraineeAction.GetQuestRankReward(uv0.rank_, slot0, function ()
			uv0:Back()
		end)
	end)
	slot0:AddBtnListener(slot0.retBtn_, nil, function ()
		uv0:Go("/idolTraineeCamp")
	end)
end

function slot0.OnEnter(slot0)
	slot0.rank_ = slot0.params_.rank
	slot1 = IdolTraineeRewardRankCfg[slot0.rank_]
	slot0.dataList_ = slot1.reward

	table.sort(slot0.dataList_, function (slot0, slot1)
		if uv0:GetHeroLock(slot0) == uv0:GetHeroLock(slot1) then
			return slot0 < slot1
		else
			return slot3
		end
	end)

	slot0.maxNum_ = slot1.num
	slot0.selectDic_ = {}
	slot0.selectNum_ = 0

	slot0.ItemUIList_:StartScroll(#slot0.dataList_)
	slot0.noneController_:SetSelectedState("true")

	slot5 = "state1"

	slot0.okBtnController_:SetSelectedState(slot5)

	for slot5, slot6 in ipairs(slot0.dataList_) do
		if not slot0:GetHeroLock(slot6) then
			slot0.noneController_:SetSelectedState("false")
			slot0.okBtnController_:SetSelectedState("state0")

			break
		end
	end

	slot0:UpdatePreview()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot3 = slot0.dataList_[slot1]
	slot5 = clone(ItemTemplateData)
	slot5.id = slot3
	slot5.locked = slot0:GetHeroLock(slot3)
	slot5.topAmountValue = slot0.selectDic_[slot3] or 0

	function slot5.clickFun(slot0)
		if uv0 then
			return false
		end

		uv1:AddSelect(uv2)
		uv3:RefreshTopAmount(uv1.selectDic_[uv2])
		uv1:UpdatePreview()

		return true
	end

	function slot5.clickAmountFun(slot0)
		if uv0 then
			return false
		end

		uv1:DeleteSelect(uv2)
		uv3:RefreshTopAmount(uv1.selectDic_[uv2])
		uv1:UpdatePreview()

		return true
	end

	slot2:SetData(slot5)
end

function slot0.AddSelect(slot0, slot1)
	if slot0.maxNum_ <= slot0.selectNum_ then
		return
	end

	if not slot0.selectDic_[slot1] then
		slot0.selectDic_[slot1] = 0
	end

	slot0.selectDic_[slot1] = slot0.selectDic_[slot1] + 1
	slot0.selectNum_ = slot0.selectNum_ + 1
end

function slot0.DeleteSelect(slot0, slot1)
	if slot0.selectNum_ <= 0 or not slot0.selectDic_[slot1] or slot0.selectDic_[slot1] <= 0 then
		return
	end

	slot0.selectDic_[slot1] = slot0.selectDic_[slot1] - 1
	slot0.selectNum_ = slot0.selectNum_ - 1
end

function slot0.UpdatePreview(slot0)
	slot0.numText_.text = slot0.selectNum_ .. "/" .. slot0.maxNum_

	slot0.okBtnController_:SetSelectedState(slot0.selectNum_ == slot0.maxNum_ and "state1" or "state0")
end

function slot0.GetHeroLock(slot0, slot1)
	return not HeroTools.GetHeroIsUnlock(slot1 - 10000)
end

function slot0.OnExit(slot0)
	slot0.selectInex_ = 0
	slot0.selectNum_ = 0
	slot0.lastSelectItem_ = nil
end

function slot0.Dispose(slot0)
	slot0.ItemUIList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
