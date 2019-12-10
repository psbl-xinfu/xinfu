var str=""
	str+='<section>'
	str+='<ul class="list-ul">'
        	<list>
				str+='<li class="list-li">'
		        	str+=' <div class="list">'
		        	str+='        <img src="'+contextPath+'/images/icon_head.png" class="touxiangpic fl">'
		        		
		            		str+=' <div class="content fl" " onclick="getinfo(\'${fld:the_code}\')">'
		            			str+='<p class="name" style="width:120%;"><label style="width:40%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;" title="${fld:the_name}">${fld:the_name}</label><span>${fld:i_sex}&ensp;${fld:vc_mobile}</span></p>'
		            	        	str+=' <span class="thespan">${fld:position}</span><p class="time">最近跟进：${fld:created}</p>'
		        	str+='   </div>'
		        	str+=' <a href="tel:${fld:vc_mobile}"> <img src="'+contextPath+'/js/project/fitness/wx/image/tel.png" class="telpic fr"></a>'
		        	str+=' </div>'
		        	str+='<div class="thebtn" id="thecomm" onclick="getcomm(\'${fld:the_code}\')">跟进</div>'
		        str+='</li>'		
	        	</list>
			str+='<ul>'
		str+='</section>'
        	$('.myziyuanlistbody').html(str);
        	
        	 var open = null;//open初始化，判断是否是已展开元素
             var list = document.getElementsByClassName("list-li");//list获取所有的待展开框
             for(var i = 0;i < list.length; i++){
               var x,y,X,Y,moveX,moveY;
               list[i].addEventListener('touchstart',function(e){
                 /*获取最初的触摸位置*/
                 x = e.changedTouches[0].pageX;
                 y = e.changedTouches[0].pageY;
                 moveX = true;
                 moveY = true;
               });
               
               
               list[i].addEventListener('touchmove',function(e){
                 X = e.changedTouches[0].pageX;
                 Y = e.changedTouches[0].pageY;
                 
                 //左右滑动
                 if(moveX && Math.abs(X - x) - Math.abs(Y -y) > 0){
                   e.stopPropagation();//阻止冒泡事件
                   //右滑收起删除按钮
                   if(X - x > 12){
                     e.preventDefault();
                     this.classList.remove("moveleft");
                   }
                   //左滑显示删除按钮
                   if(x - X > 12){
                     e.preventDefault();
                     this.classList.add("moveleft");
                     open = this;//存入展开的li元素
                   }
                   moveY = false;//左右滑动时不执行上下滑动时的事件
                 }
                 
                 //上下滑动
                 if(moveY && Math.abs(X - x) - Math.abs(Y - y) < 0){
                   moveX = false;//上下滑动时不执行左右滑动时的事件
                 }
               });
               
               list[i].addEventListener('click',function(e){
                 //在已展开的元素中执行操作
                 if(open){
                   var obj = e.target;
                   var objli = e.target.closest(".list-li");
                   
                   //点击li元素里不是删除按钮的部分，li元素收起
                   if(obj.className != "thebtn"){
                       open.classList.remove("moveleft");
                   }/*else if(obj.className == "thebtn"){//点击删除按钮执行删除
                	   location.href="${def:context}/action/project/fitness/wx/mc/myziyuan/gustinfo/thecontact/from?guestcode="+$("#guestcode").val();
                   }*/
                 }
               });
               
             }
        	