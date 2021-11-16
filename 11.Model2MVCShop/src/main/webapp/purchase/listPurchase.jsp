<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
	<style>
	  body {
	      padding-top : 50px;
	  }
	</style>

<title>구매 목록조회</title>

<script type="text/javascript">

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
   		$("form").attr("method","POST").attr("action", "/purchase/listPurchase").submit();	
	}
	
	$(function() {
		
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
				
		$(".ct_list_pop:nth-child(2n+1)" ).css("background-color" , "ivory");
		
		$(".link").css("color", "blue");
		
		$(".ct_list_pop td:nth-child(1)").on("click", function() {
			var tranNo = $(this).data("tranno");
			self.location = "/purchase/getPurchase?tranNo="+tranNo;
		});
		
		$(".ct_list_pop td:nth-child(2)").on("click", function() {
			var buyer = $(this).data("buyer");
			self.location = "/user/getUser?userId="+buyer;
		});
		
		$(  "td:nth-child(7) > i"  ).on("click" , function() {
			var tranNo =  $(this).next().val();
			$.ajax( 
					{
						url : "/purchase/json/getPurchase/"+tranNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {

							var displayValue = "<h6>"
														+"상품번호  : "+JSONData.purchaseProd.prodNo+"<br/>"
														+"회 원 명  : "+JSONData.receiverName+"<br/>"
														+"전화 번호 : "+JSONData.receiverPhone+"<br/>"
														+"배송지 주소 : "+JSONData.divyAddr+"<br/>"
														+"요청 사항 : "+JSONData.divyRequest+"<br/>"
														+"</h6>";
							$("h6").remove();
							$( "#"+tranNo+"" ).html(displayValue);
						}
				});
					
		});
		
		$(".ct_list_pop td:nth-child(6)").on("click", function() {
			var tranNo = $(this).data("tranno");
			var tranCode = $(this).data("trancode");
			self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode="+tranCode;
		});
	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
		<div class="page-header text-info">
			 <h3>구매 목록조회</h3>
		</div> 
		
		<div class="row">
			<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    <div class="col-md-6 text-right">
		    	<form class="form-inline" name="detailForm">
		    		<div class="form-group">
		    		</div>
		    		<div class="form-group">
		    			<input type="hidden" id="currentPage" name="currentPage" value="0"/>
		    		</div>
		    	</form>
		    </div>
		</div>
	
	
	<table class="table table-hover table-striped" >
	   <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >회원ID</th>
            <th align="left">회원명</th>
            <th align="left">전화번호</th>
            <th align="left">배송현황</th>
            <th align="left">정보수정</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>
        
        <tbody>
        	<c:set var="i" value="0" />
			<c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
				<td align="center" title="Click : 구매정보 확인" id="getPurchase" data-traNno="${purchase.tranNo}">${ i }</td>
				<td align="left"  title="Click : 유저정보 확인" id="getUser" data-buyer="${user.userId}">
					${user.userId}
				</td>
				<td align="left">${purchase.receiverName}</td>
				<td align="left">${purchase.receiverPhone}</td>
				<c:choose>
					<c:when test="${purchase.tranCode == '0'}">
						<td align="left">
							구매완료
						</td>	
					</c:when>
					<c:when test="${purchase.tranCode == '1'}">
						<td align="left">
							배송중
						</td>	
					</c:when>				
					<c:otherwise>
						<td align="left">
							배송완료
						</td>	
					</c:otherwise>
				</c:choose>
				<td align="left" id="receive" data-tranNo="${purchase.tranNo}" data-tranCode="2">
					<c:if test="${purchase.tranCode == '1'}">
						물건도착
					</c:if>
				</td>	
				
				<td>
				<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}" ></i>
				<input type="hidden" value="${purchase.tranNo}">
				</td>
			</tr>
		</c:forEach>
	</tbody>		
	</table>
	</div>
		<jsp:include page="../common/pageNavigator_new.jsp"/>

</body>
</html>