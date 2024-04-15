slot0 = class("JumpToStep", BaseStep)

function slot0.Init(slot0, slot1)
	slot0._isNoHome = slot0._guide.is_no_home
	slot0._linkData = GuideStepCfg[slot0._stepId].params
end

function slot0.Play(slot0)
	if slot0._linkData[1] == 101 or slot0._isNoHome then
		gameContext:ClearHistory()
	end

	JumpTools.OpenPageUntilLoaded(JumpTools.GetLinkAndParams(slot0._linkData))
	slot0:OnStepEnd()
end

function slot0.Check(slot0)
	if whereami == "home" and not LuaExchangeHelper.GetSceneIsHanding() then
		return true
	else
		return false
	end
end

return slot0
