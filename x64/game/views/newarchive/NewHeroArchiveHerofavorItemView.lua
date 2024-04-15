slot0 = class("NewHeroArchiveHerofavorItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.favorController = ControllerUtil.GetController(slot0.transform_, "favorability")
end

function slot0.OnTop(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data = slot1
	slot0.id = slot2
	slot0.index = slot3

	slot0:RefreshUI()
end

function slot0.ResetData(slot0)
	slot0.data = nil
end

function slot0.RefreshUI(slot0, slot1)
	if slot0.data == nil then
		return
	end

	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Itemshead/" .. slot0.id)

	if ArchiveData:GetTrustLevel(slot0.id) > 0 then
		slot0.favorController:SetSelectedState("3")

		if slot0.favorExText_ then
			slot0.favorExText_.text = ArchiveTools.GetTrustLvDes(slot2)
		else
			slot0.favorText_.text = ArchiveTools.GetTrustLvDes(slot2)
		end
	else
		if not slot1 then
			slot0.favorController:SetSelectedState("1")
		else
			slot0.favorController:SetSelectedState("2")
		end

		if slot0.favorExText_ then
			slot0.favorExText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), slot0.data.lv)
		elseif slot1 then
			slot0.favorText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), slot0.data.lv)
		else
			slot0.favorText_.text = "Lv." .. slot0.data.lv
		end
	end

	if not slot1 and slot0.index > 1 then
		SetActive(slot0.gameObject_, false)
	else
		SetActive(slot0.gameObject_, true)
	end

	if slot0.nameText_ then
		if slot1 then
			slot0.nameText_.text = HeroCfg[slot0.id].name
		else
			slot0.nameText_.text = HeroCfg[slot0.id].suffix
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
