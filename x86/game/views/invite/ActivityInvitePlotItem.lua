slot0 = class("ActivityInvitePlotItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.data = slot1
	slot0.index = slot2
	slot0.cfg = slot3
	slot0.curIndex = slot4

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.contentTxt_.text = GetI18NText(slot0:GetWordCfg(slot0.data.id).content)

	slot0.stateController:SetSelectedState(slot0.data.role == 0 and "1" or "2")
	SetActive(slot0.headGo_, slot0.data.role == 1)

	if slot0.curIndex == slot0.index then
		slot0.animator_:Play("ContenuUI_talkicon", 0, 0)
	end

	if slot0.data.role == 0 then
		slot0.myTxt_.text = GetI18NText(PlayerData:GetPlayerInfo().nick)
	elseif slot0.data.role == 1 then
		slot0.roleTxt_.text = GetI18NText(HeroCfg[slot0.data.heroId].suffix)
		slot0.headIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.cfg.hero_image_route)
	elseif slot0.data.role == 2 then
		slot0.roleTxt_.text = GetTips("ACTIVITY_INVITE_NPC1")
	elseif slot0.data.role == 3 then
		slot0.roleTxt_.text = GetTips("ACTIVITY_INVITE_NPC2")
	end
end

function slot0.GetWordCfg(slot0, slot1)
	if StoryWordCfg[slot1] then
		return StoryWordCfg[slot1]
	elseif StoryWordCfg2[slot1] then
		return StoryWordCfg2[slot1]
	else
		return StoryWordCfg3[slot1]
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
