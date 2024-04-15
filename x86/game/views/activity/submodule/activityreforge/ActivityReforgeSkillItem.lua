slot0 = class("ActivityReforgeSkillItem", ReduxView)

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

	slot0.skillUseStateController_ = slot0.controllerEx_:GetController("skillUseState")
	slot0.selectController_ = slot0.controllerEx_:GetController("select")
	slot0.skillStatusController_ = slot0.controllerEx_:GetController("skillStatus")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_SKILL .. uv0.skillID_, 0)

		if uv0.clickHandle_ then
			uv0.clickHandle_(uv0.skillID_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.viewType_ = slot1
	slot0.skillID_ = slot2
	slot7 = ActivityReforgeSkillCfg[slot0.skillID_]
	slot0.clickHandle_ = slot3
	slot0.activityID_ = slot4
	slot0.levelID_ = slot5
	slot0.curSkillID_ = slot6

	if slot0.skillID_ == slot0.curSkillID_ then
		slot0.selectController_:SetSelectedState("true")
	else
		slot0.selectController_:SetSelectedState("false")
	end

	slot0.iconImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", slot7.icon)
	slot0.skillNameText_.text = slot7.name

	if slot0.viewType_ == 1 then
		if ActivityReforgeData:GetSkillIsLock(slot0.activityID_, slot0.skillID_) then
			slot0.skillUseStateController_:SetSelectedState("illustratedLock")
		elseif slot7.count == -1 then
			slot0.skillUseStateController_:SetSelectedState("freeNormal")
		else
			slot0.skillUseStateController_:SetSelectedState("normal")
			slot0.skillStatusController_:SetSelectedState("useNum" .. slot7.count)

			for slot12 = 1, 3 do
				SetActive(slot0["useNumGo" .. slot12 .. "_"], true)
			end
		end
	else
		slot0.skillStatus_, slot0.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(slot0.activityID_, slot0.levelID_, slot0.skillID_)

		slot0.skillUseStateController_:SetSelectedState(slot0.skillStatus_)

		if slot0.skillStatus_ == "using" or slot0.skillStatus_ == "normal" or slot0.skillStatus_ == "lock" or slot0.skillStatus_ == "haveNot" or slot0.skillStatus_ == "ban" then
			slot0.skillStatusController_:SetSelectedState("useNum" .. slot7.count)

			if slot0.skillStatus_ == "using" or slot0.skillStatus_ == "normal" then
				for slot12 = 1, 3 do
					if slot12 <= slot0.skillCanUseNum_ then
						SetActive(slot0["useNumGo" .. slot12 .. "_"], true)
					else
						SetActive(slot0["useNumGo" .. slot12 .. "_"], false)
					end
				end
			else
				for slot12 = 1, 3 do
					SetActive(slot0["useNumGo" .. slot12 .. "_"], false)
				end
			end
		end
	end

	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.ACTIVITY_REFORGE_SKILL .. slot0.skillID_)
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.ACTIVITY_REFORGE_SKILL .. slot0.skillID_)
end

function slot0.SetIsActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0.clickHandle_ = nil

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
