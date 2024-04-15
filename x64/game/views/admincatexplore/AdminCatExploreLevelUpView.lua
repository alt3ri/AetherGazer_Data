slot0 = class("AdminCatExploreLevelUpView", ReduxView)

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExploreLevelUpPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBg_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateView(slot0)
	slot0.curLevel = AdminCatExploreData:GetDataByPara("level")
	slot0.lockRegion = AdminCatExploreData:GetDataByPara("nextLockRegion")[slot0.curLevel]
	slot0.lockAdminCat = AdminCatExploreData:GetDataByPara("nextLockAdminCat")[slot0.curLevel]

	SetActive(slot0.regionGo_, slot0.lockRegion ~= nil)
	SetActive(slot0.adminCatGo_, slot0.lockAdminCat ~= nil)

	slot0.titleImage_.sprite = getSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. slot0.curLevel)
	slot1 = ExploreLevelCfg[slot0.curLevel - 1]
	slot2 = ExploreLevelCfg[slot0.curLevel]

	if slot0.lockRegion then
		slot3 = ExploreAreaCfg[slot0.lockRegion]
		slot0.regionNameTxt_.text = GetI18NText(slot3.area_name)
		slot0.regionImage_.sprite = getSpriteWithoutAtlas("TextureBg/ExploreUI/" .. slot3.icon)
	end

	if slot0.lockAdminCat then
		slot3 = ExploreMeowCfg[slot0.lockAdminCat]
		slot0.adminCatNameTxt_.text = GetI18NText(slot3.meow_name)
		slot0.skillImg1_.sprite = getSpriteWithoutAtlas("TextureConfig/Chip/" .. ExploreMeowInbornCfg[slot3.inborn].inborn_icon)
		slot0.skillImg2_.sprite = getSpriteWithoutAtlas("TextureConfig/Chip/" .. ExploreMeowSkillCfg[slot3.skill].skill_icon)
		slot0.adminCatImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. slot3.meow_icon)
	end

	slot0.oldQueueTxt_.text = string.format(GetTips("EXPLORE_QUEUE_AMOUNT"), slot1.amount)
	slot0.newQueueTxt.text = string.format(GetTips("EXPLORE_LEVEL_UP"), slot2.amount)
	slot0.oldExploreTime_.text = string.format(GetTips("EXPLORE_MAX_TIME"), slot1.time)
	slot0.newExploreTime_.text = slot2.time .. GetTips("HOUR")
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
