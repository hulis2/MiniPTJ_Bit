package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;



//==> ȸ������ Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public int addProduct( @RequestBody Product product ) throws Exception {

		System.out.println("/product/json/getProduct : POST");
		
		System.out.println("::"+product);
				
		return productService.addProduct(product);
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable String prodNo ) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");
		System.out.println(prodNo);
		
		return productService.getProduct(Integer.parseInt(prodNo));
	}
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST)
	public int updateProduct(@RequestBody Product product) throws Exception{
		
		System.out.println("/product/json/updateProduct : POST");
				 
		return productService.updateProduct(product);
	}
	
	@RequestMapping( value="json/autoProduct/{searchCondition}/{searchKeyword}", method=RequestMethod.GET)
	public Map autoProduct(@PathVariable String searchCondition, @PathVariable String searchKeyword, Search search) throws Exception{
		
		System.out.println("/product/json/listProduct : GET / POST");
		
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		
		Map<String , Object> map=productService.getProductList(search);
		map.put("search", search);
		
		System.out.println(search);
		
		return map;
	}
	
	@RequestMapping( value="json/listProduct/{currentPage}", method=RequestMethod.GET)
	public List listProduct(@PathVariable int currentPage, Search search) throws Exception{
		
		System.out.println("/product/json/listProduct : GET");
		
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		Map<String , Object> map=productService.getProductList(search);
	
		List<Product> list = (List<Product>) map.get("list");

		return list;
	}
	
}