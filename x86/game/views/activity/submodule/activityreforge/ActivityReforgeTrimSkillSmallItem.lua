slot0 = class("ActivityReforgeTrimSkillSkillItem", ReduxView)

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

	slot0.stateController_ = slot0.controllerEx_:GetController("state")
	slot0.skillStateController_ = slot0.controllerEx_:GetController("skillState")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = uv0.activityID_,
			chapterActivityID = uv0.chapterActivityID_,
			levelID = uv0.levelID_,
			skillID = uv0.skillID_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.activityID_ = slot1
	slot0.chapterActivityID_ = slot2
	slot0.levelID_ = slot3
	slot0.skillID_ = slot4

	if slot0.skillID_ == 0 then
		slot0.stateController_:SetSelectedState("empty")
	else
		slot0.stateController_:SetSelectedState("icon")

		slot0.icon_.sprite = getSprite("Atlas/ValhallaSkillAtlas", ActivityReforgeSkillCfg[slot0.skillID_].icon)
		slot0.skillStatus_, slot0.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(slot0.activityID_, slot0.levelID_, slot0.skillID_)

		if slot0.skillStatus_ == "freeUsing" or slot0.skillStatus_ == "infiniteUsing" then
			slot0.skillStateController_:SetSelectedState("infinite")
		else
			slot0.skillStateController_:SetSelectedState("useNum" .. slot5.count)

			for slot10 = 1, 3 do
				if slot10 <= slot0.skillCanUseNum_ then
					SetActive(slot0["useNumGo" .. slot10 .. "_"], true)
				else
					SetActive(slot0["useNumGo" .. slot10 .. "_"], false)
				end
			end
		end
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
