slot0 = class("CultureGravureAstroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot4 = "state"
	slot0.btnController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.astroItems = {}

	for slot4 = 1, 3 do
		slot0.astroItems[slot4] = CultureGravureRecommendAstroItem.New(slot0["astro_" .. slot4])
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot2
	slot0.rate_ = slot2.rate
	slot0.heroID_ = slot3
	slot0.astroDataList_ = slot2.list

	slot0:RefreshUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		slot0, slot1 = CultureGravureData:GetHasUnlockAllAstro(uv0.heroID_, uv0.astroDataList_)
		slot2 = HeroAstrolabeCfg[slot1]

		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
			JumpTools.OpenPageByJump("/astrolabeAdjust", {
				isEnter = true,
				heroId = uv0.heroID_,
				selectPos = {
					table.indexof(HeroCfg[uv0.heroID_].astrolabe, slot2.hero_astrolabe_suit_id),
					slot2.pos
				}
			})
		else
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.HERO_ASTROLABE, slot5))
		end
	end)
	slot0:AddBtnListener(slot0.equipBtn_, nil, function ()
		AstrolabeAction.AstrolabeEquipByList(uv0.heroID_, uv0.astroDataList_)
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.RefreshUI(slot0)
	slot0.rateText_.text = math.floor(slot0.rate_ / 100)

	slot0:RefreshAstroItem()
	slot0:RefreshState()
end

function slot0.RefreshAstroItem(slot0)
	for slot4, slot5 in ipairs(slot0.astroItems) do
		slot5:SetData(slot4, slot0.astroDataList_[slot4], slot0.heroID_)
		slot5:SetClickCallBack(slot0.callback)
	end
end

function slot0.RefreshState(slot0)
	slot2 = CultureGravureData:GetHasUnlockAllAstro(slot0.heroID_, slot0.astroDataList_)

	if CultureGravureData:GetHasEquippedAllAstro(slot0.heroID_, slot0.astroDataList_) then
		slot0.btnController_:SetSelectedState("equip")
	elseif slot2 then
		slot0.btnController_:SetSelectedState("had")
	else
		slot0.btnController_:SetSelectedState("get")
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.astroItems) do
		slot5:Dispose()
	end

	slot0.astroItems = nil

	uv0.super.Dispose(slot0)
end

return slot0
