slot0 = class("TangramPuuzleTestNode")

function slot0.OnCtor(slot0)
	slot0.checkConditionFunc_ = nil
	slot0.checkSuccessFunc_ = nil
	slot0.checkFailFunc_ = nil
	slot0.runFunc_ = nil
	slot0.afterRunFunc_ = nil
	slot0.nextNode_ = nil
end

function slot0.CheckCondition(slot0)
	if slot0.checkConditionFunc_ then
		if slot0.checkConditionFunc_() == true then
			if slot0.checkSuccessFunc_ then
				slot0.checkSuccessFunc_()
			end
		elseif slot0.checkFailFunc_ then
			slot0.checkFailFunc_()
		end

		return slot1
	else
		return true
	end
end

function slot0.Run(slot0)
	if slot0.runFunc_ then
		slot0.runFunc_()
	end
end

function slot0.Dispose(slot0)
	slot0.checkConditionFunc_ = nil
	slot0.checkSuccessFunc_ = nil
	slot0.checkFailFunc_ = nil
	slot0.runFunc_ = nil
	slot0.afterRunFunc_ = nil
	slot0.nextNode_ = nil
end

return slot0
