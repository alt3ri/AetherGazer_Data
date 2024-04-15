return {
	ACCOUNT_BAN = 1005,
	NEED_UPDATE = 7,
	ANTI_ADDICTION = 1001,
	SERVER_MAINTAIN = 1004,
	KICK_REASON = {
		"LOGIN_IN_OTHER_PLACE",
		"KICK_BY_SERVER",
		"RECONNECT_TOO_LONG",
		"CONNECT_DATA_ERROR",
		"CS_INDEX_ERROR",
		[9999] = "SDK主动唤起重新登录",
		[1001] = "ANTIADDICTION_ONLINE_TIME_LIMIT",
		[1003] = "ERROR_LOGIN_TOKEN_CHK_FAIL"
	},
	LOGIN_TYPE = {
		LOGIN = 0,
		RECONNECT = 1
	}
}