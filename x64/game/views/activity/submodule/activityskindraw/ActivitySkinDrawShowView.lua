slot0 = class("ActivitySkinDrawShowView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddBtnListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starCon_ = ControllerUtil.GetController(slot0.transform_, "star")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddBtnListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	SetActive(slot0.gameObject_, true)
	slot0:DestroySticker()

	if slot2.type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		slot0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(ChatStickerCfg[slot2.param[1]].icon .. SettingData:GetCurrentLanguageKey()), slot0.dynamicTf_)

		slot0.typeCon_:SetSelectedState("dynamic")
	elseif slot2.type == ItemConst.ITEM_TYPE.HERO_SKIN then
		slot0.role_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot2.id)

		slot0.typeCon_:SetSelectedState("skin")
	else
		slot0.icon_.sprite = ItemTools.getItemSprite(slot2.id)

		slot0.typeCon_:SetSelectedState("icon")
		slot0.icon_:SetNativeSize()
	end

	slot0.name_.text = ItemTools.getItemName(slot2.id) .. "×" .. slot3

	slot0.starCon_:SetSelectedState(slot2.rare)
	slot0.playable_:Evaluate()

	slot0.playable_.time = 0

	slot0.playable_:Play()
end

function slot0.DestroySticker(slot0)
	if slot0.dynamicStickerGo_ then
		Object.Destroy(slot0.dynamicStickerGo_)

		slot0.dynamicStickerGo_ = nil
	end
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:DestroySticker()
	slot0.super.Dispose(slot0)
end

return slot0
