slot0 = class("MythicDifficultyItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddClickListen()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = slot0.m_contrExCo_:GetController("select")
	slot0.lockController_ = slot0.m_contrExCo_:GetController("lock")
end

function slot0.AddClickListen(slot0)
	slot0:AddBtnListener(slot0.m_button, nil, function ()
		if uv0.unlock and uv0.clickFunc then
			uv0.clickFunc(uv0.index)
		end
	end)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.SetChoice(slot0, slot1)
	slot0.selectController_:SetSelectedIndex(slot1 == slot0.index and 1 or 0)
end

function slot0.RefreshData(slot0, slot1)
	slot0.index = slot1
	slot2 = MythicCfg.all[slot0.index]
	slot0.m_bg.sprite = getSpriteWithoutAtlas("TextureConfig/Challenge_Mythic/" .. MythicCfg[slot2].background)
	slot0.unlock = MythicData:GetIsOpenDifficulty(slot2)

	slot0.lockController_:SetSelectedIndex(slot0.unlock and 0 or 1)

	if slot3.difficulty == 1 then
		slot0.numText_.text = NumberTools.IntToRomam(slot2)
	else
		slot0.numText_.text = "Ω"
	end
end

return slot0
