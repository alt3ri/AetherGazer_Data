slot0 = class("IlluPlotDetailItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "ButItem")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.storyID_ = slot1
	slot0.type_ = slot2
	slot0.unlock_ = IllustratedData:GetPlotInfo()[slot1]

	if slot0.unlock_ then
		if (StoryCfg[slot1].videoPath ~= nil and slot3.videoPath ~= "" or VideoTrackCfg[slot1 .. ".usm"] ~= nil) and slot0.unlock_ ~= nil then
			slot0.controller_:SetSelectedState("video")
		else
			slot0.controller_:SetSelectedState("normal")
		end
	else
		slot0.controller_:SetSelectedState("empty")
	end

	slot0.nameText_.text = GetI18NText(StoryCfg[slot1].name)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if IllustratedData:GetPlotInfo()[uv0.storyID_] then
			manager.story:StartStoryById(uv0.storyID_, function (slot0)
				IllustratedAction.ViewIllustration(uv0.storyID_, CollectConst.PLOT)
				gameContext:Go("/blank")
				gameContext:Back()
			end)
		elseif uv0.type_ == 1 then
			slot0 = getStageViaStoryID(uv0.storyID_)
			slot3, slot4 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot0).toggle, slot0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot0), GetI18NText(slot3), GetI18NText(slot4)))
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
