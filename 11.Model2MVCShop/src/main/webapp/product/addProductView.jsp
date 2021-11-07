<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<html lang="ko">
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
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> 
	<style>
	  body {
	      padding-top : 100px;
	  }
	</style>
	
	<title>상품등록</title>
	
	<script type="text/javascript">
	
	function fncAddProduct(){
		//Form 유효성 검증
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
	
		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
	
		$("form").attr("method","POST").attr("action","/product/addProduct").submit();
		
	}
	
	$(function() {
		
	    $("#manuDate").datepicker({
	        dateFormat: 'yy-mm-dd' 
	    });      
	    
	    $('#manuDate').datepicker('setDate', 'today');            
				
		$("a[href='#' ]").on("click", function() {
			$("form")[0].reset();
		});
		
		$("button").on("click", function() {
			fncAddProduct();
		});
	});

</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
	
		<div class="page-header text-center">
			<h3 class=" text-info">판매상품 등록</h3>
			<h5 class="text-muted">판매상품의 <strong class="text-danger">정보를 입력</strong>해 주세요.</h5>
		</div>
		
		<form class="form-horizontal">
		
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상  품  명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명을 입력해주세요."> 
				</div>
			</div>
		
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품상세정보를 입력해주세요."> 
				</div>
			</div>
			
			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제 조 일 자</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="manuDate" name="manuDate"/>
				</div>
			</div>  

			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가     격</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="price" name="price" placeholder="가격을 입력해주세요.">
				</div>
				<div class="center">
					<label for="price" class="control-label">원</label>
				</div>
			</div>
			
			<div class="form-group">
				<label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상 품 이 미 지</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="fileName" name="fileName"> 
				</div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >등 &nbsp;록</button>
				  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
			    </div>
		    </div>		
		
		</form>
	</div>
</body>
</html>