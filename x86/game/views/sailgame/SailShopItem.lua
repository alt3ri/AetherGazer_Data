slot0 = class("SailShopItem", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SailGameAction.EventOperate(uv0.activityID_, SailGameData:GetCurGameData(uv0.activityID_).curStageIndex, uv0.index_)
	end)
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.activityID_ = slot1
	slot0.goodData_ = slot2
	slot0.index_ = slot3

	slot0:RefreshUI()
	slot0:UpdateStatus()
end

function slot0.UpdateStatus(slot0)
	if slot0.goodData_.soldOut == SailGameConst.EVENT_SHOP_STATUS.SOLD_OUT then
		slot0.statusController_:SetSelectedState("soldOut")
	elseif ItemTools.getItemNum(slot0.goodData_.costID) < slot0.goodData_.costNum then
		slot0.statusController_:SetSelectedState("off")
	else
		slot0.statusController_:SetSelectedState("normal")
	end
end

function slot0.RefreshUI(slot0)
	if not slot0.commonItem_ then
		slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)

		slot0.commonItem_:RegistCallBack(function ()
			if uv0.clickCallback_ then
				if uv0.clickCallback_() then
					ShowPopItem(POP_ITEM, uv0.costCfg_)
				end
			else
				ShowPopItem(POP_ITEM, uv0.costCfg_)
			end
		end)
	end

	slot0.costCfg_ = {
		slot0.goodData_.costID,
		slot0.goodData_.costNum
	}

	slot0.commonItem_:RefreshData(formatReward(slot0.costCfg_))
	slot0.commonItem_:SetBottomText(string.format("%s/%s", ItemTools.getItemNum(slot0.costCfg_[1]), slot0.costCfg_[2]))

	slot0.goodIcon_.sprite = ItemTools.getItemSprite(slot0.goodData_.goodID)
	slot0.goodNumText_.text = slot0.goodData_.goodNum
end

return slot0
