slot1 = class("AbyssTeamInfoView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)
	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.LockSorter))
end

function slot1.OnEnter(slot0)
	slot0.abandonList_ = AbyssTools.GetGlobalBanHeroList()
	slot0.lockList_ = AbyssTools.GetLayerLockHeroList(slot0.params_.reserveParams.customData.layer)

	uv0.super.OnEnter(slot0)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)

	slot3 = slot0.heroDataList_[slot1].id
	slot5, slot6, slot7 = slot0:IsInTeam(slot3, slot0.heroDataList_[slot1].trialID)
	slot8 = AbyssData:IsHeroInLockList(slot3, slot0.lockList_)

	if AbyssData:IsHeroInLockList(slot3, slot0.abandonList_) > 0 then
		slot2:SetHeroLock(true)
		slot2:SetHeroLockType("abyss_abandon")
	elseif slot8 > 0 then
		slot2:SetHeroLock(true)
		slot2:SetHeroLockType("abyss_lock")
	else
		slot2:SetHeroLock(false)
	end

	slot2.lockImage_:SetNativeSize()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot2.lockContainer_)
	slot2:SetInTeamFlag(slot5)
end

function slot1.LockSorter(slot0, slot1, slot2, slot3, slot4)
	slot5 = AbyssData:IsHeroInLockList(slot1.id, slot0.lockList_) > 0 and 1 or 0
	slot6 = AbyssData:IsHeroInLockList(slot2.id, slot0.lockList_) > 0 and 1 or 0

	if (AbyssData:IsHeroInAbandonList(slot1.id, slot0.abandonList_) > 0 and 1 or 0) ~= (AbyssData:IsHeroInAbandonList(slot2.id, slot0.abandonList_) > 0 and 1 or 0) then
		return true, slot7 < slot8
	end

	if slot5 ~= slot6 then
		return true, slot5 < slot6
	end
end

function slot1.RefreshJoinBtn(slot0)
	uv0.super.RefreshJoinBtn(slot0)

	if AbyssData:IsHeroInAbandonList(slot0.selectID_, slot0.abandonList_) > 0 then
		slot0.joinBtn_.interactable = false

		slot0.joinBtnController_:SetSelectedState("lock")
	end

	if AbyssData:IsHeroInLockList(slot0.selectID_, slot0.lockList_) > 0 then
		slot0.joinBtn_.interactable = false

		slot0.joinBtnController_:SetSelectedState("lock")
	end
end

return slot1
