slot0 = class("NewChessTipsItem")

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.switchDiceController_ = ControllerUtil.GetController(slot0.switchDiceTrans_, "point")
	slot0.diceController_ = ControllerUtil.GetController(slot0.getDiceTrans_, "point")
	slot0.buffItem_ = NewWarChessTipsBuffItem.New(slot0.buffGo_)
end

function slot0.SetData(slot0, slot1)
	slot0.typeController_:SetSelectedIndex(slot1.tipsType)

	slot0.text_.text = slot1.tipsText

	if slot1.tipsType == NewChessConst.TIPS_TYPE.SWITCH then
		slot0.switchDiceController_:SetSelectedIndex(slot1.tipsDiceNum)
	elseif slot1.tipsType == NewChessConst.TIPS_TYPE.DICE then
		slot0.diceController_:SetSelectedIndex(slot1.tipsDiceNum)
		manager.audio:PlayEffect("minigame_activity_2_6_grid", "minigame_activity_2_6_grid_getdice", "")
	elseif slot1.tipsType == NewChessConst.TIPS_TYPE.BUFF then
		slot0.buffItem_:SetData(1, 0, slot1.tipsBuffEntity)
	end
end

function slot0.SetDisposeHandler(slot0, slot1)
	slot0.disposeHandler_ = slot1
end

function slot0.SetIsShow(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	slot0.isShow_ = slot1

	if slot1 then
		slot0.transform_:SetAsLastSibling()
		slot0:StartTimer()
	end
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:StopTimer()
			uv0:SetIsShow(false)
			uv0.disposeHandler_(uv0.tipsinfo_)
		end, 3, 1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.GetIsShow(slot0)
	return slot0.isShow_
end

function slot0.Dispose(slot0)
	slot0:StopTimer()

	slot0.disposeHandler_ = nil

	Object.Destroy(slot0.gameObject_)
	slot0.buffItem_:Dispose()
end

return slot0
