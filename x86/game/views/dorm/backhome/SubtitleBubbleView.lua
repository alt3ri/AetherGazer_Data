slot0 = class("SubtitleBubble", import("game.extend.BaseView"))

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/item/SubtitleBubbleView"
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.super.Ctor(slot0)

	if slot1 == nil then
		slot0.gameObject_ = GameObject.Instantiate(Asset.Load(slot0:UIName()), manager.ui.uiMain.transform)
		slot0.needDisposeGo = true
		slot0.global = true
	else
		slot0.gameObject_ = slot1
	end

	slot0.stack = slot3 or Dorm.subtitleViewStack
	slot0.transform_ = nullable(slot0.gameObject_, "transform")
	slot0.staticMode = slot2
	slot0.bubbles = {}
	slot0.curPlaying = {}

	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	if #slot0.stack > 0 then
		if slot0.global then
			slot0.stack[1]:OnDisable()

			slot0.stack[1] = slot0
		else
			slot0.stack[#slot0.stack]:OnDisable()
			table.insert(slot0.stack, slot0)
		end
	else
		table.insert(slot0.stack, slot0)
	end

	slot0:OnEnable()
end

function slot0.OnEnable(slot0)
	slot0:RegistEventListener(DORM_CHARACTER_PLAY_SUBTITLE_SEQ, handler(slot0, slot0.OnPlaySubtitleSeq))
	slot0:RegistEventListener(DORM_CHARACTER_PLAY_SUBTITLE, handler(slot0, slot0.OnPlaySubtitle))
	slot0:RegistEventListener(DORM_CHARACTER_DISPOSE, handler(slot0, slot0.OnEntityDispose))
end

function slot0.OnExit(slot0)
	slot0:OnDisable()

	if slot0.stack[#slot0.stack] == slot0 then
		table.remove(slot0.stack)

		if #slot0.stack > 0 then
			slot0.stack[#slot0.stack]:OnEnable()
		end
	end
end

function slot0.OnDisable(slot0)
	for slot4, slot5 in pairs(slot0.curPlaying) do
		slot5:Abort()
	end

	for slot4, slot5 in pairs(slot0.bubbles) do
		slot5:Dispose()
	end

	slot0.bubbles = {}
	slot0.curPlaying = {}

	slot0:RemoveAllEventListener()
end

function slot0.SetEntityFilter(slot0, slot1)
	slot0.filter = slot1
end

function slot0.GetBubble(slot0, slot1)
	if slot0.stack[#slot0.stack] ~= slot0 then
		return nil
	end

	if not slot0.bubbles[slot1] and (slot0.filter == nil or slot0.filter[slot1]) then
		slot3 = GameObject.Instantiate(slot0.bubblePrefab, slot0.bubbleRoot)
		slot2 = BubbleItem.New(slot3)

		slot2.content:SetActive(false)

		slot0.bubbles[slot1] = slot2

		slot3:SetActive(true)
	end

	return slot2
end

function slot1(slot0)
	return slot0 == nil or slot0 == "" or IsAllSpace(slot0)
end

function slot0.UseDormHeroSubtitle(slot0, slot1)
	if uv0(nullable(DormHeroVoiceDescCfg, Dorm.storage:GetData(DormUtils.IdxNamespace(DormEnum.CharacterType.DormNormalHero), slot0), slot1)) and nullable(BackHomeHeroSkinCfg, slot3, "hero_id") ~= slot3 then
		slot4 = nullable(DormHeroVoiceDescCfg, slot5, slot1)
	end

	return slot4
end

function slot0.UseRawContent(slot0, slot1)
	return slot1
end

function slot0.UseTips(slot0, slot1)
	return GetTips(slot1)
end

function slot0.OnPlaySubtitleSeq(slot0, slot1, slot2)
	slot3 = DormCharacterActionManager.frameTaskRunner:NewTask()

	if slot0:GetBubble(slot1) == nil then
		return
	end

	if not slot0.staticMode then
		DormLuaBridge.SetUIFollow(slot4.transform_, slot1, "gua_Hp")
	end

	if slot0.curPlaying[slot1] then
		slot0.curPlaying[slot1]:Abort()
	end

	for slot10 = 0, slot2.Length - 1 do
		slot3:WaitForSec(slot2[slot10].time):Then(function ()
			uv4:ShowSubtitle(uv2)
			uv4:SetData(uv0.getContentFunc or Dorm.overrideSubtitleGetContentFunc or uv1(uv2, uv3.subtitleID))
		end)
	end

	slot0.curPlaying[slot1] = slot3

	slot3:Start()
end

function slot0.OnPlaySubtitle(slot0, slot1, slot2, slot3)
	if slot0:GetBubble(slot1) == nil or slot3 and slot4:IsPlaying() then
		return
	end

	if not slot0.staticMode then
		DormLuaBridge.SetUIFollow(slot4.transform_, slot1, "gua_Hp")
	end

	if slot0.curPlaying[slot1] then
		slot0.curPlaying[slot1]:Abort()

		slot0.curPlaying[slot1] = nil
	end

	slot4:ShowSubtitle(slot1)
	slot4:SetData(slot0.getContentFunc or Dorm.overrideSubtitleGetContentFunc or uv0(slot1, slot2))
end

function slot0.OnEntityDispose(slot0, slot1)
	if slot0.bubbles[slot1] then
		slot2:Dispose()

		slot0.bubbles[slot1] = nil
	end
end

slot3 = singletonClass("MuteBubbleSubView", slot0)

function slot3.Ctor(slot0)
	uv0.super.Ctor(slot0, nil, true)

	slot0.global = false
end

function slot3.GetBubble(slot0)
	return nil
end

function slot0.Dispose(slot0)
	if slot0.needDisposeGo then
		GameObject.Destroy(slot0.gameObject_)
	end
end

slot0.MuteBubbleSubView = slot3

return slot0
