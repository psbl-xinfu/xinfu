﻿var str="";
<list>
str+='<div class="swiper-slide">'
str+='	<img  class="bannerimg"  src='+contextPath+'/action/ccms/attachment/download?id=${fld:id}&type=0&t='+new Date().getTime()+'">'
str+='</div>'
</list>
$('.swiper-wrapper:eq(0)').html(str);

var str2="";
<list2>
str2+='<div class="swiper-slide">'
str2+='	<img  style="height:100px;"  class="hdimg"  src='+contextPath+'/action/ccms/attachment/download?id=${fld:id}&type=0&t='+new Date().getTime()+'">'
str2+='</div>'
</list2>
$('.swiper-wrapper:eq(1)').html(str2);

var width=$(window).width();
if(width<=750){
    $('.bannerimg').css({'height':width*320/750+'px'});
    $('.huiyuantop').css({'height':width*195/750+'px'});
    $('.huiyuanbottom').css({'height':width*480/750+'px'});
    $('.showdiv').css({'height':width*480/750+'px'});
    $('.showimg').css({'height':width*0.9*0.48*3/2+'px'});
}else{
    $('.bannerimg').css({'height':'320px'});
    $('.huiyuantop').css({'height':'195px'});
    $('.huiyuanbottom').css({'height':'480px'});
    $('.showdiv').css({'height':'480px'});
    $('.showimg').css({'height':'480px'});
}
/*轮播*/
var swiper = new Swiper('#swiper1', {
    pagination: {
        el: '.swiper-pagination',
    },
    autoplay:true,
    /*autoplay: {
        delay: 3000,
        stopOnLastSlide: false,//如果设置为true，当切换到最后一个slide时停止自动切换。（loop模式下无效）。
        disableOnInteraction: true,//用户操作swiper之后，是否禁止autoplay。默认为true：停止。
    },*/
    loop : true,//loop模式：（就是可以一直循环下去，从最后一个自然的过渡到第一个，不会出现跳动）会在原本slide前后复制若干个slide(默认一个)并在合适的时候切换，让Swiper看起来是循环的。 loop模式在与free模式同用时会产生抖动，因为free模式下没有复制slide的时间点
});
/*如果只有一个slide就销毁swiper，假如只有一个图片，则不显示下面的圆点*/
if(swiper.slides.length<=3){
    swiper.destroy();
}

$('#swiper2 .swiper-slide').css({width:'156px'});
$('#swiper2 .swiper-slide:last').css({marginRight:'78px'});

	/*轮播*/
	var swiper2 = new Swiper('#swiper2', {
	    // pagination: {
	    //     el: '#swiper2 .swiper-pagination',
	    // },
	    slidesPerView : 2.5,
	    slidesPerGroup:1,//在carousel mode下定义slides的数量多少为一组。(同时滑动一下会滑动几个图片)
	    spaceBetween : 8,
	});
