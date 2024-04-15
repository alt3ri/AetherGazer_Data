slot0 = require("protobuf")

module("p25_pb", package.seeall)

slot2 = {
	SC_25009_FIELD_LIST = {}
}
SC_25009 = slot0.Descriptor()
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.name = "daily_battle_list"
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.full_name = ".common.sc_25009.daily_battle_list"
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.number = 1
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.index = 0
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.label = 3
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.has_default_value = false
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.default_value = {}
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.message_type = require("protocol/chapter_hrl_pb").CHAPTER_INFO
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.type = 11
slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.cpp_type = 10
SC_25009.name = "sc_25009"
SC_25009.full_name = ".common.sc_25009"
SC_25009.nested_types = {}
SC_25009.enum_types = {}
SC_25009.fields = {
	slot2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD
}
SC_25009.is_extendable = false
SC_25009.extensions = {}
sc_25009 = slot0.Message(SC_25009)

return p25_pb
