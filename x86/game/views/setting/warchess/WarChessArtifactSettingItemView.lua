slot0 = class("WarChessArtifactSettingItemView", MatrixArtifactSettingItemView)

function slot0.SetData(slot0, slot1)
	slot3 = slot1
	slot0.name_.text = GetI18NText(WarchessItemCfg[slot1].name)
	slot0.desc_.text = GetI18NText(GetCfgDescription(AffixTypeCfg[WarchessItemCfg[slot3].params[1][1]].description[1], WarchessItemCfg[slot3].params[1][2]))
	slot0.icon_.sprite = ChessTools.GetWarChessItemSprite(slot1)
end

return slot0
