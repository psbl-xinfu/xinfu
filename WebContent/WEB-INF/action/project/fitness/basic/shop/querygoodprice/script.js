
var gpstr = "<option value=''>全部商品</option>";
<rows>
	gpstr+="<option value='${fld:gptuid}'>${fld:goods_name@js}</option>";
</rows>
$("#goodsname").html(gpstr);

$("#goodsname").selectpicker("refresh");
$("#goodsname").selectpicker("render");

