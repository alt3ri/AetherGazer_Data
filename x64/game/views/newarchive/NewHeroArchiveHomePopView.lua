slot0 = class("NewHeroArchiveHomePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroArchive/ArchiveStoryHomePopUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListeners()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		uv0:Back()
		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 0,
			record_id = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[uv0.heroID_][1]).archive_id
		})
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 0,
			record_id = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[uv0.heroID_][1]).archive_id
		})
	end)
	slot0:AddBtnListener(slot0.yesBtn_, nil, function ()
		slot0 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[uv0.heroID_][1])

		JumpTools.GoToSystem("/newHeroDetailArchive", {
			isBackHome = true,
			id = slot0.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 3,
			record_id = slot0.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 1,
			record_id = slot0.archive_id
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID
	slot0.heartType_ = slot0.params_.type

	saveData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[slot0.heroID_][1] .. slot0.heartType_, true)

	if slot0.heartType_ == 2 then
		saveData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[slot0.heroID_][1] .. 1, true)
	end

	saveData("archivePop", "cache", manager.time:GetServerTime())
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = HeroCfg[slot0.heroID_]

	if slot0.heartType_ == 1 then
		slot0.descText_.text = HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[slot0.heroID_][1]].plot_tip
	elseif slot0.heartType_ == 2 then
		slot0.descText_.text = slot1.super_plot_tip
	end

	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot1.plot_tip_picture)
	slot0.roleNameText_.text = slot2.suffix
end

function slot0.OnExit(slot0)
	if slot0.callback_ then
		slot0.callback_()
	end
end

return slot0
