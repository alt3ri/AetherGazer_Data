slot0 = class("NewbieDrawSelectPool", DrawBasePool)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/NewbiePoolSelectUI"), slot1)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.poolId = slot2
	slot0.showId = slot3
	slot0.detailBtnList_ = {}
	slot0.btnNameList_ = {}

	slot0:Init()
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.roleController_ = slot0.controller_:GetController("role")
	slot0.bgController_ = slot0.controller_:GetController("bg")
	slot0.poolItems_ = {}

	for slot4 = 1, 7 do
		slot6 = NewBieHeroPoolItem.New(slot0["poolGo_" .. slot4])

		slot6:SetData(slot4, DrawPoolCfg[slot0.poolId].optional_detail[slot4])
		table.insert(slot0.poolItems_, slot6)
	end
end

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)

	if slot0.m_changeBtn then
		slot0:AddBtnListener(slot0.m_changeBtn, nil, function ()
			if DrawPoolCfg[uv0.poolId].pool_change == 0 or DrawData:GetPoolUpTimes(uv0.poolId) < slot0 then
				slot2 = DrawPoolCfg[uv0.poolId]

				uv0:Go("/newbieDrawHeroSelect", {
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

	slot2 = DrawPoolCfg[slot0.poolId]

	slot0.roleController_:SetSelectedState(slot2.optional_detail[table.indexof(slot2.optional_lists_poolId, slot0.showId)])
	slot0.bgController_:SetSelectedState(DrawData:GetPollUpID(slot0.poolId) == 0 and "no_role" or "role")

	if slot0.m_changeCount then
		if DrawPoolCfg[slot0.poolId].pool_change == 0 then
			slot0.m_changeCount.text = ""
		else
			slot0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(slot6 - DrawData:GetPoolUpTimes(slot0.poolId)))
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.poolItems_ then
		for slot4, slot5 in pairs(slot0.poolItems_) do
			slot5:Dispose()
		end

		slot0.poolItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
