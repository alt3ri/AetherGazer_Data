local var_0_0 = require("protobuf")

module("netproto_pb", package.seeall)

local var_0_1 = {
	OP_B2G_CONNECTREQUEST_FIELD_LIST = {},
	OP_G2B_CONNECTRESPONSE_FIELD_LIST = {}
}

OP_B2G_CONNECTREQUEST = var_0_0.Descriptor()
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD = var_0_0.FieldDescriptor()
OP_G2B_CONNECTRESPONSE = var_0_0.Descriptor()
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD = var_0_0.FieldDescriptor()
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD = var_0_0.FieldDescriptor()
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD = var_0_0.FieldDescriptor()
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.name = "Timestamp"
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.full_name = ".Op_B2G_ConnectRequest.Timestamp"
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.number = 1
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.index = 0
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.label = 2
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.has_default_value = false
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.default_value = 0
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.type = 13
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.cpp_type = 3
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.name = "Verification"
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.full_name = ".Op_B2G_ConnectRequest.Verification"
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.number = 2
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.index = 1
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.label = 2
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.has_default_value = false
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.default_value = ""
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.type = 9
var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.cpp_type = 9
OP_B2G_CONNECTREQUEST.name = "Op_B2G_ConnectRequest"
OP_B2G_CONNECTREQUEST.full_name = ".Op_B2G_ConnectRequest"
OP_B2G_CONNECTREQUEST.nested_types = {}
OP_B2G_CONNECTREQUEST.enum_types = {}
OP_B2G_CONNECTREQUEST.fields = {
	var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD,
	var_0_1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD
}
OP_B2G_CONNECTREQUEST.is_extendable = false
OP_B2G_CONNECTREQUEST.extensions = {}
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.name = "ErrorCode"
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.full_name = ".Op_G2B_ConnectResponse.ErrorCode"
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.number = 1
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.index = 0
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.label = 2
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.has_default_value = false
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.default_value = 0
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.type = 13
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.cpp_type = 3
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.name = "BattleServerId"
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.full_name = ".Op_G2B_ConnectResponse.BattleServerId"
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.number = 2
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.index = 1
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.label = 2
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.has_default_value = false
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.default_value = 0
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.type = 13
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.cpp_type = 3
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.name = "IsServiceOpen"
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.full_name = ".Op_G2B_ConnectResponse.IsServiceOpen"
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.number = 3
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.index = 2
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.label = 2
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.has_default_value = false
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.default_value = false
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.type = 8
var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.cpp_type = 7
OP_G2B_CONNECTRESPONSE.name = "Op_G2B_ConnectResponse"
OP_G2B_CONNECTRESPONSE.full_name = ".Op_G2B_ConnectResponse"
OP_G2B_CONNECTRESPONSE.nested_types = {}
OP_G2B_CONNECTRESPONSE.enum_types = {}
OP_G2B_CONNECTRESPONSE.fields = {
	var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD,
	var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD,
	var_0_1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD
}
OP_G2B_CONNECTRESPONSE.is_extendable = false
OP_G2B_CONNECTRESPONSE.extensions = {}
Op_B2G_ConnectRequest = var_0_0.Message(OP_B2G_CONNECTREQUEST)
Op_G2B_ConnectResponse = var_0_0.Message(OP_G2B_CONNECTRESPONSE)

return netproto_pb
