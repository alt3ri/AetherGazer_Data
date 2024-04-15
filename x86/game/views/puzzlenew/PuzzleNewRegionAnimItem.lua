slot0 = class("PuzzleNewRegionAnimItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	SetActive(slot0.gameObject_, false)

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.PlayAnim(slot0, slot1)
	slot0.statusController_:SetSelectedIndex(2)
	SetActive(slot0.gameObject_, true)
	AnimatorTools.PlayAnimationWithCallback(slot0.animator_, "XH2ndHeroPublicize_regionItem", function ()
		SetActive(uv0.gameObject_, false)

		if uv1 then
			uv1()
		end
	end)
	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_reward", "")
end

return slot0
