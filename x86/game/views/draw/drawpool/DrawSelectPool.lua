slot0 = class("DrawSelectPool", DrawBasePool)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/pool_" .. slot2), slot1)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.poolId = slot2
	slot0.showId = slot3
	slot0.detailBtnList_ = {}
	slot0.btnNameList_ = {}

	slot0:Init()
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.firstController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "first")
	slot0.showController_ = slot0.controller_:GetController("show")
end

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.heroId
		})
	end)

	if slot0.m_changeBtn then
		slot0:AddBtnListener(slot0.m_changeBtn, nil, function ()
			if DrawPoolCfg[uv0.poolId].pool_change == 0 or DrawData:GetPoolUpTimes(uv0.poolId) < slot0 then
				slot2 = DrawPoolCfg[uv0.poolId]

				uv0:Go("/drawAllHeroSelect", {
					poolId = uv0.poolId,
					heroIdList = slot2.optional_detail,
					heroId = slot2.optional_detail[table.indexof(slot2.optional_lists_poolId, uv0.showId)]
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end
end

function slot0.Refresh(slot0, slot1)
	uv0.super.Refresh(slot0, slot1)

	slot0.showId = slot1
	slot0.upID = DrawData:GetPollUpID(slot0.poolId)

	if slot0.upID == 0 then
		slot0.showController_:SetSelectedState("no_role")
	else
		slot0.showController_:SetSelectedState("role")
	end

	slot3 = table.indexof(DrawPoolCfg[slot0.poolId].optional_lists_poolId, slot1)
	slot0.heroId = DrawData:ConvertUpId(slot0.poolId, slot0.upID, 0)
	slot4 = HeroCfg[slot0.heroId]

	if slot0.m_changeCount then
		if DrawPoolCfg[slot0.poolId].pool_change == 0 then
			slot0.m_changeCount.text = ""
		else
			slot0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(slot5 - DrawData:GetPoolUpTimes(slot0.poolId)))
		end
	end

	if slot0.upID ~= 0 then
		slot0.suffixText_.text = GetI18NText(slot4.name)
		slot0.nameText_.text = GetI18NText(slot4.suffix)
		slot0.pic_.sprite = getSpriteWithoutAtlas(string.format("TextureConfig/Character/Portrait/%d", slot0.heroId))
		slot0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(slot0.heroId)

		slot0.pic_:SetNativeSize()
	end

	slot0.countText_.text = DrawData:GetUpRemainTime(slot0.poolId)
end

return slot0
