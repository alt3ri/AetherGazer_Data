slot0 = class("NewHeroStoryView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroArchive/HeroStoryPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.data_ = slot0.params_.data
	slot0.archiveID_ = slot0.params_.archiveID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ArchiveAction.SendViewArchiveStory(slot0.archiveID_, slot0.data_.id)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = string.format(slot0.data_.name)
	slot0.storyText_.text = formatText(slot0.data_.anecdote)
	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.data_.id)
	slot0.roleNameText_.text = HeroCfg[slot0.data_.id].name
end

function slot0.OnExit(slot0)
	if slot0.callback_ then
		slot0.callback_()
	end
end

return slot0
