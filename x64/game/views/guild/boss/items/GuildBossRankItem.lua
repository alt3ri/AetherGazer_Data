slot0 = class("GuildBossRankItem", ReduxView)

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

	slot0.heroCountController_ = slot0.conExCollection_:GetController("heroCount")
	slot0.rankController_ = slot0.conExCollection_:GetController("rank")
	slot0.positionController_ = slot0.posExCon_:GetController("position")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.data_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.userID_ = slot0.data_.id
	slot0.nickText_.text = GetI18NText(slot0.data_.nick)
	slot0.rankText_.text = tostring(slot0.index_)
	slot0.scoreText_.text = slot0.data_.score
	slot0.headImg_.sprite = ItemTools.getItemSprite(slot0.data_.icon)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.data_.icon_frame)

	slot0.positionController_:SetSelectedState(tostring(slot0.data_.member_post))

	slot1 = math.min(#slot0.data_.hero_type_info, 3)
	slot2 = slot0.data_.hero_type_info
	slot6 = slot1

	slot0.heroCountController_:SetSelectedIndex(slot6)

	for slot6 = 1, slot1 do
		if slot2[slot6].skin_id == 0 then
			slot7 = slot2[slot6].hero_id
		end

		slot0["heroImg_" .. slot6].sprite = getSpriteViaConfig("HeroLittleIcon", slot7)
	end

	if slot0.index_ <= 3 then
		slot0.rankController_:SetSelectedState(slot0.index_)
	else
		slot0.rankController_:SetSelectedState(0)
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
