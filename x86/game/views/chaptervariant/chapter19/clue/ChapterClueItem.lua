slot0 = class("ChapterClueItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.positionController_ = slot0.controllerEx_:GetController("position")
	slot0.geryController_ = slot0.controllerEx_:GetController("get")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.clueID_ = slot1

	if slot1 == 0 then
		slot0.nameText_.text = ""

		slot0.geryController_:SetSelectedState("false")
	else
		slot0.nameText_.text = StageArchiveCfg[slot1].name

		slot0.geryController_:SetSelectedState("true")
	end

	if slot2 % 2 == 1 then
		slot0.positionController_:SetSelectedState("state0")
	else
		slot0.positionController_:SetSelectedState("state1")
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.clueID_ == 0 then
			ShowTips("COLLECTION_CULE_AND_READ")

			return
		end

		JumpTools.OpenPageByJump("stageArchive", {
			isClue = true,
			archiveID = uv0.clueID_
		})
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
