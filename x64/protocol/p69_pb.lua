local var_0_0 = require("protobuf")
local var_0_1 = require("protocol/rank_hrl_pb")

module("p69_pb", package.seeall)

local var_0_2 = {
	CS_69000_FIELD_LIST = {},
	SC_69001_FIELD_LIST = {},
	USER_CHILDREN_RANK_NET_REC_FIELD_LIST = {},
	CS_69002_FIELD_LIST = {},
	SC_69003_FIELD_LIST = {},
	CS_69004_FIELD_LIST = {},
	SC_69005_FIELD_LIST = {},
	CS_69006_FIELD_LIST = {},
	SC_69007_FIELD_LIST = {}
}

CS_69000 = var_0_0.Descriptor()
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD = var_0_0.FieldDescriptor()
SC_69001 = var_0_0.Descriptor()
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD = var_0_0.FieldDescriptor()
USER_CHILDREN_RANK_NET_REC = var_0_0.Descriptor()
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD = var_0_0.FieldDescriptor()
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD = var_0_0.FieldDescriptor()
CS_69002 = var_0_0.Descriptor()
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD = var_0_0.FieldDescriptor()
SC_69003 = var_0_0.Descriptor()
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD = var_0_0.FieldDescriptor()
CS_69004 = var_0_0.Descriptor()
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD = var_0_0.FieldDescriptor()
SC_69005 = var_0_0.Descriptor()
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD = var_0_0.FieldDescriptor()
CS_69006 = var_0_0.Descriptor()
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD = var_0_0.FieldDescriptor()
SC_69007 = var_0_0.Descriptor()
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.name = "rank_id"
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.full_name = ".common.cs_69000.rank_id"
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.number = 1
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.index = 0
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.label = 2
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.has_default_value = false
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.default_value = 0
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.type = 13
var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD.cpp_type = 3
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.name = "children_id"
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.full_name = ".common.cs_69000.children_id"
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.number = 2
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.index = 1
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.label = 2
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.has_default_value = false
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.default_value = 0
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.type = 13
var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD.cpp_type = 3
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.name = "start"
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.full_name = ".common.cs_69000.start"
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.number = 3
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.index = 2
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.label = 2
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.has_default_value = false
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.default_value = 0
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.type = 13
var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD.cpp_type = 3
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.name = "stop"
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.full_name = ".common.cs_69000.stop"
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.number = 4
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.index = 3
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.label = 2
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.has_default_value = false
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.default_value = 0
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.type = 13
var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD.cpp_type = 3
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.name = "version"
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.full_name = ".common.cs_69000.version"
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.number = 5
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.index = 4
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.label = 2
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.has_default_value = false
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.default_value = 0
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.type = 13
var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD.cpp_type = 3
CS_69000.name = "cs_69000"
CS_69000.full_name = ".common.cs_69000"
CS_69000.nested_types = {}
CS_69000.enum_types = {}
CS_69000.fields = {
	var_0_2.CS_69000_FIELD_LIST.CS_69000_RANK_ID_FIELD,
	var_0_2.CS_69000_FIELD_LIST.CS_69000_CHILDREN_ID_FIELD,
	var_0_2.CS_69000_FIELD_LIST.CS_69000_START_FIELD,
	var_0_2.CS_69000_FIELD_LIST.CS_69000_STOP_FIELD,
	var_0_2.CS_69000_FIELD_LIST.CS_69000_VERSION_FIELD
}
CS_69000.is_extendable = false
CS_69000.extensions = {}
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.name = "result"
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.full_name = ".common.sc_69001.result"
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.number = 1
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.index = 0
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.label = 2
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.has_default_value = false
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.default_value = 0
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.type = 13
var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD.cpp_type = 3
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.name = "rank_list"
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.full_name = ".common.sc_69001.rank_list"
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.number = 2
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.index = 1
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.label = 3
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.has_default_value = false
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.default_value = {}
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.message_type = var_0_1.USER_RANK_NET_REC
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.type = 11
var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD.cpp_type = 10
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.name = "my_rank"
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.full_name = ".common.sc_69001.my_rank"
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.number = 3
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.index = 2
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.label = 1
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.has_default_value = false
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.default_value = nil
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.message_type = var_0_1.USER_RANK_NET_REC
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.type = 11
var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD.cpp_type = 10
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.name = "total"
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.full_name = ".common.sc_69001.total"
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.number = 4
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.index = 3
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.label = 1
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.has_default_value = false
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.default_value = 0
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.type = 13
var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD.cpp_type = 3
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.name = "version"
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.full_name = ".common.sc_69001.version"
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.number = 5
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.index = 4
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.label = 1
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.has_default_value = false
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.default_value = 0
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.type = 13
var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD.cpp_type = 3
SC_69001.name = "sc_69001"
SC_69001.full_name = ".common.sc_69001"
SC_69001.nested_types = {}
SC_69001.enum_types = {}
SC_69001.fields = {
	var_0_2.SC_69001_FIELD_LIST.SC_69001_RESULT_FIELD,
	var_0_2.SC_69001_FIELD_LIST.SC_69001_RANK_LIST_FIELD,
	var_0_2.SC_69001_FIELD_LIST.SC_69001_MY_RANK_FIELD,
	var_0_2.SC_69001_FIELD_LIST.SC_69001_TOTAL_FIELD,
	var_0_2.SC_69001_FIELD_LIST.SC_69001_VERSION_FIELD
}
SC_69001.is_extendable = false
SC_69001.extensions = {}
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.name = "children_id"
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.full_name = ".common.user_children_rank_net_rec.children_id"
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.number = 1
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.index = 0
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.label = 2
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.has_default_value = false
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.default_value = 0
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.type = 13
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD.cpp_type = 3
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.name = "my_rank"
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.full_name = ".common.user_children_rank_net_rec.my_rank"
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.number = 2
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.index = 1
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.label = 2
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.has_default_value = false
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.default_value = nil
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.message_type = var_0_1.USER_RANK_NET_REC
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.type = 11
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD.cpp_type = 10
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.name = "total"
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.full_name = ".common.user_children_rank_net_rec.total"
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.number = 3
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.index = 2
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.label = 2
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.has_default_value = false
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.default_value = 0
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.type = 13
var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD.cpp_type = 3
USER_CHILDREN_RANK_NET_REC.name = "user_children_rank_net_rec"
USER_CHILDREN_RANK_NET_REC.full_name = ".common.user_children_rank_net_rec"
USER_CHILDREN_RANK_NET_REC.nested_types = {}
USER_CHILDREN_RANK_NET_REC.enum_types = {}
USER_CHILDREN_RANK_NET_REC.fields = {
	var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_CHILDREN_ID_FIELD,
	var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_MY_RANK_FIELD,
	var_0_2.USER_CHILDREN_RANK_NET_REC_FIELD_LIST.USER_CHILDREN_RANK_NET_REC_TOTAL_FIELD
}
USER_CHILDREN_RANK_NET_REC.is_extendable = false
USER_CHILDREN_RANK_NET_REC.extensions = {}
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.name = "rank_id"
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.full_name = ".common.cs_69002.rank_id"
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.number = 1
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.index = 0
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.label = 2
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.has_default_value = false
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.default_value = 0
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.type = 13
var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD.cpp_type = 3
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.name = "children_id_list"
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.full_name = ".common.cs_69002.children_id_list"
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.number = 2
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.index = 1
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.label = 3
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.has_default_value = false
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.default_value = {}
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.type = 13
var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD.cpp_type = 3
CS_69002.name = "cs_69002"
CS_69002.full_name = ".common.cs_69002"
CS_69002.nested_types = {}
CS_69002.enum_types = {}
CS_69002.fields = {
	var_0_2.CS_69002_FIELD_LIST.CS_69002_RANK_ID_FIELD,
	var_0_2.CS_69002_FIELD_LIST.CS_69002_CHILDREN_ID_LIST_FIELD
}
CS_69002.is_extendable = false
CS_69002.extensions = {}
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.name = "result"
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.full_name = ".common.sc_69003.result"
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.number = 1
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.index = 0
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.label = 2
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.has_default_value = false
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.default_value = 0
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.type = 13
var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD.cpp_type = 3
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.name = "children_rank_list"
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.full_name = ".common.sc_69003.children_rank_list"
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.number = 2
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.index = 1
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.label = 3
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.has_default_value = false
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.default_value = {}
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.message_type = USER_CHILDREN_RANK_NET_REC
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.type = 11
var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD.cpp_type = 10
SC_69003.name = "sc_69003"
SC_69003.full_name = ".common.sc_69003"
SC_69003.nested_types = {}
SC_69003.enum_types = {}
SC_69003.fields = {
	var_0_2.SC_69003_FIELD_LIST.SC_69003_RESULT_FIELD,
	var_0_2.SC_69003_FIELD_LIST.SC_69003_CHILDREN_RANK_LIST_FIELD
}
SC_69003.is_extendable = false
SC_69003.extensions = {}
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.name = "activity_id"
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.full_name = ".common.cs_69004.activity_id"
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.number = 1
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.index = 0
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.label = 2
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.has_default_value = false
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.default_value = 0
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.type = 13
var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD.cpp_type = 3
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.name = "children_id"
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.full_name = ".common.cs_69004.children_id"
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.number = 2
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.index = 1
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.label = 2
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.has_default_value = false
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.default_value = 0
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.type = 13
var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD.cpp_type = 3
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.name = "start"
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.full_name = ".common.cs_69004.start"
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.number = 3
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.index = 2
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.label = 2
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.has_default_value = false
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.default_value = 0
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.type = 13
var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD.cpp_type = 3
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.name = "stop"
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.full_name = ".common.cs_69004.stop"
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.number = 4
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.index = 3
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.label = 2
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.has_default_value = false
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.default_value = 0
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.type = 13
var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD.cpp_type = 3
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.name = "version"
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.full_name = ".common.cs_69004.version"
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.number = 5
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.index = 4
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.label = 2
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.has_default_value = false
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.default_value = 0
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.type = 13
var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD.cpp_type = 3
CS_69004.name = "cs_69004"
CS_69004.full_name = ".common.cs_69004"
CS_69004.nested_types = {}
CS_69004.enum_types = {}
CS_69004.fields = {
	var_0_2.CS_69004_FIELD_LIST.CS_69004_ACTIVITY_ID_FIELD,
	var_0_2.CS_69004_FIELD_LIST.CS_69004_CHILDREN_ID_FIELD,
	var_0_2.CS_69004_FIELD_LIST.CS_69004_START_FIELD,
	var_0_2.CS_69004_FIELD_LIST.CS_69004_STOP_FIELD,
	var_0_2.CS_69004_FIELD_LIST.CS_69004_VERSION_FIELD
}
CS_69004.is_extendable = false
CS_69004.extensions = {}
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.name = "result"
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.full_name = ".common.sc_69005.result"
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.number = 1
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.index = 0
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.label = 2
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.has_default_value = false
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.default_value = 0
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.type = 13
var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD.cpp_type = 3
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.name = "rank_list"
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.full_name = ".common.sc_69005.rank_list"
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.number = 2
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.index = 1
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.label = 3
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.has_default_value = false
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.default_value = {}
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.message_type = var_0_1.USER_RANK_NET_REC
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.type = 11
var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD.cpp_type = 10
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.name = "my_rank"
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.full_name = ".common.sc_69005.my_rank"
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.number = 3
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.index = 2
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.label = 1
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.has_default_value = false
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.default_value = nil
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.message_type = var_0_1.USER_RANK_NET_REC
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.type = 11
var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD.cpp_type = 10
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.name = "total"
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.full_name = ".common.sc_69005.total"
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.number = 4
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.index = 3
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.label = 1
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.has_default_value = false
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.default_value = 0
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.type = 13
var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD.cpp_type = 3
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.name = "version"
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.full_name = ".common.sc_69005.version"
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.number = 5
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.index = 4
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.label = 1
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.has_default_value = false
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.default_value = 0
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.type = 13
var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD.cpp_type = 3
SC_69005.name = "sc_69005"
SC_69005.full_name = ".common.sc_69005"
SC_69005.nested_types = {}
SC_69005.enum_types = {}
SC_69005.fields = {
	var_0_2.SC_69005_FIELD_LIST.SC_69005_RESULT_FIELD,
	var_0_2.SC_69005_FIELD_LIST.SC_69005_RANK_LIST_FIELD,
	var_0_2.SC_69005_FIELD_LIST.SC_69005_MY_RANK_FIELD,
	var_0_2.SC_69005_FIELD_LIST.SC_69005_TOTAL_FIELD,
	var_0_2.SC_69005_FIELD_LIST.SC_69005_VERSION_FIELD
}
SC_69005.is_extendable = false
SC_69005.extensions = {}
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.name = "activity_id"
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.full_name = ".common.cs_69006.activity_id"
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.number = 1
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.index = 0
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.label = 2
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.has_default_value = false
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.default_value = 0
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.type = 13
var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD.cpp_type = 3
CS_69006.name = "cs_69006"
CS_69006.full_name = ".common.cs_69006"
CS_69006.nested_types = {}
CS_69006.enum_types = {}
CS_69006.fields = {
	var_0_2.CS_69006_FIELD_LIST.CS_69006_ACTIVITY_ID_FIELD
}
CS_69006.is_extendable = false
CS_69006.extensions = {}
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.name = "result"
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.full_name = ".common.sc_69007.result"
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.number = 1
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.index = 0
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.label = 2
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.has_default_value = false
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.default_value = 0
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.type = 13
var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD.cpp_type = 3
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.name = "children_rank_list"
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.full_name = ".common.sc_69007.children_rank_list"
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.number = 2
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.index = 1
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.label = 3
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.has_default_value = false
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.default_value = {}
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.message_type = USER_CHILDREN_RANK_NET_REC
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.type = 11
var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD.cpp_type = 10
SC_69007.name = "sc_69007"
SC_69007.full_name = ".common.sc_69007"
SC_69007.nested_types = {}
SC_69007.enum_types = {}
SC_69007.fields = {
	var_0_2.SC_69007_FIELD_LIST.SC_69007_RESULT_FIELD,
	var_0_2.SC_69007_FIELD_LIST.SC_69007_CHILDREN_RANK_LIST_FIELD
}
SC_69007.is_extendable = false
SC_69007.extensions = {}
cs_69000 = var_0_0.Message(CS_69000)
cs_69002 = var_0_0.Message(CS_69002)
cs_69004 = var_0_0.Message(CS_69004)
cs_69006 = var_0_0.Message(CS_69006)
sc_69001 = var_0_0.Message(SC_69001)
sc_69003 = var_0_0.Message(SC_69003)
sc_69005 = var_0_0.Message(SC_69005)
sc_69007 = var_0_0.Message(SC_69007)
user_children_rank_net_rec = var_0_0.Message(USER_CHILDREN_RANK_NET_REC)

return p69_pb
