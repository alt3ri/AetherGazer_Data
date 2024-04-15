slot0 = class("HeroClueItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.clueID_ = slot2
	slot0.activityID_ = slot3
	slot0.index_ = slot4

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		if not uv0.curData_ then
			ShowTips("ACTIVITY_HERO_CLUE_NULL")

			return
		end

		if uv0.curData_.level < #HeroClueCfg[uv0.clueID_].level then
			ShowTips("ACTIVITY_HERO_CLUE_NOT_ENOUGH")

			return
		end

		HeroClueData:SetSelectedClue(uv0.activityID_, uv0.clueID_)
		JumpTools.OpenPageByJump("heroClueDetail", {
			activityID = uv0.activityID_,
			clueID = uv0.clueID_
		})
	end)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.curData_ = HeroClueData:GetUnlockClueDataDic()[slot0.clueID_]

	if slot0.curData_ == nil then
		slot0.nameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")

		slot0.statusController_:SetSelectedState("lock")
	else
		slot0.clueIcon_.sprite = getSpriteWithoutAtlas(HeroClueCfg[slot0.clueID_].icon_path)

		if slot0.curData_.level < 2 then
			slot0.nameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		else
			slot0.nameText_.text = slot1.name
		end

		slot0.progressText_.text = string.format("%d/%d", slot0.curData_.level, #slot1.level)

		slot0.statusController_:SetSelectedIndex(slot0.curData_.level)
	end

	if slot0.index_ < 10 then
		slot0.indexText_.text = "0" .. slot0.index_
	else
		slot0.indexText_.text = slot0.index_
	end
end

return slot0
