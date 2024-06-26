slot0 = require("protobuf")

module("p57_pb", package.seeall)

slot1 = {
	CS_57002_FIELD_LIST = {},
	SC_57003_FIELD_LIST = {},
	CS_57004_FIELD_LIST = {},
	SC_57005_FIELD_LIST = {},
	CS_57006_FIELD_LIST = {},
	SC_57007_FIELD_LIST = {},
	CS_57008_FIELD_LIST = {},
	SC_57009_FIELD_LIST = {}
}
CS_57002 = slot0.Descriptor()
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD = slot0.FieldDescriptor()
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD = slot0.FieldDescriptor()
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD = slot0.FieldDescriptor()
SC_57003 = slot0.Descriptor()
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD = slot0.FieldDescriptor()
CS_57004 = slot0.Descriptor()
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD = slot0.FieldDescriptor()
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD = slot0.FieldDescriptor()
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD = slot0.FieldDescriptor()
SC_57005 = slot0.Descriptor()
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD = slot0.FieldDescriptor()
CS_57006 = slot0.Descriptor()
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD = slot0.FieldDescriptor()
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD = slot0.FieldDescriptor()
SC_57007 = slot0.Descriptor()
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD = slot0.FieldDescriptor()
CS_57008 = slot0.Descriptor()
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD = slot0.FieldDescriptor()
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD = slot0.FieldDescriptor()
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD = slot0.FieldDescriptor()
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD = slot0.FieldDescriptor()
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD = slot0.FieldDescriptor()
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD = slot0.FieldDescriptor()
SC_57009 = slot0.Descriptor()
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD = slot0.FieldDescriptor()
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.name = "report_type"
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.full_name = ".p57.cs_57002.report_type"
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.number = 1
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.index = 0
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.label = 2
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.has_default_value = false
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.default_value = 0
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.type = 13
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD.cpp_type = 3
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.name = "report_note"
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.full_name = ".p57.cs_57002.report_note"
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.number = 2
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.index = 1
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.label = 2
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.has_default_value = false
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.default_value = ""
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.type = 9
slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD.cpp_type = 9
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.name = "msg_uid"
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.full_name = ".p57.cs_57002.msg_uid"
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.number = 3
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.index = 2
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.label = 2
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.has_default_value = false
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.default_value = "0"
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.type = 4
slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD.cpp_type = 4
CS_57002.name = "cs_57002"
CS_57002.full_name = ".p57.cs_57002"
CS_57002.nested_types = {}
CS_57002.enum_types = {}
CS_57002.fields = {
	slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_TYPE_FIELD,
	slot1.CS_57002_FIELD_LIST.CS_57002_REPORT_NOTE_FIELD,
	slot1.CS_57002_FIELD_LIST.CS_57002_MSG_UID_FIELD
}
CS_57002.is_extendable = false
CS_57002.extensions = {}
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.name = "result"
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.full_name = ".p57.sc_57003.result"
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.number = 1
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.index = 0
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.label = 2
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.has_default_value = false
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.default_value = 0
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.type = 13
slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD.cpp_type = 3
SC_57003.name = "sc_57003"
SC_57003.full_name = ".p57.sc_57003"
SC_57003.nested_types = {}
SC_57003.enum_types = {}
SC_57003.fields = {
	slot1.SC_57003_FIELD_LIST.SC_57003_RESULT_FIELD
}
SC_57003.is_extendable = false
SC_57003.extensions = {}
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.name = "reported_user_id"
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.full_name = ".p57.cs_57004.reported_user_id"
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.number = 1
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.index = 0
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.label = 2
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.has_default_value = false
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.default_value = "0"
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.type = 4
slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD.cpp_type = 4
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.name = "report_type"
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.full_name = ".p57.cs_57004.report_type"
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.number = 2
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.index = 1
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.label = 2
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.has_default_value = false
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.default_value = 0
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.type = 13
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD.cpp_type = 3
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.name = "report_note"
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.full_name = ".p57.cs_57004.report_note"
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.number = 3
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.index = 2
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.label = 2
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.has_default_value = false
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.default_value = ""
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.type = 9
slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD.cpp_type = 9
CS_57004.name = "cs_57004"
CS_57004.full_name = ".p57.cs_57004"
CS_57004.nested_types = {}
CS_57004.enum_types = {}
CS_57004.fields = {
	slot1.CS_57004_FIELD_LIST.CS_57004_REPORTED_USER_ID_FIELD,
	slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_TYPE_FIELD,
	slot1.CS_57004_FIELD_LIST.CS_57004_REPORT_NOTE_FIELD
}
CS_57004.is_extendable = false
CS_57004.extensions = {}
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.name = "result"
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.full_name = ".p57.sc_57005.result"
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.number = 1
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.index = 0
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.label = 2
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.has_default_value = false
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.default_value = 0
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.type = 13
slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD.cpp_type = 3
SC_57005.name = "sc_57005"
SC_57005.full_name = ".p57.sc_57005"
SC_57005.nested_types = {}
SC_57005.enum_types = {}
SC_57005.fields = {
	slot1.SC_57005_FIELD_LIST.SC_57005_RESULT_FIELD
}
SC_57005.is_extendable = false
SC_57005.extensions = {}
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.name = "user_id"
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.full_name = ".p57.cs_57006.user_id"
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.number = 1
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.index = 0
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.label = 2
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.has_default_value = false
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.default_value = "0"
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.type = 4
slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD.cpp_type = 4
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.name = "battle_id"
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.full_name = ".p57.cs_57006.battle_id"
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.number = 2
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.index = 1
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.label = 2
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.has_default_value = false
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.default_value = "0"
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.type = 4
slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD.cpp_type = 4
CS_57006.name = "cs_57006"
CS_57006.full_name = ".p57.cs_57006"
CS_57006.nested_types = {}
CS_57006.enum_types = {}
CS_57006.fields = {
	slot1.CS_57006_FIELD_LIST.CS_57006_USER_ID_FIELD,
	slot1.CS_57006_FIELD_LIST.CS_57006_BATTLE_ID_FIELD
}
CS_57006.is_extendable = false
CS_57006.extensions = {}
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.name = "result"
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.full_name = ".p57.sc_57007.result"
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.number = 1
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.index = 0
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.label = 2
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.has_default_value = false
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.default_value = 0
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.type = 13
slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD.cpp_type = 3
SC_57007.name = "sc_57007"
SC_57007.full_name = ".p57.sc_57007"
SC_57007.nested_types = {}
SC_57007.enum_types = {}
SC_57007.fields = {
	slot1.SC_57007_FIELD_LIST.SC_57007_RESULT_FIELD
}
SC_57007.is_extendable = false
SC_57007.extensions = {}
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.name = "reported_user_id"
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.full_name = ".p57.cs_57008.reported_user_id"
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.number = 1
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.index = 0
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.label = 2
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.has_default_value = false
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.default_value = "0"
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.type = 4
slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD.cpp_type = 4
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.name = "layout_uid"
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.full_name = ".p57.cs_57008.layout_uid"
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.number = 2
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.index = 1
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.label = 2
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.has_default_value = false
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.default_value = 0
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.type = 13
slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD.cpp_type = 3
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.name = "architecture_id"
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.full_name = ".p57.cs_57008.architecture_id"
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.number = 3
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.index = 2
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.label = 2
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.has_default_value = false
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.default_value = 0
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.type = 13
slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD.cpp_type = 3
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.name = "report_type"
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.full_name = ".p57.cs_57008.report_type"
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.number = 4
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.index = 3
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.label = 2
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.has_default_value = false
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.default_value = 0
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.type = 13
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD.cpp_type = 3
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.name = "report_note"
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.full_name = ".p57.cs_57008.report_note"
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.number = 5
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.index = 4
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.label = 2
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.has_default_value = false
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.default_value = ""
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.type = 9
slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD.cpp_type = 9
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.name = "picture_link"
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.full_name = ".p57.cs_57008.picture_link"
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.number = 6
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.index = 5
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.label = 2
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.has_default_value = false
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.default_value = ""
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.type = 9
slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD.cpp_type = 9
CS_57008.name = "cs_57008"
CS_57008.full_name = ".p57.cs_57008"
CS_57008.nested_types = {}
CS_57008.enum_types = {}
CS_57008.fields = {
	slot1.CS_57008_FIELD_LIST.CS_57008_REPORTED_USER_ID_FIELD,
	slot1.CS_57008_FIELD_LIST.CS_57008_LAYOUT_UID_FIELD,
	slot1.CS_57008_FIELD_LIST.CS_57008_ARCHITECTURE_ID_FIELD,
	slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_TYPE_FIELD,
	slot1.CS_57008_FIELD_LIST.CS_57008_REPORT_NOTE_FIELD,
	slot1.CS_57008_FIELD_LIST.CS_57008_PICTURE_LINK_FIELD
}
CS_57008.is_extendable = false
CS_57008.extensions = {}
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.name = "result"
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.full_name = ".p57.sc_57009.result"
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.number = 1
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.index = 0
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.label = 2
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.has_default_value = false
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.default_value = 0
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.type = 13
slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD.cpp_type = 3
SC_57009.name = "sc_57009"
SC_57009.full_name = ".p57.sc_57009"
SC_57009.nested_types = {}
SC_57009.enum_types = {}
SC_57009.fields = {
	slot1.SC_57009_FIELD_LIST.SC_57009_RESULT_FIELD
}
SC_57009.is_extendable = false
SC_57009.extensions = {}
cs_57002 = slot0.Message(CS_57002)
cs_57004 = slot0.Message(CS_57004)
cs_57006 = slot0.Message(CS_57006)
cs_57008 = slot0.Message(CS_57008)
sc_57003 = slot0.Message(SC_57003)
sc_57005 = slot0.Message(SC_57005)
sc_57007 = slot0.Message(SC_57007)
sc_57009 = slot0.Message(SC_57009)

return p57_pb
