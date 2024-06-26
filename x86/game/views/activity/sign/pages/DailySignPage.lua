slot0 = class("DailySignPage", BaseSignPage)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.hander_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/ActivitySign/SignUI"), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.animPlaying = false
	slot0.signItem_ = {}
end

function slot0.OnShow(slot0)
	slot0:RefreshSignItem()
end

function slot0.OnHide(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshSignItem(slot0)
	slot6 = manager.time:GetServerTime()

	for slot6 = #slot0.signItem_, manager.time:CalcMonthDays(manager.time:STimeDescS(slot6, "!%Y"), SignData:GetDailySignInfo().month) + 1, -1 do
		slot0.signItem_[slot6]:Show(false)
	end

	for slot6 = 1, slot2 do
		if not slot0.signItem_[slot6] then
			slot0.signItem_[slot6] = DailySignItem.New(slot0, Object.Instantiate(slot0.itemGo_, slot0.contentParent_))
		end

		slot0.signItem_[slot6]:SetData({
			month = slot1,
			day = slot6,
			state = SignTools.GetDailySignState(slot6)
		})
	end
end

function slot0.AutoGetReward(slot0)
	slot0.signIndex_ = SignTools.GetDailySignIndex()

	if slot0.signIndex_ > 0 then
		manager.ui:UIEventEnabledByUI(false, true)

		slot0.timer_ = Timer.New(function ()
			SignAction.QueryDailySign()
		end, 0.033, 1)

		slot0.timer_:Start()
	end
end

function slot0.OnSign(slot0, slot1)
	if isSuccess(slot1.result) then
		if slot0.signIndex_ <= 0 then
			return
		end

		slot0.signItem_[slot0.signIndex_]:StartPlayAnimator()

		slot0.timer_ = Timer.New(function ()
			if uv0.signItem_[uv0.signIndex_]:GetAnimator():GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not uv0.animPlaying then
				if uv0.animPlaying then
					manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, true)
				end

				getReward2(uv1.item_list, {
					ItemConst.ITEM_TYPE.HERO,
					ItemConst.ITEM_TYPE.WEAPON_SERVANT
				}, handler(uv0.hander_, uv0.hander_.CheckSign))
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end
		end, 0.033, -1)

		manager.ui:UIEventEnabledByUI(true, false)
		manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, false)
		slot0.timer_:Start()
	else
		manager.ui:UIEventEnabledByUI(true, false)
		ShowTips(slot1.result)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.signItem_) do
		slot5:Dispose()
	end

	slot0.signItem_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
