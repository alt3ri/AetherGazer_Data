slot0 = class("ActivityNoobUpgradeView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activitynewbie/NewbieUpgradeUI_new"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.upgradeItemList_ = {}

	for slot6 = 1, #GameSetting.levelup_reward.value do
		slot0.upgradeItemList_[slot6] = ActivityNoobUpgradeItem.New(slot0[string.format("button%s_", slot6)], slot6)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.upgradeItemList_) do
		slot5:Dispose()
	end

	slot0.upgradeItemList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.SetData(slot0)
	slot0.textLevel_.text = PlayerData:GetPlayerInfo().userLevel

	for slot4, slot5 in pairs(slot0.upgradeItemList_) do
		slot5:RefreshUI()
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
