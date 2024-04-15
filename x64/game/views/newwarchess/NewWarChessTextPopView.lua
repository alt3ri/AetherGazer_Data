slot0 = class("NewWarChessTextPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessTextPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		JumpTools.Back()

		if uv0.params_.callBack then
			uv0.params_.callBack()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.ID_ = slot0.params_.ID

	if NewWarChessContentCfg[slot0.ID_].icon and slot1.icon ~= 0 then
		SetActive(slot0.itemGo_, true)

		slot0.itemiconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/NewWarChess/Item/" .. slot1.icon)
	else
		SetActive(slot0.itemGo_, false)
	end

	slot0.textnameText_.text = slot1.name
	slot0.textinfoText_.text = slot1.content
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
