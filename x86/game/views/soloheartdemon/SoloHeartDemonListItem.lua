slot0 = class("SoloHeartDemonListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	if slot0.conExCollection_ then
		slot0.rankController_ = slot0.conExCollection_:GetController("rank")
	else
		slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot2
	slot0.data = slot1
	slot0.type = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.data == nil then
		slot0.rankController_:SetSelectedState("5")

		slot0.rankText_.text = ""

		return
	end

	slot0.nickText_.text = slot0.data.nick
	slot0.rankText_.text = slot0.data.rank

	slot0.rankController_:SetSelectedState(tostring(slot0.data.rank > 3 and 0 or slot0.data.rank))

	slot0.headImg_.sprite = ItemTools.getItemSprite(slot0.data.portrait)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.data.frame)

	slot0[slot0.type == 2 and "UpdateRankView" or "UpdateMainView"](slot0)
end

function slot0.UpdateRankView(slot0)
	slot0.finishTimeText_.text = manager.time:DescCdTime2(slot0.data.staticInfo.clearTime)
	slot0.gradeText_.text = slot0.data.score
	slot0.hitDamageText_.text = slot0.data.staticInfo.hitNumber
end

function slot0.UpdateMainView(slot0)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
