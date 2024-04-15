slot0 = class("SpringWelfarePlayerLetterTextItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.richText_ = slot0:FindCom("RichText", "", slot1.transform)
	slot0.buttonUpAudio_ = slot0:FindCom("ButtonUpAudio", "", slot1.transform)
	slot0.buttonUpAudio_.enabled = false
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetText(slot0, slot1)
	slot0.richText_.text = slot1
end

return slot0
