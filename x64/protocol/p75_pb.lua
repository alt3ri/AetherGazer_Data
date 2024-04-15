slot0 = require("protobuf")
slot1 = require("protocol/item_hrl_pb")

module("p75_pb", package.seeall)

slot2 = {
	HEART_DEMON_CHALLENGE_INFO_FIELD_LIST = {},
	SC_75001_FIELD_LIST = {},
	CS_75002_FIELD_LIST = {},
	SC_75003_FIELD_LIST = {},
	SC_75005_FIELD_LIST = {},
	CS_75006_FIELD_LIST = {},
	SC_75007_FIELD_LIST = {},
	ATTRIBUTE_STAGE_INFO_FIELD_LIST = {},
	LOCK_HERO_INFO_FIELD_LIST = {},
	SC_75009_FIELD_LIST = {}
}
HEART_DEMON_CHALLENGE_INFO = slot0.Descriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD = slot0.FieldDescriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD = slot0.FieldDescriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD = slot0.FieldDescriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD = slot0.FieldDescriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD = slot0.FieldDescriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD = slot0.FieldDescriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD = slot0.FieldDescriptor()
SC_75001 = slot0.Descriptor()
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD = slot0.FieldDescriptor()
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD = slot0.FieldDescriptor()
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD = slot0.FieldDescriptor()
CS_75002 = slot0.Descriptor()
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD = slot0.FieldDescriptor()
SC_75003 = slot0.Descriptor()
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD = slot0.FieldDescriptor()
SC_75005 = slot0.Descriptor()
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD = slot0.FieldDescriptor()
CS_75006 = slot0.Descriptor()
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD = slot0.FieldDescriptor()
SC_75007 = slot0.Descriptor()
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD = slot0.FieldDescriptor()
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD = slot0.FieldDescriptor()
ATTRIBUTE_STAGE_INFO = slot0.Descriptor()
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD = slot0.FieldDescriptor()
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD = slot0.FieldDescriptor()
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD = slot0.FieldDescriptor()
LOCK_HERO_INFO = slot0.Descriptor()
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD = slot0.FieldDescriptor()
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD = slot0.FieldDescriptor()
SC_75009 = slot0.Descriptor()
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD = slot0.FieldDescriptor()
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD = slot0.FieldDescriptor()
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD = slot0.FieldDescriptor()
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD = slot0.FieldDescriptor()
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD = slot0.FieldDescriptor()
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.name = "difficulty"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.full_name = ".common.heart_demon_challenge_info.difficulty"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.number = 1
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.index = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.label = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.has_default_value = false
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.default_value = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.type = 13
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD.cpp_type = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.name = "challenge_state"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.full_name = ".common.heart_demon_challenge_info.challenge_state"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.number = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.index = 1
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.label = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.has_default_value = false
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.default_value = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.type = 13
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD.cpp_type = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.name = "max_extremely_dodge_times"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.full_name = ".common.heart_demon_challenge_info.max_extremely_dodge_times"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.number = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.index = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.label = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.has_default_value = false
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.default_value = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.type = 13
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD.cpp_type = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.name = "shortest_battle_clear_time"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.full_name = ".common.heart_demon_challenge_info.shortest_battle_clear_time"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.number = 4
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.index = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.label = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.has_default_value = false
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.default_value = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.type = 13
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD.cpp_type = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.name = "max_score"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.full_name = ".common.heart_demon_challenge_info.max_score"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.number = 5
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.index = 4
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.label = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.has_default_value = false
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.default_value = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.type = 13
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD.cpp_type = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.name = "least_injure_num"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.full_name = ".common.heart_demon_challenge_info.least_injure_num"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.number = 6
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.index = 5
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.label = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.has_default_value = false
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.default_value = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.type = 13
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD.cpp_type = 3
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.name = "least_hit_num"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.full_name = ".common.heart_demon_challenge_info.least_hit_num"
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.number = 7
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.index = 6
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.label = 2
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.has_default_value = false
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.default_value = 0
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.type = 13
slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD.cpp_type = 3
HEART_DEMON_CHALLENGE_INFO.name = "heart_demon_challenge_info"
HEART_DEMON_CHALLENGE_INFO.full_name = ".common.heart_demon_challenge_info"
HEART_DEMON_CHALLENGE_INFO.nested_types = {}
HEART_DEMON_CHALLENGE_INFO.enum_types = {}
HEART_DEMON_CHALLENGE_INFO.fields = {
	slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_DIFFICULTY_FIELD,
	slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_CHALLENGE_STATE_FIELD,
	slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_EXTREMELY_DODGE_TIMES_FIELD,
	slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_SHORTEST_BATTLE_CLEAR_TIME_FIELD,
	slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_MAX_SCORE_FIELD,
	slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_INJURE_NUM_FIELD,
	slot2.HEART_DEMON_CHALLENGE_INFO_FIELD_LIST.HEART_DEMON_CHALLENGE_INFO_LEAST_HIT_NUM_FIELD
}
HEART_DEMON_CHALLENGE_INFO.is_extendable = false
HEART_DEMON_CHALLENGE_INFO.extensions = {}
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.name = "open_edition"
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.full_name = ".common.sc_75001.open_edition"
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.number = 1
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.index = 0
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.label = 2
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.has_default_value = false
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.default_value = 0
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.type = 13
slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD.cpp_type = 3
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.name = "challenge_stage"
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.full_name = ".common.sc_75001.challenge_stage"
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.number = 2
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.index = 1
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.label = 2
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.has_default_value = false
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.default_value = 0
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.type = 13
slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD.cpp_type = 3
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.name = "info_list"
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.full_name = ".common.sc_75001.info_list"
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.number = 3
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.index = 2
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.label = 3
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.has_default_value = false
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.default_value = {}
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.message_type = HEART_DEMON_CHALLENGE_INFO
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.type = 11
slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD.cpp_type = 10
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.name = "obtained_reward_list"
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.full_name = ".common.sc_75001.obtained_reward_list"
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.number = 4
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.index = 3
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.label = 3
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.default_value = {}
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.type = 13
slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD.cpp_type = 3
SC_75001.name = "sc_75001"
SC_75001.full_name = ".common.sc_75001"
SC_75001.nested_types = {}
SC_75001.enum_types = {}
SC_75001.fields = {
	slot2.SC_75001_FIELD_LIST.SC_75001_OPEN_EDITION_FIELD,
	slot2.SC_75001_FIELD_LIST.SC_75001_CHALLENGE_STAGE_FIELD,
	slot2.SC_75001_FIELD_LIST.SC_75001_INFO_LIST_FIELD,
	slot2.SC_75001_FIELD_LIST.SC_75001_OBTAINED_REWARD_LIST_FIELD
}
SC_75001.is_extendable = false
SC_75001.extensions = {}
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.name = "reward_list"
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.full_name = ".common.cs_75002.reward_list"
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.number = 1
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.index = 0
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.label = 3
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.has_default_value = false
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.default_value = {}
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.type = 13
slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD.cpp_type = 3
CS_75002.name = "cs_75002"
CS_75002.full_name = ".common.cs_75002"
CS_75002.nested_types = {}
CS_75002.enum_types = {}
CS_75002.fields = {
	slot2.CS_75002_FIELD_LIST.CS_75002_REWARD_LIST_FIELD
}
CS_75002.is_extendable = false
CS_75002.extensions = {}
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.name = "result"
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.full_name = ".common.sc_75003.result"
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.number = 1
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.index = 0
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.label = 2
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.has_default_value = false
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.default_value = 0
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.type = 13
slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD.cpp_type = 3
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.name = "reward_list"
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.full_name = ".common.sc_75003.reward_list"
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.number = 2
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.index = 1
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.label = 3
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.default_value = {}
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.message_type = slot1.ITEM_NET_REC
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.type = 11
slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD.cpp_type = 10
SC_75003.name = "sc_75003"
SC_75003.full_name = ".common.sc_75003"
SC_75003.nested_types = {}
SC_75003.enum_types = {}
SC_75003.fields = {
	slot2.SC_75003_FIELD_LIST.SC_75003_RESULT_FIELD,
	slot2.SC_75003_FIELD_LIST.SC_75003_REWARD_LIST_FIELD
}
SC_75003.is_extendable = false
SC_75003.extensions = {}
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.name = "score"
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.full_name = ".common.sc_75005.score"
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.number = 1
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.index = 0
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.label = 2
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.has_default_value = false
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.default_value = 0
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.type = 13
slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD.cpp_type = 3
SC_75005.name = "sc_75005"
SC_75005.full_name = ".common.sc_75005"
SC_75005.nested_types = {}
SC_75005.enum_types = {}
SC_75005.fields = {
	slot2.SC_75005_FIELD_LIST.SC_75005_SCORE_FIELD
}
SC_75005.is_extendable = false
SC_75005.extensions = {}
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.name = "reward_list"
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.full_name = ".common.cs_75006.reward_list"
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.number = 1
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.index = 0
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.label = 3
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.has_default_value = false
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.default_value = {}
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.type = 13
slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD.cpp_type = 3
CS_75006.name = "cs_75006"
CS_75006.full_name = ".common.cs_75006"
CS_75006.nested_types = {}
CS_75006.enum_types = {}
CS_75006.fields = {
	slot2.CS_75006_FIELD_LIST.CS_75006_REWARD_LIST_FIELD
}
CS_75006.is_extendable = false
CS_75006.extensions = {}
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.name = "result"
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.full_name = ".common.sc_75007.result"
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.number = 1
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.index = 0
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.label = 2
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.has_default_value = false
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.default_value = 0
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.type = 13
slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD.cpp_type = 3
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.name = "reward_list"
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.full_name = ".common.sc_75007.reward_list"
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.number = 2
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.index = 1
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.label = 3
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.default_value = {}
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.message_type = slot1.ITEM_NET_REC
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.type = 11
slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD.cpp_type = 10
SC_75007.name = "sc_75007"
SC_75007.full_name = ".common.sc_75007"
SC_75007.nested_types = {}
SC_75007.enum_types = {}
SC_75007.fields = {
	slot2.SC_75007_FIELD_LIST.SC_75007_RESULT_FIELD,
	slot2.SC_75007_FIELD_LIST.SC_75007_REWARD_LIST_FIELD
}
SC_75007.is_extendable = false
SC_75007.extensions = {}
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.name = "id"
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.full_name = ".common.attribute_stage_info.id"
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.number = 1
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.index = 0
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.label = 2
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.has_default_value = false
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.default_value = 0
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.type = 13
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD.cpp_type = 3
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.name = "sign"
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.full_name = ".common.attribute_stage_info.sign"
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.number = 2
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.index = 1
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.label = 2
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.has_default_value = false
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.default_value = 0
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.type = 13
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD.cpp_type = 3
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.name = "min_time"
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.full_name = ".common.attribute_stage_info.min_time"
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.number = 3
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.index = 2
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.label = 2
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.has_default_value = false
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.default_value = 0
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.type = 13
slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD.cpp_type = 3
ATTRIBUTE_STAGE_INFO.name = "attribute_stage_info"
ATTRIBUTE_STAGE_INFO.full_name = ".common.attribute_stage_info"
ATTRIBUTE_STAGE_INFO.nested_types = {}
ATTRIBUTE_STAGE_INFO.enum_types = {}
ATTRIBUTE_STAGE_INFO.fields = {
	slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_ID_FIELD,
	slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_SIGN_FIELD,
	slot2.ATTRIBUTE_STAGE_INFO_FIELD_LIST.ATTRIBUTE_STAGE_INFO_MIN_TIME_FIELD
}
ATTRIBUTE_STAGE_INFO.is_extendable = false
ATTRIBUTE_STAGE_INFO.extensions = {}
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.name = "boss_type"
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.full_name = ".common.lock_hero_info.boss_type"
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.number = 1
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.index = 0
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.label = 2
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.has_default_value = false
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.default_value = 0
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.type = 13
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD.cpp_type = 3
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.name = "hero_list"
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.full_name = ".common.lock_hero_info.hero_list"
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.number = 2
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.index = 1
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.label = 3
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.has_default_value = false
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.default_value = {}
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.type = 13
slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD.cpp_type = 3
LOCK_HERO_INFO.name = "lock_hero_info"
LOCK_HERO_INFO.full_name = ".common.lock_hero_info"
LOCK_HERO_INFO.nested_types = {}
LOCK_HERO_INFO.enum_types = {}
LOCK_HERO_INFO.fields = {
	slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_BOSS_TYPE_FIELD,
	slot2.LOCK_HERO_INFO_FIELD_LIST.LOCK_HERO_INFO_HERO_LIST_FIELD
}
LOCK_HERO_INFO.is_extendable = false
LOCK_HERO_INFO.extensions = {}
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.name = "now_cycle"
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.full_name = ".common.sc_75009.now_cycle"
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.number = 1
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.index = 0
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.label = 2
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.has_default_value = false
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.default_value = 0
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.type = 13
slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD.cpp_type = 3
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.name = "next_cycle"
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.full_name = ".common.sc_75009.next_cycle"
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.number = 2
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.index = 1
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.label = 2
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.has_default_value = false
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.default_value = 0
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.type = 13
slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD.cpp_type = 3
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.name = "stage_info"
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.full_name = ".common.sc_75009.stage_info"
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.number = 3
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.index = 2
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.label = 3
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.has_default_value = false
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.default_value = {}
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.message_type = ATTRIBUTE_STAGE_INFO
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.type = 11
slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD.cpp_type = 10
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.name = "reward_list"
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.full_name = ".common.sc_75009.reward_list"
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.number = 4
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.index = 3
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.label = 3
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.has_default_value = false
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.default_value = {}
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.type = 13
slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD.cpp_type = 3
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.name = "lock_list"
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.full_name = ".common.sc_75009.lock_list"
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.number = 5
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.index = 4
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.label = 3
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.has_default_value = false
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.default_value = {}
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.message_type = LOCK_HERO_INFO
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.type = 11
slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD.cpp_type = 10
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.name = "refresh_timestamp"
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.full_name = ".common.sc_75009.refresh_timestamp"
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.number = 6
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.index = 5
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.label = 2
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.has_default_value = false
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.default_value = 0
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.type = 13
slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD.cpp_type = 3
SC_75009.name = "sc_75009"
SC_75009.full_name = ".common.sc_75009"
SC_75009.nested_types = {}
SC_75009.enum_types = {}
SC_75009.fields = {
	slot2.SC_75009_FIELD_LIST.SC_75009_NOW_CYCLE_FIELD,
	slot2.SC_75009_FIELD_LIST.SC_75009_NEXT_CYCLE_FIELD,
	slot2.SC_75009_FIELD_LIST.SC_75009_STAGE_INFO_FIELD,
	slot2.SC_75009_FIELD_LIST.SC_75009_REWARD_LIST_FIELD,
	slot2.SC_75009_FIELD_LIST.SC_75009_LOCK_LIST_FIELD,
	slot2.SC_75009_FIELD_LIST.SC_75009_REFRESH_TIMESTAMP_FIELD
}
SC_75009.is_extendable = false
SC_75009.extensions = {}
attribute_stage_info = slot0.Message(ATTRIBUTE_STAGE_INFO)
cs_75002 = slot0.Message(CS_75002)
cs_75006 = slot0.Message(CS_75006)
heart_demon_challenge_info = slot0.Message(HEART_DEMON_CHALLENGE_INFO)
lock_hero_info = slot0.Message(LOCK_HERO_INFO)
sc_75001 = slot0.Message(SC_75001)
sc_75003 = slot0.Message(SC_75003)
sc_75005 = slot0.Message(SC_75005)
sc_75007 = slot0.Message(SC_75007)
sc_75009 = slot0.Message(SC_75009)

return p75_pb
