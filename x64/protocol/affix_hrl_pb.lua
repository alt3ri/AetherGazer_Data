slot0 = require("protobuf")

module("affix_hrl_pb", package.seeall)

slot1 = {
	AFFIX_NET_REC_FIELD_LIST = {}
}
AFFIX_NET_REC = slot0.Descriptor()
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD = slot0.FieldDescriptor()
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD = slot0.FieldDescriptor()
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD = slot0.FieldDescriptor()
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.name = "id"
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.full_name = ".common.affix_net_rec.id"
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.number = 1
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.index = 0
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.label = 2
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.has_default_value = false
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.default_value = 0
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.type = 13
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD.cpp_type = 3
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.name = "level"
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.full_name = ".common.affix_net_rec.level"
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.number = 2
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.index = 1
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.label = 2
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.has_default_value = false
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.default_value = 0
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.type = 13
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD.cpp_type = 3
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.name = "type"
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.full_name = ".common.affix_net_rec.type"
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.number = 3
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.index = 2
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.label = 2
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.has_default_value = false
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.default_value = 0
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.type = 13
slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD.cpp_type = 3
AFFIX_NET_REC.name = "affix_net_rec"
AFFIX_NET_REC.full_name = ".common.affix_net_rec"
AFFIX_NET_REC.nested_types = {}
AFFIX_NET_REC.enum_types = {}
AFFIX_NET_REC.fields = {
	slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_ID_FIELD,
	slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_LEVEL_FIELD,
	slot1.AFFIX_NET_REC_FIELD_LIST.AFFIX_NET_REC_TYPE_FIELD
}
AFFIX_NET_REC.is_extendable = false
AFFIX_NET_REC.extensions = {}
affix_net_rec = slot0.Message(AFFIX_NET_REC)

return affix_hrl_pb
