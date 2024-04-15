slot0 = class("ArtifactSettingToggle", BaseSettingToggle)

function slot0.Ctor(slot0, slot1)
	slot0.params_ = slot1
end

function slot0.GetName(slot0)
	return "Artifact"
end

function slot0.UIClass(slot0)
	if slot0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixArtifactSettingView
	elseif slot1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
		return MatrixArtifactSettingView
	elseif slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
		return MatrixArtifactSettingView
	elseif slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		return WarChessArtifactSettingView
	end
end

function slot0.GetPath(slot0)
	return "Widget/System/Setting/InformationSettingUI"
end

function slot0.Order(slot0)
	return 7
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting08")
end

function slot0.GetParams(slot0)
	if slot0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixData:GetArtifactList()
	elseif slot1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
		return ActivityMatrixData:GetArtifactList(slot1:GetActivityID())
	elseif slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
		slot0.viewList_[view] = MatrixArtifactSettingView.New(slot0.viewListGo_[view], StrategyMatrixData:GetArtifactList(slot1:GetActivityID()))
	elseif slot1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		slot3 = {}

		for slot7, slot8 in pairs(WarChessData:GetArtifactData()) do
			table.insert(slot3, {
				id = slot7
			})
		end

		return slot3
	end
end

function slot0.IsSetting(slot0)
	return false
end

return slot0
