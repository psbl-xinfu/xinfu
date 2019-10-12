ccms.dialog.alert("修改成功！")
$('#modalAddnew1').modal('hide');
ccms.util.clearForm('addForm');
search.searchData(1);
$('#modalAddnew1').prop('scrollTop','0');