slot0 = require("protobuf")

module("p55_pb", package.seeall)

slot1 = {
	ABYSS_STAGE_NET_REC_FIELD_LIST = {},
	ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST = {},
	ABYSS_LAYER_NET_REC_FIELD_LIST = {},
	SC_55001_FIELD_LIST = {},
	CS_55002_FIELD_LIST = {},
	SC_55003_FIELD_LIST = {},
	CS_55004_FIELD_LIST = {},
	SC_55005_FIELD_LIST = {},
	CS_55006_FIELD_LIST = {},
	SC_55007_FIELD_LIST = {},
	SC_55009_FIELD_LIST = {},
	SC_55011_FIELD_LIST = {},
	CS_55012_FIELD_LIST = {},
	SC_55013_FIELD_LIST = {},
	SC_55017_FIELD_LIST = {},
	CS_55020_FIELD_LIST = {},
	SC_55021_FIELD_LIST = {},
	SC_55023_FIELD_LIST = {}
}
ABYSS_STAGE_NET_REC = slot0.Descriptor()
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD = slot0.FieldDescriptor()
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD = slot0.FieldDescriptor()
ABYSS_BOSS_STAGE_NET_REC = slot0.Descriptor()
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD = slot0.FieldDescriptor()
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD = slot0.FieldDescriptor()
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD = slot0.FieldDescriptor()
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD = slot0.FieldDescriptor()
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD = slot0.FieldDescriptor()
ABYSS_LAYER_NET_REC = slot0.Descriptor()
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD = slot0.FieldDescriptor()
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD = slot0.FieldDescriptor()
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD = slot0.FieldDescriptor()
SC_55001 = slot0.Descriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD = slot0.FieldDescriptor()
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD = slot0.FieldDescriptor()
CS_55002 = slot0.Descriptor()
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD = slot0.FieldDescriptor()
SC_55003 = slot0.Descriptor()
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD = slot0.FieldDescriptor()
CS_55004 = slot0.Descriptor()
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD = slot0.FieldDescriptor()
SC_55005 = slot0.Descriptor()
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD = slot0.FieldDescriptor()
CS_55006 = slot0.Descriptor()
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD = slot0.FieldDescriptor()
SC_55007 = slot0.Descriptor()
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD = slot0.FieldDescriptor()
SC_55009 = slot0.Descriptor()
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD = slot0.FieldDescriptor()
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD = slot0.FieldDescriptor()
SC_55011 = slot0.Descriptor()
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD = slot0.FieldDescriptor()
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD = slot0.FieldDescriptor()
CS_55012 = slot0.Descriptor()
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD = slot0.FieldDescriptor()
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD = slot0.FieldDescriptor()
SC_55013 = slot0.Descriptor()
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD = slot0.FieldDescriptor()
SC_55017 = slot0.Descriptor()
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD = slot0.FieldDescriptor()
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD = slot0.FieldDescriptor()
CS_55020 = slot0.Descriptor()
SC_55021 = slot0.Descriptor()
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD = slot0.FieldDescriptor()
SC_55023 = slot0.Descriptor()
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.name = "stage_id"
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.full_name = ".p55.abyss_stage_net_rec.stage_id"
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.number = 1
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.index = 0
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.label = 2
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.has_default_value = false
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.default_value = 0
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.type = 13
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD.cpp_type = 3
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.name = "is_completed"
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.full_name = ".p55.abyss_stage_net_rec.is_completed"
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.number = 2
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.index = 1
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.label = 2
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.has_default_value = false
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.default_value = false
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.type = 8
slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD.cpp_type = 7
ABYSS_STAGE_NET_REC.name = "abyss_stage_net_rec"
ABYSS_STAGE_NET_REC.full_name = ".p55.abyss_stage_net_rec"
ABYSS_STAGE_NET_REC.nested_types = {}
ABYSS_STAGE_NET_REC.enum_types = {}
ABYSS_STAGE_NET_REC.fields = {
	slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_STAGE_ID_FIELD,
	slot1.ABYSS_STAGE_NET_REC_FIELD_LIST.ABYSS_STAGE_NET_REC_IS_COMPLETED_FIELD
}
ABYSS_STAGE_NET_REC.is_extendable = false
ABYSS_STAGE_NET_REC.extensions = {}
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.name = "stage_id"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.full_name = ".p55.abyss_boss_stage_net_rec.stage_id"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.number = 1
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.index = 0
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.label = 2
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.has_default_value = false
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.default_value = 0
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.type = 13
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD.cpp_type = 3
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.name = "is_completed"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.full_name = ".p55.abyss_boss_stage_net_rec.is_completed"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.number = 2
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.index = 1
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.label = 2
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.has_default_value = false
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.default_value = false
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.type = 8
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD.cpp_type = 7
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.name = "score"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.full_name = ".p55.abyss_boss_stage_net_rec.score"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.number = 3
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.index = 2
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.label = 2
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.has_default_value = false
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.default_value = 0
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.type = 13
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD.cpp_type = 3
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.name = "phase"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.full_name = ".p55.abyss_boss_stage_net_rec.phase"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.number = 4
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.index = 3
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.label = 2
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.has_default_value = false
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.default_value = 0
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.type = 13
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD.cpp_type = 3
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.name = "boss_hp_rate"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.full_name = ".p55.abyss_boss_stage_net_rec.boss_hp_rate"
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.number = 5
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.index = 4
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.label = 2
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.has_default_value = false
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.default_value = 0
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.type = 13
slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD.cpp_type = 3
ABYSS_BOSS_STAGE_NET_REC.name = "abyss_boss_stage_net_rec"
ABYSS_BOSS_STAGE_NET_REC.full_name = ".p55.abyss_boss_stage_net_rec"
ABYSS_BOSS_STAGE_NET_REC.nested_types = {}
ABYSS_BOSS_STAGE_NET_REC.enum_types = {}
ABYSS_BOSS_STAGE_NET_REC.fields = {
	slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_STAGE_ID_FIELD,
	slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_IS_COMPLETED_FIELD,
	slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_SCORE_FIELD,
	slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_PHASE_FIELD,
	slot1.ABYSS_BOSS_STAGE_NET_REC_FIELD_LIST.ABYSS_BOSS_STAGE_NET_REC_BOSS_HP_RATE_FIELD
}
ABYSS_BOSS_STAGE_NET_REC.is_extendable = false
ABYSS_BOSS_STAGE_NET_REC.extensions = {}
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.name = "layer_id"
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.full_name = ".p55.abyss_layer_net_rec.layer_id"
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.number = 1
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.index = 0
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.label = 2
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.has_default_value = false
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.default_value = 0
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.type = 13
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD.cpp_type = 3
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.name = "stage_info_list"
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.full_name = ".p55.abyss_layer_net_rec.stage_info_list"
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.number = 2
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.index = 1
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.label = 3
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.has_default_value = false
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.default_value = {}
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.message_type = ABYSS_STAGE_NET_REC
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.type = 11
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD.cpp_type = 10
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.name = "boss_stage_info_list"
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.full_name = ".p55.abyss_layer_net_rec.boss_stage_info_list"
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.number = 3
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.index = 2
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.label = 3
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.has_default_value = false
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.default_value = {}
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.message_type = ABYSS_BOSS_STAGE_NET_REC
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.type = 11
slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD.cpp_type = 10
ABYSS_LAYER_NET_REC.name = "abyss_layer_net_rec"
ABYSS_LAYER_NET_REC.full_name = ".p55.abyss_layer_net_rec"
ABYSS_LAYER_NET_REC.nested_types = {}
ABYSS_LAYER_NET_REC.enum_types = {}
ABYSS_LAYER_NET_REC.fields = {
	slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_LAYER_ID_FIELD,
	slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_STAGE_INFO_LIST_FIELD,
	slot1.ABYSS_LAYER_NET_REC_FIELD_LIST.ABYSS_LAYER_NET_REC_BOSS_STAGE_INFO_LIST_FIELD
}
ABYSS_LAYER_NET_REC.is_extendable = false
ABYSS_LAYER_NET_REC.extensions = {}
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.name = "is_back"
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.full_name = ".p55.sc_55001.is_back"
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.number = 1
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.index = 0
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.label = 2
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.type = 8
slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD.cpp_type = 7
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.name = "history_max_layer"
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.full_name = ".p55.sc_55001.history_max_layer"
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.number = 2
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.index = 1
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.label = 2
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.default_value = 0
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.type = 13
slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD.cpp_type = 3
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.name = "got_layer_reward_list"
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.full_name = ".p55.sc_55001.got_layer_reward_list"
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.number = 3
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.index = 2
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.label = 3
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.default_value = {}
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.type = 13
slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD.cpp_type = 3
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.name = "layer_reset_time"
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.full_name = ".p55.sc_55001.layer_reset_time"
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.number = 4
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.index = 3
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.label = 2
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.default_value = 0
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.type = 13
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD.cpp_type = 3
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.name = "stage_reset_time"
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.full_name = ".p55.sc_55001.stage_reset_time"
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.number = 5
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.index = 4
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.label = 2
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.default_value = 0
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.type = 13
slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD.cpp_type = 3
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.name = "layer_info_list"
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.full_name = ".p55.sc_55001.layer_info_list"
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.number = 6
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.index = 5
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.label = 3
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.default_value = {}
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.message_type = ABYSS_LAYER_NET_REC
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.type = 11
slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD.cpp_type = 10
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.name = "last_version_max_unlock_layer"
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.full_name = ".p55.sc_55001.last_version_max_unlock_layer"
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.number = 7
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.index = 6
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.label = 2
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.default_value = 0
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.type = 13
slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD.cpp_type = 3
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.name = "refresh_timestamp"
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.full_name = ".p55.sc_55001.refresh_timestamp"
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.number = 8
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.index = 7
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.label = 2
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.default_value = 0
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.type = 13
slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD.cpp_type = 3
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.name = "activity_id"
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.full_name = ".p55.sc_55001.activity_id"
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.number = 9
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.index = 8
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.label = 2
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.has_default_value = false
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.default_value = 0
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.type = 13
slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD.cpp_type = 3
SC_55001.name = "sc_55001"
SC_55001.full_name = ".p55.sc_55001"
SC_55001.nested_types = {}
SC_55001.enum_types = {}
SC_55001.fields = {
	slot1.SC_55001_FIELD_LIST.SC_55001_IS_BACK_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_HISTORY_MAX_LAYER_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_GOT_LAYER_REWARD_LIST_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_RESET_TIME_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_STAGE_RESET_TIME_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_LAYER_INFO_LIST_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_LAST_VERSION_MAX_UNLOCK_LAYER_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_REFRESH_TIMESTAMP_FIELD,
	slot1.SC_55001_FIELD_LIST.SC_55001_ACTIVITY_ID_FIELD
}
SC_55001.is_extendable = false
SC_55001.extensions = {}
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.name = "layer"
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.full_name = ".p55.cs_55002.layer"
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.number = 1
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.index = 0
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.label = 2
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.has_default_value = false
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.default_value = 0
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.type = 13
slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD.cpp_type = 3
CS_55002.name = "cs_55002"
CS_55002.full_name = ".p55.cs_55002"
CS_55002.nested_types = {}
CS_55002.enum_types = {}
CS_55002.fields = {
	slot1.CS_55002_FIELD_LIST.CS_55002_LAYER_FIELD
}
CS_55002.is_extendable = false
CS_55002.extensions = {}
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.name = "result"
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.full_name = ".p55.sc_55003.result"
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.number = 1
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.index = 0
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.label = 2
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.has_default_value = false
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.default_value = 0
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.type = 13
slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD.cpp_type = 3
SC_55003.name = "sc_55003"
SC_55003.full_name = ".p55.sc_55003"
SC_55003.nested_types = {}
SC_55003.enum_types = {}
SC_55003.fields = {
	slot1.SC_55003_FIELD_LIST.SC_55003_RESULT_FIELD
}
SC_55003.is_extendable = false
SC_55003.extensions = {}
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.name = "stage_id"
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.full_name = ".p55.cs_55004.stage_id"
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.number = 1
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.index = 0
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.label = 2
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.has_default_value = false
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.default_value = 0
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.type = 13
slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD.cpp_type = 3
CS_55004.name = "cs_55004"
CS_55004.full_name = ".p55.cs_55004"
CS_55004.nested_types = {}
CS_55004.enum_types = {}
CS_55004.fields = {
	slot1.CS_55004_FIELD_LIST.CS_55004_STAGE_ID_FIELD
}
CS_55004.is_extendable = false
CS_55004.extensions = {}
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.name = "result"
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.full_name = ".p55.sc_55005.result"
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.number = 1
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.index = 0
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.label = 2
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.has_default_value = false
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.default_value = 0
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.type = 13
slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD.cpp_type = 3
SC_55005.name = "sc_55005"
SC_55005.full_name = ".p55.sc_55005"
SC_55005.nested_types = {}
SC_55005.enum_types = {}
SC_55005.fields = {
	slot1.SC_55005_FIELD_LIST.SC_55005_RESULT_FIELD
}
SC_55005.is_extendable = false
SC_55005.extensions = {}
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.name = "layer_list"
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.full_name = ".p55.cs_55006.layer_list"
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.number = 1
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.index = 0
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.label = 3
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.has_default_value = false
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.default_value = {}
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.type = 13
slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD.cpp_type = 3
CS_55006.name = "cs_55006"
CS_55006.full_name = ".p55.cs_55006"
CS_55006.nested_types = {}
CS_55006.enum_types = {}
CS_55006.fields = {
	slot1.CS_55006_FIELD_LIST.CS_55006_LAYER_LIST_FIELD
}
CS_55006.is_extendable = false
CS_55006.extensions = {}
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.name = "result"
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.full_name = ".p55.sc_55007.result"
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.number = 1
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.index = 0
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.label = 2
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.has_default_value = false
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.default_value = 0
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.type = 13
slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD.cpp_type = 3
SC_55007.name = "sc_55007"
SC_55007.full_name = ".p55.sc_55007"
SC_55007.nested_types = {}
SC_55007.enum_types = {}
SC_55007.fields = {
	slot1.SC_55007_FIELD_LIST.SC_55007_RESULT_FIELD
}
SC_55007.is_extendable = false
SC_55007.extensions = {}
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.name = "layer_reset_time"
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.full_name = ".p55.sc_55009.layer_reset_time"
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.number = 1
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.index = 0
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.label = 2
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.has_default_value = false
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.default_value = 0
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.type = 13
slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD.cpp_type = 3
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.name = "stage_reset_time"
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.full_name = ".p55.sc_55009.stage_reset_time"
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.number = 2
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.index = 1
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.label = 2
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.has_default_value = false
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.default_value = 0
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.type = 13
slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD.cpp_type = 3
SC_55009.name = "sc_55009"
SC_55009.full_name = ".p55.sc_55009"
SC_55009.nested_types = {}
SC_55009.enum_types = {}
SC_55009.fields = {
	slot1.SC_55009_FIELD_LIST.SC_55009_LAYER_RESET_TIME_FIELD,
	slot1.SC_55009_FIELD_LIST.SC_55009_STAGE_RESET_TIME_FIELD
}
SC_55009.is_extendable = false
SC_55009.extensions = {}
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.name = "layer"
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.full_name = ".p55.sc_55011.layer"
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.number = 1
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.index = 0
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.label = 2
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.has_default_value = false
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.default_value = 0
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.type = 13
slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD.cpp_type = 3
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.name = "boss_stage_info"
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.full_name = ".p55.sc_55011.boss_stage_info"
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.number = 2
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.index = 1
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.label = 2
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.has_default_value = false
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.default_value = nil
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.message_type = ABYSS_BOSS_STAGE_NET_REC
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.type = 11
slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD.cpp_type = 10
SC_55011.name = "sc_55011"
SC_55011.full_name = ".p55.sc_55011"
SC_55011.nested_types = {}
SC_55011.enum_types = {}
SC_55011.fields = {
	slot1.SC_55011_FIELD_LIST.SC_55011_LAYER_FIELD,
	slot1.SC_55011_FIELD_LIST.SC_55011_BOSS_STAGE_INFO_FIELD
}
SC_55011.is_extendable = false
SC_55011.extensions = {}
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.name = "stage_id"
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.full_name = ".p55.cs_55012.stage_id"
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.number = 1
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.index = 0
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.label = 2
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.has_default_value = false
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.default_value = 0
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.type = 13
slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD.cpp_type = 3
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.name = "is_save"
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.full_name = ".p55.cs_55012.is_save"
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.number = 2
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.index = 1
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.label = 2
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.has_default_value = false
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.default_value = false
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.type = 8
slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD.cpp_type = 7
CS_55012.name = "cs_55012"
CS_55012.full_name = ".p55.cs_55012"
CS_55012.nested_types = {}
CS_55012.enum_types = {}
CS_55012.fields = {
	slot1.CS_55012_FIELD_LIST.CS_55012_STAGE_ID_FIELD,
	slot1.CS_55012_FIELD_LIST.CS_55012_IS_SAVE_FIELD
}
CS_55012.is_extendable = false
CS_55012.extensions = {}
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.name = "result"
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.full_name = ".p55.sc_55013.result"
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.number = 1
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.index = 0
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.label = 2
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.has_default_value = false
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.default_value = 0
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.type = 13
slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD.cpp_type = 3
SC_55013.name = "sc_55013"
SC_55013.full_name = ".p55.sc_55013"
SC_55013.nested_types = {}
SC_55013.enum_types = {}
SC_55013.fields = {
	slot1.SC_55013_FIELD_LIST.SC_55013_RESULT_FIELD
}
SC_55013.is_extendable = false
SC_55013.extensions = {}
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.name = "history_max_layer"
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.full_name = ".p55.sc_55017.history_max_layer"
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.number = 1
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.index = 0
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.label = 2
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.has_default_value = false
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.default_value = 0
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.type = 13
slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD.cpp_type = 3
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.name = "layer_info"
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.full_name = ".p55.sc_55017.layer_info"
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.number = 2
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.index = 1
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.label = 2
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.has_default_value = false
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.default_value = nil
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.message_type = ABYSS_LAYER_NET_REC
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.type = 11
slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD.cpp_type = 10
SC_55017.name = "sc_55017"
SC_55017.full_name = ".p55.sc_55017"
SC_55017.nested_types = {}
SC_55017.enum_types = {}
SC_55017.fields = {
	slot1.SC_55017_FIELD_LIST.SC_55017_HISTORY_MAX_LAYER_FIELD,
	slot1.SC_55017_FIELD_LIST.SC_55017_LAYER_INFO_FIELD
}
SC_55017.is_extendable = false
SC_55017.extensions = {}
CS_55020.name = "cs_55020"
CS_55020.full_name = ".p55.cs_55020"
CS_55020.nested_types = {}
CS_55020.enum_types = {}
CS_55020.fields = {}
CS_55020.is_extendable = false
CS_55020.extensions = {}
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.name = "result"
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.full_name = ".p55.sc_55021.result"
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.number = 1
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.index = 0
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.label = 2
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.has_default_value = false
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.default_value = 0
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.type = 13
slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD.cpp_type = 3
SC_55021.name = "sc_55021"
SC_55021.full_name = ".p55.sc_55021"
SC_55021.nested_types = {}
SC_55021.enum_types = {}
SC_55021.fields = {
	slot1.SC_55021_FIELD_LIST.SC_55021_RESULT_FIELD
}
SC_55021.is_extendable = false
SC_55021.extensions = {}
SC_55023.name = "sc_55023"
SC_55023.full_name = ".p55.sc_55023"
SC_55023.nested_types = {}
SC_55023.enum_types = {}
SC_55023.fields = {}
SC_55023.is_extendable = false
SC_55023.extensions = {}
abyss_boss_stage_net_rec = slot0.Message(ABYSS_BOSS_STAGE_NET_REC)
abyss_layer_net_rec = slot0.Message(ABYSS_LAYER_NET_REC)
abyss_stage_net_rec = slot0.Message(ABYSS_STAGE_NET_REC)
cs_55002 = slot0.Message(CS_55002)
cs_55004 = slot0.Message(CS_55004)
cs_55006 = slot0.Message(CS_55006)
cs_55012 = slot0.Message(CS_55012)
cs_55020 = slot0.Message(CS_55020)
sc_55001 = slot0.Message(SC_55001)
sc_55003 = slot0.Message(SC_55003)
sc_55005 = slot0.Message(SC_55005)
sc_55007 = slot0.Message(SC_55007)
sc_55009 = slot0.Message(SC_55009)
sc_55011 = slot0.Message(SC_55011)
sc_55013 = slot0.Message(SC_55013)
sc_55017 = slot0.Message(SC_55017)
sc_55021 = slot0.Message(SC_55021)
sc_55023 = slot0.Message(SC_55023)

return p55_pb
