slot0 = class("ChapterBaseItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.chapterClientID_ = slot3
	slot0.chapterToggle_ = slot4
	slot0.transform_.name = slot3

	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	slot0:RefrshData()
	slot0:RefreshItem()
	slot0:RefreshLock()
	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
	slot0:Show(false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if BattleFieldData:GetCacheChapterClient(uv0.chapterToggle_) ~= uv0.chapterClientID_ then
			BattleFieldData:SetCacheChapterClient(uv0.chapterToggle_, slot0)
			manager.notify:Invoke(CHANGE_DUNGEON)

			return
		end

		BattleFieldData:SetCacheChapterClient(uv0.chapterToggle_, slot0)

		if not uv0:GetLockState() then
			SystemRedPoint:CancelNewTagByChapterId(slot0)
		end

		uv0:ClickItem(slot0)
	end)
end

function slot0.RefrshData(slot0)
	slot0:IsNotice()
	slot0:IsLock()
end

function slot0.IsNotice(slot0)
	slot0.notice_ = false
end

function slot0.GetLockState(slot0)
	return slot0.isLock_
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.PlayAnimatorEnter(slot0)
	if slot0.gameObject_.activeInHierarchy then
		slot0.animator_:Play("Fx_mapRenderItemt_cx", 0, 0)
		slot0.animator_:Update(0)
	end
end

function slot0.PlayAnimatorExit(slot0)
	if slot0.gameObject_.activeInHierarchy then
		slot0.animator_:Play("Fx_mapRenderItemt_xs", 0, 0)
		slot0.animator_:Update(0)
	end
end

function slot0.RefreshItem(slot0)
	if not ChapterClientCfg[slot0.chapterClientID_] then
		return
	end

	slot0.nameText_.text = GetI18NText(slot1.name)

	slot0:RefreshCustomItem(slot1)
end

function slot0.RefreshCustomItem(slot0, slot1)
end

function slot0.RefreshLock(slot0)
	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.SetPosition(slot0, slot1, slot2, slot3)
	slot0.transform_.localPosition = Vector3(slot1, slot2, slot0.transform_.localPosition.z)
	slot0.transform_.localScale = Vector3(slot3, slot3, 1)
end

function slot0.InvokeBtn(slot0)
	slot0.isAbove_ = true

	slot0.btn_.onClick:Invoke()
end

function slot0.GetChapterClientID(slot0)
	return slot0.chapterClientID_
end

function slot0.IsLock(slot0)
	slot0.isLock_, slot0.lockTips_ = JumpTools.GetSystemLockedText(ChapterClientCfg[slot0.chapterClientID_].jump_system)
end

function slot0.GetLockTips(slot0)
	return slot0.lockTips_
end

return slot0
