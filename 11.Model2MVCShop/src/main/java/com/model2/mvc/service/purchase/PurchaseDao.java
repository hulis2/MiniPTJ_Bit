package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	
	public Purchase findPurchase(int tranNo) throws Exception;
	
	public Purchase findPurchase2(int prodNo) throws Exception;
	
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception;
	
	public List<Purchase> getSaleList(Search search);
	
	public int insertPurchase(Purchase purchase) throws Exception;
	
	public int updatePurchase(Purchase purchase) throws Exception;
	
	public int updateTranCode(Purchase purchase) throws Exception;
	
	public int getTotalCount(String buyerId) throws Exception;

	
	

}
