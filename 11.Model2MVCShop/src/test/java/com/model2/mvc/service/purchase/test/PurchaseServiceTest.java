package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	//@Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		purchase.setBuyer("user10");
		purchase.setPurchaseProd("10061");
		purchase.setPaymentOption("1");	
		purchase.setReceiverName("�׽�Ʈ");
		purchase.setReceiverPhone("7777777");
		purchase.setDivyAddr("�׽�Ʈ");
		purchase.setDivyRequest("�׽�Ʈ");
//		purchase.setTranCode("0");
		purchase.setDivyDate("20000707");
		
		//System.out.println(purchaseService.addPurchase(purchase));
		
		//==> API Ȯ��
		Assert.assertEquals(1, purchaseService.addPurchase(purchase) );
	}
	
	//@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		//tranNo�� �˻��ؼ� Purchase���� ��������.
		purchase = purchaseService.getPurchase(10008);

		//==> console Ȯ��
		System.out.println(purchase);
		
	}
	
	//@Test
	public void testGetPurchase2() throws Exception {
			
		Purchase purchase = new Purchase();
			
		//prodNo�� �˻��ؼ� transaction�� tranNo ��������.
		purchase = purchaseService.getPurchase2(10000);

		//==> console Ȯ��
		System.out.println(purchase.getTranNo());
			
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		
		Purchase purchase = new Purchase();

		purchase.setTranNo(10008);
		purchase.setBuyer("user10");
		purchase.setPaymentOption("1");
		purchase.setReceiverName("�׽�Ʈ");
		purchase.setReceiverPhone("7777777");
		purchase.setDivyAddr("�׽�Ʈ");
		purchase.setDivyRequest("�׽�Ʈ");
		purchase.setDivyDate("20000707");
		
		Assert.assertEquals(1, purchaseService.updatePurchase(purchase));
		
	 }
	
	//@Test
	public void testUpdateTrancode() throws Exception{
		
		Purchase purchase = new Purchase();
		
		purchase.setTranNo(10008);
//		purchase.setTranCode("1");
		
		Assert.assertEquals(1, purchaseService.updateTranCode(purchase));
	 }
	 
	@Test
	public void testGetPurchaseLis() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	List<Purchase> list = (List<Purchase>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 		 	
	 }
}