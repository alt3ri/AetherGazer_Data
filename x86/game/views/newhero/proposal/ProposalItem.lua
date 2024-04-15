slot0 = class("EquipProposalItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = slot0.proposalCon_:GetController("select")
	slot0.nameController_ = slot0.proposalCon_:GetController("name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener("", nil, function ()
		uv0.func()
	end)
	slot0:AddBtnListener(slot0.btnChangeName_, nil, function ()
		uv0.changeNameFunc()
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.label1Text_.text = GetI18NText(slot1.proposal_name)
	slot0.label2Text_.text = GetI18NText(slot1.proposal_name)
end

function slot0.ShowSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "select" or "unselect")
	slot0.nameController_:SetSelectedState(slot1 and "change" or "name")
end

function slot0.RegistCallBack(slot0, slot1, slot2)
	slot0.func = slot1
	slot0.changeNameFunc = slot2
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
