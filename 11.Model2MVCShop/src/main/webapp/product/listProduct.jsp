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
	   
	  img {
		  width: 200px;
		  height: 200px;
	  }

	</style>

<title>��ǰ ����</title>

<script type="text/javascript">
	
	var loading = false; 
	var currentPage = 1;

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
	}

	  $(function() {
		    
		  /* $("#searchKeyword").autocomplete({
			  	
	        	 source : function( request, response ) {
	        		 alert("1234");
	        		 $.ajax({
							url : "/product/json/autoProduct/"+$("#searchCondition").val()+"/"+$("#searchKeyword").val() ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								var search = JSONData.search;
							    var list = JSONData.list;
							    var availableTags ="";
							    
								if($("#searchCondition").val() === "0"){
									alert("0000");
									for(var i=0; i< list.length; i++) {
										availableTags += list[i].prodNo+",";						
									}
								}else if($("#searchCondition").val() === "1"){
									alert("1111");
									for(var i=0; i< list.length; i++) {
										availableTags += list[i].prodName+",";						
									}
								}else{
									alert("2222");
									for(var i=0; i< list.length; i++) {
										availableTags += list[i].price+",";						
									}
								}
									
		                        	response(availableTags);
		                    
		               }
		            });
	        	 }
	         });  */
	 
		$(  ".image"  ).hover( function() {
			
			var prodNo =  $(this).data("prodno");
			
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

							var displayValue ="<h6>"
														+"��ǰ��ȣ  : "+JSONData.prodNo+"<br/>"
														+"�� ǰ ��  : "+JSONData.prodName+"<br/>"
														+"��ǰ������: "+JSONData.prodDetail+"<br/>"
														+"��������   : "+JSONData.manuDate+"<br/>"
														+"��   ��  : "+JSONData.price+"<br/>"
														+"</h6>";
							
							$(".image").attr('title',displayValue); 							
						
						}
				});
					
		});
	
		 $( "button:contains('�˻�')" ).on("click" , function() {
				fncGetList(1);
			});
		 
		 $("#searchKeyword").keypress(function(e) { 
			    if (e.keyCode == 13){
			    	fncGetList(1);
			    }    
			});
				
		$("body").on("click",".prod-btn", function() {
			self.location = "/product/getProduct?prodNo="+$(this).data("prodno")+"&menu="+$(this).data("menu");
		});
		
				
		$("body").on("click",".baesong", function() {
			self.location = "/purchase/updateTranCodeByProd?prodNo="+$(this).data("prodno")+"&tranCode="+$(this).data("protrancode");
		});
		
		$("img").tooltip({
			 content: function() {
			        return $(this).prop('title');
			 }
		 });
	 });
	 
		 $(function() {
					 
			 window.onscroll = function(e){ 
				 
				 if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
					
					currentPage++;
					loading = true; 
					
					$.ajax({
							url : "/product/json/listProduct/"+currentPage ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								$.each(JSONData, function(i, product) {
								
									var append_node ="";
									
									append_node += "<span>"
									append_node += "<span class='col-sm-6 col-md-3' >"
									append_node += "<div class='thumbnail'>"
								    append_node += "<div align='center' class='image' data-prodNo="+product.prodNo+">" 
									append_node += "<img src='/images/uploadFiles/"+product.fileName+"'" + "onerror=this.src='/images/others/no_image.jpg' alt='��ǰ�̹���' >"
									append_node += "</div>"
									append_node += "<div class='caption'>"
									append_node += "<h3>"+product.prodName+"</h3>"
									append_node += "</div>"
									append_node += "<span class='col-sm-6'>"
									append_node += product.price+"��"
									append_node += "</span>"
																		
										if("${user.role}" === "user" && "${param.menu}" === "search"){
											if(product.proTranCode == null ){
												 append_node += "<span class='col-sm-3'>"
												 append_node += "</span>"
												 append_node += "<span>"
												 append_node += "<a href='#' class='btn btn-primary prod-btn' role='button' data-prodNo='"+product.prodNo+"' data-menu='${param.menu}' >����</a>"
												 append_node += "</span>"
											}else if(product.proTranCode != null ){
												 append_node += "<span class='col-sm-3'>"
												 append_node += "</span>" 
												 append_node += "<span>"
											     append_node += "<input type=button class='btn btn-danger' value='ǰ��'/>"
											     append_node += "</span>"
											}
										}else if("${user.role}" === "admin" && "${param.menu}" === "manage"){
											if(product.proTranCode == null ){
												 append_node += "<span class='col-sm-3'>"
												 append_node += "</span>" 
												 append_node += "<span>"
												 append_node += "<a href='#' class='btn btn-primary prod-btn' role='button' data-prodNo='"+product.prodNo+"' data-menu='${param.menu}' >����</a>"
												 append_node += "</span>"
											}else if(product.proTranCode === "0" ){
												 append_node += "<span style='padding:5px'>"
												 append_node += "<a href='#' class='btn btn-primary prod-btn' role='button' data-prodNo='"+product.prodNo+"' data-menu='${param.menu}' >����</a>"
												 append_node += "</span>"
												 append_node += "<span>"
											     append_node += "<a href='###' class='btn btn-primary baesong' role='button' data-prodNo='"+product.prodNo+"' data-proTranCode='1' >���</a>"
											     append_node += "</span>"
											}else{
												 append_node += "<span class='col-sm-3'>"
												 append_node += "</span>"
												 append_node += "<span>"
												 append_node += "<input type=button class='btn btn-danger' value='ǰ��'/>"
												 append_node += "</span>"
											}
										}else{
											append_node += "<span class='col-sm-3'>"
											append_node += "</span>"
											append_node += "<span>"
											append_node += "<a href='#' class='btn btn-primary prod-btn' role='button' data-prodNo='"+product.prodNo+"' data-menu='${param.menu}' >Ȯ��</a>"
											append_node += "</span>"
										}
									
									append_node += "</div>"
									append_node += "</span>"
									append_node += "</span>"
																
									$(".list").append(append_node);
									
								});
							}				
					}); 
						loading = false;  
					}
				}
		 });
	
