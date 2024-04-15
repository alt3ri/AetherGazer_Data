slot0 = class("ReserveProposalSwitchItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = slot0.controllerExCollection_:GetController("select")
	slot4 = "temp"
	slot0.tempController_ = slot0.controllerExCollection_:GetController(slot4)
	slot0.headItemList_ = {}

	for slot4 = 1, 3 do
		slot0.headItemList_[slot4] = SectionSmallHeroItem.New(slot0.headContentTrans_:GetChild(slot4 - 1).gameObject)
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0.clickHandler_(uv0.contID_)
	end)
	slot0:AddBtnListener(slot0.renameBtn_, nil, function ()
		uv0.renameCallback_(uv0.contID_)
	end)
end

function slot0.RegisterClickCallback(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.RegistRenameCallback(slot0, slot1)
	slot0.renameCallback_ = slot1
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil
	slot0.renameCallback_ = nil

	for slot4, slot5 in ipairs(slot0.headItemList_) do
		slot5:Dispose()
	end

	slot0.headItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	if not slot0.reserveParams_ then
		slot0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, slot1)
	end

	slot0.reserveParams_.contID = slot1
	slot0.contID_ = slot1
	slot0.isTemp_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(slot0.contID_)

	slot0.tempController_:SetSelectedState(tostring(slot0.isTemp_))

	if not slot0.isTemp_ then
		slot0.nameText_.text = slot2:GetName()
	end

	slot0.heroDataList_ = slot2:GetHeroList()

	for slot6, slot7 in ipairs(slot0.heroDataList_) do
		slot0.headItemList_[slot6]:SetData(slot7:GetHeroID())
	end
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(tostring(slot0.contID_ == slot1))
end

return slot0
