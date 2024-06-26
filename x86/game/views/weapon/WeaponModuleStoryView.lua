slot0 = class("WeaponModuleStoryView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_module/HeroModuleStoryPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = WeaponModuleCfg[slot0.params_.heroID]
	slot0.nameText_.text = GetI18NText(slot1.name)
	slot0.storyText_.text = GetI18NText(slot1.story)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)

	slot0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
	slot0.moduleImage_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. slot0.params_.heroID)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
