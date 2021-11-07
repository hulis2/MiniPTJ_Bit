package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductDao;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDAO;
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDAO;
	
	
	public void setPurchaseDAO(PurchaseDao purchaseDAO) {
		this.purchaseDAO = purchaseDAO;
	}

	public void setProductDAO(ProductDao productDAO) {
		this.productDAO = productDAO;
	}

	public PurchaseServiceImpl(){
		System.out.println(this.getClass());
	}
	
	public int addPurchase(Purchase purchase) throws Exception {
		return purchaseDAO.insertPurchase(purchase);
	}
	
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDAO.findPurchase(tranNo);
	}
	
	public Purchase getPurchase2(int prodNo) throws Exception {
		return purchaseDAO.findPurchase2(prodNo);
	}
	
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception{
		
		List<Purchase> list= purchaseDAO.getPurchaseList(search, buyerId);
		int totalCount = purchaseDAO.getTotalCount(buyerId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		return map;
	}
	
	public Map<String, Object> getSaleList(Search search) throws Exception{
		return null;
	}
	
	public int updatePurchase(Purchase purchase) throws Exception{
		return purchaseDAO.updatePurchase(purchase);
	}
	
	public int updateTranCode(Purchase purchase) throws Exception{
		return purchaseDAO.updateTranCode(purchase);
	}
}
