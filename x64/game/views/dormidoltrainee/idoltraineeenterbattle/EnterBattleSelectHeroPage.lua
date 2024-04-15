slot0 = class("EnterBattleSelectHeroPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.charaItem_ = {}

	slot0:BindCfgUI(slot0.changeCharaGo_, slot0.charaItem_)

	slot0.infoPage_ = IdolTraineeTrainInfoPage.New(slot0.heroInfoSubView_)
	slot0.heroList_ = {}
	slot0.curHeroID_ = 0
	slot0.curHeroIndex_ = 0
	slot0.heroUIList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.heroListGo_, IdolTraineeHeadItem)
	slot0.detailController_ = slot0.mainControllerEx_:GetController("showDetail")
	slot0.curAtkController_ = slot0.mainControllerEx_:GetController("curAtk")
	slot0.curDefController_ = slot0.mainControllerEx_:GetController("curDef")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.setAttackCharaBtn_, nil, function ()
		IdolTraineeAction.RequestSetAttackHero(uv0.curHeroID_, function ()
			uv0:RefreshUI()
			IdolTraineeCampBridge.GenerateAttackHero(uv0.curHeroID_)
		end)
	end)
	slot0:AddBtnListener(slot0.setDefendCharaBtn_, nil, function ()
		IdolTraineeAction.RequestSetDefendHero(uv0.curHeroID_, function ()
			uv0:RefreshUI()
		end)
	end)
end

function slot0.ShowPage(slot0, slot1)
	if slot0.showFlag == slot1 then
		return
	end

	slot0.showFlag = slot1

	if slot1 then
		slot0.detailController_:SetSelectedState("true")
		slot0:OnEnter()

		if slot0.showCallBack then
			slot0.showCallBack()
		end
	else
		slot0.detailController_:SetSelectedState("false")
		slot0:OnExit()

		if slot0.closeCallBack then
			slot0.closeCallBack()
		end
	end
end

function slot0.SetShowCallBack(slot0, slot1, slot2)
	if slot1 then
		slot0.showCallBack = slot1
	end

	if slot2 then
		slot0.closeCallBack = slot2
	end
end

function slot0.OnEnter(slot0)
	if slot0.showFlag then
		slot0:RefreshUI()
	end
end

function slot0.OnExit(slot0)
	if slot0.showFlag then
		-- Nothing
	end
end

function slot0.RefreshUI(slot0)
	slot0.heroList_ = IdolTraineeData:GetIdolHeroList() or {}
	slot1 = IdolTraineeData:GetCurAttackHero()

	if not slot0.curHeroID_ or slot0.curHeroID_ == 0 then
		for slot5, slot6 in pairs(slot1) do
			if slot6 == true then
				slot0.curHeroID_ = slot5
			end
		end
	end

	if slot0.curHeroID_ then
		slot0.curHeroIndex_ = table.keyof(slot0.heroList_, slot0.curHeroID_)
		slot0.charaItem_.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(slot0.curHeroID_)
	end

	IdolTraineeCampBridge.GenerateAttackHero(slot0.curHeroID_)
	slot0:UpdateView(slot0.curHeroID_)
	slot0.heroUIList_:StartScroll(#slot0.heroList_)
end

function slot0.UpdateView(slot0, slot1)
	slot0.curHeroID_ = slot1

	slot0.curDefController_:SetSelectedState(IdolTraineeTools:CheckHeroIsDefine(slot0.curHeroID_) and "true" or "false")
	slot0.curAtkController_:SetSelectedState(IdolTraineeTools:CheckHeroIsAttack(slot0.curHeroID_) and "true" or "false")
	slot0.infoPage_:RefreshUI(IdolTraineeTools:GetHeroBattleInfoTemplate(slot0.curHeroID_))
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.heroList_[slot1], slot0.curHeroID_, function ()
		if uv0.curHeroID_ ~= 0 and uv0.curHeroIndex_ ~= 0 and uv0.heroUIList_:GetItemByIndex(uv0.curHeroIndex_) then
			slot0:SelectOff()
		end

		uv0.curHeroIndex_ = uv1

		uv2:SelectOn()
		uv0:UpdateView(uv0.heroList_[uv1])
	end)
end

function slot0.Dispose(slot0)
	if slot0.heroUIList_ then
		slot0.heroUIList_:Dispose()

		slot0.heroUIList_ = nil
	end

	if slot0.infoPage_ then
		slot0.infoPage_:Dispose()

		slot0.infoPage_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
