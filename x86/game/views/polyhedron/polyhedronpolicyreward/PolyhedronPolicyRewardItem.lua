slot0 = class("PolyhedronPolicyRewardItem", ReduxView)

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

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	if slot0.btn_ then
		slot0:AddBtnListener(slot0.btn_, nil, function ()
			PolyhedronAction.QueryPolicyReward(2, uv0.level_)
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.ID_ = slot1
	slot0.rewardCfg_ = PolyhedronPolicyCfg[slot0.ID_].rewards[1]
	slot0.level_ = PolyhedronPolicyCfg[slot0.ID_].level
	slot0.curLevel_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.levelText_.text = slot0.level_
	slot1 = clone(ItemTemplateData)
	slot1.id = slot0.rewardCfg_[1]
	slot1.number = slot0.rewardCfg_[2]

	function slot1.clickFun(slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	if slot0.commonItem_ == nil then
		slot0.commonItem_ = CommonItemPool.New(slot0.rewardPanelGo_, slot1)
	else
		slot0.commonItem_:SetData(slot1)
	end

	if slot0.stateController_ then
		if PolyhedronData:GetPolicyApplyList()[slot0.level_] == true then
			slot0.stateController_:SetSelectedState("received")
		elseif slot0.level_ <= slot0.curLevel_ then
			slot0.stateController_:SetSelectedState("unreceive")
		else
			slot0.stateController_:SetSelectedState("uncomplete")
		end
	end
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
