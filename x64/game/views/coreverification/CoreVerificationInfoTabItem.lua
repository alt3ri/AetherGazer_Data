slot0 = class("CoreVerificationInfoTabItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = slot0.mainControllerEx_:GetController("select")
	slot0.lockController_ = slot0.mainControllerEx_:GetController("lock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.mainBtn_, nil, function ()
		if uv0.click_ then
			uv0.click_()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.click_ = slot4
	slot0.nameText_.text = slot2

	if slot2 == 1 or CoreVerificationData:GetStageInfoByTypeAndDiff(slot1, slot2 - 1) then
		slot0.lockController_:SetSelectedState("false")
	else
		slot0.lockController_:SetSelectedState("true")
	end

	if PlayerData:GetPlayerInfo().userLevel < CoreVerificationData:GetInfoCfgByTypeAndDiff(slot1, slot2).unlock_level then
		slot0.lockController_:SetSelectedState("true")
	end

	slot0.selectController_:SetSelectedState(slot2 == slot3 and "true" or "false")
end

function slot0.Select(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
