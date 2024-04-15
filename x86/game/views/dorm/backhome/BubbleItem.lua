slot0 = class("BubbleItem", BaseView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.duration = 4
end

function slot1(slot0)
	slot1 = slot0.taskDataCtx.bubbleObj

	return slot1.duration <= Time.time - slot1.startTime
end

function slot2(slot0, slot1)
	slot0.task = nil
	slot0.text.text = ""

	slot0.content:SetActive(false)

	if slot1 then
		DormUtils.ShowCharaSpecialVfx(slot1, Dorm.charaVfxActiveType)
	end
end

function slot0.ShowSubtitle(slot0, slot1, slot2)
	slot0.startTime = Time.time

	if slot2 then
		slot0.duration = slot2
	end

	if slot0.task == nil then
		slot4 = DormCharacterActionManager.frameTaskRunner:NewTask({
			bubbleObj = slot0
		})

		slot4:WaitUntil(uv0)
		slot4:SetOnComplete(function ()
			uv0(uv1, uv2)
		end)
		slot4:SetOnAbort(function ()
			uv0(uv1, uv2)
		end)

		slot0.task = slot4

		slot0.task:Start()
		DormUtils.HideCharaSpecialVfx(slot1)
	end
end

function slot3(slot0)
	return slot0 == nil or slot0 == "" or IsAllSpace(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.text.text = slot1

	if not uv0(slot1) then
		slot0.content:SetActive(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content.transform)
	end
end

function slot0.Hide(slot0)
	if slot0.task then
		slot0.task:Abort()

		slot0.task = nil
	end
end

function slot0.IsPlaying(slot0)
	return slot0.task ~= nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.task then
		slot0.task:Abort()

		slot0.task = nil
	end

	slot0.gameObject_:Destroy()
end

return slot0
