<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>

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
	
<title>구매상세조회</title>

<script type="text/javascript">

	function fncAddProduct(){
		
		$("form").attr("method","POST").attr("action","/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
	}
	
	$(function() {
	
		$("#manuDate").datepicker({
			 dateFormat: 'yy-mm-dd'
		});
	 
		$("button:contains('확인')").on("click", function() {
				self.location="/purchase/listPurchase";
		});
		 
		$("button:contains('이전')").on("click", function() {
			history.go(-1);
		});	
		
	});
	
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
	<div class="page-header text-center">
	    <h3 class=" text-info">구매정보 수정결과</h3>
	    <h5 class="text-muted">구매정보수정에 <strong class="text-danger">성공</strong>하였습니다.</h5>
	</div>
	
	<form class="form-horizontal form-center">
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>물품번호</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>구매자아이디</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>구매방법</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.paymentOption == "1" ? "현금구매" : "신용구매"}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>구매자이름</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>구매자연락처</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>구매자주소</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>구매요청사항</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>배송희망일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>주문일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>			
		</div>
		
		<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">확인</button>
	  			<button type="button" class="btn btn-primary">이전</button>
	  		</div>
	  		
		</div>

</form>	
</div>
</body>
</html>