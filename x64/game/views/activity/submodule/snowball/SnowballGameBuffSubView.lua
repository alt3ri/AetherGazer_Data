slot0 = class("SnowballGameBuffSubView", BaseView)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0)

	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.buffs = {}
end

function slot0.OnExit(slot0)
	slot0.buffs = nil

	slot0:RemoveAllEventListener()
end

function slot0.AddBuff(slot0, slot1, slot2, slot3)
	if slot0.buffs[slot1] then
		slot4.lastTime = math.max(slot4.lastTime, slot2)

		if slot0.OnBuffExtended then
			slot0:OnBuffExtended(slot1)
		end
	else
		if SnowballGameBuff.buff[slot1].WillOverride then
			for slot9, slot10 in pairs(slot0.buffs) do
				if slot5.WillOverride(slot9) then
					slot0:RemoveBuff(slot9)
				end
			end
		end

		slot6 = GameObject.Instantiate(slot5.IsDebuff and slot0.debuff_ or slot0.buff_, slot0.buffRoot_)
		slot7 = {}

		slot0:BindCfgUI(slot6, slot7)

		slot7.icon_.sprite = getSpriteWithoutAtlas(GameDisplayCfg.activity_snowball_buff_icon.value[slot1])
		slot0.buffs[slot1] = {
			lastTime = slot2,
			obj = slot6,
			com = slot7
		}

		if slot0.OnBuffAdded then
			slot0:OnBuffAdded(slot1, slot3)
		end

		slot0:SortBuffIcon()
	end
end

function slot0.Update(slot0, slot1)
	for slot5, slot6 in pairs(slot0.buffs) do
		slot6.lastTime = slot6.lastTime - slot1

		if slot6.lastTime <= 0 then
			slot0:RemoveBuff(slot5)
		end
	end
end

function slot0.RemoveBuff(slot0, slot1)
	if slot0.buffs[slot1] == nil then
		return
	end

	if slot0.buffs[slot1].obj then
		GameObject.Destroy(slot2)
	end

	slot0.buffs[slot1] = nil

	if slot0.OnBuffFinished then
		slot0:OnBuffFinished(slot1)
	end
end

function slot0.ClearAllBuff(slot0)
	for slot4, slot5 in ipairs(SnowballGameBuff.all) do
		slot0:RemoveBuff(slot5)
	end
end

function slot0.SortBuffIcon(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(SnowballGameBuff.all) do
		if slot0.buffs[slot6] then
			slot0.buffs[slot6].obj.transform:SetSiblingIndex(slot1)

			slot1 = slot1 + 1
		end
	end
end

return slot0
