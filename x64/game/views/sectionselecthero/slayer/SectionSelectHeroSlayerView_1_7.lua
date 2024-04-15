local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroSlayerView")
local var_0_1 = class("SectionSelectHeroSlayerView_1_7", var_0_0)

function var_0_1.RefreshAddBtn(arg_1_0)
	var_0_1.super.RefreshAddBtn(arg_1_0)
	SetActive(arg_1_0.addBtnGo_[2], false)
	SetActive(arg_1_0.addBtnGo_[3], false)
	SetActive(arg_1_0.drag_[2].gameObject, false)
	SetActive(arg_1_0.drag_[3].gameObject, false)
end

function var_0_1.RefreshRace(arg_2_0)
	var_0_1.super.RefreshRace(arg_2_0)
	SetActive(arg_2_0.effectPanel_, false)
end

return var_0_1
