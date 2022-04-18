console.log("Reply Module........");

var replyService = (function() {

	function add(board, callback, error) {
		console.log("add reply...............");

		$.ajax({
			type : 'post',
			url : '/board/register',
			data : JSON.stringify(board),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				alert(result);
				if (callback) {
					callback(result);
					
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}

	function getList(busi_num, callback, error) {

		var busi_num = busi_num;

		$.getJSON("/replies/pages/" + busi_num + "/" + ".json",
				function(data) {
					alert(data);
					if (callback) {
						callback(data);
						
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	

//	function getList(param, callback, error) {

//	    var bno = param.bno;
//	    var page = param.page || 1;
	    
//	    $.getJSON("/replies/pages/" + bno + "/" + page + ".json",
//	        function(data) {
	    	
//	          if (callback) {
	            //callback(data); // 댓글 목록만 가져오는 경우 
//	            callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
//	          }
//	        }).fail(function(xhr, status, err) {
//	      if (error) {
//	        error();
//	      }
//	    });
//	  }

	
	function remove(busi_num, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/board/' + busi_num,
			success : function(deleteResult, status, xhr) {
				alert(deleteResult);
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	function update(board, callback, error) {

		console.log("busi_num: " + board.busi_num);

		$.ajax({
			type : 'put',
			url : '/replies/' + board.busi_num,
			data : JSON.stringify(board),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				alert(result);
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

//	function get(busi_num, callback, error) {

//		$.get("/replies/" + busi_num + ".json", function(result) {

//			if (callback) {
//				callback(result);
//			}

//		}).fail(function(xhr, status, err) {
//					if (error) {
//				error();
//			}
//		});
//	}

	function displayTime(timeValue) {

		var today = new Date();

		var gap = today.getTime() - timeValue;

		var dateObj = new Date(timeValue);
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	};

	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};

})();
