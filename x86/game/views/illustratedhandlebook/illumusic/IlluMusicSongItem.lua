slot0 = class("IlluMusicSongItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.handler = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.expand = false
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.expandController = ControllerUtil.GetController(slot0.transform_, "expand")
	slot0.playController = ControllerUtil.GetController(slot0.transform_, "play")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_expandBtn, nil, function ()
		uv0:SetExpand(not uv0.expand)
	end)
	slot0:AddBtnListener(slot0.m_playBtn, nil, function ()
		if uv0.handler and uv0.handler.PlayMusic then
			uv0.handler:PlayMusic(uv0.id)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.id = slot1
	slot2 = MusicRecordCfg[slot1]
	slot0.m_info.text = GetI18NText(slot2.detail)
	slot5 = slot0.m_title.transform.rect.size

	if slot5.x < UnityEngine.TextGenerator.New():GetPreferredWidth(GetI18NText(slot2.musicName), slot0.m_title:GetGenerationSettings(slot5)) / slot0.m_title.pixelsPerUnit then
		slot10 = utf8len(slot8 .. "...")

		while slot5.x < slot9 do
			if slot10 <= 4 then
				slot8 = GetI18NText(slot3)

				break
			end

			slot9 = slot4:GetPreferredWidth(utf8sub(slot8, 1, slot10 - 1 - 3) .. "...", slot6) / slot7
		end
	end

	slot0.m_title.text = slot8

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_info.transform)
	slot0:SetExpand(slot0.expand)
end

function slot0.RefreshSongsState(slot0, slot1)
	slot0.playController:SetSelectedIndex(slot0.id == slot1 and 1 or 0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetExpand(slot0, slot1)
	slot0.expand = slot1

	if slot1 then
		slot0.expandController:SetSelectedIndex(1)
	else
		slot0.expandController:SetSelectedIndex(0)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_info.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)

	if slot0.handler and slot0.handler.ForceRebuild then
		slot0.handler:ForceRebuild()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
