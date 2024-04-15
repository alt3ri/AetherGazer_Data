slot0 = class("RechargeEnterListItemView", ReduxView)

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

	slot0.selectController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickListener_ ~= nil then
			uv0.clickListener_(uv0.index_)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickListener_ = slot1
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1

	if slot0.id_ ~= nil then
		manager.redPoint:unbindUIandKey(slot0.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. slot0.id_, {
			x = 0,
			y = 0
		})
	end

	slot0.id_ = slot2

	manager.redPoint:bindUIandKey(slot0.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. slot0.id_, {
		x = 0,
		y = 0
	})

	slot0.cfg_ = RechargeRecommendCfg[slot0.id_]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.titleLabel_.text = slot0.cfg_.title
	slot0.subTitleLabel_.text = slot0.cfg_.sub_title
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/RechargeRecommend/icons/" .. slot0.cfg_.icon)
end

function slot0.GetIndex(slot0)
	return slot0.index_
end

function slot0.SetSelect(slot0, slot1)
	if slot1 and slot0.id_ ~= nil then
		ShopAction.ReadRedPoint(slot0.id_)
	end

	slot0.selectController_:SetSelectedState(slot1 and "on" or "off")
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
	slot0.data_ = nil

	if slot0.id_ ~= nil then
		manager.redPoint:unbindUIandKey(slot0.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. slot0.id_, {
			x = 0,
			y = 0
		})
	end

	uv0.super.Dispose(slot0)
end

return slot0
