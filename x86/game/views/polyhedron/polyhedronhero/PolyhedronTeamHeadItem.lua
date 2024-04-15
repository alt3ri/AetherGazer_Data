local var_0_0 = import("game.views.heroTeamInfo.HeroTeamHeadItem")
local var_0_1 = class("PolyhedronTeamHeadItem", var_0_0)

function var_0_1.SetHeroData(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.extra_ = arg_1_3

	if arg_1_2 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_1_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_1_0.trialID_ = arg_1_1
		arg_1_0.heroId_ = HeroStandardSystemCfg[arg_1_1].hero_id
		arg_1_1 = arg_1_0.heroId_
	else
		arg_1_0.heroId_ = arg_1_1
		arg_1_0.trialID_ = 0
	end

	arg_1_0.heroCfg_ = HeroCfg[arg_1_1]
	arg_1_0.heroInfo_ = PolyhedronData:GetHeroData(arg_1_1)
	arg_1_0.heroDataType_ = HeroConst.HERO_DATA_TYPE.POLYHEDRON

	arg_1_0:UpdateView()

	local var_1_0 = PolyhedronData:GetHeroUsingSkinInfo(arg_1_0.heroId_).id

	arg_1_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_1_0)

	local var_1_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS)

	if not PolyhedronData:GetPolyhedronHeroUnlock(arg_1_0.heroId_) and arg_1_0.heroInfo_.unlock == 1 and var_1_1 > 0 then
		manager.redPoint:SetRedPointIndependent(arg_1_0.noticePos_, true, {
			x = 0,
			y = 0
		})
	else
		manager.redPoint:SetRedPointIndependent(arg_1_0.noticePos_, false)
	end

	arg_1_0.loveCon_:SetSelectedState("off")
end

return var_0_1
