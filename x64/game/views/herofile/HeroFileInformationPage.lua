slot0 = class("HeroFileInformationPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.curHeroID_ = 0
	slot0.curRecordID_ = 0
	slot0.relationNetController_ = slot0.rightControllerEx_:GetController("relationNet")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.relationBtn_, nil, function ()
		if ArchiveData:GetTrustLevel(uv0.curHeroID_) == 0 then
			ShowTips("HERO_RELATION_UNLOCK_TRUST")

			return
		end

		JumpTools.OpenPageByJump("/heroTrammels", {
			heroId = uv0.curHeroID_
		})
	end)
end

function slot0.Show(slot0, slot1, slot2)
	slot0:UpdateView(slot1, slot2)
	SetActive(slot0.gameObject_, true)
end

function slot0.UpdateView(slot0, slot1, slot2)
	if slot2 ~= slot0.curHeroID_ then
		slot3 = HeroCfg[slot2]
		slot0.lableText_.text = GetI18NText(slot3.name)
		slot0.summaryText_.text = GetI18NText(slot3.hero_desc)

		if HeroRelationNetCfg.get_id_list_by_hero_id[slot2] then
			slot0.relationNetController_:SetSelectedState("unlock")
		else
			slot0.relationNetController_:SetSelectedState("lock")
		end

		slot0.curHeroID_ = slot2
	end

	if slot1 ~= slot0.curRecordID_ then
		slot3 = HeroRecordCfg[slot1]
		slot0.nameText_.text = GetI18NText(slot3.name)
		slot0.heightText_.text = GetI18NText(slot3.height)
		slot0.weightText_.text = GetI18NText(slot3.weight)
		slot0.birthdayText_.text = GetI18NText(slot3.birthday)
		slot0.organizationText_.text = GetI18NText(slot3.organization)
		slot0.hobbyText_.text = GetI18NText(slot3.like)
		slot0.curRecordID_ = slot1
	end

	manager.redPoint:bindUIandKey(slot0.relationBtn_.transform, string.format("%s_%s", RedPointConst.HERO_REALTION, slot0.curHeroID_))
end

function slot0.Hide(slot0)
	manager.redPoint:unbindUIandKey(slot0.relationBtn_.transform)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
