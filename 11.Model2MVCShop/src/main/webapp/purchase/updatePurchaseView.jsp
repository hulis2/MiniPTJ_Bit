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
	
<title>�������� ����</title>

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
	    <h3 class=" text-info">������������</h3>
	    <h5 class="text-muted">���������� <strong class="text-danger">����</strong>�� �ּ���.</h5>
	</div>
	
	<form class="form-horizontal">
	
		<div class="form-group">
			<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
			<div class="col-sm-4">
		  		<input type="text" class="form-control" value="${purchase.buyer.userId}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
			<div class="col-sm-2">
		  		<select class="form-control" id="paymentOption" name="paymentOption" >
		  		<option value="1" ${purchase.paymentOption == '1' ? "selected" : ""}>���ݱ���</option>
				<option value="2" ${purchase.paymentOption == '2' ? "selected" : ""}>�ſ뱸��</option>
			</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
			<div class="col-sm-4">
		  		<input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
			<div class="col-sm-2">
		  		<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}">
		  	</div>
		</div>
		
		<div class="form-group">
			<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}">
		  	</div>
		</div>
		
		<div class="form-group">
			<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate}">
		  	</div>
		</div>
		
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >����</button>
			  <a class="btn btn-primary btn" href="#" role="button">���</a>
		    </div>
		</div>	
		
		<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		
	</form>
	
</div>
</body>
</html>