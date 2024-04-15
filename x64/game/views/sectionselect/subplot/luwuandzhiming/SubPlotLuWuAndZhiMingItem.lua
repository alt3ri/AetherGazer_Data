SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")
slot0 = class("SubPlotLuWuAndZhiMingItem", SubPlotBaseItem)

function slot0.RefreshCustomUI(slot0)
	slot0.textIndex_.text = BattleActivityStoryStageCfg[slot0.stageID_].name
end

return slot0
