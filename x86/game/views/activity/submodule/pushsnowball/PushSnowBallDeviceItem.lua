slot0 = class("PushSnowBallDeviceItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.equipController_ = ControllerUtil.GetController(slot0.equipBtn_.transform, "isEquipped")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.cfg_ = PushSnowBallDeviceCfg[slot2]

	manager.redPoint:bindUIandKey(slot0.bgTrs_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. slot0.index_)
	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.equipBtn_, nil, function ()
		PushSnowBallAction:SendEquipDevice(PushSnowBallData:GetSingleActivityID(), uv0.index_ == PushSnowBallData:GetSelectedDeviceID() and 0 or uv0.id_)
		saveData("PushSnowBall", "Device" .. uv0.id_ .. PushSnowBallData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, true)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. uv0.id_, 0)
	end)
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.bgTrs_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. slot0.index_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshItem()
	slot0:RefreshState()
end

function slot0.RefreshItem(slot0)
	slot0.titleText_.text = slot0.cfg_.name
	slot0.descText_.text = slot0.cfg_.desc
	slot0.lockText_.text = ConditionCfg[slot0.cfg_.condition_id].desc
	slot0.powerSliderImg_.fillAmount = slot0.cfg_.power_star / 5
	slot0.agilitySliderImg_.fillAmount = slot0.cfg_.agile_star / 5
	slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Item_l/" .. slot0.cfg_.icon)
end

function slot0.RefreshState(slot0)
	if PushSnowBallData:GetIsDeviceUnlockByID(slot0.cfg_.id) then
		slot0.lockController_:SetSelectedState("unlock")
	else
		slot0.lockController_:SetSelectedState("lock")
	end

	slot0.equipController_:SetSelectedState(tostring(slot0.index_ == PushSnowBallData:GetSelectedDeviceID() and slot1))
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
