slot0 = class("HeroAstrolabeBaseInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	if slot0.itemS_ then
		for slot4, slot5 in ipairs(slot0.itemS_) do
			for slot9, slot10 in ipairs(slot5) do
				slot10:Dispose()
			end
		end
	end

	slot0.itemSGo_ = nil
	slot0.itemS_ = nil
	slot0.astrolabeInfo_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
