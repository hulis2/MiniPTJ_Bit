package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;



//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
	private static final String FILE_SERVER_PATH = "C:\\Users\\hulis\\git\\repository11\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles";
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	//@Value("#{commonProperties['pageUnit']}")
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	//@Value("#{commonProperties['pageSize']}")
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, Model model, MultipartFile file ) throws Exception {

		System.out.println("/product/addProduct : POST");
		
		if(!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
		}
		
		
		String manuDate = product.getManuDate().replace("-","");
		
				
		product.setManuDate(manuDate);
		product.setFileName(file.getOriginalFilename());
		
		//Business Logic
		productService.addProduct(product);
		
		System.out.println(product);
		
		model.addAttribute("product", product);
				
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo ,@RequestParam("menu") String menu, Model model,
											HttpServletRequest request,	HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		Cookie[] cookies = request.getCookies();
	      
		String value="";
	      
		for (int i = 0; i < cookies.length; i++) { 
			Cookie cookie = cookies[i]; 
	       	  if (cookie.getName().equals("history")) { 
	    		  value = cookie.getValue(); 
	    		  System.out.println(cookie.getValue());
	    	  } 
	      }
	      value += request.getParameter("prodNo");
	      
	      System.out.println("cookie value�� Ȯ��"+value);
	      
	      Cookie cookie = new Cookie("history",value+",");
	   	      
	      response.addCookie(cookie);
	      
		// Model �� View ����
		model.addAttribute("product", product);
		
		if(menu.equals("manage")){
			return "forward:/product/updateProduct";
		}else {
			return "forward:/product/getProduct.jsp";
		}
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model �� View ����
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, Model model) throws Exception{

		System.out.println("/product/updateProduct : POST");
		
		String manuDate = product.getManuDate().replace("-","");
		product.setManuDate(manuDate);
		//Business Logic
		productService.updateProduct(product);
		
		product = productService.getProduct(product.getProdNo());
		
		model.addAttribute("product", product);
						
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model, HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		System.out.println(search);
						
		return "forward:/product/listProduct.jsp";
	}
}