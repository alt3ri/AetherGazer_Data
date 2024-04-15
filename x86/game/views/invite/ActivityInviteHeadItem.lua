slot0 = class("ActivityInviteHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = ControllerUtil.GetController(slot0.transform_, "isSelected")
	slot0.finishController = ControllerUtil.GetController(slot0.transform_, "finish")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		uv0.delegate_(uv0.index, uv0.data.heroId)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.data = slot1
	slot0.index = slot2
	slot0.delegate_ = slot3
	slot0.selectIndex = slot4

	slot0:UpdateView()
end

function slot0.GetController(slot0)
	return slot0.controller
end

function slot0.GetFinishController(slot0)
	return slot0.finishController
end

function slot0.UpdateView(slot0)
	slot0.headImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. tostring(slot0.data.image))
	slot0.nameTxt_.text = GetI18NText(HeroCfg[slot0.data.heroId].suffix)

	slot0.controller:SetSelectedState(slot0.selectIndex == slot0.index and "true" or "false")
	slot0.finishController:SetSelectedState(#(InviteData:GetDataByPara("completeHeroTable")[slot0.data.heroId] or {}) == 7 and "2" or "1")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
