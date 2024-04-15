slot0 = class("SwitchHeroRewardView", RewardView)

function slot0.OnCtor(slot0)
	uv0.super.OnCtor(slot0)

	slot0.timerList = {}
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.effctItem_ = Asset.Load("Widget/Common/Com_Prefab/ZhuanHuaAni")
end

function slot1(slot0, slot1, slot2)
	if slot2.idx == slot1 then
		uv0.super.indexItem(slot0, slot1, slot2)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2.idx = slot1
	slot3 = slot0.itemList_[slot1]

	uv0.super.indexItem(slot0, slot1, slot2)
end

function slot0.IsConvertAnimePlayed(slot0, slot1)
	return slot0.timerList[slot1] ~= nil
end

function slot0.PlayConvertAnime(slot0, slot1, slot2)
	if slot0:IsConvertAnimePlayed(slot1) then
		return false
	end

	if slot2:FindTrs("ZhuanHuaAni") then
		SetActive(slot3.gameObject, false)
	end

	if not slot3 then
		slot4 = Object.Instantiate(slot0.effctItem_, slot2.transform_)
		slot3 = slot4.transform
		slot4.name = "ZhuanHuaAni"

		SetActive(slot4, false)
	end

	SetActive(slot3.gameObject, true)

	slot3.localPosition = Vector3.New(127, -124, 0)

	slot3:GetComponent("Animator"):Play("CommonItem_zhuanhua", 0, 0)
	manager.audio:PlayEffect("ui_system_search", "search_itemTransform", "")

	return true
end

function slot0.AddTimer(slot0, slot1, slot2)
	slot0.timerList[slot1] = slot2
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI(slot0.params_.list)

	slot0.callBack_ = slot0.params_.callBack
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.params_.lateCallback then
			uv0:StopTime()
			uv0:Back(uv0.callBack_)
		else
			uv0:Back(uv0.params_.callBack)
		end
	end)
end

function slot0.StopTime(slot0)
	for slot4, slot5 in pairs(slot0.timerList) do
		slot5:Stop()
	end
end

function slot0.OnExit(slot0)
	slot0.params_.callBack = nil

	for slot4, slot5 in pairs(slot0.timerList) do
		if slot5 then
			slot5:Stop()

			slot5 = nil
		end
	end

	slot0.timerList = {}

	uv0.super.OnExit(slot0)
end

return slot0
