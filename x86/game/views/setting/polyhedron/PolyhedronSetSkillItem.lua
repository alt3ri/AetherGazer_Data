local var_0_0 = class("PolyhedronSetSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.POLYHEDRON)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	if arg_4_1 then
		local var_4_0 = arg_4_0:GetRealSkillId(arg_4_1)
		local var_4_1 = HeroSkillCfg[var_4_0]

		arg_4_0.iconImg_.sprite = getSprite("Atlas/" .. arg_4_1.heroId, var_4_0)
		arg_4_0.nameText_.text = var_4_1.name

		arg_4_0:RefreshLv(arg_4_1)

		local var_4_2 = HeroCfg[arg_4_1.heroId]
		local var_4_3 = table.indexof(var_4_2.skills, arg_4_1.id)

		arg_4_0.subnameText_.text = var_4_2.skill_subhead[var_4_3]

		local var_4_4 = var_4_1.element_type

		for iter_4_0, iter_4_1 in pairs(var_4_4) do
			local var_4_5 = arg_4_0["typeIcon_" .. iter_4_0]

			if var_4_5 then
				local var_4_6 = SkillElementCfg[iter_4_1].icon

				if var_4_6 and var_4_6 ~= "" then
					SetActive(var_4_5.transform.gameObject, true)

					var_4_5.sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[iter_4_1].icon)
				end
			end
		end

		arg_4_0.contentText_.text = HeroSkillCfg[var_4_0].simpleDesc

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.contentText_.transform)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.transform_)
	end
end

function var_0_0.RefreshLv(arg_5_0, arg_5_1)
	local var_5_0 = 0

	if var_5_0 <= 0 then
		arg_5_0.lvText_.text = string.format("%d", arg_5_1.lv + arg_5_1.addSkillLv)
	else
		arg_5_0.lvText_.text = string.format("<color=#F3DC5A>%d</color>", arg_5_1.lv + arg_5_1.addSkillLv + var_5_0)
	end
end

function var_0_0.GetRealSkillId(arg_6_0, arg_6_1)
	return arg_6_0.heroViewProxy_:GetRealSkillId(arg_6_1.heroId, arg_6_1.id)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
