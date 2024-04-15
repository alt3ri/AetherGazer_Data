slot0 = class("BackHomeCricketBuffItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.buffBtn_, nil, slot0.OnClick, slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.buffID = slot1.id
	slot0.buffIcon_.sprite = IdolTraineeTools:GetBuffIcon(slot0.buffID)
	slot0.buffRoundText_.text = slot1.duration
	slot0.showInfoFunc = slot2
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	manager.notify:CallUpdateFunc("OnBuffIconClick", slot0.buffID, slot0.showInfoFunc)
end

return slot0
