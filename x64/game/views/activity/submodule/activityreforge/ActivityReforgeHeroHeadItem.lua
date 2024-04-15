slot0 = class("ActivityReforgeHeroHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.callBack_ then
			uv0.callBack_(uv0.standardHeroID_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.standardHeroID_ = slot1
	slot2 = HeroStandardSystemCfg[slot0.standardHeroID_]
	slot0.heroImage_.sprite = HeroTools.GetHeadSprite(slot2.skin_id)
	slot0.promoteImage_.sprite = getSprite("Atlas/Common", "star_" .. math.floor(slot2.star_lv / 100))
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.callBack_ = slot1
end

function slot0.Dispose(slot0)
	slot0.callBack_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
