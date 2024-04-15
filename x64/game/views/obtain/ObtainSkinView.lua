slot0 = class("ObtainSkinView", ObtainBaseView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.AdaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.portrait_.transform)
end

function slot0.SetInfo(slot0, slot1, slot2)
	slot0.obtainsParams_ = slot2
	slot4 = ShopTools.GetGoodsIdBySkinId(slot1)

	if HeroTools.GetHasOwnedSkin((SkinCfg[slot1] or SkinCfg[ItemCfg[slot1].param[1]]).id) then
		slot0.limitTimeText_.text = GetTips("ALREADY_GET")
	elseif ItemCfg[slot1].time then
		slot0.limitTimeText_.text = string.format(GetTips("SKIN_LIMIT_TIME"), ItemCfg[slot1].time[2][1])
	end

	SetActive(slot0.limitTimeGo_, ItemCfg[slot1].time ~= nil)
	SetActive(slot0.dlcGo_, slot0.obtainsParams_.HasDlc)

	if slot0.obtainsParams_.HasDlc then
		slot5 = nil

		if HomeSceneSettingData:GetUsedState(HomeSceneSettingCfg[slot0.obtainsParams_.dlcCfg.param[1]].id) == SceneConst.HOME_SCENE_TYPE.UNLOCK then
			slot0.leftTimeText_.text = GetTips("ALREADY_GET")
		elseif slot0.obtainsParams_.dlcCfg.time then
			slot0.leftTimeText_.text = string.format(GetTips("SKIN_LIMIT_TIME"), slot0.obtainsParams_.dlcCfg.time[2][1])
		end

		slot0.dlcNameText_.text = GetI18NText(slot0.obtainsParams_.dlcCfg.name)
		slot0.dlcImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Item_l/" .. slot6.id)

		SetActive(slot0.leftTimeText_.gameObject, slot5 ~= nil)
		SetActive(slot0.get1content_, slot5 ~= nil)
		SetActive(slot0.dlcGo_, not slot7)
	end

	if not slot3 then
		return
	end

	slot5 = HeroCfg[slot3.hero]
	slot0.portrait_.sprite = AssetEx.LoadSprite("TextureConfig/Character/Portrait/" .. slot3.id)
	slot0.heroNameTxt_.text = HeroTools.GetHeroFullName(slot3.hero)

	slot0.AdaptImg_:AdaptImg()

	slot0.name_.text = GetI18NText(slot3.name)

	if slot4 then
		if getShopCfg(slot4).give_back_list and #slot6.give_back_list > 0 then
			SetActive(slot0.itemGo_, true)
		else
			SetActive(slot0.itemGo_, false)

			return
		end

		slot0.itemNameTxt_.text = ItemTools.getItemName(slot6.give_back_list[1].id) .. "x" .. slot6.give_back_list[1].num
		slot0.itemIcon_.sprite = ItemTools.getItemSprite(slot6.give_back_list[1].id)
	else
		SetActive(slot0.itemGo_, false)
	end
end

function slot0.GetTimeLineEndTime(slot0)
	return 6.27
end

function slot0.Hide(slot0)
	uv0.super.Hide(slot0)

	slot0.portrait_.sprite = nil
end

return slot0
