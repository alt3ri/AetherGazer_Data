slot0 = class("StrongholdOperateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdOperateUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.pageController = ControllerUtil.GetController(slot0.transform_, "page")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pages = {}
	slot0.classList = {
		StrongholdOperateTaskPage,
		StrongholdOperateSkillPage,
		StrongholdOperateIncreasePage,
		StrongholdOperateRewardPage
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_taskBtn, function ()
		uv0:SelectPage(1)
	end)
	slot0:AddBtnListener(nil, slot0.m_skillBtn, function ()
		uv0:SelectPage(2)
	end)
	slot0:AddBtnListener(nil, slot0.m_increaseBtn, function ()
		uv0:SelectPage(3)
	end)
	slot0:AddBtnListener(nil, slot0.m_rewardBtn, function ()
		uv0:SelectPage(4)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.activity_id

	if slot0.params_.selectIndex then
		slot0:SelectPage(slot0.params_.selectIndex)
	else
		slot0:SelectPage(1)
	end

	manager.redPoint:bindUIandKey(slot0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, slot0.activity_id))
	manager.redPoint:bindUIandKey(slot0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, slot0.activity_id))
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, slot0.activity_id))
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnCurrencyChange))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.curPage then
		slot0.curPage:SetActive(false)

		slot0.curPage = nil
	end

	slot0.curIndex = nil

	manager.redPoint:unbindUIandKey(slot0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, slot0.activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, slot0.activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, slot0.activity_id))
	slot0:RemoveAllEventListener()
end

function slot0.SelectPage(slot0, slot1)
	if slot1 == slot0.curIndex then
		return
	end

	slot0.curIndex = slot1

	slot0.pageController:SetSelectedIndex(slot1 - 1)

	if slot0.curPage then
		slot0.curPage:SetActive(false)
	end

	if not slot0.pages[slot1] then
		slot0.pages[slot1] = slot0.classList[slot1].New(slot0, slot0.m_content)
	end

	slot0.curPage = slot0.pages[slot1]

	slot0.curPage:Refresh(slot0.activity_id)
	slot0.curPage:SetActive(true)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.pages) do
		slot5:Dispose()
	end

	slot0.pages = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnStrongholdUpgradeIncrease(slot0)
	if slot0.curPage and slot0.curPage.OnStrongholdUpgradeIncrease then
		slot0.curPage:OnStrongholdUpgradeIncrease()
	end
end

function slot0.OnStrongholdUpdateReward(slot0)
	if slot0.curPage and slot0.curPage.OnStrongholdUpdateReward then
		slot0.curPage:OnStrongholdUpdateReward()
	end
end

function slot0.OnTaskListChange(slot0)
	if slot0.curPage and slot0.curPage.OnTaskListChange then
		slot0.curPage:OnTaskListChange()
	end
end

function slot0.OnCurrencyChange(slot0)
	if slot0.curPage and slot0.curPage.OnCurrencyChange then
		slot0.curPage:OnCurrencyChange()
	end
end

return slot0
