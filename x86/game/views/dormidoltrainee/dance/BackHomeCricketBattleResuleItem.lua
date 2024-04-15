slot0 = class("BackHomeCricketBattleResuleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot0.type = slot1.type
	slot0.name_.text = GetTips(BackHomeCricketConst.SCORE_DESC[slot0.type])

	if BackHomeCricketBattleData:GetSingleBattleData() then
		slot5, slot6 = nil

		if slot0.type == BackHomeCricketConst.SCORE_INDEX.TOTAL then
			slot5 = slot1.attackData.totalNum
			slot6 = slot1.defendData.totalNum
		elseif slot0.type == BackHomeCricketConst.SCORE_INDEX.ADVANTAGE then
			slot5 = slot3.peculiar
			slot6 = slot4.peculiar
		elseif slot0.type == BackHomeCricketConst.SCORE_INDEX.SKILL_SCORE then
			slot5 = slot3.skillAdd
			slot6 = slot4.skillAdd
		elseif slot0.type == BackHomeCricketConst.SCORE_INDEX.SKILL_DEDCUTION then
			slot5 = slot3.skillDec
			slot6 = slot4.skillDec
		end

		slot7 = slot0:CalculateBaseNum(slot5, slot6)
		slot8, slot9 = nil
		slot0.scorelText_.text = slot5
		slot0.scorerText_.text = slot6
		slot10 = LeanTween.value(slot0.bar1_.gameObject, 0, slot5 / slot7, 1)

		slot10:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.bar1_.value = slot0
		end))
		slot10:setOnComplete(System.Action(function ()
			LeanTween.cancel(uv0.bar1_.gameObject)
			uv1:setOnUpdate(nil):setOnComplete(nil)
		end))

		slot11 = LeanTween.value(slot0.bar2_.gameObject, 0, slot6 / slot7, 1)

		slot11:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.bar2_.value = slot0
		end))
		slot11:setOnComplete(System.Action(function ()
			LeanTween.cancel(uv0.bar2_.gameObject)
			uv1:setOnUpdate(nil):setOnComplete(nil)
		end))
	end
end

function slot0.CalculateBaseNum(slot0, slot1, slot2)
	slot5 = -1

	for slot9, slot10 in ipairs(GameDisplayCfg.dorm_idol_score_compare_scale.value) do
		if math.max(slot1, slot2) < slot10[1] then
			slot5 = slot10[2]

			break
		end
	end

	if slot5 < 0 then
		slot5 = slot4[#slot4][2]
	end

	return math.ceil((slot3 + 1) / slot5) * slot5
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
