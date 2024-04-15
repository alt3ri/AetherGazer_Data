slot0 = class("ChapterPlot19StoryCollectStoryItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot0 = StageArchiveCfg[uv0.storyID_]

		JumpTools.OpenPageByJump("gameHelpLong", {
			title = slot0.name,
			content = formatText(slot0.desc)
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.storyID_ = slot1
	slot0.nameText_.text = StageArchiveCfg[slot1].name

	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
