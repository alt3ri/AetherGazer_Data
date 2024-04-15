slot0 = class("PushSnowBallTeamResultItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot2
	slot0.index_ = slot1

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	if slot0.rankText_ then
		slot0.rankText_.text = slot0.data_.rank
	end

	if slot0.scoreText_ then
		slot0.scoreText_.text = slot0.data_.score
	end

	if slot0.rankController_ then
		if slot0.data_.rank <= 3 then
			slot0.rankController_:SetSelectedIndex(slot0.data_.rank - 1)
		else
			slot0.rankController_:SetSelectedIndex(0)
		end
	end

	slot0.nameText_.text = slot0.data_.nick
	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot0.data_.icon)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.data_.frame)
end

return slot0
