slot0 = class("XH3rdFlipCardClueItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.clueId = slot1.detail_id
	slot0.name = slot1.name
	slot0.icon_path = slot1.icon_path
	slot0.picture = slot1.picture
	slot0.activityId = slot2
	slot0.isGetted = XH3rdFlipCardData:CheckClueIsGetted(slot0.clueId)
	slot0.isViewed = XH3rdFlipCardData:CheckClueIsViewed(slot0.clueId)

	manager.redPoint:bindUIandKey(slot0.checkBtnTrans_, string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0.activityId, slot0.clueId))
	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "clue")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		XH3rdFlipCardAction:sendViewClueRequest(uv0.activityId, uv0.clueId)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.titleText_.text = slot0.name

	if slot0.isGetted then
		slot0.lockController:SetSelectedState("unlock")
	else
		slot0.lockController:SetSelectedState("lock")
	end
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.checkBtnTrans_, string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0.activityId, slot0.clueId))
	uv0.super.Dispose(slot0)
end

function slot0.SetReveivedHandler(slot0, slot1)
	slot0.onReceived_ = slot1
end

return slot0
