slot0 = class("EnterBattleSelectOpponentPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
	slot0:RegisterEvents()

	slot0.opponentUIList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.opponentList_, SelectOpponentListItem)
	slot0.showFlag = false
	slot0.typeController_ = slot0.mainControllerEx_:GetController("type")
	slot0.stateController = slot0.mainControllerEx_:GetController("state")
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(IDOL_TRAINEE_REFRESH_OPPONENT, function ()
	end)
end

function slot0.ShowPage(slot0, slot1)
	if slot0.showFlag == slot1 then
		return
	end

	slot0.showFlag = slot1

	if slot1 then
		slot0.stateController:SetSelectedState("show")
		slot0:OnEnter()
	else
		slot0.stateController:SetSelectedState("close")
		slot0:OnExit()
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.strangerBtn_, nil, function ()
		if uv0.canClick then
			uv0.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.stranger, function ()
				uv0:ChangeContent(IdolTraineeConst.friendType.stranger)

				uv0.canClick = true
			end)
		end
	end)
	slot0:AddBtnListener(slot0.friendBtn_, nil, function ()
		if uv0.canClick then
			uv0.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.friend, function ()
				uv0:ChangeContent(IdolTraineeConst.friendType.friend)

				uv0.canClick = true
			end)
		end
	end)
	slot0:AddBtnListener(slot0.refreshBtn_, nil, function ()
		if uv0.canClick then
			uv0.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.stranger, function ()
				uv0:ChangeContent(uv0.curContent_, true)

				uv0.canClick = true
			end, true)
		end
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.infoList[slot1], slot0.curContent_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0:ChangeContent(slot1 or slot0.curContent_ or IdolTraineeConst.friendType.friend, true)
end

function slot0.ChangeContent(slot0, slot1, slot2)
	if slot0.curContent_ == slot1 and not slot2 then
		return
	end

	slot0.curContent_ = slot1

	if slot1 == IdolTraineeConst.friendType.friend then
		slot0.typeController_:SetSelectedState("friend")
	else
		slot0.typeController_:SetSelectedState("stranger")
	end

	slot0:RefreshPlayerInfoList()
end

function slot0.OnEnter(slot0)
	slot0.canClick = true

	if slot0.canClick then
		slot0.canClick = false

		IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.friend, function ()
			uv0:ChangeContent(IdolTraineeConst.friendType.friend)

			uv0.canClick = true
		end)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.RefreshPlayerInfoList(slot0)
	slot0.infoList = IdolTraineeTools:GetOpponentList(slot0.curContent_)

	if slot0.infoList then
		slot0.opponentUIList_:StartScroll(#slot0.infoList)
	end
end

function slot0.Dispose(slot0)
	slot0.infoList = nil

	slot0.opponentUIList_:Dispose()

	slot0.opponentUIList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
