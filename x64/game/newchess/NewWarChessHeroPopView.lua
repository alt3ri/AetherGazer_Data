slot0 = class("NewWarChessHeroPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessGet"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroItem_ = NewWarChessHeroItem.New(slot0.heroGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backbtn_, nil, function ()
		JumpTools.Back()

		if uv0.params_.callBack then
			uv0.params_.callBack()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroItem_:SetData(NewWarChessData:GetHeroInfo(slot0.params_.newChessHeroID))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.heroItem_ then
		slot0.heroItem_:Dispose()

		slot0.heroItem_ = nil
	end
end

return slot0
