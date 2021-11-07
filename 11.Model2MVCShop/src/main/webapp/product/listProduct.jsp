<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
	<style>
	  body {
	      padding-top : 50px;
	  }
	</style>

<title>상품 관리</title>

<script type="text/javascript">

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
	}

	$(function() {
				
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
				
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		$(".link").css("color", "blue");
		
		$(".link").on("click", function() {
			
			self.location = "/product/getProduct?prodNo="+$(this).attr("prodNo")+"&menu="+$(this).attr("menu");
		});
		
		$(  "td:nth-child(6) > i"  ).on("click" , function() {
			var prodNo =  $(this).next().val();
			$.ajax( 
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {

							var displayValue = "<h6>"
														+"상품번호  : "+JSONData.prodNo+"<br/>"
														+"상 품 명  : "+JSONData.prodName+"<br/>"
														+"상품상세정보: "+JSONData.prodDetail+"<br/>"
														+"제조일자   : "+JSONData.manuDate+"<br/>"
														+"가   격  : "+JSONData.price+"<br/>"
														+"</h6>";
							$("h6").remove();
							$( "#"+prodNo+"" ).html(displayValue);
						}
				});
					
	});
		
		
		$(".shipping").on("click", function() {
			self.location = "/purchase/updateTranCodeByProd?prodNo="+$(this).attr("prodNo")+"&tranCode="+$(this).attr("proTranCode");
		});

	});
</script>
</head>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
		<div class="page-header text-info">
			 <h3>${!empty param.menu && param.menu=="manage" ? "상품관리" : "상품목록 조회"}</h3>
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
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value="0"/>
				  
				</form>
	    	</div>
	</div>
	
	<table class="table table-hover table-striped" >
	   <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>
        
        <tbody>
        	<c:set var="i" value="0" />
			<c:forEach var="product" items="${list}">
				<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
				<td align="center">${ i }</td>
		
				
		<c:choose>
			<c:when test="${user.role =='user' and param.menu =='search'}">
				<c:choose>
					<c:when test="${empty product.proTranCode}">
					<td align="left"  title="Click : 상품정보 확인" class="link" name="user" prodNo="${product.prodNo}" menu="${param.menu}">
						${product.prodName}
					</td>
					</c:when>
					<c:otherwise>
					<td align="left">
						${product.prodName}
					</td>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:when test="${user.role =='admin' and param.menu =='manage'}">
				<c:choose>
					<c:when test="${empty product.proTranCode}">
					<td align="left" title="Click : 상품정보 수정" class="link" name="admin" prodNo="${product.prodNo}" menu="${param.menu}">
						${product.prodName}
					</td>
					</c:when>
					<c:otherwise>
					<td align="left">
						${product.prodName}
					</td>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
			<td align="left" title="Click : 상품정보 확인" class="link" name="otherwise" prodNo="${product.prodNo}" menu="${param.menu}">
				${product.prodName}
			</td>
			</c:otherwise>
		</c:choose>			
			
		
		<td align="left">${product.price}</td>
	
		<td align="left">${product.regDate}</td>
		
		
		<c:choose>
			<c:when test="${user.role == 'user' and param.menu == 'search'}">
			<td align="left">
				${empty product.proTranCode ? "판매중" : "재고없음" }
			</td>
			</c:when>
			<c:when test="${user.role == 'admin' and param.menu == 'manage'}">
				<c:choose>
					<c:when test="${empty product.proTranCode}">
					<td align="left">
						판매중
					</td>
					</c:when>
					<c:when test="${product.proTranCode==0}">
					<td align="left" class="shipping" prodNo = "${product.prodNo}" proTranCode="1">	
						구매완료 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 배송하기
					</td>
					</c:when>
					<c:otherwise>
					<td align="left">
						${product.proTranCode ==1 ? "배송중" : "재고없음" }
					</td>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
			<td align="left">
				${empty product.proTranCode ? "판매중" : "재고없음" }
			</td>
			</c:otherwise>
		</c:choose>
			
			<td>
				<i class="glyphicon glyphicon-ok" id= "${product.prodNo}" ></i>
				<input type="hidden" value="${product.prodNo}">
				
			</td>
		      
        </tr>
		</c:forEach>
	</tbody>
</table>

</div>
	<jsp:include page="../common/pageNavigator_new.jsp"/>
</body>
</html>
