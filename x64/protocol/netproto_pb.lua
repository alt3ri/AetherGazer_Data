slot0 = require("protobuf")

module("netproto_pb", package.seeall)

slot1 = {
	OP_B2G_CONNECTREQUEST_FIELD_LIST = {},
	OP_G2B_CONNECTRESPONSE_FIELD_LIST = {}
}
OP_B2G_CONNECTREQUEST = slot0.Descriptor()
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD = slot0.FieldDescriptor()
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD = slot0.FieldDescriptor()
OP_G2B_CONNECTRESPONSE = slot0.Descriptor()
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD = slot0.FieldDescriptor()
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD = slot0.FieldDescriptor()
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD = slot0.FieldDescriptor()
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.name = "Timestamp"
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.full_name = ".Op_B2G_ConnectRequest.Timestamp"
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.number = 1
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.index = 0
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.label = 2
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.has_default_value = false
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.default_value = 0
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.type = 13
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD.cpp_type = 3
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.name = "Verification"
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.full_name = ".Op_B2G_ConnectRequest.Verification"
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.number = 2
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.index = 1
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.label = 2
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.has_default_value = false
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.default_value = ""
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.type = 9
slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD.cpp_type = 9
OP_B2G_CONNECTREQUEST.name = "Op_B2G_ConnectRequest"
OP_B2G_CONNECTREQUEST.full_name = ".Op_B2G_ConnectRequest"
OP_B2G_CONNECTREQUEST.nested_types = {}
OP_B2G_CONNECTREQUEST.enum_types = {}
OP_B2G_CONNECTREQUEST.fields = {
	slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_TIMESTAMP_FIELD,
	slot1.OP_B2G_CONNECTREQUEST_FIELD_LIST.OP_B2G_CONNECTREQUEST_VERIFICATION_FIELD
}
OP_B2G_CONNECTREQUEST.is_extendable = false
OP_B2G_CONNECTREQUEST.extensions = {}
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.name = "ErrorCode"
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.full_name = ".Op_G2B_ConnectResponse.ErrorCode"
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.number = 1
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.index = 0
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.label = 2
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.has_default_value = false
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.default_value = 0
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.type = 13
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD.cpp_type = 3
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.name = "BattleServerId"
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.full_name = ".Op_G2B_ConnectResponse.BattleServerId"
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.number = 2
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.index = 1
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.label = 2
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.has_default_value = false
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.default_value = 0
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.type = 13
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD.cpp_type = 3
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.name = "IsServiceOpen"
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.full_name = ".Op_G2B_ConnectResponse.IsServiceOpen"
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.number = 3
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.index = 2
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.label = 2
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.has_default_value = false
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.default_value = false
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.type = 8
slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD.cpp_type = 7
OP_G2B_CONNECTRESPONSE.name = "Op_G2B_ConnectResponse"
OP_G2B_CONNECTRESPONSE.full_name = ".Op_G2B_ConnectResponse"
OP_G2B_CONNECTRESPONSE.nested_types = {}
OP_G2B_CONNECTRESPONSE.enum_types = {}
OP_G2B_CONNECTRESPONSE.fields = {
	slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ERRORCODE_FIELD,
	slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_BATTLESERVERID_FIELD,
	slot1.OP_G2B_CONNECTRESPONSE_FIELD_LIST.OP_G2B_CONNECTRESPONSE_ISSERVICEOPEN_FIELD
}
OP_G2B_CONNECTRESPONSE.is_extendable = false
OP_G2B_CONNECTRESPONSE.extensions = {}
Op_B2G_ConnectRequest = slot0.Message(OP_B2G_CONNECTREQUEST)
Op_G2B_ConnectResponse = slot0.Message(OP_G2B_CONNECTRESPONSE)

return netproto_pb
