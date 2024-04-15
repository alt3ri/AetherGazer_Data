slot0 = import("game.quiz.QuizFunction")
slot1 = class("ActivityQuizRankItem", ReduxView)

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.mineCon_ = ControllerUtil.GetController(slot0.transform_, "mine")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot1.AddUIListeners(slot0)
end

function slot1.RefreshData(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.index_ = slot2
	slot0.data_ = uv0:GetRankData(slot1)
	slot0.scroe_.text = slot0.data_.score
	slot0.nick_.text = slot0.data_.nick
	slot0.rank_.text = slot0.index_

	if slot0.index_ > 3 then
		slot0.stateCon_:SetSelectedState("other")
	else
		slot0.stateCon_:SetSelectedState(slot0.index_)
	end
end

function slot1.SetMine(slot0, slot1)
	if slot0.mineCon_ then
		slot0.mineCon_:SetSelectedState(slot1 and "me" or "other")
	end
end

function slot1.OnExit(slot0)
end

function slot1.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot1
