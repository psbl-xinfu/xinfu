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
	   	{value:1030, name: '次卡', selected: true},
		{value: 2020, name: '时效卡'}
	]
};
/** 会员卡类型 */
var seriesJson2 = {
	name:'会员卡类型',
	type:'pie',
	selectedMode: 'single',
	radius: ['60%', '75%'],
	data: [
		{value: 1040, name: '塑性次卡'},
		{value: 3055, name: '瑜伽年卡'},
		{value: 2660, name: '年卡'},
		{value: 5550, name: '其他'},
		{value: 4000, name: '庆店卡'},
		{value: 2050, name: '游泳次卡'}
	]
};
cardsalesamountPic.updateOption([seriesJson1, seriesJson2]);
