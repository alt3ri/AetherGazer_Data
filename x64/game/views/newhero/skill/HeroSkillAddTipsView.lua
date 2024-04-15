slot0 = class("HeroSkillAddTipsView", ReduxView)
slot1 = {
	[HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT] = {
		titleName = "钥从效果"
	},
	[HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE] = {
		titleName = "同调效果"
	},
	[HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE] = {
		titleName = "神格效果"
	},
	[HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE] = {
		titleName = "属性强化"
	}
}
slot2 = {
	empty = "empty",
	noEmpty = "noEmpty"
}

function slot0.UIName(slot0)
	return "Widget/System/Hero_skill/HeroSkillTipUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:SetInfoIsShow(false)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.emptyController = slot0.controllerexcollection_:GetController("empty")
	slot0.textItemList = {}
end

function slot0.OnEnter(slot0)
	slot0.backBtnCallback = slot0.params_.backBtnCallback

	slot0:RefreshUi(slot0.params_)
end

function slot0.OnHeroSkillAddViewUpdate(slot0, slot1)
	slot0:RefreshUi(slot1)
end

function slot0.RefreshUi(slot0, slot1)
	slot0.showType = slot1.showType
	slot0.showTextList = slot1.showTextList
	slot0.heroId = slot1.heroId

	slot0:SetDataAndShow(slot0.showType, slot0.showTextList)
end

function slot0.SetBackBtnCallback(slot0, slot1)
	slot0.backBtnCallback = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:SetInfoIsShow(false)

		if uv0.backBtnCallback then
			uv0.backBtnCallback()
		end

		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.gobtnBtn_, nil, function ()
		uv0:OnGoBtn()
	end)
end

function slot0.OnGoBtn(slot0)
	if slot0.showType == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT then
		if slot0.params_.dataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			JumpTools.GoToSystem("/polyhedronHero", {
				isEnter = true,
				pageIndex = 3,
				hid = slot0.heroId,
				type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
			})
		else
			JumpTools.GoToSystem("/newHero", {
				isEnter = true,
				pageIndex = 3,
				hid = slot0.heroId,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	elseif slot0.showType == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE then
		JumpTools.Back()
		JumpTools.OpenPageByJump("/weaponModuleView", {
			heroID = slot0.heroId
		})
	elseif slot0.showType == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE then
		if slot0.params_.dataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			JumpTools.GoToSystem("/polyhedronHero", {
				isEnter = true,
				pageIndex = 6,
				hid = slot0.heroId,
				type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
			})
		else
			JumpTools.GoToSystem("/newHero", {
				isEnter = true,
				pageIndex = 6,
				hid = slot0.heroId,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	elseif slot0.showType == HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE and gameContext:GetOpenPageHandler("skillView") then
		JumpTools.Back()
		slot1:ChangeTab(2)
	end
end

function slot0.SetInfoIsShow(slot0, slot1)
	slot0.isShow_ = slot1

	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			SetActive(uv0.gameObject_, uv0.isShow_)

			uv0.timer_ = nil
		end, 0.034, 1)

		slot0.timer_:Start()
	end
end

function slot0.CreateItem(slot0, slot1)
	slot3 = HeroSkillAddTipsItem.New(GameObject.Instantiate(slot0.skillitemGo_, slot0.contentTrs_))
	slot0.textItemList[slot1] = slot3

	return slot3
end

function slot0.SetDataAndShow(slot0, slot1, slot2)
	slot6 = true

	slot0:SetInfoIsShow(slot6)

	for slot6, slot7 in pairs(slot2) do
		(slot0.textItemList[slot6] or slot0:CreateItem(slot6)):RefreshUI(slot7)
	end

	for slot6 = #slot2 + 1, #slot0.textItemList do
		if slot0.textItemList[slot6] then
			SetActive(slot7.gameObject_, false)
		end
	end

	if uv0[slot1] then
		slot0.titleText_.text = slot3.titleName
	end

	slot0.emptyController:SetSelectedState(#slot2 > 0 and uv1.noEmpty or uv1.empty)
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.textItemList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
