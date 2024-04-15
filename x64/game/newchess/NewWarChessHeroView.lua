slot0 = class("NewWarChessHeroView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessTeamUIPop"
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

	slot0.List_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, NewWarChessHeroItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.heroInfoList_[slot1])
	slot2:EnableSkillItemClick()
	slot2:BindSkillRedPoint()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backbtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.heroInfoList_ = NewWarChessData:GetHeroInfoList()

	slot0.List_:StartScroll(#slot0.heroInfoList_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.List_ then
		slot0.List_:Dispose()

		slot0.List_ = nil
	end
end

return slot0
