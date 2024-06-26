slot0 = require("protobuf")

module("p81_pb", package.seeall)

slot1 = {
	STORY_BRANCH_INFO_NET_REC_FIELD_LIST = {},
	SC_81001_FIELD_LIST = {},
	CS_81002_FIELD_LIST = {}
}
STORY_BRANCH_INFO_NET_REC = slot0.Descriptor()
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD = slot0.FieldDescriptor()
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD = slot0.FieldDescriptor()
SC_81001 = slot0.Descriptor()
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD = slot0.FieldDescriptor()
CS_81002 = slot0.Descriptor()
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD = slot0.FieldDescriptor()
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD = slot0.FieldDescriptor()
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD = slot0.FieldDescriptor()
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD = slot0.FieldDescriptor()
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.name = "trigger_group_id"
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.full_name = ".p81.story_branch_info_net_rec.trigger_group_id"
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.number = 1
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.index = 0
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.label = 2
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.has_default_value = false
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.default_value = 0
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.type = 13
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD.cpp_type = 3
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.name = "completed_trigger_list"
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.full_name = ".p81.story_branch_info_net_rec.completed_trigger_list"
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.number = 2
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.index = 1
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.label = 3
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.has_default_value = false
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.default_value = {}
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.type = 13
slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD.cpp_type = 3
STORY_BRANCH_INFO_NET_REC.name = "story_branch_info_net_rec"
STORY_BRANCH_INFO_NET_REC.full_name = ".p81.story_branch_info_net_rec"
STORY_BRANCH_INFO_NET_REC.nested_types = {}
STORY_BRANCH_INFO_NET_REC.enum_types = {}
STORY_BRANCH_INFO_NET_REC.fields = {
	slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_TRIGGER_GROUP_ID_FIELD,
	slot1.STORY_BRANCH_INFO_NET_REC_FIELD_LIST.STORY_BRANCH_INFO_NET_REC_COMPLETED_TRIGGER_LIST_FIELD
}
STORY_BRANCH_INFO_NET_REC.is_extendable = false
STORY_BRANCH_INFO_NET_REC.extensions = {}
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.name = "info_list"
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.full_name = ".p81.sc_81001.info_list"
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.number = 1
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.index = 0
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.label = 3
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.has_default_value = false
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.default_value = {}
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.message_type = STORY_BRANCH_INFO_NET_REC
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.type = 11
slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD.cpp_type = 10
SC_81001.name = "sc_81001"
SC_81001.full_name = ".p81.sc_81001"
SC_81001.nested_types = {}
SC_81001.enum_types = {}
SC_81001.fields = {
	slot1.SC_81001_FIELD_LIST.SC_81001_INFO_LIST_FIELD
}
SC_81001.is_extendable = false
SC_81001.extensions = {}
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.name = "trigger_id"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.full_name = ".p81.cs_81002.trigger_id"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.number = 1
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.index = 0
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.label = 2
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.has_default_value = false
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.default_value = 0
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.type = 13
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD.cpp_type = 3
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.name = "trigger_story"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.full_name = ".p81.cs_81002.trigger_story"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.number = 2
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.index = 1
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.label = 2
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.has_default_value = false
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.default_value = 0
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.type = 13
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD.cpp_type = 3
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.name = "trigger_text"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.full_name = ".p81.cs_81002.trigger_text"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.number = 3
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.index = 2
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.label = 2
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.has_default_value = false
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.default_value = 0
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.type = 13
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD.cpp_type = 3
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.name = "trigger_select"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.full_name = ".p81.cs_81002.trigger_select"
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.number = 4
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.index = 3
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.label = 2
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.has_default_value = false
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.default_value = 0
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.type = 13
slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD.cpp_type = 3
CS_81002.name = "cs_81002"
CS_81002.full_name = ".p81.cs_81002"
CS_81002.nested_types = {}
CS_81002.enum_types = {}
CS_81002.fields = {
	slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_ID_FIELD,
	slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_STORY_FIELD,
	slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_TEXT_FIELD,
	slot1.CS_81002_FIELD_LIST.CS_81002_TRIGGER_SELECT_FIELD
}
CS_81002.is_extendable = false
CS_81002.extensions = {}
cs_81002 = slot0.Message(CS_81002)
sc_81001 = slot0.Message(SC_81001)
story_branch_info_net_rec = slot0.Message(STORY_BRANCH_INFO_NET_REC)

return p81_pb
