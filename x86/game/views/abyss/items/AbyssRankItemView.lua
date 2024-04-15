slot0 = class("AbyssRankItemView", ReduxView)

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

	slot0.rankController_ = slot0.conExCollection_:GetController("rank")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.viewBtn_, nil, function ()
		slot0 = {
			userId = uv0.data_.user_id,
			layer = uv0.data_.difficulty,
			stageInfos = {}
		}

		for slot4, slot5 in pairs(uv0.data_.stage_team_list) do
			slot6 = {
				stage_id = slot4,
				heroList = {}
			}

			for slot10, slot11 in pairs(slot5) do
				table.insertto(slot6.heroList, slot11)
			end

			table.insert(slot0.stageInfos, slot6)
		end

		table.sort(slot0.stageInfos, function (slot0, slot1)
			return slot0.stage_id < slot1.stage_id
		end)
		JumpTools.OpenPageByJump("abyssTeamCheck", {
			layerInfo = slot0
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.isGuild_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.headImg_.sprite = ItemTools.getItemSprite(slot0.data_.portrait)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.data_.frame)

	if slot0.data_.rank < 4 then
		slot0.rankController_:SetSelectedIndex(slot0.data_.rank)
	else
		slot0.rankController_:SetSelectedIndex(0)
	end

	slot0.rankText_.text = GetI18NText(slot0.data_.rank)
	slot0.nickText_.text = GetI18NText(slot0.data_.nick)
	slot0.scoreText_.text = GetI18NText(slot0.data_.score)
	slot0.layerText_.text = GetI18NText(slot0.data_.difficulty)
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

	uv0.super.Dispose(slot0)
end

return slot0
