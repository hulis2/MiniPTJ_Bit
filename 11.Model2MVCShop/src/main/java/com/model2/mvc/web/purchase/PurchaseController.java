package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;



//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	//@Value("#{commonProperties['pageUnit']}")
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	//@Value("#{commonProperties['pageSize']}")
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase, Model model ) throws Exception {

		System.out.println("/purchase/addPurchase : POST");
		
		//Business Logic
		purchase.setTranCode("0");
		purchaseService.addPurchase(purchase);
				
		System.out.println(purchase);
		
		model.addAttribute("purchase", purchase);
				
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping(value="addPurchaseView", method=RequestMethod.GET)
	public String addPurchaseView( @RequestParam("prod_no") int prodNo, Model model ) throws Exception {

		System.out.println("/purchase/addPurchaseView : GET");
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
				
		System.out.println(product);
		
		model.addAttribute("product", product);
				
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase( @RequestParam("tranNo") int tranNo , Model model,
											HttpServletRequest request,	HttpServletResponse response) throws Exception {
		
		System.out.println("/purchase/getpurchase : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
				
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
		
	}
	
	@RequestMapping(value="updatePurchaseView", method=RequestMethod.GET)
	public String updatePurchaseView( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{

		System.out.println("/purchase/updatePurchaseView : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping(value="updatePurchase")
	public String updatePurchase( @ModelAttribute("purchase") Purchase purchase , @RequestParam("tranNo") int tranNo, 
											Model model, HttpServletRequest request) throws Exception{

		System.out.println("purchase/updatePurchase : GET/POST");
		//Business Logic
		purchase.setTranNo(tranNo);
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);
		
		model.addAttribute("purchase", purchase);
			
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode( @ModelAttribute("purchase") Purchase purchase , @RequestParam("tranNo") int tranNo, 
													@RequestParam("tranCode") String tranCode) throws Exception{

		System.out.println("/purchase/updateTranCode : GET");
		//Business Logic
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		return "redirect:/purchase/listPurchase";
	}
	
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd( @ModelAttribute("purchase") Purchase purchase , @RequestParam("prodNo") int prodNo, 
													@RequestParam("tranCode") String tranCode) throws Exception{

		System.out.println("/purchase/updateTranCodeByProd : GET");
		//Business Logic
		purchase = purchaseService.getPurchase2(prodNo);		
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		return "redirect:/product/listProduct?menu=manage";
	}
	
	@RequestMapping(value="listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET/POST");
		
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		String buyerId = user.getUserId();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
				
		return "forward:/purchase/listPurchase.jsp";
	}
}