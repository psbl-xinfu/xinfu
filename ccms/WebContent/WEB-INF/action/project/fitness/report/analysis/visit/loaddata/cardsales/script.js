/** 卡类型 */
var seriesJson1 = {
	name:'卡类型',
	type:'pie',
	selectedMode: 'single',
	radius: [0, '50%'],
	label: {
		normal: {
			position: 'inner'
		}
	},
	labelLine: {
		normal: {
			show: false
		}
	},
	data: [
	   	{value: ${fld:unkownnum}, name: '次卡', selected: true},
		{value: ${fld:femalenum}, name: '时效卡'}
	]
};
/** 会员卡类型 */
var seriesJson2 = {
	name:'会员卡类型',
	type:'pie',
	selectedMode: 'single',
	radius: ['60%', '75%'],
	data: [
		{value: ${fld:guestnum}, name: '塑性次卡'},
		{value: ${fld:custnum}, name: '瑜伽年卡'},
		{value: ${fld:expirecustnum}, name: '年卡'},
		{value: ${fld:expirecustnum}, name: '其他'},
		{value: ${fld:expirecustnum}, name: '庆店卡'},
		{value: ${fld:expirecustnum}, name: '游泳次卡'}
	]
};
cardsalesPic.updateOption([seriesJson1, seriesJson2]);
