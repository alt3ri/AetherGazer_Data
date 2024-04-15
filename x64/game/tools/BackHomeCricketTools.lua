function slot1(slot0)
	slot1 = {
		effectType = slot0.effect_type,
		object = slot0.object,
		triggetTime = slot0.trigger_time,
		round = slot0.round,
		probability = slot0.probability
	}
end

return {
	GetSkillEffectStruct = function (slot0)
		if IdolTraineeSkillEffectCfg[slot0] then
			slot4 = slot1.unique

			if uv0(slot1).effectType == BackHomeCricketConst.SKILL_EFFECT_TYPE.ATTRIBUTE_CHNAGE then
				slot2 = {
					attributeType = slot4[1],
					percent = slot4[2]
				}
			elseif slot3 == BackHomeCricketConst.SKILL_EFFECT_TYPE.ACTION_SCORE_CHANGE then
				slot2 = {
					attributeAction = slot4[1],
					percent = slot4[2]
				}
			elseif slot3 == BackHomeCricketConst.SKILL_EFFECT_TYPE.SKILL_RELEASE then
				slot2 = {
					percent = slot4[1]
				}
			elseif slot3 == BackHomeCricketConst.SKILL_EFFECT_TYPE.BEHAVIOR_SCORE_CHANGE then
				slot2 = {
					point = slot4[1]
				}
			elseif slot3 == BackHomeCricketConst.SKILL_EFFECT_TYPE.TOTAL_SCORE_CHANGE then
				slot2 = {
					percent = slot4[1]
				}
			end

			return slot2
		else
			Debug.LogError("未获取到对应技能效果id配置 " .. slot0)
		end
	end
}
