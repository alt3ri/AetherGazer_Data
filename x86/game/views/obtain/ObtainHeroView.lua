slot0 = class("ObtainHeroView", require("game.views.obtain.ObtainBaseView"))

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

	slot0.starController_ = ControllerUtil.GetController(slot0.starControllerTrs_, "star")
	slot0.AdaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.portrait_.transform)
	slot0.SimplePlayer_ = slot0:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
end

function slot0.PlayGetHeroVoice(slot0)
	slot1 = slot0:GetHeroID()

	manager.audio:PlayVoice(string.format("vo_sys_%d", slot1), string.format("v_s_%d_%s", slot1, "get"), string.format("vo_sys_%d.awb", slot1))
end

function slot0.GetPlayable(slot0)
	return slot0.playableDirector_
end

function slot0.GetHeroID(slot0)
	return slot0.convert and slot0.item.convert_from.id or slot0.item.id
end

function slot0.OnClick(slot0)
	if not slot0:GetPlayable() then
		return true
	end

	if slot1.time == 0 or slot0:GetTimeLineEndTime() <= slot1.time then
		return true
	else
		slot1.time = slot0:GetTimeLineEndTime()

		return false
	end
end

function slot0.Show(slot0, slot1)
	slot0.item = slot1
	slot0.convert = ItemWillConvert(slot1)

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, true)
	end

	if slot0.playableDirector_ then
		slot0.playableDirector_:Evaluate()
		slot0.playableDirector_:Play()
	end

	slot0:SetInfo(slot1)
end

function slot0.RefreshContent(slot0, slot1, slot2)
	slot0.portrait_.sprite = AssetEx.LoadSprite("TextureConfig/Character/Portrait/" .. slot1)

	slot0.AdaptImg_:AdaptImg()

	slot0.name_.text = HeroTools.GetHeroFullName(slot1)
	slot0.camp_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[slot2.race].icon)
	slot5 = math.min(ItemCfg[slot1].display_rare, 5)

	slot0.starController_:SetSelectedIndex(slot5)

	if slot5 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif slot5 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	slot0.SimplePlayer_:SetVoiceInfo(string.format("vo_sys_%d", slot1), string.format("v_s_%d_%s", slot1, "get"), string.format("vo_sys_%d.awb", slot1))
end

function slot0.SetInfo(slot0, slot1)
	if slot1.draw_rebate and slot1.draw_rebate ~= 0 then
		SetActive(slot0.rebateGo_, true)

		slot0.rebateLab_.text = "x" .. slot1.draw_rebate
	else
		SetActive(slot0.rebateGo_, false)
	end

	if not HeroCfg[slot0:GetHeroID()] then
		return
	end

	slot0:RefreshContent(slot2, slot3)

	if slot0.convert then
		SetActive(slot0.convertGo_, true)

		slot0.convertIcon_.sprite = ItemTools.getItemSprite(slot1.id)
		slot0.convertLab_.text = "x" .. slot1.num
	else
		SetActive(slot0.convertGo_, false)
	end
end

function slot0.GetTimeLineEndTime(slot0)
	return 5.5
end

function slot0.Skip2End(slot0)
	if slot0:GetPlayable() then
		slot1.time = 5.5
	end
end

function slot0.Dispose(slot0)
	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.Hide(slot0)
	uv0.super.Hide(slot0)

	slot0.portrait_.sprite = nil
end

return slot0
