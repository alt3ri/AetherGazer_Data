slot0 = class("HeroInteractionGMContentView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroInteractionGMContentUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.OnEnter(slot0)
	if slot0.inited == false then
		slot0:Init()
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.inited = true
end

function slot0.InitUI(slot0)
	slot0.skinId_ = slot0.params_.skinId

	if SkinCfg[slot0.skinId_] == nil then
		print("SkinCfg[self.skinId_] == nil")
	end

	slot0.typeName_ = slot0.params_.typeName

	if #string.split(slot0.typeName_, "_") == 1 then
		slot0.actionType_ = slot1[1]
		slot0.voiceType_ = slot0.actionType_ .. "_talk"
		slot0.voiceDelayType_ = slot0.actionType_ .. "_delay"
	else
		slot0.actionType_ = slot1[1]
		slot0.voiceType_ = slot0.typeName_
		slot0.voiceDelayType_ = slot1[1] .. "_delay"
	end

	slot0.actionNameList = {}
	slot0.actionList_ = {}
	slot0.voiceList_ = {}
	slot0.voiceDelayList_ = {}
	slot0.interactionCfg_ = HeroInteractionCfg[SkinCfg[slot0.skinId_].hero]

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.typeName_] ~= nil then
		slot0.actionNameList = slot0.interactionCfg_[slot0.typeName_]
	end

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.voiceType_] ~= nil then
		slot0.voiceList_ = slot0.interactionCfg_[slot0.voiceType_]
	end

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.actionType_] ~= nil then
		slot0.actionList_ = slot0.interactionCfg_[slot0.actionType_]
	end

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.voiceDelayType_] ~= nil then
		slot0.voiceDelayList_ = slot0.interactionCfg_[slot0.voiceDelayType_]
	end

	if slot0.backgroundBtn_ == nil then
		slot0.backgroundBtn_ = slot0:FindCom("Button", "background")
	end

	if slot0.btn_prefab == nil then
		slot0.btn_prefab = slot0:FindGo("HeroInteractionBut_prefab")
	end

	if slot0.panel_go == nil then
		slot0.panel_go = slot0:FindTrs("panel")
	end

	slot0.btn_list = {}
	slot0.btnGo_list = {}

	slot0:GenBtn()
end

function slot0.GenBtn(slot0)
	if slot0.actionNameList ~= nil and #slot0.actionNameList > 0 then
		for slot4, slot5 in ipairs(slot0.actionNameList) do
			if Object.Instantiate(slot0.btn_prefab, slot0.panel_go):GetComponentInChildren(typeof(Text)) ~= nil then
				slot7.text = GetI18NText(slot5)
			else
				print("btn_text为空")
			end

			if slot6:GetComponent(typeof(Button)) == nil then
				print("button_:按钮为空")
			end

			table.insert(slot0.btn_list, slot8)
			table.insert(slot0.btnGo_list, slot6)
		end
	end
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.btn_list) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:DelayToPlayInteractionAnimation(uv1, 0)
		end)
	end

	slot0:AddBtnListener(slot0.backgroundBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.DelayToPlayInteractionAnimation(slot0, slot1, slot2)
	if slot0.playingInteraction_ then
		return
	end

	if slot2 == nil then
		slot2 = 1
	end

	slot0:PlayInteractionAnimation(slot1)
end

function slot0.PlayInteractionAnimation(slot0, slot1)
	manager.posterGirl:SetForceRandomIndex(slot1)

	if slot0.typeName_ == "greeting" then
		manager.posterGirl:DoGreeting()
	elseif slot0.typeName_ == "mainTouch" then
		manager.posterGirl:DoTouch()
	elseif slot0.typeName_ == "mainQuickTouch" then
		manager.posterGirl:DoQuickTouch()
	elseif slot0.typeName_ == "shaking" then
		manager.posterGirl:DoShacking()
	elseif slot0.typeName_ == "showing" then
		manager.posterGirl:DoShowing()
	elseif slot0.typeName_ == "idle" then
		manager.posterGirl:DoIdle()
	else
		error("HeroInteractionGMContentView can not find interaction by typeName :" .. slot0.typeName_)
	end
end

function slot0.PlaySpecialAnimation(slot0, slot1, slot2, slot3)
end

function slot0.OnPlaySpecialCallback(slot0)
end

function slot0.PlayIdleAni(slot0)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.btnGo_list) do
		Object.Destroy(slot5)
	end

	slot0.btn_list = nil
	slot0.btnGo_list = nil
	slot0.inited = false
	slot0.playingInteraction_ = false

	HeroTools.StopTalk()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
