slot0 = require("protobuf")
slot1 = require("protocol/item_hrl_pb")

module("p16_pb", package.seeall)

slot2 = {
	CS_16010_FIELD_LIST = {},
	SC_16011_FIELD_LIST = {},
	CS_16012_FIELD_LIST = {},
	SC_16013_FIELD_LIST = {},
	DRAW_RECORD_FIELD_LIST = {},
	SC_16015_FIELD_LIST = {},
	DRAW_INFO_SEND_FIELD_LIST = {},
	CS_16016_FIELD_LIST = {},
	SC_16017_FIELD_LIST = {},
	CS_16018_FIELD_LIST = {},
	SC_16019_FIELD_LIST = {},
	POOL_DETAILS_NET_REC_FIELD_LIST = {},
	CS_16020_FIELD_LIST = {},
	SC_16021_FIELD_LIST = {}
}
CS_16010 = slot0.Descriptor()
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD = slot0.FieldDescriptor()
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD = slot0.FieldDescriptor()
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD = slot0.FieldDescriptor()
SC_16011 = slot0.Descriptor()
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD = slot0.FieldDescriptor()
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD = slot0.FieldDescriptor()
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD = slot0.FieldDescriptor()
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD = slot0.FieldDescriptor()
CS_16012 = slot0.Descriptor()
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD = slot0.FieldDescriptor()
SC_16013 = slot0.Descriptor()
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD = slot0.FieldDescriptor()
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD = slot0.FieldDescriptor()
DRAW_RECORD = slot0.Descriptor()
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD = slot0.FieldDescriptor()
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD = slot0.FieldDescriptor()
SC_16015 = slot0.Descriptor()
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD = slot0.FieldDescriptor()
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD = slot0.FieldDescriptor()
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD = slot0.FieldDescriptor()
DRAW_INFO_SEND = slot0.Descriptor()
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD = slot0.FieldDescriptor()
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD = slot0.FieldDescriptor()
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD = slot0.FieldDescriptor()
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD = slot0.FieldDescriptor()
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD = slot0.FieldDescriptor()
CS_16016 = slot0.Descriptor()
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD = slot0.FieldDescriptor()
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD = slot0.FieldDescriptor()
SC_16017 = slot0.Descriptor()
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD = slot0.FieldDescriptor()
CS_16018 = slot0.Descriptor()
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD = slot0.FieldDescriptor()
SC_16019 = slot0.Descriptor()
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD = slot0.FieldDescriptor()
POOL_DETAILS_NET_REC = slot0.Descriptor()
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD = slot0.FieldDescriptor()
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD = slot0.FieldDescriptor()
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD = slot0.FieldDescriptor()
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD = slot0.FieldDescriptor()
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD = slot0.FieldDescriptor()
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD = slot0.FieldDescriptor()
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD = slot0.FieldDescriptor()
CS_16020 = slot0.Descriptor()
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD = slot0.FieldDescriptor()
SC_16021 = slot0.Descriptor()
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD = slot0.FieldDescriptor()
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.name = "type"
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.full_name = ".common.cs_16010.type"
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.number = 1
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.index = 0
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.label = 2
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.has_default_value = false
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.default_value = 0
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.type = 13
slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD.cpp_type = 3
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.name = "pool"
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.full_name = ".common.cs_16010.pool"
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.number = 2
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.index = 1
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.label = 2
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.has_default_value = false
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.default_value = 0
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.type = 13
slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD.cpp_type = 3
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.name = "cost"
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.full_name = ".common.cs_16010.cost"
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.number = 3
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.index = 2
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.label = 2
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.has_default_value = false
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.default_value = nil
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.message_type = slot1.ITEM_NET_REC
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.type = 11
slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD.cpp_type = 10
CS_16010.name = "cs_16010"
CS_16010.full_name = ".common.cs_16010"
CS_16010.nested_types = {}
CS_16010.enum_types = {}
CS_16010.fields = {
	slot2.CS_16010_FIELD_LIST.CS_16010_TYPE_FIELD,
	slot2.CS_16010_FIELD_LIST.CS_16010_POOL_FIELD,
	slot2.CS_16010_FIELD_LIST.CS_16010_COST_FIELD
}
CS_16010.is_extendable = false
CS_16010.extensions = {}
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.name = "result"
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.full_name = ".common.sc_16011.result"
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.number = 1
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.index = 0
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.label = 2
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.has_default_value = false
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.default_value = 0
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.type = 13
slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD.cpp_type = 3
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.name = "item"
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.full_name = ".common.sc_16011.item"
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.number = 2
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.index = 1
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.label = 3
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.has_default_value = false
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.default_value = {}
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.message_type = slot1.ITEM_NET_REC
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.type = 11
slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD.cpp_type = 10
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.name = "first_ssr_draw_flag"
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.full_name = ".common.sc_16011.first_ssr_draw_flag"
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.number = 3
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.index = 2
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.label = 1
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.has_default_value = false
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.default_value = false
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.type = 8
slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD.cpp_type = 7
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.name = "newbie_choose_draw_flag"
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.full_name = ".common.sc_16011.newbie_choose_draw_flag"
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.number = 4
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.index = 3
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.label = 1
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.has_default_value = false
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.default_value = false
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.type = 8
slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.cpp_type = 7
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.name = "ssr_draw_times"
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.full_name = ".common.sc_16011.ssr_draw_times"
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.number = 5
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.index = 4
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.label = 1
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.has_default_value = false
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.default_value = 0
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.type = 13
slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD.cpp_type = 3
SC_16011.name = "sc_16011"
SC_16011.full_name = ".common.sc_16011"
SC_16011.nested_types = {}
SC_16011.enum_types = {}
SC_16011.fields = {
	slot2.SC_16011_FIELD_LIST.SC_16011_RESULT_FIELD,
	slot2.SC_16011_FIELD_LIST.SC_16011_ITEM_FIELD,
	slot2.SC_16011_FIELD_LIST.SC_16011_FIRST_SSR_DRAW_FLAG_FIELD,
	slot2.SC_16011_FIELD_LIST.SC_16011_NEWBIE_CHOOSE_DRAW_FLAG_FIELD,
	slot2.SC_16011_FIELD_LIST.SC_16011_SSR_DRAW_TIMES_FIELD
}
SC_16011.is_extendable = false
SC_16011.extensions = {}
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.name = "id"
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.full_name = ".common.cs_16012.id"
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.number = 1
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.index = 0
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.label = 2
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.has_default_value = false
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.default_value = 0
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.type = 13
slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD.cpp_type = 3
CS_16012.name = "cs_16012"
CS_16012.full_name = ".common.cs_16012"
CS_16012.nested_types = {}
CS_16012.enum_types = {}
CS_16012.fields = {
	slot2.CS_16012_FIELD_LIST.CS_16012_ID_FIELD
}
CS_16012.is_extendable = false
CS_16012.extensions = {}
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.name = "result"
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.full_name = ".common.sc_16013.result"
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.number = 1
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.index = 0
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.label = 2
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.has_default_value = false
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.default_value = 0
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.type = 13
slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD.cpp_type = 3
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.name = "ssr_draw_times"
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.full_name = ".common.sc_16013.ssr_draw_times"
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.number = 2
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.index = 1
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.label = 1
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.has_default_value = false
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.default_value = 0
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.type = 13
slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD.cpp_type = 3
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.name = "draw_record_list"
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.full_name = ".common.sc_16013.draw_record_list"
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.number = 3
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.index = 2
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.label = 3
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.has_default_value = false
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.default_value = {}
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.message_type = DRAW_RECORD
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.type = 11
slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD.cpp_type = 10
SC_16013.name = "sc_16013"
SC_16013.full_name = ".common.sc_16013"
SC_16013.nested_types = {}
SC_16013.enum_types = {}
SC_16013.fields = {
	slot2.SC_16013_FIELD_LIST.SC_16013_RESULT_FIELD,
	slot2.SC_16013_FIELD_LIST.SC_16013_SSR_DRAW_TIMES_FIELD,
	slot2.SC_16013_FIELD_LIST.SC_16013_DRAW_RECORD_LIST_FIELD
}
SC_16013.is_extendable = false
SC_16013.extensions = {}
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.name = "item"
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.full_name = ".common.draw_record.item"
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.number = 1
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.index = 0
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.label = 2
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.has_default_value = false
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.default_value = nil
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.message_type = slot1.ITEM_NET_REC
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.type = 11
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD.cpp_type = 10
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.name = "draw_timestamp"
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.full_name = ".common.draw_record.draw_timestamp"
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.number = 2
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.index = 1
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.label = 2
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.has_default_value = false
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.default_value = 0
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.type = 13
slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD.cpp_type = 3
DRAW_RECORD.name = "draw_record"
DRAW_RECORD.full_name = ".common.draw_record"
DRAW_RECORD.nested_types = {}
DRAW_RECORD.enum_types = {}
DRAW_RECORD.fields = {
	slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_ITEM_FIELD,
	slot2.DRAW_RECORD_FIELD_LIST.DRAW_RECORD_DRAW_TIMESTAMP_FIELD
}
DRAW_RECORD.is_extendable = false
DRAW_RECORD.extensions = {}
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.name = "draw_info_list"
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.full_name = ".common.sc_16015.draw_info_list"
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.number = 1
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.index = 0
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.label = 3
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.has_default_value = false
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.default_value = {}
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.message_type = DRAW_INFO_SEND
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.type = 11
slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD.cpp_type = 10
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.name = "first_ssr_draw_flag"
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.full_name = ".common.sc_16015.first_ssr_draw_flag"
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.number = 2
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.index = 1
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.label = 1
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.has_default_value = false
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.default_value = false
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.type = 8
slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD.cpp_type = 7
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.name = "today_draw_times"
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.full_name = ".common.sc_16015.today_draw_times"
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.number = 3
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.index = 2
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.label = 2
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.has_default_value = false
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.default_value = 0
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.type = 13
slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD.cpp_type = 3
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.name = "newbie_choose_draw_flag"
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.full_name = ".common.sc_16015.newbie_choose_draw_flag"
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.number = 4
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.index = 3
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.label = 2
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.has_default_value = false
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.default_value = false
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.type = 8
slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD.cpp_type = 7
SC_16015.name = "sc_16015"
SC_16015.full_name = ".common.sc_16015"
SC_16015.nested_types = {}
SC_16015.enum_types = {}
SC_16015.fields = {
	slot2.SC_16015_FIELD_LIST.SC_16015_DRAW_INFO_LIST_FIELD,
	slot2.SC_16015_FIELD_LIST.SC_16015_FIRST_SSR_DRAW_FLAG_FIELD,
	slot2.SC_16015_FIELD_LIST.SC_16015_TODAY_DRAW_TIMES_FIELD,
	slot2.SC_16015_FIELD_LIST.SC_16015_NEWBIE_CHOOSE_DRAW_FLAG_FIELD
}
SC_16015.is_extendable = false
SC_16015.extensions = {}
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.name = "id"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.full_name = ".common.draw_info_send.id"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.number = 1
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.index = 0
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.label = 2
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.has_default_value = false
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.default_value = 0
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.type = 13
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD.cpp_type = 3
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.name = "ssr_draw_times"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.full_name = ".common.draw_info_send.ssr_draw_times"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.number = 2
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.index = 1
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.label = 2
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.has_default_value = false
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.default_value = 0
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.type = 13
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD.cpp_type = 3
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.name = "up"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.full_name = ".common.draw_info_send.up"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.number = 3
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.index = 2
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.label = 2
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.has_default_value = false
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.default_value = 0
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.type = 13
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD.cpp_type = 3
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.name = "up_times"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.full_name = ".common.draw_info_send.up_times"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.number = 4
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.index = 3
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.label = 2
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.has_default_value = false
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.default_value = 0
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.type = 13
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD.cpp_type = 3
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.name = "is_new"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.full_name = ".common.draw_info_send.is_new"
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.number = 5
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.index = 4
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.label = 2
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.has_default_value = false
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.default_value = 0
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.type = 13
slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD.cpp_type = 3
DRAW_INFO_SEND.name = "draw_info_send"
DRAW_INFO_SEND.full_name = ".common.draw_info_send"
DRAW_INFO_SEND.nested_types = {}
DRAW_INFO_SEND.enum_types = {}
DRAW_INFO_SEND.fields = {
	slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_ID_FIELD,
	slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_SSR_DRAW_TIMES_FIELD,
	slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_FIELD,
	slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_UP_TIMES_FIELD,
	slot2.DRAW_INFO_SEND_FIELD_LIST.DRAW_INFO_SEND_IS_NEW_FIELD
}
DRAW_INFO_SEND.is_extendable = false
DRAW_INFO_SEND.extensions = {}
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.name = "id"
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.full_name = ".common.cs_16016.id"
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.number = 1
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.index = 0
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.label = 2
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.has_default_value = false
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.default_value = 0
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.type = 13
slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD.cpp_type = 3
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.name = "up"
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.full_name = ".common.cs_16016.up"
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.number = 2
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.index = 1
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.label = 2
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.has_default_value = false
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.default_value = 0
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.type = 13
slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD.cpp_type = 3
CS_16016.name = "cs_16016"
CS_16016.full_name = ".common.cs_16016"
CS_16016.nested_types = {}
CS_16016.enum_types = {}
CS_16016.fields = {
	slot2.CS_16016_FIELD_LIST.CS_16016_ID_FIELD,
	slot2.CS_16016_FIELD_LIST.CS_16016_UP_FIELD
}
CS_16016.is_extendable = false
CS_16016.extensions = {}
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.name = "result"
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.full_name = ".common.sc_16017.result"
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.number = 1
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.index = 0
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.label = 2
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.has_default_value = false
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.default_value = 0
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.type = 13
slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD.cpp_type = 3
SC_16017.name = "sc_16017"
SC_16017.full_name = ".common.sc_16017"
SC_16017.nested_types = {}
SC_16017.enum_types = {}
SC_16017.fields = {
	slot2.SC_16017_FIELD_LIST.SC_16017_RESULT_FIELD
}
SC_16017.is_extendable = false
SC_16017.extensions = {}
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.name = "id"
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.full_name = ".common.cs_16018.id"
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.number = 1
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.index = 0
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.label = 2
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.has_default_value = false
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.default_value = 0
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.type = 13
slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD.cpp_type = 3
CS_16018.name = "cs_16018"
CS_16018.full_name = ".common.cs_16018"
CS_16018.nested_types = {}
CS_16018.enum_types = {}
CS_16018.fields = {
	slot2.CS_16018_FIELD_LIST.CS_16018_ID_FIELD
}
CS_16018.is_extendable = false
CS_16018.extensions = {}
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.name = "result"
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.full_name = ".common.sc_16019.result"
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.number = 1
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.index = 0
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.label = 2
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.has_default_value = false
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.default_value = 0
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.type = 13
slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD.cpp_type = 3
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.name = "pool_details"
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.full_name = ".common.sc_16019.pool_details"
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.number = 2
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.index = 1
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.label = 1
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.has_default_value = false
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.default_value = nil
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.message_type = POOL_DETAILS_NET_REC
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.type = 11
slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD.cpp_type = 10
SC_16019.name = "sc_16019"
SC_16019.full_name = ".common.sc_16019"
SC_16019.nested_types = {}
SC_16019.enum_types = {}
SC_16019.fields = {
	slot2.SC_16019_FIELD_LIST.SC_16019_RESULT_FIELD,
	slot2.SC_16019_FIELD_LIST.SC_16019_POOL_DETAILS_FIELD
}
SC_16019.is_extendable = false
SC_16019.extensions = {}
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.name = "s_up_probability"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.full_name = ".common.pool_details_net_rec.s_up_probability"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.number = 1
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.index = 0
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.label = 2
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.has_default_value = false
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.default_value = 0
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.type = 13
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD.cpp_type = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.name = "s_up_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.full_name = ".common.pool_details_net_rec.s_up_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.number = 2
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.index = 1
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.label = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.has_default_value = false
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.default_value = {}
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.type = 13
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD.cpp_type = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.name = "s_other_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.full_name = ".common.pool_details_net_rec.s_other_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.number = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.index = 2
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.label = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.has_default_value = false
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.default_value = {}
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.type = 13
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD.cpp_type = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.name = "a_up_probability"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.full_name = ".common.pool_details_net_rec.a_up_probability"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.number = 4
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.index = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.label = 2
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.has_default_value = false
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.default_value = 0
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.type = 13
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD.cpp_type = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.name = "a_up_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.full_name = ".common.pool_details_net_rec.a_up_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.number = 5
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.index = 4
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.label = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.has_default_value = false
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.default_value = {}
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.type = 13
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD.cpp_type = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.name = "a_other_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.full_name = ".common.pool_details_net_rec.a_other_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.number = 6
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.index = 5
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.label = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.has_default_value = false
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.default_value = {}
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.type = 13
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD.cpp_type = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.name = "b_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.full_name = ".common.pool_details_net_rec.b_item"
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.number = 7
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.index = 6
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.label = 3
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.has_default_value = false
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.default_value = {}
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.type = 13
slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD.cpp_type = 3
POOL_DETAILS_NET_REC.name = "pool_details_net_rec"
POOL_DETAILS_NET_REC.full_name = ".common.pool_details_net_rec"
POOL_DETAILS_NET_REC.nested_types = {}
POOL_DETAILS_NET_REC.enum_types = {}
POOL_DETAILS_NET_REC.fields = {
	slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_PROBABILITY_FIELD,
	slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_UP_ITEM_FIELD,
	slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_S_OTHER_ITEM_FIELD,
	slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_PROBABILITY_FIELD,
	slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_UP_ITEM_FIELD,
	slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_A_OTHER_ITEM_FIELD,
	slot2.POOL_DETAILS_NET_REC_FIELD_LIST.POOL_DETAILS_NET_REC_B_ITEM_FIELD
}
POOL_DETAILS_NET_REC.is_extendable = false
POOL_DETAILS_NET_REC.extensions = {}
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.name = "pool_id"
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.full_name = ".common.cs_16020.pool_id"
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.number = 1
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.index = 0
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.label = 2
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.has_default_value = false
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.default_value = 0
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.type = 13
slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD.cpp_type = 3
CS_16020.name = "cs_16020"
CS_16020.full_name = ".common.cs_16020"
CS_16020.nested_types = {}
CS_16020.enum_types = {}
CS_16020.fields = {
	slot2.CS_16020_FIELD_LIST.CS_16020_POOL_ID_FIELD
}
CS_16020.is_extendable = false
CS_16020.extensions = {}
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.name = "result"
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.full_name = ".common.sc_16021.result"
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.number = 1
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.index = 0
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.label = 2
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.has_default_value = false
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.default_value = 0
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.type = 13
slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD.cpp_type = 3
SC_16021.name = "sc_16021"
SC_16021.full_name = ".common.sc_16021"
SC_16021.nested_types = {}
SC_16021.enum_types = {}
SC_16021.fields = {
	slot2.SC_16021_FIELD_LIST.SC_16021_RESULT_FIELD
}
SC_16021.is_extendable = false
SC_16021.extensions = {}
cs_16010 = slot0.Message(CS_16010)
cs_16012 = slot0.Message(CS_16012)
cs_16016 = slot0.Message(CS_16016)
cs_16018 = slot0.Message(CS_16018)
cs_16020 = slot0.Message(CS_16020)
draw_info_send = slot0.Message(DRAW_INFO_SEND)
draw_record = slot0.Message(DRAW_RECORD)
pool_details_net_rec = slot0.Message(POOL_DETAILS_NET_REC)
sc_16011 = slot0.Message(SC_16011)
sc_16013 = slot0.Message(SC_16013)
sc_16015 = slot0.Message(SC_16015)
sc_16017 = slot0.Message(SC_16017)
sc_16019 = slot0.Message(SC_16019)
sc_16021 = slot0.Message(SC_16021)

return p16_pb
