local var_0_0 = require("protobuf")

module("p50_pb", package.seeall)

local var_0_1 = {
	SC_50001_FIELD_LIST = {},
	PROPOSAL_NET_REC_FIELD_LIST = {},
	HERO_CHIP_STATE_REC_FIELD_LIST = {},
	CS_50002_FIELD_LIST = {},
	SC_50003_FIELD_LIST = {},
	CS_50008_FIELD_LIST = {},
	SC_50009_FIELD_LIST = {},
	CS_50010_FIELD_LIST = {},
	SC_50011_FIELD_LIST = {},
	CS_50012_FIELD_LIST = {},
	SC_50013_FIELD_LIST = {},
	CS_50014_FIELD_LIST = {},
	SC_50015_FIELD_LIST = {},
	CS_50018_FIELD_LIST = {},
	SC_50019_FIELD_LIST = {}
}

SC_50001 = var_0_0.Descriptor()
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD = var_0_0.FieldDescriptor()
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD = var_0_0.FieldDescriptor()
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD = var_0_0.FieldDescriptor()
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD = var_0_0.FieldDescriptor()
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD = var_0_0.FieldDescriptor()
PROPOSAL_NET_REC = var_0_0.Descriptor()
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD = var_0_0.FieldDescriptor()
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD = var_0_0.FieldDescriptor()
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD = var_0_0.FieldDescriptor()
HERO_CHIP_STATE_REC = var_0_0.Descriptor()
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD = var_0_0.FieldDescriptor()
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD = var_0_0.FieldDescriptor()
CS_50002 = var_0_0.Descriptor()
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD = var_0_0.FieldDescriptor()
SC_50003 = var_0_0.Descriptor()
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD = var_0_0.FieldDescriptor()
CS_50008 = var_0_0.Descriptor()
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD = var_0_0.FieldDescriptor()
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD = var_0_0.FieldDescriptor()
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD = var_0_0.FieldDescriptor()
SC_50009 = var_0_0.Descriptor()
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD = var_0_0.FieldDescriptor()
CS_50010 = var_0_0.Descriptor()
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD = var_0_0.FieldDescriptor()
SC_50011 = var_0_0.Descriptor()
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD = var_0_0.FieldDescriptor()
CS_50012 = var_0_0.Descriptor()
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD = var_0_0.FieldDescriptor()
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD = var_0_0.FieldDescriptor()
SC_50013 = var_0_0.Descriptor()
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD = var_0_0.FieldDescriptor()
CS_50014 = var_0_0.Descriptor()
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD = var_0_0.FieldDescriptor()
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD = var_0_0.FieldDescriptor()
SC_50015 = var_0_0.Descriptor()
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD = var_0_0.FieldDescriptor()
CS_50018 = var_0_0.Descriptor()
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD = var_0_0.FieldDescriptor()
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD = var_0_0.FieldDescriptor()
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD = var_0_0.FieldDescriptor()
SC_50019 = var_0_0.Descriptor()
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD = var_0_0.FieldDescriptor()
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.name = "unlock_kernel_chip"
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.full_name = ".p50.sc_50001.unlock_kernel_chip"
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.number = 1
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.index = 0
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.label = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.has_default_value = false
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.default_value = {}
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.type = 13
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD.cpp_type = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.name = "unlock_secondary_chip"
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.full_name = ".p50.sc_50001.unlock_secondary_chip"
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.number = 2
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.index = 1
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.label = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.has_default_value = false
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.default_value = {}
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.type = 13
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD.cpp_type = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.name = "unlock_hero_chip"
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.full_name = ".p50.sc_50001.unlock_hero_chip"
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.number = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.index = 2
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.label = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.has_default_value = false
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.default_value = {}
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.type = 13
var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD.cpp_type = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.name = "proposals"
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.full_name = ".p50.sc_50001.proposals"
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.number = 4
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.index = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.label = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.has_default_value = false
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.default_value = {}
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.message_type = PROPOSAL_NET_REC
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.type = 11
var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD.cpp_type = 10
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.name = "hero_chip_state"
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.full_name = ".p50.sc_50001.hero_chip_state"
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.number = 5
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.index = 4
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.label = 3
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.has_default_value = false
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.default_value = {}
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.message_type = HERO_CHIP_STATE_REC
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.type = 11
var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD.cpp_type = 10
SC_50001.name = "sc_50001"
SC_50001.full_name = ".p50.sc_50001"
SC_50001.nested_types = {}
SC_50001.enum_types = {}
SC_50001.fields = {
	var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_KERNEL_CHIP_FIELD,
	var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_SECONDARY_CHIP_FIELD,
	var_0_1.SC_50001_FIELD_LIST.SC_50001_UNLOCK_HERO_CHIP_FIELD,
	var_0_1.SC_50001_FIELD_LIST.SC_50001_PROPOSALS_FIELD,
	var_0_1.SC_50001_FIELD_LIST.SC_50001_HERO_CHIP_STATE_FIELD
}
SC_50001.is_extendable = false
SC_50001.extensions = {}
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.name = "id"
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.full_name = ".p50.proposal_net_rec.id"
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.number = 1
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.index = 0
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.label = 2
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.has_default_value = false
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.default_value = 0
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.type = 13
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD.cpp_type = 3
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.name = "name"
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.full_name = ".p50.proposal_net_rec.name"
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.number = 2
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.index = 1
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.label = 2
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.has_default_value = false
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.default_value = ""
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.type = 9
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD.cpp_type = 9
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.name = "secondary"
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.full_name = ".p50.proposal_net_rec.secondary"
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.number = 3
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.index = 2
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.label = 3
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.has_default_value = false
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.default_value = {}
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.type = 13
var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD.cpp_type = 3
PROPOSAL_NET_REC.name = "proposal_net_rec"
PROPOSAL_NET_REC.full_name = ".p50.proposal_net_rec"
PROPOSAL_NET_REC.nested_types = {}
PROPOSAL_NET_REC.enum_types = {}
PROPOSAL_NET_REC.fields = {
	var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_ID_FIELD,
	var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_NAME_FIELD,
	var_0_1.PROPOSAL_NET_REC_FIELD_LIST.PROPOSAL_NET_REC_SECONDARY_FIELD
}
PROPOSAL_NET_REC.is_extendable = false
PROPOSAL_NET_REC.extensions = {}
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.name = "hero_id"
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.full_name = ".p50.hero_chip_state_rec.hero_id"
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.number = 1
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.index = 0
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.label = 2
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.has_default_value = false
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.default_value = 0
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.type = 13
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD.cpp_type = 3
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.name = "secondary"
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.full_name = ".p50.hero_chip_state_rec.secondary"
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.number = 2
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.index = 1
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.label = 3
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.has_default_value = false
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.default_value = {}
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.type = 13
var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD.cpp_type = 3
HERO_CHIP_STATE_REC.name = "hero_chip_state_rec"
HERO_CHIP_STATE_REC.full_name = ".p50.hero_chip_state_rec"
HERO_CHIP_STATE_REC.nested_types = {}
HERO_CHIP_STATE_REC.enum_types = {}
HERO_CHIP_STATE_REC.fields = {
	var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_HERO_ID_FIELD,
	var_0_1.HERO_CHIP_STATE_REC_FIELD_LIST.HERO_CHIP_STATE_REC_SECONDARY_FIELD
}
HERO_CHIP_STATE_REC.is_extendable = false
HERO_CHIP_STATE_REC.extensions = {}
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.name = "id"
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.full_name = ".p50.cs_50002.id"
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.number = 1
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.index = 0
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.label = 2
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.has_default_value = false
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.default_value = 0
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.type = 13
var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD.cpp_type = 3
CS_50002.name = "cs_50002"
CS_50002.full_name = ".p50.cs_50002"
CS_50002.nested_types = {}
CS_50002.enum_types = {}
CS_50002.fields = {
	var_0_1.CS_50002_FIELD_LIST.CS_50002_ID_FIELD
}
CS_50002.is_extendable = false
CS_50002.extensions = {}
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.name = "result"
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.full_name = ".p50.sc_50003.result"
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.number = 1
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.index = 0
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.label = 2
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.has_default_value = false
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.default_value = 0
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.type = 13
var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD.cpp_type = 3
SC_50003.name = "sc_50003"
SC_50003.full_name = ".p50.sc_50003"
SC_50003.nested_types = {}
SC_50003.enum_types = {}
SC_50003.fields = {
	var_0_1.SC_50003_FIELD_LIST.SC_50003_RESULT_FIELD
}
SC_50003.is_extendable = false
SC_50003.extensions = {}
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.name = "id"
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.full_name = ".p50.cs_50008.id"
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.number = 1
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.index = 0
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.label = 2
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.has_default_value = false
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.default_value = 0
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.type = 13
var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD.cpp_type = 3
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.name = "name"
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.full_name = ".p50.cs_50008.name"
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.number = 2
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.index = 1
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.label = 2
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.has_default_value = false
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.default_value = ""
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.type = 9
var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD.cpp_type = 9
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.name = "secondary"
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.full_name = ".p50.cs_50008.secondary"
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.number = 3
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.index = 2
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.label = 3
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.has_default_value = false
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.default_value = {}
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.type = 13
var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD.cpp_type = 3
CS_50008.name = "cs_50008"
CS_50008.full_name = ".p50.cs_50008"
CS_50008.nested_types = {}
CS_50008.enum_types = {}
CS_50008.fields = {
	var_0_1.CS_50008_FIELD_LIST.CS_50008_ID_FIELD,
	var_0_1.CS_50008_FIELD_LIST.CS_50008_NAME_FIELD,
	var_0_1.CS_50008_FIELD_LIST.CS_50008_SECONDARY_FIELD
}
CS_50008.is_extendable = false
CS_50008.extensions = {}
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.name = "result"
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.full_name = ".p50.sc_50009.result"
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.number = 1
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.index = 0
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.label = 2
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.has_default_value = false
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.default_value = 0
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.type = 13
var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD.cpp_type = 3
SC_50009.name = "sc_50009"
SC_50009.full_name = ".p50.sc_50009"
SC_50009.nested_types = {}
SC_50009.enum_types = {}
SC_50009.fields = {
	var_0_1.SC_50009_FIELD_LIST.SC_50009_RESULT_FIELD
}
SC_50009.is_extendable = false
SC_50009.extensions = {}
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.name = "id"
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.full_name = ".p50.cs_50010.id"
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.number = 1
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.index = 0
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.label = 2
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.has_default_value = false
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.default_value = 0
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.type = 13
var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD.cpp_type = 3
CS_50010.name = "cs_50010"
CS_50010.full_name = ".p50.cs_50010"
CS_50010.nested_types = {}
CS_50010.enum_types = {}
CS_50010.fields = {
	var_0_1.CS_50010_FIELD_LIST.CS_50010_ID_FIELD
}
CS_50010.is_extendable = false
CS_50010.extensions = {}
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.name = "result"
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.full_name = ".p50.sc_50011.result"
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.number = 1
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.index = 0
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.label = 2
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.has_default_value = false
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.default_value = 0
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.type = 13
var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD.cpp_type = 3
SC_50011.name = "sc_50011"
SC_50011.full_name = ".p50.sc_50011"
SC_50011.nested_types = {}
SC_50011.enum_types = {}
SC_50011.fields = {
	var_0_1.SC_50011_FIELD_LIST.SC_50011_RESULT_FIELD
}
SC_50011.is_extendable = false
SC_50011.extensions = {}
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.name = "id"
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.full_name = ".p50.cs_50012.id"
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.number = 1
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.index = 0
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.label = 2
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.has_default_value = false
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.default_value = 0
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.type = 13
var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD.cpp_type = 3
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.name = "name"
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.full_name = ".p50.cs_50012.name"
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.number = 2
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.index = 1
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.label = 2
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.has_default_value = false
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.default_value = ""
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.type = 9
var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD.cpp_type = 9
CS_50012.name = "cs_50012"
CS_50012.full_name = ".p50.cs_50012"
CS_50012.nested_types = {}
CS_50012.enum_types = {}
CS_50012.fields = {
	var_0_1.CS_50012_FIELD_LIST.CS_50012_ID_FIELD,
	var_0_1.CS_50012_FIELD_LIST.CS_50012_NAME_FIELD
}
CS_50012.is_extendable = false
CS_50012.extensions = {}
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.name = "result"
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.full_name = ".p50.sc_50013.result"
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.number = 1
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.index = 0
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.label = 2
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.has_default_value = false
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.default_value = 0
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.type = 13
var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD.cpp_type = 3
SC_50013.name = "sc_50013"
SC_50013.full_name = ".p50.sc_50013"
SC_50013.nested_types = {}
SC_50013.enum_types = {}
SC_50013.fields = {
	var_0_1.SC_50013_FIELD_LIST.SC_50013_RESULT_FIELD
}
SC_50013.is_extendable = false
SC_50013.extensions = {}
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.name = "kernel_chip_id"
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.full_name = ".p50.cs_50014.kernel_chip_id"
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.number = 1
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.index = 0
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.label = 2
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.has_default_value = false
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.default_value = 0
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.type = 13
var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD.cpp_type = 3
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.name = "proposal_id"
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.full_name = ".p50.cs_50014.proposal_id"
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.number = 2
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.index = 1
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.label = 2
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.has_default_value = false
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.default_value = 0
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.type = 13
var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD.cpp_type = 3
CS_50014.name = "cs_50014"
CS_50014.full_name = ".p50.cs_50014"
CS_50014.nested_types = {}
CS_50014.enum_types = {}
CS_50014.fields = {
	var_0_1.CS_50014_FIELD_LIST.CS_50014_KERNEL_CHIP_ID_FIELD,
	var_0_1.CS_50014_FIELD_LIST.CS_50014_PROPOSAL_ID_FIELD
}
CS_50014.is_extendable = false
CS_50014.extensions = {}
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.name = "result"
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.full_name = ".p50.sc_50015.result"
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.number = 1
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.index = 0
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.label = 2
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.has_default_value = false
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.default_value = 0
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.type = 13
var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD.cpp_type = 3
SC_50015.name = "sc_50015"
SC_50015.full_name = ".p50.sc_50015"
SC_50015.nested_types = {}
SC_50015.enum_types = {}
SC_50015.fields = {
	var_0_1.SC_50015_FIELD_LIST.SC_50015_RESULT_FIELD
}
SC_50015.is_extendable = false
SC_50015.extensions = {}
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.name = "hero_id"
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.full_name = ".p50.cs_50018.hero_id"
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.number = 1
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.index = 0
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.label = 2
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.has_default_value = false
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.default_value = 0
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.type = 13
var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD.cpp_type = 3
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.name = "slot_id"
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.full_name = ".p50.cs_50018.slot_id"
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.number = 2
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.index = 1
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.label = 2
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.has_default_value = false
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.default_value = 0
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.type = 13
var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD.cpp_type = 3
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.name = "secondary"
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.full_name = ".p50.cs_50018.secondary"
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.number = 3
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.index = 2
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.label = 2
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.has_default_value = false
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.default_value = 0
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.type = 13
var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD.cpp_type = 3
CS_50018.name = "cs_50018"
CS_50018.full_name = ".p50.cs_50018"
CS_50018.nested_types = {}
CS_50018.enum_types = {}
CS_50018.fields = {
	var_0_1.CS_50018_FIELD_LIST.CS_50018_HERO_ID_FIELD,
	var_0_1.CS_50018_FIELD_LIST.CS_50018_SLOT_ID_FIELD,
	var_0_1.CS_50018_FIELD_LIST.CS_50018_SECONDARY_FIELD
}
CS_50018.is_extendable = false
CS_50018.extensions = {}
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.name = "result"
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.full_name = ".p50.sc_50019.result"
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.number = 1
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.index = 0
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.label = 2
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.has_default_value = false
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.default_value = 0
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.type = 13
var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD.cpp_type = 3
SC_50019.name = "sc_50019"
SC_50019.full_name = ".p50.sc_50019"
SC_50019.nested_types = {}
SC_50019.enum_types = {}
SC_50019.fields = {
	var_0_1.SC_50019_FIELD_LIST.SC_50019_RESULT_FIELD
}
SC_50019.is_extendable = false
SC_50019.extensions = {}
cs_50002 = var_0_0.Message(CS_50002)
cs_50008 = var_0_0.Message(CS_50008)
cs_50010 = var_0_0.Message(CS_50010)
cs_50012 = var_0_0.Message(CS_50012)
cs_50014 = var_0_0.Message(CS_50014)
cs_50018 = var_0_0.Message(CS_50018)
hero_chip_state_rec = var_0_0.Message(HERO_CHIP_STATE_REC)
proposal_net_rec = var_0_0.Message(PROPOSAL_NET_REC)
sc_50001 = var_0_0.Message(SC_50001)
sc_50003 = var_0_0.Message(SC_50003)
sc_50009 = var_0_0.Message(SC_50009)
sc_50011 = var_0_0.Message(SC_50011)
sc_50013 = var_0_0.Message(SC_50013)
sc_50015 = var_0_0.Message(SC_50015)
sc_50019 = var_0_0.Message(SC_50019)

return p50_pb
