slot0 = class("ActivityReforgeLevelViewItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.clickHandler_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.levelController_ = slot0.controllerEx_:GetController("Level")
	slot0.isPassController_ = slot0.controllerEx_:GetController("ispass")
	slot0.isBattlingController_ = slot0.controllerEx_:GetController("isbattling")
	slot0.isSelectController_ = slot0.controllerEx_:GetController("isselect")
	slot0.isLast_ = false
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.index_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.chapterActivityID_ = slot2
	slot0.levelID_ = slot3

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.cfg_ = ActivityReforgeLevelCfg[slot0.levelID_]

	slot0.levelController_:SetSelectedState(slot0.index_)

	if slot0.levelID_ == ActivityReforgeData:GetCurLevel() then
		slot2 = ActivityReforgeLevelCfg[slot0.levelID_].wave_list
		slot0.isLast_ = slot2[#slot2] == ActivityReforgeData:GetCurLastWinWaveID()

		if slot0.isLast_ then
			slot0.curWaveNum_.text = string.format(GetTips("ACTIVITY_REFORGE_WAVE"), ActivityReforgeData:GetCurLevelFinishWave())
		else
			slot0.curWaveNum_.text = string.format(GetTips("ACTIVITY_REFORGE_WAVE"), ActivityReforgeData:GetCurLevelFinishWave() + 1)
		end

		slot0.isBattlingController_:SetSelectedState("true")
	else
		slot0.isBattlingController_:SetSelectedState("false")
	end

	if ActivityReforgeData:GetLevelIsFinish(slot0.chapterActivityID_, slot0.levelID_) then
		slot0.isPassController_:SetSelectedState("true")
	else
		slot0.isPassController_:SetSelectedState("false")
	end
end

function slot0.RefreshSelect(slot0, slot1)
	if slot0.index_ == slot1 then
		slot0.isSelectController_:SetSelectedState("true")
	else
		slot0.isSelectController_:SetSelectedState("false")
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

return slot0
