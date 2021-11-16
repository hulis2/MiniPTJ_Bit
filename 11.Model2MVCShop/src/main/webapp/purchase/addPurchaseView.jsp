<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> 
	<style>
	  body {
	      padding-top : 100px;
	  }
	</style>

	<title>상품 구매</title>

	<script type="text/javascript">

	function fncAddPurchase() {
		$("form").attr("method","POST").attr("action","/purchase/addPurchase").submit();
	}
	
	$(function() {
		
	    $("#divyDate").datepicker({
	        dateFormat: 'yy-mm-dd' 
	    });      
	    
	    $('#divyDate').datepicker('setDate', 'today');            
				
		$("a[href='#' ]").on("click", function() {
			$("form")[0].reset();
		});
		
		$("button").on("click", function() {
			fncAddPurchase();
		});
	});
	
	</script>
</head>

<body>
	
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-center">
			<h3 class=" text-info">상품 구매</h3>
			<h5 class="text-muted">구매해 주셔서 <strong class="text-danger">감사</strong>합니다.</h5>
		</div>
	
		<form class="form-horizontal">
		
			<div class="form-group">
				<label for="purchaseProd" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="purchaseProd" name="purchaseProd" value="${product.prodNo}" readonly="readonly"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" value="${product.prodName}" readonly="readonly"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" value="${product.prodDetail}" readonly="readonly"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" value="${product.manuDate}" readonly="readonly"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" value="${product.price}" readonly="readonly"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" value="${product.regDate}" readonly="readonly">
				</div>
			</div>
			
			<div class="form-group">
				<label for="buyer" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="buyer" name="buyer" value="${user.userId}" readonly="readonly">
				</div>
			</div>
			
			<div class="form-group">
				<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
				<div class="col-sm-4 ">
					<select class="form-control" id="paymentOption" name="paymentOption">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}"> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="구매요청사항을 입력해주세요."> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="divyDate" name="divyDate"/> 
				</div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >구매</button>
				  <a class="btn btn-primary btn" href="#" role="button">취소</a>
			    </div>
		    </div>	
		    		
		</form>
		
	</div>
	
</body>
</html>