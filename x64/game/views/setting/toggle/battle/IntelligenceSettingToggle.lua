slot0 = class("IntelligenceSettingToggle", BaseSettingToggle)

function slot0.Ctor(slot0, slot1)
	slot0.params_ = slot1
end

function slot0.GetName(slot0)
	return "Intelligence"
end

function slot0.UIClass(slot0)
	if slot0.params_.stageData and slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixStageSettingView
	elseif slot1 and (slot1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		return MatrixStageSettingView
	else
		return IntelligenceView
	end
end

function slot0.GetPath(slot0)
	if slot0.params_.stageData and slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return "Widget/System/Setting/VariableSettingUI"
	elseif slot1 and (slot1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		return "Widget/System/Setting/VariableSettingUI"
	else
		return "Widget/System/Setting/IntelligenceUI"
	end
end

function slot0.Order(slot0)
	return 2
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting09")
end

function slot0.GetParams(slot0)
	return slot0.params_
end

function slot0.IsSetting(slot0)
	return false
end

return slot0
