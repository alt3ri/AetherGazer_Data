slot0 = class("BackHomeQuickJumpView", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.canteenBtnController = ControllerUtil.GetController(slot0.canteenBtn.transform, "position")
	slot0.publicDormBtnController = ControllerUtil.GetController(slot0.publicDormBtn.transform, "position")
	slot0.chooseDormBtnBtnController = ControllerUtil.GetController(slot0.chooseDormBtn.transform, "position")
	slot0.danceBtnBtnController = ControllerUtil.GetController(slot0.danceRoomBtn.transform, "position")
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.showBtn.transform, RedPointConst.BACKHOME)
	manager.redPoint:bindUIandKey(slot0.canteenBtn.transform, RedPointConst.CANTEEN)
	manager.redPoint:bindUIandKey(slot0.chooseDormBtn.transform, RedPointConst.DORM_PLACEMENT)
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.showBtn.transform, RedPointConst.BACKHOME)
	manager.redPoint:unbindUIandKey(slot0.canteenBtn.transform, RedPointConst.CANTEEN)
	manager.redPoint:unbindUIandKey(slot0.chooseDormBtn.transform, RedPointConst.DORM_PLACEMENT)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgMask_, nil, function ()
		uv0:ShowView(false)
	end)
	slot0:AddBtnListener(slot0.showBtn, nil, function ()
		uv0:ShowView(true)
	end)
	slot0:AddBtnListener(slot0.visitBtn, nil, function ()
		JumpTools.OpenPageByJump("/dormVisitView", {
			enterType = "quick"
		})
	end)
	slot0:AddBtnListener(slot0.canteenBtn, nil, function ()
		if DormData:GetCurrectSceneID() == DormConst.CANTEEN_ID then
			uv0:ShowView(false)

			return
		end

		BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
	end)
	slot0:AddBtnListener(slot0.publicDormBtn, nil, function ()
		if DormData:GetCurrectSceneID() == DormConst.PUBLIC_DORM_ID then
			uv0:ShowView(false)

			return
		end

		if nullable(BackHomeCfg, slot0, "type") == DormConst.BACKHOME_TYPE.PrivateDorm then
			JumpTools.OpenPageByJump("/dormHeroDeployView")
		end

		BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
	end)
	slot0:AddBtnListener(slot0.chooseDormBtn, nil, function ()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	slot0:AddBtnListener(slot0.danceRoomBtn, nil, function ()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			uv0:ShowView(false)

			return
		end

		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
end

function slot0.ShowView(slot0, slot1)
	if slot0.show == slot1 then
		return
	end

	slot0.show = slot1

	if slot0.show then
		slot0.stateController:SetSelectedState("true")
		slot0:RefreshView()

		if slot0.clickFunc then
			slot0.clickFunc()
		end
	else
		slot0.stateController:SetSelectedState("false")

		slot0.show = false

		if slot0.closeFunc then
			slot0.closeFunc()
		end
	end
end

function slot0.RefreshView(slot0)
	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		slot0.canteenBtnController:SetSelectedState("off")
		slot0.publicDormBtnController:SetSelectedState("off")
		slot0.chooseDormBtnBtnController:SetSelectedState("off")
		slot0.danceBtnBtnController:SetSelectedState("on")
	elseif DormData:GetCurrectSceneID() == DormConst.CANTEEN_ID then
		slot0.canteenBtnController:SetSelectedState("on")
		slot0.publicDormBtnController:SetSelectedState("off")
		slot0.chooseDormBtnBtnController:SetSelectedState("off")
		slot0.danceBtnBtnController:SetSelectedState("off")
	elseif slot2 == DormConst.PUBLIC_DORM_ID then
		slot0.canteenBtnController:SetSelectedState("off")
		slot0.publicDormBtnController:SetSelectedState("on")
		slot0.chooseDormBtnBtnController:SetSelectedState("off")
		slot0.danceBtnBtnController:SetSelectedState("off")
	elseif BackHomeCfg[slot2].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot0.canteenBtnController:SetSelectedState("off")
		slot0.publicDormBtnController:SetSelectedState("off")
		slot0.chooseDormBtnBtnController:SetSelectedState("on")
		slot0.danceBtnBtnController:SetSelectedState("off")
	end
end

function slot0.AddClickCallBack(slot0, slot1)
	if slot1 then
		slot0.clickFunc = slot1
	end
end

function slot0.CloseCallBack(slot0, slot1)
	if slot1 then
		slot0.closeFunc = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
