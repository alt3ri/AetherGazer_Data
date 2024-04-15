slot0 = class("ActivityReforgeSkillSmallItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.emptyController_ = slot0.controllerEx_:GetController("empty")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 1,
			viewType = 2,
			activityID = uv0.activityID_,
			chapterActivityID = uv0.chapterActivityID_,
			levelID = uv0.levelID_,
			skillID = uv0.skillID_,
			slot = uv0.index_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.activityID_ = slot1
	slot0.chapterActivityID_ = slot2
	slot0.levelID_ = slot3
	slot0.index_ = slot4
	slot0.skillID_ = ActivityReforgeData:GetCurUsingInitiativeSkill(slot0.index_)

	if slot0.skillID_ == 0 then
		slot0.emptyController_:SetSelectedState("true")
	else
		slot0.emptyController_:SetSelectedState("false")

		slot0.icon_.sprite = getSprite("Atlas/ValhallaSkillAtlas", ActivityReforgeSkillCfg[slot0.skillID_].icon)
	end
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

return slot0
