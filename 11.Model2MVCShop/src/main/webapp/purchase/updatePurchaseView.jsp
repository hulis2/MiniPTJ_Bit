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
	
<title>구매정보 수정</title>

<script type="text/javascript">

	function fncAddProduct(){
		
		$("form").attr("method","POST").attr("action","/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
	}
	
	$(function() {
	
		 $("#divyDate").datepicker({
			 dateFormat: 'yy-mm-dd'
		});
	 
		$("a[href='#']").on("click", function() {
			history.go(-1);
		});
	
		$("button").on("click", function() {
			fncAddProduct();
		});
	});
	
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
	<div class="page-header text-center">
	    <h3 class=" text-info">구매정보수정</h3>
	    <h5 class="text-muted">구매정보를 <strong class="text-danger">수정</strong>해 주세요.</h5>
	</div>
	
	<form class="form-horizontal">
	
		<div class="form-group">
			<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
			<div class="col-sm-4">
		  		<input type="text" class="form-control" value="${purchase.buyer.userId}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
			<div class="col-sm-2">
		  		<select class="form-control" id="paymentOption" name="paymentOption" >
		  		<option value="1" ${purchase.paymentOption == '1' ? "selected" : ""}>현금구매</option>
				<option value="2" ${purchase.paymentOption == '2' ? "selected" : ""}>신용구매</option>
			</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
			<div class="col-sm-4">
		  		<input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
			<div class="col-sm-2">
		  		<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}">
		  	</div>
		</div>
		
		<div class="form-group">
			<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}">
		  	</div>
		</div>
		
		<div class="form-group">
			<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate}">
		  	</div>
		</div>
		
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
		    </div>
		</div>	
		
		<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		
	</form>
	
</div>
</body>
</html>