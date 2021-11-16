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

<title>��ǰ����ȸ</title>

<script type="text/javascript">

	$(function() {
		
		$("button:contains('����')").on("click", function() {
			self.location="/purchase/addPurchaseView?prod_no=${product.prodNo}";
		});
		
		$("button:contains('����')").on("click", function() {
			history.go(-1);
		});
		
	});

</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<div class="page-header text-center">
		<h3 class="text-info">��ǰ����ȸ</h3>
	</div>

	<form class="form-horizontal form-center">
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${product.fileName}"></div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>			
		</div>
		
		<div class="form-group">
			<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>			
		</div>
		
		<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  			<c:if test="${user.role eq 'user'}">
	  			<button type="button" class="btn btn-primary">����</button>
	  			</c:if>
	  			<button type="button" class="btn btn-primary">����</button>
	  		</div>
	  		
		</div>

</form>
</div>
</body>
</html>