return {
	[1001] = {
		pool_type = 1,
		pool_id = 1001,
		detail_note = [[
一、核心奖励：

「海上的私语」*1
「蓝染雪枝」*1
「精确探测凭证x10」*1
「钥从探测凭证x5」*2
「神识凝晶x10」*1
「极致灵泉萃取液x96」*1
「高级赋能模块x40」*1


二、活动规则

1.每次邀约需要消耗「特邀贵宾函」，「特邀贵宾函」可使用移转之辉或移转之花兑换，<color=#F6841D>使用移转之花兑换「特邀贵宾函」会根据当前兑换次数获得不同的兑换折扣</color>。
2.每次邀约时将会通过概率决定抽取到的奖励类型，核心奖励的概率为<color=#F6841D>1%</color>，其他奖励的概率为<color=#F6841D>99%</color>，每次邀约均会获取一个奖励，每<color=#F6841D>10</color>次邀约中至少可以获得一个核心奖励。<color=#F6841D>奖励获取后不会再次被抽取</color>，至多<color=#F6841D>80</color>次邀约必定获得卡池内全部奖励。
3.使用移转之辉购买「特邀贵宾函」单价为移转之辉*120，合计可兑换80张。
4.使用移转之花购买「特邀贵宾函」单价为移转之花*120，可以1折折扣兑换20张（单价移转之花*12），2折折扣兑换10张（单价移转之花*24），3折折扣兑换10张（单价移转之花*36），4折折扣兑换10张（单价移转之花*48），6折折扣兑换10张（单价移转之花*72），8折折扣兑换10张（单价移转之花*96），原价兑换10张，合计可兑换80张。

三、核心奖励概率说明：

1.当抽取到核心奖励时，各核心奖励初始概率如下：

「海上的私语」-0.30%
「蓝染雪枝」-30.00%
「精确探测凭证x10」-2.70%
「钥从探测凭证x5」-10.00%
「神识凝晶x10」-12.00%
「极致灵泉萃取液x96」-20.00%
「高级赋能模块x40」-25.00%

2.每次抽取到核心奖励时，核心奖励奖池内各个奖励将会由各奖励所占权重实时计算概率。计算公式如下：

<color=#F6841D>特定奖励获取概率=特定奖励剩余数量*特定奖励权重/（核心奖励奖池内剩余奖励数量*各奖励对应权重）之和</color>

各奖励权重如下：

「海上的私语」	   3
「蓝染雪枝」	   300
「精确探测凭证x10」	 27
「钥从探测凭证x5」	  50
「神识凝晶x10」	  120
「极致灵泉萃取液x96」	 200
「高级赋能模块x40」	 250

例如：
当核心奖励奖池内「蓝染雪枝」、「高级赋能模块x40」、「极致灵泉萃取液x96」已抽取完成，此时再次抽取到核心奖励时，奖励为「海上的私语」的概率
=3*1/（3*1+27*1+50*2+120*1）=1.20%
当核心奖励奖池内仅剩余「海上的私语」、「精确探测凭证x10」未被抽取，此时再次抽取到核心奖励时，奖励为「海上的私语」的概率
=3*1/（3*1+27*1）=10.00%
即随着抽取行为的进行，所有物品的概率均会做实时的波动。]],
		activity_id = {
			182221
		},
		cost_once = {
			53030,
			1
		},
		cost_ten_times = {
			53030,
			10
		},
		stage_list = {
			1
		},
		payment = {
			300000014,
			300000013,
			300000012,
			300000011,
			300000010,
			300000009,
			300000008,
			300000007
		},
		payment_free = {
			300000006
		},
		main_icon_info = {
			{
				113,
				2020
			},
			{
				120,
				107602
			}
		},
		icon_info = {
			{
				108,
				90001
			},
			{
				109,
				90002
			},
			{
				110,
				90003
			},
			{
				111,
				90004
			},
			{
				112,
				90005
			}
		}
	},
	[1002] = {
		pool_type = 2,
		pool_id = 1002,
		detail_note = [[
一、核心奖励：

「暮色珍珠」*1
「精确探测凭证x5」*1
「聚合权能晶体x24」*1
「重构秘仪x20」*1


二、活动规则

1.每次邀约需要消耗「宴会邀请函」，「宴会邀请函」可使用移转之辉或移转之花兑换，<color=#F6841D>使用移转之花兑换「宴会邀请函」会根据当前兑换次数获得不同的兑换折扣</color>。
2.每次邀约时将会通过概率决定抽取到的奖励类型，核心奖励的概率为<color=#F6841D>1%</color>，其他奖励的概率为<color=#F6841D>99%</color>，每次邀约均会获取一个奖励，每<color=#F6841D>10</color>次邀约中至少可以获得一个核心奖励。<color=#F6841D>奖励获取后不会再次被抽取</color>，至多<color=#F6841D>40</color>次邀约必定获得卡池内全部奖励。
3.使用移转之辉购买「宴会邀请函」单价为移转之辉*60，合计可兑换40张。
4.使用移转之花购买「宴会邀请函」单价为移转之花*60，可以1折折扣兑换10张（单价移转之花*6），4折折扣兑换10张（单价移转之花*24），8折折扣兑换10张（单价移转之花*48），原价兑换10张，合计可兑换40张。

三、核心奖励概率说明：

1.当抽取到核心奖励时，各核心奖励初始概率如下：

「暮色珍珠」-2.50%
「精确探测凭证x5」-7.50%
「聚合权能晶体x24」-40.00%
「重构秘仪x20」-50.00%

2.每次抽取到核心奖励时，核心奖励奖池内各个奖励将会由各奖励所占权重实时计算概率。计算公式如下：

<color=#F6841D>特定奖励获取概率=特定奖励剩余数量*特定奖励权重/（核心奖励奖池内剩余奖励数量*各奖励对应权重）之和</color>

各奖励权重如下：

「暮色珍珠」	1
「精确探测凭证x5」	3
「聚合权能晶体x24」	16
「重构秘仪x20」	 20

例如：
当核心奖励奖池内「重构秘仪x20」、「聚合权能晶体x24」已抽取完成，此时再次抽取到核心奖励时，奖励为「暮色珍珠」的概率
=1*1/（1*1+3*1）=25.00%
即随着抽取行为的进行，所有物品的概率均会做实时的波动。]],
		activity_id = {
			182222
		},
		cost_once = {
			53031,
			1
		},
		cost_ten_times = {
			53031,
			10
		},
		stage_list = {
			1
		},
		payment = {
			300000005,
			300000004,
			300000003,
			300000002
		},
		payment_free = {
			300000001
		},
		main_icon_info = {
			{
				208,
				6001
			}
		},
		icon_info = {
			{
				207,
				38
			},
			{
				206,
				41303
			},
			{
				205,
				40701
			}
		}
	},
	all = {
		1001,
		1002
	}
}
