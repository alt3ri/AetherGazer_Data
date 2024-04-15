slot0 = class("LikeInfoPopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.id_)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.id_ = slot1.id
	slot0.nick_ = slot1.nick
	slot0.icon_ = slot1.icon
	slot0.frame_ = slot1.frame
	slot0.level_ = slot1.level
	slot0.time_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot0.icon_)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.frame_)
	slot0.nickTxt_.text = slot0.nick_
	slot0.levelTxt_.text = slot0.level_
	slot0.timeTxt_.text = manager.time:STimeDescS(slot0.time_, "!%Y/%m/%d %H:%M")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
