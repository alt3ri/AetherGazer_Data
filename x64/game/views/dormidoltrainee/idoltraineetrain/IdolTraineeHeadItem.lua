slot0 = class("IdolTraineeHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.selectController_ = slot0.mainControllerEx_:GetController("select")
	slot0.defendController_ = slot0.mainControllerEx_:GetController("defend")
	slot0.attackController_ = slot0.mainControllerEx_:GetController("attack")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.click_ then
			uv0.click_()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.heroID_ = slot1
	slot0.click_ = slot3
	slot0.headIcon_.sprite = IdolTraineeTools:GetHeroBattleInfoTemplate(slot1).heroIcon

	slot0.defendController_:SetSelectedState(IdolTraineeTools:CheckHeroIsDefine(slot1) and "true" or "false")
	slot0.attackController_:SetSelectedState(IdolTraineeTools:CheckHeroIsAttack(slot1) and "true" or "false")
	slot0.selectController_:SetSelectedState(slot1 == slot2 and "true" or "false")
end

function slot0.SelectOn(slot0)
	slot0.selectController_:SetSelectedState("true")
end

function slot0.SelectOff(slot0)
	slot0.selectController_:SetSelectedState("false")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
