slot0 = class("LinkMethod")

function slot0.Ctor(slot0)
	slot0.methodList_ = {}
	slot0.peek_ = 100
end

function slot0.AddMethod(slot0, slot1)
	table.insert(slot0.methodList_, slot1)
end

function slot0.AddMethodList(slot0, slot1)
	slot0.methodList_ = slot1
end

function slot0.StartNext(slot0)
	slot0.peek_ = 1

	slot0:DoNext()
end

function slot0.DoNext(slot0)
	if slot0.methodList_[slot0.peek_] then
		slot0.peek_ = slot0.peek_ + 1

		slot1()
	end
end

function slot0.IsFree(slot0)
	return slot0.peek_ > #slot0.methodList_
end

function slot0.Stop(slot0)
	slot0.peek_ = #slot0.methodList_ + 1
end

return slot0
