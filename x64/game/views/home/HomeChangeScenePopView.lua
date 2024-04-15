slot0 = class("HomeChangeScenePopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Main/HomeSceneChangePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = slot0.collecter_:GetController("state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		uv0.curIndex_ = 1

		uv0:RefreshState()
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		uv0.curIndex_ = 2

		uv0:RefreshState()
	end)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		saveData("scenePop", "sceneID_" .. uv0.leftID_, true)

		if uv0.curIndex_ == 2 then
			HomeSceneSettingAction.SetHomeScene(uv0.rightID_)
		else
			HomeSceneSettingData:SetDefaultScene(uv0.leftID_)
		end

		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.curIndex_ = 1
	slot0.leftID_ = slot0.params_.left
	slot0.rightID_ = slot0.params_.right
	slot0.leftText_.text = HomeSceneSettingCfg[slot0.leftID_].title
	slot0.rightText_.text = HomeSceneSettingCfg[slot0.rightID_].title
	slot0.leftIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/SceneChangeUI/item/" .. slot0.leftID_)
	slot0.rightIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/SceneChangeUI/item/" .. slot0.rightID_)
	slot0.desc_.text = GetTips("HOME_SCENE_FORCE_CHANGE")

	slot0:RefreshState()
end

function slot0.RefreshState(slot0)
	slot0.stateCon_:SetSelectedState(slot0.curIndex_ == 1 and "left" or "right")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
