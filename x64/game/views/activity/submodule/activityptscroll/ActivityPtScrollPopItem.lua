slot0 = class("ActivityPtScrollPopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

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
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.handler_ = slot2
	slot0.viewHeight_ = slot3
	slot0.height_ = slot0.transform_.rect.height
	slot0.centerY_ = centerY

	slot0:RefreshUI()
	slot0:RefreshScroll()
end

function slot0.RefreshUI(slot0)
	if slot0.data_.useless then
		slot1 = ActivityPtRouletteTipsCfg[slot0.data_.affix]
		slot0.title_.text = slot1.name
		slot0.desc_.text = slot1.desc
		slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. slot1.icon)
	else
		slot0.title_.text = getAffixName({
			slot0.data_.affix
		})
		slot0.desc_.text = getAffixDesc({
			slot0.data_.affix,
			slot0.data_.level
		})
		slot0.icon_.sprite = getAffixSprite({
			slot0.data_.affix
		})
	end

	slot0.icon_:SetNativeSize()
end

function slot0.RefreshScroll(slot0)
	slot0:StopTimer()
	slot0:RefreshSelf()

	slot0.timer_ = FrameTimer.New(function ()
		uv0:RefreshSelf()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RefreshSelf(slot0)
	slot2 = (slot0.viewHeight_ - math.abs(slot0.handler_.localPosition.y + slot0.transform_.localPosition.y - 0.5 * slot0.height_)) / slot0.viewHeight_
	slot0.content_.localScale = Vector3(slot2, slot2, slot2)
	slot0.canvas_.alpha = slot2
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:StopTimer()
	slot0.super.Dispose(slot0)
end

return slot0
