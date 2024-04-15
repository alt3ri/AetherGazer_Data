slot0 = class("IdolTraineeChapterListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not uv0.closeClick then
			JumpTools.OpenPageByJump("/idolTraineeLevelMainView", {
				chapterID = uv0.chapterID_
			})
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chapterID_ = slot1
	slot0.closeClick = slot2
	slot4, slot5 = IdolTraineeTools:GetChapterProgress(slot1)
	slot0.progress_.text = string.format("%s/%s", slot4, slot5)
	slot0.name_.text = IdolTraineeChapterCfg[slot1].title
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