</script>
</head>
<body>
	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
		<div class="page-header text-info">
			 <h3>${!empty param.menu && param.menu=="manage" ? "��ǰ����" : "��ǰ��� ��ȸ"}</h3>
		</div>
		
		<div class="row">
			<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		
			<div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" id="searchCondition">
						<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���" autocomplete="off"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value="0"/>
				  
				</form>
	    	</div>
	</div>
	
	<c:forEach var="product" items="${list}">
		<c:choose>
			<c:when test="${user.role =='user' and param.menu =='search'}">
				<span>
  					<span class="col-sm-6 col-md-3" >
    					<div class="thumbnail">
    						<div title="" align="center" class="image" data-prodNo="${product.prodNo}">
      							<img src="/images/uploadFiles/${product.fileName}" onerror="this.src='/images/others/no_image.jpg'"  alt="��ǰ�̹���" >
      						</div>
      							<div class="caption">
        							<h3>${product.prodName}</h3>
        						</div>
        						<span class="col-sm-9">
        							${product.price}��
        						</span>
        						<c:choose>
        							<c:when test="${empty product.proTranCode}">
        								<span>
        									<a href="#" class="btn btn-primary prod-btn" role="button" data-prodNo="${product.prodNo}" data-menu="${param.menu}" >����</a>
        								</span>
        							</c:when>
        							<c:otherwise>
        								<span>
        									<input type=button class="btn btn-danger" value="ǰ��"/>
        								</span>
        							</c:otherwise>
        						</c:choose>
     					</div>
 					 </span>
				</span>
			</c:when>
			
			<c:when test="${user.role =='admin' and param.menu =='manage'}">
				<span>
  					<span class="col-sm-6 col-md-3" >
    					<div class="thumbnail">
    						<div title="" align="center" class="image" data-prodNo="${product.prodNo}">
      							<img src="/images/uploadFiles/${product.fileName}" onerror="this.src='/images/others/no_image.jpg'"  alt="��ǰ�̹���" >
      						</div>
      							<div class="caption">
        							<h3>${product.prodName}</h3>
        						</div>
        						<div>
        						<span class="col-sm-6">
        							${product.price}��
        						</span>
        						<c:choose>
        							<c:when test="${empty product.proTranCode}">
        								<span class="col-sm-3">
        								</span>
        								<span>
        									<a href="#" class="btn btn-primary prod-btn" role="button" data-prodNo="${product.prodNo}" data-menu="${param.menu}" >����</a>
        								</span>
        							</c:when>	
        							<c:when test="${product.proTranCode == 0}">
        								<span>
        									<a href="#" class="btn btn-primary" role="button" data-prodNo="${product.prodNo}" data-menu="${param.menu}" >����</a>
        								</span>	
        								<span>
        									<a href="###" class="btn btn-primary baesong" role="button" data-prodNo="${product.prodNo}" data-proTranCode="1" >���</a>
        								</span>
        							</c:when>
        							<c:otherwise>
        								<span class="col-sm-3">
        								</span>
        								<span >
        									<input type=button class="btn btn-danger" value="ǰ��"/>
        								</span>
        							</c:otherwise>
        						</c:choose>
        						</div>
     					</div>
 					 </span>
				</span>
			</c:when>
			
			<c:otherwise>
				<span>
  					<span class="col-sm-6 col-md-3" >
    					<div class="thumbnail">
    						<div title="" align="center" class="image" data-prodNo="${product.prodNo}">
      							<img src="/images/uploadFiles/${product.fileName}" onerror="this.src='/images/others/no_image.jpg'"  alt="��ǰ�̹���" >
      						</div>
      							<div class="caption">
        							<h3>${product.prodName}</h3>
        						</div>
        						<span class="col-sm-9">
        							${product.price}��
        						</span>
        						<span>
        							<a href="#" class="btn btn-primary prod-btn" role="button" data-prodNo="${product.prodNo}" data-menu="${param.menu}" >Ȯ��</a>
        						</span>
        				</div>
 					 </span>
				</span>
			</c:otherwise>
		</c:choose>
		
	
	</c:forEach>
<div class="list">
</div>
</div>

 	<%-- <jsp:include page="../common/pageNavigator_new.jsp"/> --%> 
</body>
</html>
