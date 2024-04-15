slot0 = class("PosterGirlMgr")

function slot0.Ctor(slot0)
	slot0.view_tag = PosterGirlConst.ViewTag.null
	slot0.view_data = nil
	slot0.actor = nil

	slot0:Init()
end

function slot0.Init(slot0)
end

function slot0.SetViewTag(slot0, slot1, slot2)
	if slot1 == slot0.view_tag then
		return
	end

	slot0.view_tag = slot1
	slot0.view_data = slot2

	if PosterGirlConst.ViewTag.null == slot0.view_tag then
		if slot0.actor then
			slot0.actor:Dispose()
		end

		slot0.actor = nil
	else
		slot0:RefreshModel()
	end
end

function slot0.GetViewTag(slot0)
	return slot0.view_tag
end

function slot0.RefreshModel(slot0)
	if slot0.view_tag == PosterGirlConst.ViewTag.playerInfo_other then
		slot0:RefreshOtherModel(slot0.view_data)
	else
		slot0:RefreshCommonModel()
	end

	if slot0.actor then
		slot0.actor:UpdateViewTag(slot0.view_tag)
		slot0.actor:DoInit(slot0.view_tag)
	end
end

function slot0.RefreshCommonModel(slot0)
	slot3 = HeroTools.HeroUsingSkinInfo(PlayerData:GetPlayerInfo().poster_girl).id
	slot4 = SkinCfg[slot3]
	slot6 = HomeSceneSettingData:GetCurScene()

	if SkinSceneActionCfg[slot3] and slot5.special_scene_id == slot6 then
		if slot0.actor and slot0.actor:GetSkinId() == slot3 and slot0.actor:GetModelId() == slot5.special_action then
			return
		end

		if slot0.actor then
			slot0.actor:Dispose()
		end

		if HomeSceneSettingCfg[slot6].limit_display == 0 then
			slot0.actor = PosterGirlDlcActor.New(slot3, slot7)
		else
			slot0.actor = PosterTzeroActor.New(slot3, slot7)
		end
	else
		if slot0.actor and slot0.actor:GetSkinId() == slot3 and slot0.actor:GetModelId() == slot4.main_model_id then
			return
		end

		if slot0.actor then
			slot0.actor:Dispose()
		end

		slot0.actor = PosterCommonActor.New(slot3, slot7)
	end
end

function slot0.RefreshOtherModel(slot0, slot1)
	if slot0.actor and slot0.actor:GetSkinId() == slot1 and slot0.actor:GetModelId() == SkinCfg[slot1].main_model_id then
		return
	end

	if slot0.actor then
		slot0.actor:Dispose()
	end

	slot0.actor = PosterCommonActor.New(slot1, slot3)
end

function slot0.GetTag(slot0)
	if slot0.actor then
		return slot0.actor:GetTag()
	end

	return PosterGirlConst.PosterGirlTag.null
end

function slot0.GetViewDirect(slot0)
	if slot0.actor then
		return slot0.actor:GetViewDirect()
	end

	return 0
end

function slot0.Dispose(slot0)
	if slot0.actor then
		slot0.actor:Dispose()
	end

	slot0.actor = nil
	slot0.view_tag = PosterGirlConst.ViewTag.null
end

function slot0.SetForceRandomIndex(slot0, slot1)
	slot0.randomIndex = slot1
end

function slot0.GetForceRandomIndex(slot0)
	slot0.randomIndex = nil

	return slot0.randomIndex
end

function slot0.CheckDebut(slot0)
	if not slot0.actor then
		return false
	end

	return slot0.actor:CheckDebut()
end

function slot0.SkipDebut(slot0)
	if not slot0.actor then
		return false
	end

	return slot0.actor:SkipDebut()
end

function slot0.IsPlayingDebut(slot0)
	if slot0.actor then
		return slot0.actor:IsPlayingDebut()
	end

	return false
end

function slot0.DoShacking(slot0)
	if slot0.actor and #slot0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.shaking] ~= 0 then
		slot0.actor:DoShacking()
	end
end

function slot0.DoTouch(slot0)
	if slot0.actor and #slot0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.mainTouch] ~= 0 then
		slot0.actor:DoTouch()
	end
end

function slot0.DoQuickTouch(slot0)
	if slot0.actor and #slot0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.mainQuickTouch] ~= 0 then
		slot0.actor:DoQuickTouch()
	end
end

function slot0.DoShowing(slot0)
	if slot0.actor and #slot0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.showing] ~= 0 then
		slot0.actor:DoShowing()
	end
end

function slot0.DoGreeting(slot0)
	if slot0.actor and #slot0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.greeting] ~= 0 then
		slot0.actor:DoGreeting()
	end
end

function slot0.DoIdle(slot0)
	if slot0.actor and #slot0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.idle] ~= 0 then
		slot0.actor:DoIdle()
	end
end

function slot0.InitTouchHelp(slot0, slot1)
	if slot0.actor then
		slot0.actor:InitTouchHelp(slot1)
	end
end

function slot0.TouchHelpIdle(slot0)
	if slot0.actor then
		slot0.actor:TouchHelpIdle()
	end
end

function slot0.TouchHelpSingleDrag(slot0, slot1, slot2)
	if slot0.actor then
		slot0.actor:TouchHelpSingleDrag(slot1, slot2)
	end
end

function slot0.TouchHelpMutiDrag(slot0, slot1)
	if slot0.actor then
		slot0.actor:TouchHelpMutiDrag(slot1)
	end
end

return slot0
