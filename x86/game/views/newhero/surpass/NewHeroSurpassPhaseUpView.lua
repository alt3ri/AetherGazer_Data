slot0 = class("NewHeroSurpassPhaseUpView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_transition/HeroPrintRewardUI"
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

	slot0.attrItemList = {}

	for slot4 = 1, 3 do
		slot0.attrItemList[slot4] = HeroSurpassAttrItem.New(slot0["message" .. slot4 .. "Go_"])
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.fullscreenBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.starID = slot0.params_.starID
	slot0.heroID = slot0.params_.heroID

	slot0:Refresh()

	if slot0.starID == 600 then
		HeroTools.PlayTalk(slot0.heroID, "pro3", 1)
	elseif slot0.starID == 500 then
		HeroTools.PlayTalk(slot0.heroID, "pro2", 1)
	else
		HeroTools.PlayTalk(slot0.heroID, "pro1", 1)
	end
end

function slot0.Refresh(slot0)
	slot1 = HeroStarCfg[slot0.starID]
	slot2 = HeroCfg[slot0.heroID]

	SurpassTools.ChangeIconStarSpirte(slot0.iconImg_, slot1.star - 1)
	SurpassTools.ChangeIconStarSpirte(slot0.icon_changeImg_, slot1.star)

	slot3 = slot1.star
	slot4 = math.max(slot3 - 1, 0)

	slot0.attrItemList[1]:RefreshUI(slot2.atk_ratio[slot4], slot2.atk_ratio[slot3], 1, true)
	slot0.attrItemList[2]:RefreshUI(slot2.arm_ratio[slot4], slot2.arm_ratio[slot3], 2, true)
	slot0.attrItemList[3]:RefreshUI(slot2.sta_ratio[slot4], slot2.sta_ratio[slot3], 3, true)

	slot5, slot6 = SurpassTools.GetStarUpAttrShowDesc(slot2, slot0.starID)
	slot0.specialtextText_.text = slot6

	if slot6 ~= "" then
		SetActive(slot0.specialnodeGo_, true)
	else
		SetActive(slot0.specialnodeGo_, false)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.attrItemList) do
		if slot5 then
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
