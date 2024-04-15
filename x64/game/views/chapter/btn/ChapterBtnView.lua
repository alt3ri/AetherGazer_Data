slot0 = class("ChapterBtnView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.toggle_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.switchController_ = ControllerUtil.GetController(slot0.transform_, "tab")
end

function slot0.OnEnter(slot0)
	slot0:RefreshRedPoint()

	slot0.isLock_ = false

	if slot0.toggle_ == BattleConst.TOGGLE.RESOURCE then
		slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_DAILY)
	elseif slot0.toggle_ == BattleConst.TOGGLE.EQUIP then
		slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP)
	elseif slot0.toggle_ == BattleConst.TOGGLE.CHALLENGE then
		slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_ASTROLABE)
	end

	slot0:RefreshLock()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.active_ then
			return
		end

		slot1 = ViewConst.SYSTEM_ID.BATTLE

		if uv0.toggle_ == BattleConst.TOGGLE.MAIN then
			slot1 = ViewConst.SYSTEM_ID.BATTLE
		elseif slot0 == BattleConst.TOGGLE.RESOURCE then
			slot1 = ViewConst.SYSTEM_ID.BATTLE_DAILY
		elseif slot0 == BattleConst.TOGGLE.CHALLENGE then
			slot1 = ViewConst.SYSTEM_ID.BATTLE_ASTROLABE
		elseif slot0 == BattleConst.TOGGLE.EQUIP then
			slot1 = ViewConst.SYSTEM_ID.BATTLE_EQUIP
		end

		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = uv0.toggle_
		}, slot1)
		OperationRecorder.Record(uv0.class.__cname, tostring(uv0.toggle_))
	end)
end

function slot0.SelectChapterToggle(slot0, slot1)
	slot0.active_ = slot1

	if slot1 then
		slot0.switchController_:SetSelectedState("select")
	else
		slot0:RefreshLock()
	end
end

function slot0.RefreshRedPoint(slot0)
	if slot0.toggle_ == BattleConst.TOGGLE.MAIN then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_MAIN)
	elseif slot1 == BattleConst.TOGGLE.CHALLENGE then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_CHALLENGE)
	elseif slot1 == BattleConst.TOGGLE.EQUIP then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_EQUIP)
	elseif slot1 == BattleConst.TOGGLE.RESOURCE then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.RESOURSE_STAGE)
	end
end

function slot0.RefreshLock(slot0)
	if slot0.isLock_ then
		slot0.switchController_:SetSelectedState("lock")
	else
		slot0.switchController_:SetSelectedState("notSelect")
	end
end

return slot0
