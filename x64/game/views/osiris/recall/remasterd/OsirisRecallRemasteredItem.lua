slot1 = class("OsirisRecallRemasteredItem", import("game.views.osiris.recall.OsirisRecallItem"))

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_button, nil, function ()
		saveData("osirisExtraStory", "osiris_" .. uv0.id, 1)
		uv0:RefreshNotice()
		manager.notify:Invoke(PLAY_EXTRA_STORY_START)
		manager.story:StartStoryById(uv0.id, function ()
			manager.notify:Invoke(PLAY_EXTRA_STORY_OVER)
		end)
	end)
end

function slot1.SetData(slot0, slot1)
	slot0.id = slot1
	slot0.m_button.interactable = true

	slot0.stateController:SetSelectedIndex(0)

	slot0.m_name.text = StoryCfg[slot1] and GetI18NText(slot2.name) or ""

	slot0:RefreshNotice()
end

function slot1.RefreshNotice(slot0)
	if getData("osirisExtraStory", "osiris_" .. slot0.id) then
		SetActive(slot0.noticeGo_, false)
	else
		SetActive(slot0.noticeGo_, true)
	end
end

return slot1
