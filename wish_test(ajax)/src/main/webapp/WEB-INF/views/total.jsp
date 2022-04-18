<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=post_num]").val(data.zonecode);
           $("[name=addr1]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}

function search(){
	searchForm.submit();
}

</script>



<style>
.list {
	position:absolute;
	float: left;
	height: 675.8px;
	border: 1px solid black;
}

.total{
	position:relative;
	left:350px;
	border: 1px solid black;
	float: left;
}
</style>
</head>
<body>
	<div class="content" style="width: 100%">
		<div class="list" >
			<div class="form-group">
				<form name='searchForm' action="" method='get'
					style="margin: 20px;">
					<div class="form-group">
						사업자번호 : <input type="text" id="busi_num" name="busi_num1"><br>
					</div>
					<div class="form-group">
						거래처명 : <input type="text" id="custom" name="custom1">
						<input type="button" value="조회" onclick="search()">
						<!-- <button id='SearchBtn' type="button" class="btn btn-danger">조회</button> -->
					</div>
				</form>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>사업자 번호</th>
								<th>거래처명</th>
							</tr>
						</thead>
						
						
						<tbody id="good">
        				
        				</tbody>
						
						<%-- <tr>
							<td><c:out value="${list.busi_num}" /></td>
							<td><c:out value="${list.custom}" /></td>
							<td><a href='/board/modify?busi_num=<c:out value="${list.busi_num}"/>'>
									<a class='move' href='<c:out value="${board.busi_num}"/>'>
									<c:out value="${list.custom}" />
							</a></td>
						</tr>  --%>
					
					</table>
				</div>
			</div>
		</div>

		<div class="total">
			<!-- /.panel-heading -->
			<form>
			<button type="reset">초기화</button>
       		<button id='RegisterBtn' type="button" class="btn btn-danger">등록</button>
        	<button id='ModifyBtn' type="button" class="btn btn-primary">수정</button>
        	<button id='DeleteBtn' type="button" class="btn btn-default">삭제</button>
			<div class="panel-body">
				<div class="form-group">
					사업자 번호 : <input type="text" id="busi_num" name='busi_num' 
						value='<c:out value="${board.busi_num}"/>'> 
					약칭 : <input type="text" id="sshort" name='sshort' value='<c:out 
						value="${board.sshort}"/>'><br>
				</div>
				<div class="form-group">
					거 래 처 명 : <input type="text" id="custom" name='custom' size="30"
						value='<c:out value="${board.custom}"/>'><br>
				</div>
				<div class="form-group">
					대표자 : <input type="text" id="ceo" name='ceo'
						value='<c:out value="${board.ceo}"/>'> 
					담당자 : <input type="text" id="charge_person" name='charge_person'
						value='<c:out value="${board.charge_person}"/>'>
				</div>
				<div class="form-group">
					업 태 : <input type="text" id="busi_condition" name='busi_condition'
						value='<c:out value="${board.busi_condition}"/>'> 
					종 목 : <input type="text" id="item" name='item' 
						value='<c:out value="${board.item}"/>'>
				</div>
				<div class="form-group">
					우편번호 : <input type="text" id="post_num" name="post_num" size="5"
						value='<c:out value="${board.post_num}"/>'> 
						<input type="button" value="검색" onclick="execPostCode()"> 
						주소1 : <input type="text" id="addr1" name="addr1" size="30"
						value='<c:out value="${board.addr1}"/>'><br>
				</div>
				<div class="form-group">
					주소2 : <input type="text" id="addr2" name="addr2" size="50"
						value='<c:out value="${board.addr2}"/>'><br>
				</div>
				<div class="form-group">
					전화번호 : <input type="text"  id="tel" name='tel'
						value='<c:out value="${board.tel}"/>'> 
					팩스번호: <input type="text" id="fax" name='fax' 
						value='<c:out value="${board.fax}"/>'>
				</div>
				<div class="form-group">
					홈페이지 : <input type="text" id="homepage" name='homepage' size="40"
						value='<c:out value="${board.addr2}"/>'>
				</div>
				<div class="form-group">
					법인여부 : 
					<input type="radio" name="co_yn" value="Y" checked> 법인 
					<input type="radio" name="co_yn" value='<c:out value="${board.co_yn}"/>'> 개인 &nbsp;&nbsp;&nbsp; 
					해외 여부 : 
					<input type="radio" name="foreign_yn" value="Y" checked> 국내 
					<input type="radio" name="foreign_yn" value='<c:out value="${board.foreign_yn}"/>'  > 해외
				</div>
				<div class="form-group">
					과세 구분 : <select name="tax_yn">
						<option value="">과세/면세</option>
						<option value='<c:out value="${board.tax_yn}"/>'>과세</option>
						<option value='<c:out value="${board.tax_yn}"/>'>면세</option>
					</select>
					 국가  : <input type="text" name=country_eng size="3" value='<c:out value="${board.country_eng}"/>'> 
					<input type="text" name=country_kor size="12" value='<c:out value="${board.country_kor}"/>'>
					<input type=button value="검색" onclick="" style="margin-left: 5px;">
					 
				</div>
				<div class="form-group">
					특수 관계자 : <input type="checkbox" id="special_relation" name="special_relation"
						value='<c:out value="Y"/>' checked>
					거래 중지 : <input type="checkbox" id="trade_stop" name="trade_stop"
						value='<c:out value="Y"/>' checked>
				</div>
				<div class="form-group">
					계약기간: <input type="date" value="2001-01-01"> ~ <input
						type="date" value="2001-12-31">
				</div>
				<div class="form-group">
					등록정보: <input type="text" name="regi_info_man" value='<c:out value="${board.regi_info_man}"/>' size="3" > <input type="text" name="regi_info_date" value='<c:out value="${board.regi_info_date}"/>'>  변경정보 : <input type="text" name="mod_info_man" value='<c:out value="${board.mod_info_man}"/>'size="3"> <input type="text" name="mod_info_date" value='<c:out value="${board.mod_info_date}"/>'>
				</div>
				<div class="form-group">
					거래처 계좌정보
					<table border='1'>
						<tr>
							<th>사무소</th>
							<th>거래은행</th>
							<th>계좌번호</th>
						</tr>
						<tr>
							<td><input type="text" id="factory" name="factory"
								value='<c:out value="${board.factory}"/>'></td>
							<td><input type="text" id="trade_bank" name="trade_bank"
								value='<c:out value="${board.trade_bank}"/>'></td>
							<td><input type="text" id="account_num" name="account_num"
								value='<c:out value="${board.account_num}"/>'></td>
						</tr>
					</table>
					
				</div>
			</div>
			</form>
		</div>
	</div>


<script type="text/javascript">
$(document).ready(function() {
	/* $("#SearchBtn").on("click", function(e){
		
	}); */
	
	showList();
	
	function showList(){
	
		 $.ajax({
		    url: "/board/pages/",
		    type: "get",
		    dataType: "json",
		    async: false,
		    success: function (data) {
		    	/* var str = JSON.stringify(data);
		    	alert(str) */
				$.each(data, function(index, item) {
					$("#good").append("<tr>"+"<td data-busi_num='"+item.busi_num+"'>"+item.busi_num +"</td>"+"<td>"+item.custom +"</td>"+"</tr>");
				});
			},
			error : function() {
				alert('error');			
			}
		 });
	}
	
	
  $("#RegisterBtn").on("click", function(e){
	  	var busi_num = $('input[name=busi_num]').val();
	  	var custom = $('input[name=custom]').val(); 
	  	var sshort = $('input[name=sshort]').val(); 
	  	var ceo = $('input[name=ceo]').val(); 
	  	var charge_person = $('input[name=charge_person]').val(); 
	  	var busi_condition = $('input[name=busi_condition]').val(); 
	  	var item = $('input[name=item]').val();
	  	var post_num = $('input[name=post_num]').val();
	  	var addr1 = $('input[name=addr1]').val(); 
	  	var addr2 = $('input[name=addr2]').val(); 
	  	var tel = $('input[name=tel]').val(); 
	  	var fax = $('input[name=fax]').val(); 
	  	var homepage = $('input[name=homepage]').val(); 
	  	var co_yn = $('input[name=co_yn]').val(); 
	  	var foreign_yn = $('input[name=foreign_yn]').val();
	  	var special_relation = $('input[name=special_relation]').val(); 
	  	var trade_stop = $('input[name=trade_stop]').val(); 
	  	var regi_info_man = $('input[name=regi_info_man]').val();
	  	var regi_info_date = $('input[name=regi_info_date]').val(); 
	  	var mod_info_man = $('input[name=mod_info_man]').val(); 
	  	var mod_info_date = $('input[name=mod_info_date]').val(); 
	  	var factory = $('input[name=factory]').val(); 
	  	var trade_bank = $('input[name=trade_bank]').val(); 
	  	var account_num = $('input[name=account_num]').val();
	  	
	    var member = { "busi_num":busi_num,	
	    			   "custom":custom,
	    			   "sshort":sshort,
	    			   "ceo":ceo,
	    			   "charge_person":charge_person,
	    			   "busi_condition":busi_condition,
	    			   "item":item,
	    			   "post_num":post_num,
	    			   "addr1":addr1,
	    			   "addr2":addr2,
	    			   "tel":tel,
	    			   "fax":fax,
	    			   "homepage":homepage,
	    			   "co_yn":co_yn,
	    			   "foreign_yn":foreign_yn,
	    			   "tax_yn":"Y",
	    			   "country_kor":"대한민국",
	    			   "country_eng":"KOR",
	    			   "special_relation":special_relation,
	    			   "trade_stop":trade_stop,
	    			   "regi_info_man":regi_info_man,
	    			   "regi_info_date":regi_info_date,
	    			   "mod_info_man":mod_info_man,
	    			   "mod_info_date":mod_info_date,
	    			   "factory":factory,
	    			   "trade_bank":trade_bank,
	    			   "account_num":account_num
	    			   };
		$.ajax({
	        type:"post",
	        url:"/board/register.do",
	        contentType: "application/json",
	        data :JSON.stringify(member),
	     success:function (data,textStatus){
	    	 alert(data);
	     },
	     error:function(data,textStatus){
	        alert("실패했습니다.");
	     },
	     complete:function(data,textStatus){
	     }
	  });
  });
  
 	$("#good").on("click", "td", function(e){
      
      var busi_num =$.trim($(this).data("busi_num"));
      
      var URL = "/board/"+busi_num+".json";
      
      
      $.ajax({
		    url: URL,
		    type: "get",
		    dataType: "json",
		    async: false,
		    success: function (data) {
		    	$('input[name=busi_num]').attr("value", data.busi_num);
		    	$('input[name=custom]').attr("value", data.custom);
		    	$('input[name=sshort]').attr("value", data.sshort);
		    	$('input[name=ceo]').attr("value", data.ceo);
		    	$('input[name=charge_person]').attr("value", data.charge_person);
		    	$('input[name=busi_condition]').attr("value", data.busi_condition);
		    	$('input[name=item]').attr("value", data.item);
		    	$('input[name=post_num]').attr("value", data.post_num);
		    	$('input[name=addr1]').attr("value", data.addr1);
		    	$('input[name=addr2]').attr("value", data.addr2);
		    	$('input[name=tel]').attr("value", data.tel);
		    	$('input[name=fax]').attr("value", data.fax);
		    	$('input[name=homepage]').attr("value", data.homepage);
		    	$('input[name=co_yn]').attr("value", data.co_yn);
		    	$('input[name=foreign_yn]').attr("value", data.foreign_yn);
		    	$('input[name=tax_yn]').attr("value", data.tax_yn);
		    	$('input[name=special_relation]').attr("value", data.special_relation);
		    	$('input[name=trade_stop]').attr("value", data.trade_stop);
		    	$('input[name=regi_info_man]').attr("value", data.regi_info_man);
		    	$('input[name=regi_info_date]').attr("value", data.regi_info_date);
		    	$('input[name=mod_info_man]').attr("value", data.mod_info_man);
		    	$('input[name=factory]').attr("value", data.factory);
		    	$('input[name=trade_bank]').attr("value", data.trade_bank);
		    	$('input[name=account_num]').attr("value", data.account_num);

		    
			},
			error : function() {
				alert('error');			
			}
		 });

    });
 	
  $("#ModifyBtn").on("click", function(e){
	  
	  	var busi_num = $.trim($('input[name=busi_num]').val());  
	  	var custom = $('input[name=custom]').val(); 
	  	var sshort = $('input[name=sshort]').val(); 
	  	var ceo = $('input[name=ceo]').val(); 
	  	var charge_person = $('input[name=charge_person]').val(); 
	  	var busi_condition = $('input[name=busi_condition]').val(); 
	  	var item = $('input[name=item]').val();
	  	var post_num = $('input[name=post_num]').val();
	  	var addr1 = $('input[name=addr1]').val(); 
	  	var addr2 = $('input[name=addr2]').val(); 
	  	var tel = $('input[name=tel]').val(); 
	  	var fax = $('input[name=fax]').val(); 
	  	var homepage = $('input[name=homepage]').val(); 
	  	var co_yn = $('input[name=co_yn]').val(); 
	  	var foreign_yn = $('input[name=foreign_yn]').val();
	  	var special_relation = $('input[name=special_relation]').val(); 
	  	var trade_stop = $('input[name=trade_stop]').val(); 
	  	var regi_info_man = $('input[name=regi_info_man]').val();
	  	var regi_info_date = $('input[name=regi_info_date]').val(); 
	  	var mod_info_man = $('input[name=mod_info_man]').val(); 
	  	var mod_info_date = $('input[name=mod_info_date]').val(); 
	  	var factory = $('input[name=factory]').val(); 
	  	var trade_bank = $('input[name=trade_bank]').val(); 
	  	var account_num = $('input[name=account_num]').val();
	  	
	    var good = {   "custom":custom,
	    			   "sshort":sshort,
	    			   "ceo":ceo,
	    			   "charge_person":charge_person,
	    			   "busi_condition":busi_condition,
	    			   "item":item,
	    			   "post_num":post_num,
	    			   "addr1":addr1,
	    			   "addr2":addr2,
	    			   "tel":tel,
	    			   "fax":fax,
	    			   "homepage":homepage,
	    			   "co_yn":co_yn,
	    			   "foreign_yn":foreign_yn,
	    			   "tax_yn":"Y",
	    			   "country_kor":"대한민국",
	    			   "country_eng":"KOR",
	    			   "special_relation":special_relation,
	    			   "trade_stop":trade_stop,
	    			   "regi_info_man":regi_info_man,
	    			   "regi_info_date":regi_info_date,
	    			   "mod_info_man":mod_info_man,
	    			   "mod_info_date":mod_info_date,
	    			   "factory":factory,
	    			   "trade_bank":trade_bank,
	    			   "account_num":account_num
	    			   };
	    
	    
	    $.ajax({
	        type:'put',
	        url:'/board/' + busi_num,
	        contentType : "application/json; charset=utf-8",
	        data :JSON.stringify(good),
	     success:function (data,textStatus){
	    	 alert(data);
	     },
	     error:function(data,textStatus){
	        alert("실패했습니다.");
	     },
	     complete:function(data,textStatus){
	     }
	  });
  });
  
  $("#DeleteBtn").on("click", function(e){
	  
	  var busi_num = $.trim($('input[name=busi_num]').val());
	  
	  
	  $.ajax({
	        type:'delete',
	        url:'/board/'+ busi_num,
	     success:function (data,textStatus){
	    	 alert(data);
	     },
	     error:function(data,textStatus){
	        alert("에러가 발생했습니다.");
	     },
	     complete:function(data,textStatus){
	     }
	  }); 
  });  
});
</script>
</body>
</html>

