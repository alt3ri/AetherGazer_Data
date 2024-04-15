return {
	TerminologyDefaultHandler = function (slot0)
		if #slot0 <= 0 then
			return
		end

		JumpTools.OpenPageByJump("terminology", {
			terminologyIdList = slot0
		})
	end,
	AddTerminologyHandler = function (slot0, slot1, slot2, slot3)
		if slot3 == nil then
			slot3 = uv0.TerminologyDefaultHandler
		end

		RichTextTools.AddEventClickHandler(slot0, slot1, slot2, "terminology", function (slot0)
			uv0(uv1.MergeIdList(slot0))
		end)
	end,
	MergeIdList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			for slot10 in string.gmatch(slot6, "%d+") do
				table.insert(slot1, tonumber(slot10))
			end
		end

		return slot1
	end,
	GetCfgTitle = function (slot0)
		return GetI18NText(slot0.word)
	end,
	GetCfgDescription = function (slot0)
		return GetI18NText(slot0.desc)
	end
}
