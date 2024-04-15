slot0 = class("DormLinkGameSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "item")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.illustrateBtn_, nil, function ()
		JumpTools.OpenPageByJump("dormLinkGameItemTips", {
			itemID = uv0.itemID
		})
	end)
	slot0:AddBtnListenerScale(slot0.useItemBtn_, nil, function ()
		if uv0.useItem then
			uv0.useItem(uv0.itemID)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.itemID = slot1
	slot0.iconImg_.sprite = DormLinkGameTools:GetDormLinkGameItemIcon(DormLinkGameData:GetMainActivityID(), slot1)

	if slot2 then
		slot0.stateController:SetSelectedState("lock")

		slot0.nameText_.text = ActivityLinkGameGoodsCfg[slot1].name
	else
		if DormLinkGameData:GetCurCnaUseTokenNum() < ActivityLinkGameGoodsCfg[slot0.itemID].coin_num then
			slot0.stateController:SetSelectedState("none")
		else
			slot0.stateController:SetSelectedState("normal")
		end

		slot0.neediconImg_.sprite = ItemTools.getItemSprite(DormLinkGameTools:GetCurrencyID(DormLinkGameData:GetMainActivityID()))
		slot0.neednumtextText_.text = ActivityLinkGameGoodsCfg[slot1].coin_num
	end
end

function slot0.UseItem(slot0, slot1)
	if slot1 then
		slot0.useItem = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
