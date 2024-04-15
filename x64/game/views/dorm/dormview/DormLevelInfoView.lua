slot0 = class("DormLevelInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormPoplevelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.levelScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DormLevelAwardItem)
	slot0.maxController = ControllerUtil.GetController(slot0.gameObject_.transform, "level")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot0.archiveID = slot0.params_.archiveID
	end

	slot0:RefreshList()
	slot0:RefreshExp()
end

function slot0.OnExit(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList[slot1], slot1, slot0.curLevel)
end

function slot0.RefreshList(slot0)
	slot0.itemList = BackHomeHeroCfg[DormData:GetHeroInfo(slot0.archiveID):GetCanUseHeroList()[1]].level_reward
	slot0.curLevel = DormitoryData:GetDormLevel(slot0.roomID)

	slot0.levelScroll:StartScroll(#slot0.itemList)
	slot0.levelScroll:ScrollToIndex(slot0.curLevel, false, false)
end

function slot0.RefreshExp(slot0)
	slot1 = DormitoryData:GetDormLevel(slot0.roomID)
	slot0.level.text = tostring(slot1)

	if slot1 == #BackHomeDormLevel.all then
		slot0.maxController:SetSelectedState("full_rank")

		slot0.curExp.text = ""
		slot0.maxExp.text = ""
		slot0.progress.value = 1

		return
	end

	slot2 = DormitoryData:GetDormExp(slot0.roomID)
	slot3 = 0

	if slot1 >= 1 then
		for slot7 = 1, slot1 do
			slot3 = slot3 + BackHomeDormLevel[slot7].exp
		end
	end

	slot0.curExp.text = slot2
	slot0.maxExp.text = "/" .. slot3
	slot0.progress.value = slot2 / slot3
end

function slot0.Dispose(slot0)
	if slot0.levelScroll then
		slot0.levelScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
