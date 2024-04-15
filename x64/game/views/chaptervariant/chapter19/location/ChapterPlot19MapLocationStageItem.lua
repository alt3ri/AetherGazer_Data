slot0 = class("ChapterPlot19MapLocationStageItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stageTypeController_ = slot0.controllerEx_:GetController("type")
	slot0.clearController_ = slot0.controllerEx_:GetController("clear")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chapterID_ = slot1
	slot0.stageInfo_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.stageInfo_.stageType == BattleConst.PLOT_19_STAGE_TYPE.EVENT then
		slot3 = slot1.id
		slot0.nameText_.text = StageArchiveCfg[slot3].name

		slot0.stageTypeController_:SetSelectedState("event")
		slot0.clearController_:SetSelectedState(tostring(BattleStageData:HasReadLocationEvent(slot3) ~= nil))

		if ChapterTools.IsUnlockEvent(slot3) then
			slot0:Show(true)
		else
			slot0:Show(false)
		end
	else
		slot0.nameText_.text = BattleStageTools.GetStageCfg(ChapterCfg[slot0.chapterID_].type, slot1.id).name

		if slot2 == BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY then
			slot0.stageTypeController_:SetSelectedState("main")
		else
			slot0.stageTypeController_:SetSelectedState("side")
		end

		slot6 = false

		if BattleStageData:GetStageData()[slot3] then
			slot0:Show(true)

			if slot5.clear_times > 0 then
				slot6 = true
			end
		else
			slot0:Show(false)
		end

		slot0.clearController_:SetSelectedState(tostring(slot6))
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.stageInfo_.stageType == BattleConst.PLOT_19_STAGE_TYPE.EVENT then
			BattleStageAction.UpdateLocationEvent(slot0.id)

			slot1 = StageArchiveCfg[slot0.id]

			JumpTools.OpenPageByJump("gameHelpLong", {
				title = slot1.name,
				content = formatText(slot1.desc)
			})
		else
			uv0:Go("chapter19SectionInfo", {
				section = slot0.id,
				sectionType = ChapterCfg[uv0.chapterID_].type
			})
		end
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0.transform_:SetAsLastSibling()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

return slot0
