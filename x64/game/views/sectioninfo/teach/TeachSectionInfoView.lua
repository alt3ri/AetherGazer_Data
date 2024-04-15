slot0 = class("TeachSectionInfoView", SectionInfoBaseView)

function slot0.UpdateBar(slot0)
	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
end

function slot0.OnUpdate(slot0)
	if slot0.stageID_ == slot0.params_.section then
		return
	end

	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		uv0:OnClickBtn()
	end)
	slot0:AddBtnListener(slot0.buttonWeb_, nil, function ()
		if not SDKTools.IsSDK() then
			Application.OpenURL(TeachStageExInfoCfg[uv0.stageID_].video_url)
		else
			LuaForUtil.OpenWebView(slot1.video_url, true, function ()
				manager.audio:PauseAll(true)
				print("--->> open webView")
			end, function ()
				print("====>>> close webView")
				manager.audio:PauseAll(false)
			end)
		end

		SDKTools.SendMessageToSDK("lecture_video", {
			channel_type = 2,
			videro_channel = uv0.stageID_
		})
	end)
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshVideoUI()
	slot0.hideFatigueController_:SetSelectedState("close")
end

function slot0.RefreshData(slot0)
	slot2 = nil

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == slot0.stageType_ then
		slot2 = BattleBaseTeachStageCfg[slot0.stageID_]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == slot0.stageType_ then
		slot2 = BattleHeroTeachStageCfg[slot1]
	end

	slot0.stageCfg_ = slot2
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost_ = 0
	slot0.isFirstClear_ = (BattleTeachData:GetStageData()[slot0.stageID_] or 0) <= 0
	slot0.dropLibID_ = slot0.stageCfg_ and slot0.stageCfg_.drop_lib_id or 0

	BattleFieldData:SetCacheStage(getChapterAndSectionID(slot1), slot1)
	slot0.hideStageDescController_:SetSelectedState("false")
end

function slot0.RefreshVideoUI(slot0)
	slot2 = TeachStageExInfoCfg[slot0.stageID_]

	if SDKTools.GetIsOverSea() then
		slot0.btnWebController_:SetSelectedState("notshow")
	elseif slot2 and slot2.video_url ~= "" and true or false then
		slot0.btnWebController_:SetSelectedState("show")
	else
		slot0.btnWebController_:SetSelectedState("notshow")
	end
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).id then
		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(slot0.stageType_, slot0.stageID_)
		slot0.sectionText_.text = string.format("%s-%s", GetI18NText(slot2), GetI18NText(slot3))
		slot0.sectionName_.text = GetI18NText(slot1.name)
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.oldCfgID_ = slot1.id
		slot0.storyText_.text = GetI18NText(slot1.tips)
	end
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.stageID_,
		sectionType = slot0.stageType_
	})
end

return slot0
