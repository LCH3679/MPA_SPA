<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

     <div class="panel-heading">Board Read</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        		<div class="form-group">
            	사업자 번호  : <input type="text" name='busi_num' value='<c:out value="${board.busi_num}"/>'> 약칭 : <input type="text" name='sshort' value='<c:out value="${board.sshort}"/>'><br>
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
            	홈페이지 : <input type="text" name='homepage' size="40" value='<c:out value="${board.addr2}"/>'> 
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
      			 국가  : <input type="text" >
            	</div> 
            	<div class="form-group">
            	특수 관계자 : <input type="checkbox" name="special_relation" value='<c:out value="${board.special_relation}"/>' checked> 
				거래 중지 : <input type="checkbox" name="trade_stop" value='<c:out value="${board.trade_stop}"/>' checked> 
            	</div>
            	<div class="form-group">
            	계약기간: <input type="date" value="2001-01-01" > ~ <input type="date" value="2001-12-31" >
            	</div>
            	<div class="form-group">
            	등록정보: <input type="text" name="regi_info_man" value='<c:out value="${board.regi_info_man}"/>' > <input type="text" name="regi_info_date" value='<c:out value="${board.regi_info_date}"/>'>  변경정보 : <input type="text" name="mod_info_man" value='<c:out value="${board.mod_info_man}"/>'> <input type="text" name="mod_info_date" value='<c:out value="${board.mod_info_date}"/>'> 
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
            </div>
		</div>
	</div>
</div>
<%-- 		<button data-oper='modify' class="btn btn-default">
        <a href="/board/modify?bno=<c:out value="${board.bno}"/>">Modify</a></button>
        <button data-oper='list' class="btn btn-info">
        <a href="/board/list">List</a></button> --%>


<button data-oper='modify' class="btn btn-default">Modify</button>
<button data-oper='list' class="btn btn-info">List</button>

<%-- <form id='operForm' action="/boad/modify" method="get">
  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
</form> --%>


<form id='operForm' action="/boad/modify" method="get">
  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
</form>



      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->

<script type="text/javascript">
$(document).ready(function() {
  
  var operForm = $("#operForm"); 
  
  $("button[data-oper='modify']").on("click", function(e){
    
    operForm.attr("action","/board/modify").submit();
    
  });
  
    
  $("button[data-oper='list']").on("click", function(e){
    
    operForm.find("#busi_num").remove();
    operForm.attr("action","/board/list")
    operForm.submit();
    
  });  
});
</script>


<%@include file="../includes/footer.jsp"%>
