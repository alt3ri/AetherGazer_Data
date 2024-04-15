slot0 = class("RegressionNewPage_2_0", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("Widget/System/ReturnTwo/RT2stAdd2UI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.drawPoolBtn_, nil, function ()
		if uv0.drawCfg_ then
			if not ActivityData:GetActivityIsOpen(uv0.drawCfg_[2]) then
				ShowTips("REGRESSION_JUMP")

				return
			end

			JumpTools.GoToSystem("/draw", {
				poolId = ActivityDrawPoolCfg[slot0].config_list[1]
			}, ViewConst.SYSTEM_ID.DRAW)
		end
	end)
	slot0:AddBtnListener(slot0.plotBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.plotCfg_[2]) then
			ShowTips("REGRESSION_JUMP")

			return
		end

		ChapterTools.GotoChapterStagePage(uv0.plotList_)
	end)
	slot0:AddBtnListener(slot0.progressBtn_, nil, function ()
		ChapterTools.GotoMaxChapterClient()
	end)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0)
	slot0.drawActivityList_ = {}
	slot0.plotList_ = {}

	for slot5, slot6 in ipairs(GameSetting.regression_jump.value) do
		if slot6[1] == 3 then
			if ActivityData:GetActivityIsOpen(slot6[2]) == true then
				slot0.drawActivityList_[#slot0.drawActivityList_ + 1] = slot6
			end
		elseif slot6[1] == 4 then
			slot0.progressCfg_ = slot6
		elseif ActivityData:GetActivityIsOpen(slot6[2]) == true then
			slot0.plotList_[#slot0.plotList_ + 1] = slot6
		end
	end

	slot0:RefreshDrawUI()
	slot0:RefreshPlotUI()
	slot0:RefreshProgressUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.RefreshDrawUI(slot0)
	if #slot0.drawActivityList_ > 0 then
		SetActive(slot0.drawItemGo_, true)

		slot1 = 1

		for slot5, slot6 in ipairs(slot0.drawActivityList_) do
			if ActivityData:GetActivityIsOpen(slot6[2]) == true then
				slot1 = slot5
			end
		end

		slot0.drawCfg_ = slot0.drawActivityList_[slot1]
		slot0.drawIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Announcements/" .. MainAdvinfoCfg[slot0.drawCfg_[3]].picture .. SettingData:GetCurrentLanguageKey())
	else
		SetActive(slot0.drawItemGo_, false)
	end
end

function slot0.RefreshPlotUI(slot0)
	if #slot0.plotList_ > 0 then
		SetActive(slot0.plotItemGo_, true)

		slot0.plotCfg_ = slot0.plotList_[ChapterTools.GetActivityChapterIndex(slot0.plotList_)]
		slot0.plotIcon_.sprite = getSpriteViaConfig("ActivityBannerTextures", slot0.plotCfg_[4] .. SettingData:GetCurrentLanguageKey())
	else
		SetActive(slot0.plotItemGo_, false)
	end
end

function slot0.RefreshProgressUI(slot0)
	slot0.progressIcon_.sprite = getSpriteWithoutAtlas("TextureBg/ReturnTwo/" .. slot0.progressCfg_[3])
end

return slot0
