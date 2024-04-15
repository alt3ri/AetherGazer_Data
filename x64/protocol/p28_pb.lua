slot0 = require("protobuf")
slot1 = require("protocol/item_hrl_pb")

module("p28_pb", package.seeall)

slot2 = {
	SC_28001_FIELD_LIST = {},
	ASSIGNMENT_INFO_FIELD_LIST = {},
	SC_28005_FIELD_LIST = {},
	SC_28007_FIELD_LIST = {},
	ASSIGNMENT_PROGRESS_FIELD_LIST = {},
	CS_28010_FIELD_LIST = {},
	SC_28011_FIELD_LIST = {},
	CS_28014_FIELD_LIST = {},
	SC_28015_FIELD_LIST = {},
	CS_28016_FIELD_LIST = {},
	SC_28017_FIELD_LIST = {},
	SC_28019_FIELD_LIST = {},
	PT_FIELD_LIST = {},
	SC_28021_FIELD_LIST = {},
	SC_28023_FIELD_LIST = {},
	CS_28024_FIELD_LIST = {},
	SC_28025_FIELD_LIST = {}
}
SC_28001 = slot0.Descriptor()
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD = slot0.FieldDescriptor()
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD = slot0.FieldDescriptor()
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD = slot0.FieldDescriptor()
ASSIGNMENT_INFO = slot0.Descriptor()
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD = slot0.FieldDescriptor()
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD = slot0.FieldDescriptor()
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD = slot0.FieldDescriptor()
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD = slot0.FieldDescriptor()
SC_28005 = slot0.Descriptor()
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD = slot0.FieldDescriptor()
SC_28007 = slot0.Descriptor()
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD = slot0.FieldDescriptor()
ASSIGNMENT_PROGRESS = slot0.Descriptor()
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD = slot0.FieldDescriptor()
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD = slot0.FieldDescriptor()
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD = slot0.FieldDescriptor()
CS_28010 = slot0.Descriptor()
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD = slot0.FieldDescriptor()
SC_28011 = slot0.Descriptor()
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD = slot0.FieldDescriptor()
CS_28014 = slot0.Descriptor()
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD = slot0.FieldDescriptor()
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD = slot0.FieldDescriptor()
SC_28015 = slot0.Descriptor()
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD = slot0.FieldDescriptor()
CS_28016 = slot0.Descriptor()
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD = slot0.FieldDescriptor()
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD = slot0.FieldDescriptor()
SC_28017 = slot0.Descriptor()
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD = slot0.FieldDescriptor()
SC_28019 = slot0.Descriptor()
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD = slot0.FieldDescriptor()
PT = slot0.Descriptor()
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD = slot0.FieldDescriptor()
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD = slot0.FieldDescriptor()
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD = slot0.FieldDescriptor()
SC_28021 = slot0.Descriptor()
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD = slot0.FieldDescriptor()
SC_28023 = slot0.Descriptor()
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD = slot0.FieldDescriptor()
CS_28024 = slot0.Descriptor()
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD = slot0.FieldDescriptor()
SC_28025 = slot0.Descriptor()
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.name = "assignment_list"
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.full_name = ".common.sc_28001.assignment_list"
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.number = 1
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.index = 0
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.label = 3
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.has_default_value = false
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.default_value = {}
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.message_type = ASSIGNMENT_INFO
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.type = 11
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD.cpp_type = 10
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.name = "send_type"
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.full_name = ".common.sc_28001.send_type"
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.number = 2
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.index = 1
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.label = 2
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.has_default_value = false
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.default_value = 0
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.type = 13
slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD.cpp_type = 3
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.name = "newbie_phase"
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.full_name = ".common.sc_28001.newbie_phase"
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.number = 3
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.index = 2
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.label = 1
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.has_default_value = false
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.default_value = 0
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.type = 13
slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD.cpp_type = 3
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.name = "assignment_phase"
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.full_name = ".common.sc_28001.assignment_phase"
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.number = 4
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.index = 3
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.label = 1
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.has_default_value = false
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.default_value = 0
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.type = 13
slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD.cpp_type = 3
SC_28001.name = "sc_28001"
SC_28001.full_name = ".common.sc_28001"
SC_28001.nested_types = {}
SC_28001.enum_types = {}
SC_28001.fields = {
	slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_LIST_FIELD,
	slot2.SC_28001_FIELD_LIST.SC_28001_SEND_TYPE_FIELD,
	slot2.SC_28001_FIELD_LIST.SC_28001_NEWBIE_PHASE_FIELD,
	slot2.SC_28001_FIELD_LIST.SC_28001_ASSIGNMENT_PHASE_FIELD
}
SC_28001.is_extendable = false
SC_28001.extensions = {}
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.name = "id"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.full_name = ".common.assignment_info.id"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.number = 1
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.index = 0
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.label = 2
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.has_default_value = false
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.default_value = 0
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.type = 13
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD.cpp_type = 3
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.name = "progress"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.full_name = ".common.assignment_info.progress"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.number = 2
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.index = 1
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.label = 2
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.has_default_value = false
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.default_value = 0
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.type = 13
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD.cpp_type = 3
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.name = "complete_flag"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.full_name = ".common.assignment_info.complete_flag"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.number = 3
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.index = 2
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.label = 2
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.has_default_value = false
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.default_value = 0
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.type = 13
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD.cpp_type = 3
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.name = "expired_timestamp"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.full_name = ".common.assignment_info.expired_timestamp"
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.number = 4
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.index = 3
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.label = 2
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.has_default_value = false
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.default_value = 0
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.type = 13
slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD.cpp_type = 3
ASSIGNMENT_INFO.name = "assignment_info"
ASSIGNMENT_INFO.full_name = ".common.assignment_info"
ASSIGNMENT_INFO.nested_types = {}
ASSIGNMENT_INFO.enum_types = {}
ASSIGNMENT_INFO.fields = {
	slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_ID_FIELD,
	slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_PROGRESS_FIELD,
	slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_COMPLETE_FLAG_FIELD,
	slot2.ASSIGNMENT_INFO_FIELD_LIST.ASSIGNMENT_INFO_EXPIRED_TIMESTAMP_FIELD
}
ASSIGNMENT_INFO.is_extendable = false
ASSIGNMENT_INFO.extensions = {}
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.name = "id_list"
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.full_name = ".common.sc_28005.id_list"
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.number = 1
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.index = 0
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.label = 3
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.has_default_value = false
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.default_value = {}
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.type = 13
slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD.cpp_type = 3
SC_28005.name = "sc_28005"
SC_28005.full_name = ".common.sc_28005"
SC_28005.nested_types = {}
SC_28005.enum_types = {}
SC_28005.fields = {
	slot2.SC_28005_FIELD_LIST.SC_28005_ID_LIST_FIELD
}
SC_28005.is_extendable = false
SC_28005.extensions = {}
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.name = "progress_list"
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.full_name = ".common.sc_28007.progress_list"
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.number = 1
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.index = 0
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.label = 3
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.has_default_value = false
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.default_value = {}
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.message_type = ASSIGNMENT_INFO
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.type = 11
slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD.cpp_type = 10
SC_28007.name = "sc_28007"
SC_28007.full_name = ".common.sc_28007"
SC_28007.nested_types = {}
SC_28007.enum_types = {}
SC_28007.fields = {
	slot2.SC_28007_FIELD_LIST.SC_28007_PROGRESS_LIST_FIELD
}
SC_28007.is_extendable = false
SC_28007.extensions = {}
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.name = "id"
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.full_name = ".common.assignment_progress.id"
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.number = 1
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.index = 0
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.label = 2
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.has_default_value = false
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.default_value = 0
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.type = 13
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD.cpp_type = 3
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.name = "progress"
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.full_name = ".common.assignment_progress.progress"
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.number = 2
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.index = 1
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.label = 2
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.has_default_value = false
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.default_value = 0
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.type = 13
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD.cpp_type = 3
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.name = "complete_flag"
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.full_name = ".common.assignment_progress.complete_flag"
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.number = 3
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.index = 2
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.label = 2
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.has_default_value = false
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.default_value = 0
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.type = 13
slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD.cpp_type = 3
ASSIGNMENT_PROGRESS.name = "assignment_progress"
ASSIGNMENT_PROGRESS.full_name = ".common.assignment_progress"
ASSIGNMENT_PROGRESS.nested_types = {}
ASSIGNMENT_PROGRESS.enum_types = {}
ASSIGNMENT_PROGRESS.fields = {
	slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_ID_FIELD,
	slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_PROGRESS_FIELD,
	slot2.ASSIGNMENT_PROGRESS_FIELD_LIST.ASSIGNMENT_PROGRESS_COMPLETE_FLAG_FIELD
}
ASSIGNMENT_PROGRESS.is_extendable = false
ASSIGNMENT_PROGRESS.extensions = {}
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.name = "id"
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.full_name = ".common.cs_28010.id"
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.number = 1
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.index = 0
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.label = 2
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.has_default_value = false
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.default_value = 0
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.type = 13
slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD.cpp_type = 3
CS_28010.name = "cs_28010"
CS_28010.full_name = ".common.cs_28010"
CS_28010.nested_types = {}
CS_28010.enum_types = {}
CS_28010.fields = {
	slot2.CS_28010_FIELD_LIST.CS_28010_ID_FIELD
}
CS_28010.is_extendable = false
CS_28010.extensions = {}
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.name = "result"
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.full_name = ".common.sc_28011.result"
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.number = 1
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.index = 0
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.label = 2
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.has_default_value = false
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.default_value = 0
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.type = 13
slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD.cpp_type = 3
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.name = "reward_list"
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.full_name = ".common.sc_28011.reward_list"
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.number = 2
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.index = 1
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.label = 3
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.default_value = {}
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.message_type = slot1.ITEM_NET_REC
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.type = 11
slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD.cpp_type = 10
SC_28011.name = "sc_28011"
SC_28011.full_name = ".common.sc_28011"
SC_28011.nested_types = {}
SC_28011.enum_types = {}
SC_28011.fields = {
	slot2.SC_28011_FIELD_LIST.SC_28011_RESULT_FIELD,
	slot2.SC_28011_FIELD_LIST.SC_28011_REWARD_LIST_FIELD
}
SC_28011.is_extendable = false
SC_28011.extensions = {}
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.name = "id_list"
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.full_name = ".common.cs_28014.id_list"
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.number = 1
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.index = 0
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.label = 3
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.has_default_value = false
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.default_value = {}
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.type = 13
slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD.cpp_type = 3
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.name = "type"
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.full_name = ".common.cs_28014.type"
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.number = 2
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.index = 1
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.label = 2
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.has_default_value = false
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.default_value = 0
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.type = 13
slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD.cpp_type = 3
CS_28014.name = "cs_28014"
CS_28014.full_name = ".common.cs_28014"
CS_28014.nested_types = {}
CS_28014.enum_types = {}
CS_28014.fields = {
	slot2.CS_28014_FIELD_LIST.CS_28014_ID_LIST_FIELD,
	slot2.CS_28014_FIELD_LIST.CS_28014_TYPE_FIELD
}
CS_28014.is_extendable = false
CS_28014.extensions = {}
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.name = "result"
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.full_name = ".common.sc_28015.result"
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.number = 1
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.index = 0
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.label = 2
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.has_default_value = false
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.default_value = 0
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.type = 13
slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD.cpp_type = 3
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.name = "reward_list"
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.full_name = ".common.sc_28015.reward_list"
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.number = 2
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.index = 1
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.label = 3
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.default_value = {}
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.message_type = slot1.ITEM_NET_REC
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.type = 11
slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD.cpp_type = 10
SC_28015.name = "sc_28015"
SC_28015.full_name = ".common.sc_28015"
SC_28015.nested_types = {}
SC_28015.enum_types = {}
SC_28015.fields = {
	slot2.SC_28015_FIELD_LIST.SC_28015_RESULT_FIELD,
	slot2.SC_28015_FIELD_LIST.SC_28015_REWARD_LIST_FIELD
}
SC_28015.is_extendable = false
SC_28015.extensions = {}
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.name = "need_active_point"
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.full_name = ".common.cs_28016.need_active_point"
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.number = 1
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.index = 0
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.label = 2
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.has_default_value = false
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.default_value = 0
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.type = 13
slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD.cpp_type = 3
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.name = "activity_pt_id"
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.full_name = ".common.cs_28016.activity_pt_id"
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.number = 2
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.index = 1
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.label = 1
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.has_default_value = false
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.default_value = 0
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.type = 13
slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD.cpp_type = 3
CS_28016.name = "cs_28016"
CS_28016.full_name = ".common.cs_28016"
CS_28016.nested_types = {}
CS_28016.enum_types = {}
CS_28016.fields = {
	slot2.CS_28016_FIELD_LIST.CS_28016_NEED_ACTIVE_POINT_FIELD,
	slot2.CS_28016_FIELD_LIST.CS_28016_ACTIVITY_PT_ID_FIELD
}
CS_28016.is_extendable = false
CS_28016.extensions = {}
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.name = "result"
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.full_name = ".common.sc_28017.result"
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.number = 1
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.index = 0
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.label = 2
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.has_default_value = false
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.default_value = 0
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.type = 13
slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD.cpp_type = 3
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.name = "reward_list"
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.full_name = ".common.sc_28017.reward_list"
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.number = 2
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.index = 1
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.label = 3
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.default_value = {}
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.message_type = slot1.ITEM_NET_REC
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.type = 11
slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD.cpp_type = 10
SC_28017.name = "sc_28017"
SC_28017.full_name = ".common.sc_28017"
SC_28017.nested_types = {}
SC_28017.enum_types = {}
SC_28017.fields = {
	slot2.SC_28017_FIELD_LIST.SC_28017_RESULT_FIELD,
	slot2.SC_28017_FIELD_LIST.SC_28017_REWARD_LIST_FIELD
}
SC_28017.is_extendable = false
SC_28017.extensions = {}
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.name = "pt_list"
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.full_name = ".common.sc_28019.pt_list"
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.number = 1
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.index = 0
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.label = 3
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.has_default_value = false
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.default_value = {}
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.message_type = PT
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.type = 11
slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD.cpp_type = 10
SC_28019.name = "sc_28019"
SC_28019.full_name = ".common.sc_28019"
SC_28019.nested_types = {}
SC_28019.enum_types = {}
SC_28019.fields = {
	slot2.SC_28019_FIELD_LIST.SC_28019_PT_LIST_FIELD
}
SC_28019.is_extendable = false
SC_28019.extensions = {}
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.name = "activity_pt_id"
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.full_name = ".common.pt.activity_pt_id"
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.number = 1
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.index = 0
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.label = 2
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.has_default_value = false
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.default_value = 0
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.type = 13
slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD.cpp_type = 3
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.name = "active_point"
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.full_name = ".common.pt.active_point"
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.number = 2
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.index = 1
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.label = 2
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.has_default_value = false
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.default_value = 0
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.type = 13
slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD.cpp_type = 3
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.name = "get_id_list"
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.full_name = ".common.pt.get_id_list"
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.number = 3
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.index = 2
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.label = 3
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.has_default_value = false
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.default_value = {}
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.type = 13
slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD.cpp_type = 3
PT.name = "pt"
PT.full_name = ".common.pt"
PT.nested_types = {}
PT.enum_types = {}
PT.fields = {
	slot2.PT_FIELD_LIST.PT_ACTIVITY_PT_ID_FIELD,
	slot2.PT_FIELD_LIST.PT_ACTIVE_POINT_FIELD,
	slot2.PT_FIELD_LIST.PT_GET_ID_LIST_FIELD
}
PT.is_extendable = false
PT.extensions = {}
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.name = "progress_list"
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.full_name = ".common.sc_28021.progress_list"
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.number = 1
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.index = 0
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.label = 3
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.has_default_value = false
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.default_value = {}
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.message_type = ASSIGNMENT_INFO
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.type = 11
slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD.cpp_type = 10
SC_28021.name = "sc_28021"
SC_28021.full_name = ".common.sc_28021"
SC_28021.nested_types = {}
SC_28021.enum_types = {}
SC_28021.fields = {
	slot2.SC_28021_FIELD_LIST.SC_28021_PROGRESS_LIST_FIELD
}
SC_28021.is_extendable = false
SC_28021.extensions = {}
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.name = "assignment_list"
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.full_name = ".common.sc_28023.assignment_list"
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.number = 1
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.index = 0
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.label = 3
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.has_default_value = false
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.default_value = {}
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.message_type = ASSIGNMENT_INFO
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.type = 11
slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD.cpp_type = 10
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.name = "send_type"
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.full_name = ".common.sc_28023.send_type"
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.number = 2
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.index = 1
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.label = 2
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.has_default_value = false
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.default_value = 0
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.type = 13
slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD.cpp_type = 3
SC_28023.name = "sc_28023"
SC_28023.full_name = ".common.sc_28023"
SC_28023.nested_types = {}
SC_28023.enum_types = {}
SC_28023.fields = {
	slot2.SC_28023_FIELD_LIST.SC_28023_ASSIGNMENT_LIST_FIELD,
	slot2.SC_28023_FIELD_LIST.SC_28023_SEND_TYPE_FIELD
}
SC_28023.is_extendable = false
SC_28023.extensions = {}
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.name = "id_list"
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.full_name = ".common.cs_28024.id_list"
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.number = 1
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.index = 0
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.label = 3
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.has_default_value = false
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.default_value = {}
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.type = 13
slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD.cpp_type = 3
CS_28024.name = "cs_28024"
CS_28024.full_name = ".common.cs_28024"
CS_28024.nested_types = {}
CS_28024.enum_types = {}
CS_28024.fields = {
	slot2.CS_28024_FIELD_LIST.CS_28024_ID_LIST_FIELD
}
CS_28024.is_extendable = false
CS_28024.extensions = {}
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.name = "result"
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.full_name = ".common.sc_28025.result"
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.number = 1
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.index = 0
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.label = 2
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.has_default_value = false
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.default_value = 0
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.type = 13
slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD.cpp_type = 3
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.name = "reward_list"
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.full_name = ".common.sc_28025.reward_list"
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.number = 2
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.index = 1
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.label = 3
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.default_value = {}
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.message_type = slot1.ITEM_NET_REC
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.type = 11
slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD.cpp_type = 10
SC_28025.name = "sc_28025"
SC_28025.full_name = ".common.sc_28025"
SC_28025.nested_types = {}
SC_28025.enum_types = {}
SC_28025.fields = {
	slot2.SC_28025_FIELD_LIST.SC_28025_RESULT_FIELD,
	slot2.SC_28025_FIELD_LIST.SC_28025_REWARD_LIST_FIELD
}
SC_28025.is_extendable = false
SC_28025.extensions = {}
assignment_info = slot0.Message(ASSIGNMENT_INFO)
assignment_progress = slot0.Message(ASSIGNMENT_PROGRESS)
cs_28010 = slot0.Message(CS_28010)
cs_28014 = slot0.Message(CS_28014)
cs_28016 = slot0.Message(CS_28016)
cs_28024 = slot0.Message(CS_28024)
pt = slot0.Message(PT)
sc_28001 = slot0.Message(SC_28001)
sc_28005 = slot0.Message(SC_28005)
sc_28007 = slot0.Message(SC_28007)
sc_28011 = slot0.Message(SC_28011)
sc_28015 = slot0.Message(SC_28015)
sc_28017 = slot0.Message(SC_28017)
sc_28019 = slot0.Message(SC_28019)
sc_28021 = slot0.Message(SC_28021)
sc_28023 = slot0.Message(SC_28023)
sc_28025 = slot0.Message(SC_28025)

return p28_pb
