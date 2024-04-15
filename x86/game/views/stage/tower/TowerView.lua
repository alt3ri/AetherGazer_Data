slot0 = class("TowerView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Tower/TowerUI_NEW"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectIndex_ = -1

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.currentController = ControllerUtil.GetController(slot0.transform_, "current")
end

function slot0.AddUIListener(slot0)
	slot4 = nil

	slot0:AddBtnListener(slot0.m_maskBtn, slot4, function ()
		uv0:CloseSectionInfo()
	end)

	for slot4 = 1, 10 do
		if slot0["m_tower_" .. slot4] then
			slot0:AddBtnListener(slot5, nil, function ()
				uv0.selectIndex_ = uv1

				uv0.selectController:SetSelectedIndex(uv0.selectIndex_)
				uv0:RefreshUI()
			end)
		end
	end
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.chapterId
	slot0.chapterId = slot1
	slot0.towerList = TowerData:GetTowerList(slot1)
	slot0.curId = TowerData:GetCurId(slot1)

	slot0.currentController:SetSelectedIndex(table.indexof(slot0.towerList, slot0.curId) or 11)

	if not slot0.params_.showInfo or not slot2 then
		slot0.selectIndex_ = 0

		slot0.selectController:SetSelectedIndex(slot0.selectIndex_)
		slot0:OnTowerContentShow(false)
	else
		slot0.selectIndex_ = slot2

		slot0.selectController:SetSelectedIndex(slot0.selectIndex_)
		slot0:RefreshUI()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SPAWN_DESCRIPE")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.RefreshUI(slot0)
	slot0:OnTowerContentShow(true, slot0.selectIndex_)

	slot1 = slot0.towerList[slot0.selectIndex_]

	slot0:Go("towerSelectionInfo", {
		towerId = slot1,
		curId = slot0.curId,
		clickBackFunc = handler(slot0, slot0.BackToCurSelect),
		btnTips = (not slot0.curId or slot1 <= slot0.curId) and GetTips("READY_BATTLE") or GetTips("BACK_TO_CURRENT")
	})
end

function slot0.BackToCurSelect(slot0)
	slot0.selectIndex_ = table.indexof(slot0.towerList, slot0.curId) or 1

	slot0.selectController:SetSelectedIndex(slot0.selectIndex_)
	slot0:RefreshUI()
end

function slot0.CloseSectionInfo(slot0)
	if slot0:IsOpenRoute("towerSelectionInfo") then
		slot0:OnTowerContentShow(false)
		JumpTools.Back()
	end

	slot0.selectController:SetSelectedIndex(0)
end

function slot0.OnTowerContentShow(slot0, slot1, slot2)
	if slot1 then
		slot0:RemoveTween()

		slot0.tween_ = LeanTween.value(slot0.m_middleContent.gameObject, slot0.m_middleContent.localPosition.x, -slot0["m_tower_" .. slot2].transform.localPosition.x - 350, 0.3):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_middleContent.localPosition = Vector3(slot0, 0, 0)
		end))
	else
		slot0:RemoveTween()

		slot0.tween_ = LeanTween.value(slot0.m_middleContent.gameObject, slot0.m_middleContent.localPosition.x, 0, 0.3):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_middleContent.localPosition = Vector3(slot0, 0, 0)
		end))
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_middleContent.gameObject)

		slot0.tween_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveTween()
	uv0.super.Dispose(slot0)
end

return slot0
