/** 今日预约提醒 */
var totalnum = 0, str = '';
$("#todayPrepareList").empty();
<prepare-rows>
totalnum++;
str += '<tr>';
str += '<td>'+totalnum+'</td>';
str += '<td><img src="${def:context}/js/project/fitness/image/SVG/50X50.svg" /></td>';
str += '<td class="color-1">${fld:name@js}</td>';
str += '<td>${fld:contactphone@js}</td>>';
str += '<td>${fld:nexttime@yyyy-MM-dd HH:mm:ss}</td>';
str += '<td>${fld:remark@js}</td>';
str += '</tr>';
$("#todayPrepareList").append(str);
</prepare-rows>
$("#todayPrepareNum").text(totalnum);

/** 今日预约到访 */
totalnum = 0, str = '';
$("#prepareVisitList").empty();
<prepare-visit-rows>
totalnum++;
str = '<article class="rank">';
str += '<span class="rank">'+totalnum+'</span>';
str += '<img src="${def:context}/js/project/fitness/image/SVG/50X50.svg" />';
str += '<span class="name">${fld:name@js}</span>';
str += '<span class="count">${fld:contactphone@js}</span>';
str += '</article>';
$("#prepareVisitList").append(str);
</prepare-visit-rows>
$("#prepareVisitNum").text(totalnum);
