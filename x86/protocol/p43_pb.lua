slot0 = require("protobuf")

module("p43_pb", package.seeall)

slot1 = {
	SC_43001_FIELD_LIST = {},
	INSURE_NET_REC_FIELD_LIST = {},
	CS_43002_FIELD_LIST = {},
	SC_43003_FIELD_LIST = {},
	CS_43004_FIELD_LIST = {},
	SC_43005_FIELD_LIST = {}
}
SC_43001 = slot0.Descriptor()
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD = slot0.FieldDescriptor()
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD = slot0.FieldDescriptor()
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD = slot0.FieldDescriptor()
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD = slot0.FieldDescriptor()
INSURE_NET_REC = slot0.Descriptor()
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD = slot0.FieldDescriptor()
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD = slot0.FieldDescriptor()
CS_43002 = slot0.Descriptor()
SC_43003 = slot0.Descriptor()
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD = slot0.FieldDescriptor()
CS_43004 = slot0.Descriptor()
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD = slot0.FieldDescriptor()
SC_43005 = slot0.Descriptor()
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD = slot0.FieldDescriptor()
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.name = "stage_base_id"
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.full_name = ".p43.sc_43001.stage_base_id"
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.number = 1
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.index = 0
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.label = 2
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.has_default_value = false
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.default_value = 0
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.type = 13
slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD.cpp_type = 3
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.name = "equip_suit_id"
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.full_name = ".p43.sc_43001.equip_suit_id"
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.number = 2
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.index = 1
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.label = 2
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.has_default_value = false
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.default_value = 0
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.type = 13
slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD.cpp_type = 3
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.name = "next_refresh_time"
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.full_name = ".p43.sc_43001.next_refresh_time"
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.number = 3
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.index = 2
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.label = 2
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.has_default_value = false
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.default_value = 0
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.type = 13
slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD.cpp_type = 3
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.name = "insure_list"
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.full_name = ".p43.sc_43001.insure_list"
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.number = 4
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.index = 3
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.label = 3
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.has_default_value = false
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.default_value = {}
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.message_type = INSURE_NET_REC
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.type = 11
slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD.cpp_type = 10
SC_43001.name = "sc_43001"
SC_43001.full_name = ".p43.sc_43001"
SC_43001.nested_types = {}
SC_43001.enum_types = {}
SC_43001.fields = {
	slot1.SC_43001_FIELD_LIST.SC_43001_STAGE_BASE_ID_FIELD,
	slot1.SC_43001_FIELD_LIST.SC_43001_EQUIP_SUIT_ID_FIELD,
	slot1.SC_43001_FIELD_LIST.SC_43001_NEXT_REFRESH_TIME_FIELD,
	slot1.SC_43001_FIELD_LIST.SC_43001_INSURE_LIST_FIELD
}
SC_43001.is_extendable = false
SC_43001.extensions = {}
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.name = "difficulty"
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.full_name = ".p43.insure_net_rec.difficulty"
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.number = 1
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.index = 0
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.label = 2
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.has_default_value = false
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.default_value = 0
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.type = 13
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD.cpp_type = 3
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.name = "insure_times"
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.full_name = ".p43.insure_net_rec.insure_times"
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.number = 2
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.index = 1
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.label = 2
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.has_default_value = false
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.default_value = 0
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.type = 13
slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD.cpp_type = 3
INSURE_NET_REC.name = "insure_net_rec"
INSURE_NET_REC.full_name = ".p43.insure_net_rec"
INSURE_NET_REC.nested_types = {}
INSURE_NET_REC.enum_types = {}
INSURE_NET_REC.fields = {
	slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_DIFFICULTY_FIELD,
	slot1.INSURE_NET_REC_FIELD_LIST.INSURE_NET_REC_INSURE_TIMES_FIELD
}
INSURE_NET_REC.is_extendable = false
INSURE_NET_REC.extensions = {}
CS_43002.name = "cs_43002"
CS_43002.full_name = ".p43.cs_43002"
CS_43002.nested_types = {}
CS_43002.enum_types = {}
CS_43002.fields = {}
CS_43002.is_extendable = false
CS_43002.extensions = {}
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.name = "result"
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.full_name = ".p43.sc_43003.result"
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.number = 1
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.index = 0
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.label = 2
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.has_default_value = false
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.default_value = 0
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.type = 13
slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD.cpp_type = 3
SC_43003.name = "sc_43003"
SC_43003.full_name = ".p43.sc_43003"
SC_43003.nested_types = {}
SC_43003.enum_types = {}
SC_43003.fields = {
	slot1.SC_43003_FIELD_LIST.SC_43003_RESULT_FIELD
}
SC_43003.is_extendable = false
SC_43003.extensions = {}
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.name = "equip_suit_id"
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.full_name = ".p43.cs_43004.equip_suit_id"
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.number = 1
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.index = 0
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.label = 2
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.has_default_value = false
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.default_value = 0
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.type = 13
slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD.cpp_type = 3
CS_43004.name = "cs_43004"
CS_43004.full_name = ".p43.cs_43004"
CS_43004.nested_types = {}
CS_43004.enum_types = {}
CS_43004.fields = {
	slot1.CS_43004_FIELD_LIST.CS_43004_EQUIP_SUIT_ID_FIELD
}
CS_43004.is_extendable = false
CS_43004.extensions = {}
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.name = "result"
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.full_name = ".p43.sc_43005.result"
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.number = 1
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.index = 0
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.label = 2
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.has_default_value = false
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.default_value = 0
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.type = 13
slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD.cpp_type = 3
SC_43005.name = "sc_43005"
SC_43005.full_name = ".p43.sc_43005"
SC_43005.nested_types = {}
SC_43005.enum_types = {}
SC_43005.fields = {
	slot1.SC_43005_FIELD_LIST.SC_43005_RESULT_FIELD
}
SC_43005.is_extendable = false
SC_43005.extensions = {}
cs_43002 = slot0.Message(CS_43002)
cs_43004 = slot0.Message(CS_43004)
insure_net_rec = slot0.Message(INSURE_NET_REC)
sc_43001 = slot0.Message(SC_43001)
sc_43003 = slot0.Message(SC_43003)
sc_43005 = slot0.Message(SC_43005)

return p43_pb
