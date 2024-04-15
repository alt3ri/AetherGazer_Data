slot0 = class("SectionBaseItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.transform_.name = slot3
	slot0.stageID_ = slot3
	slot0.chapterID_ = slot4

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.gameObject_, true)

	slot0.selectController_ = slot0.controllerEx_:GetController("select")
	slot0.isBossController_ = slot0.controllerEx_:GetController("isBoss")
	slot0.showStarController_ = slot0.controllerEx_:GetController("showStar")
	slot0.threeStarBarList_ = {}

	for slot4 = 1, 3 do
		slot0.threeStarBarList_[slot4] = SectionThreeStarBar.New(slot0[string.format("starGo%s_", slot4)])
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		uv0:OnClick()
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:InitCustom()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.threeStarBarList_) do
		slot5:Dispose()
	end

	slot0.threeStarBarList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.isShow_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
end

function slot0.ShowRedPoint(slot0)
	SetActive(slot0.noticeContainer_.gameObject, false)
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)

	slot0:RefreshText()
	slot0:RefreshStar()

	if slot0:GetTag() == BattleConst.BATTLE_TAG.BOSS then
		slot0.isBossController_:SetSelectedState("true")
	else
		slot0.isBossController_:SetSelectedState("false")
	end

	SetActive(slot0.gameObject_, not slot0.isLock_)
	slot0:ShowRedPoint()
end

function slot0.GetTag(slot0)
	return BattleConst.BATTLE_TAG.DEFAULT
end

function slot0.GetPosition(slot0)
	return {
		0,
		0
	}
end

function slot0.InitCustom(slot0)
end

function slot0.RefreshStar(slot0)
end

function slot0.RefreshText(slot0)
	slot0.text_.text = ""
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.SelectorItem(slot0, slot1)
	if slot0.stageID_ == slot1 and slot0:IsOpenSectionInfo() then
		slot0.selectController_:SetSelectedState("true")
	else
		slot0.selectController_:SetSelectedState("false")
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chapterID_ = slot1
	slot0.stageID_ = slot2

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
