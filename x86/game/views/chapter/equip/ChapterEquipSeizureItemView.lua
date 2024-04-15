local var_0_0 = class("ChapterEquipSeizureItemView", import(".ChapterEquipItemBaseView"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.panelTf_, ChapterTools.GetRedPoint(arg_1_0.chapterClientID_))
	arg_1_0:AddRefreshTimer()
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.panelTf_, ChapterTools.GetRedPoint(arg_2_0.chapterClientID_))
	arg_2_0:StopRefreshTimer()
end

function var_0_0.AddRefreshTimer(arg_3_0)
	return
end

function var_0_0.StopRefreshTimer(arg_4_0)
	if arg_4_0.timer_ then
		arg_4_0.timer_:Stop()

		arg_4_0.timer_ = nil
	end
end

return var_0_0
