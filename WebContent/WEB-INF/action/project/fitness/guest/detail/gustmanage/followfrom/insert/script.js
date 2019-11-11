ccms.dialog.notice("跟进成功!", 2000, function(){
				   		/* ccms.util.clearForm('addForm'); */
				   		parent.search.searchData(1);
				   		parent.parent.search.searchData(1);
				   		ccms.dialog.close();
					});

