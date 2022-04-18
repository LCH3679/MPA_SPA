<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

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

</script>


<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

     <div class="panel-heading">Board Modify</div>
     
      <!-- /.panel-heading -->
      <div class="panel-body">
      
      <form role="form" action="/board/modify" method="post">
      
        		<div class="form-group">
            	사업자 번호  : <input type="text" name='busi_num' value='<c:out value="${board.busi_num}"/>' readonly> 약칭 : <input type="text" name='sshort' value='<c:out value="${board.sshort}"/>'><br>
            	</div>
            	<div class="form-group">
            	거 래 처 명  : <input type="text" name='custom' size="30" value='<c:out value="${board.custom}"/>'><br>
            	</div> 
            	<div class="form-group">
            	대표자 : <input type="text" name='ceo' value='<c:out value="${board.ceo}"/>'> 담당자 : <input type="text" name='charge_person' value='<c:out value="${board.charge_person}"/>'> 
            	</div>
            	<div class="form-group">
            	업 태 : <input type="text" name='busi_condition' value='<c:out value="${board.busi_condition}"/>'> 종 목 : <input type="text" name='item' value='<c:out value="${board.item}"/>'> 
            	</div>
            	<div class="form-group">
         	 	우편번호 : <input type="text" name="post_num" size="5" value='<c:out value="${board.post_num}"/>'>
         	 	<input type="button" value="검색" onclick="execPostCode()" > 
         	 	주소1 : <input type="text" name="addr1" size="30" value='<c:out value="${board.addr1}"/>'><br>
				</div>
            	<div class="form-group">
            	주소2 : <input type="text" name="addr2" size="50" value='<c:out value="${board.addr2}"/>'><br>
            	</div>
            	<div class="form-group">
            	전화번호 : <input type="text" name='tel' value='<c:out value="${board.tel}"/>'> 팩스번호: <input type="text" name='fax' value='<c:out value="${board.fax}"/>'> 
            	</div>
            	<div class="form-group">
            	홈페이지 : <input type="text" name='homepage' size="40" value='<c:out value="${board.homepage}"/>'> 
            	</div>
            	<div class="form-group">
            	법인여부 : <input type="radio" name="co_yn" value='<c:out value="${board.co_yn}"/>' checked >법인  <input type="radio" name="co_yn" value='<c:out value="${board.co_yn}"/>'>개인   
            	&nbsp;&nbsp;&nbsp;
            	해외 여부 : <input type="radio" name="foreign_yn" value='<c:out value="${board.foreign_yn}"/>'>국내  <input type="radio" name="foreign_yn" value='<c:out value="${board.foreign_yn}"/>'checked>해외 
            	</div>
            	<div class="form-group">
            	과세 구분 : <select name="tax_yn">
  						<option value="">과세/면세</option>
  						<option value='<c:out value="${board.tax_yn}"/>'>과세</option>
  						<option value='<c:out value="${board.tax_yn}"/>'>면세</option>
				</select>
      			 국가  : <input type="text" name=country_eng size="3" value='<c:out value="${board.country_eng}"/>'> <input type="text" name=country_kor size="12" value='<c:out value="${board.country_kor}"/>'><input type=button value="검색" onclick="" style="margin-left: 5px;">
      			 </div>
            	<div class="form-group">
            	특수 관계자 : <input type="checkbox" name="special_relation" value='<c:out value="${board.special_relation}"/>' checked> 
				거래 중지 : <input type="checkbox" name="trade_stop" value='<c:out value="${board.trade_stop}"/>' checked> 
            	</div>
            	<div class="form-group">
            	계약기간: <input type="date" value="2001-01-01" > ~ <input type="date" value="2001-12-31" >
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
							<td><input type="text" name="factory" value='<c:out value="${board.factory}"/>'></td>
							<td><input type="text" name="trade_bank" value='<c:out value="${board.trade_bank}"/>'></td>
							<td><input type="text" name="account_num"value='<c:out value="${board.account_num}"/>'></td>
						</tr>
				</table>
            	</div>
            	<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
  				<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
				</form>
				</div>
            </div>
		</div>
	</div>

 

<script type="text/javascript">
$(document).ready(function() {


	  var formObj = $("form");

	  $('button').on("click", function(e){
	    
	    e.preventDefault(); 
	    
	    var operation = $(this).data("oper");
	    
	    console.log(operation);
	    
	    if(operation === 'remove'){
	      formObj.attr("action", "/board/remove");
	      
	    }else if(operation === 'list'){
	      //move to list
	      formObj.attr("action", "/board/list").attr("method","get");
	      
	      var pageNumTag = $("input[name='pageNum']").clone();
	      var amountTag = $("input[name='amount']").clone();
	      var keywordTag = $("input[name='keyword']").clone();
	      var typeTag = $("input[name='type']").clone();      
	      
	      formObj.empty();
	      
	      formObj.append(pageNumTag);
	      formObj.append(amountTag);
	      formObj.append(keywordTag);
	      formObj.append(typeTag);	       
	    }
	    
	    formObj.submit();
	  });
});
</script>
  




<%@include file="../includes/footer.jsp"%>
