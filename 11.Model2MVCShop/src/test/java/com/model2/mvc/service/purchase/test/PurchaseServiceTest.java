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
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	//@Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		purchase.setBuyer("user10");
		purchase.setPurchaseProd("10061");
		purchase.setPaymentOption("1");	
		purchase.setReceiverName("테스트");
		purchase.setReceiverPhone("7777777");
		purchase.setDivyAddr("테스트");
		purchase.setDivyRequest("테스트");
//		purchase.setTranCode("0");
		purchase.setDivyDate("20000707");
		
		//System.out.println(purchaseService.addPurchase(purchase));
		
		//==> API 확인
		Assert.assertEquals(1, purchaseService.addPurchase(purchase) );
	}
	
	//@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		//tranNo로 검색해서 Purchase정보 가져오기.
		purchase = purchaseService.getPurchase(10008);

		//==> console 확인
		System.out.println(purchase);
		
	}
	
	//@Test
	public void testGetPurchase2() throws Exception {
			
		Purchase purchase = new Purchase();
			
		//prodNo로 검색해서 transaction의 tranNo 가져오기.
		purchase = purchaseService.getPurchase2(10000);

		//==> console 확인
		System.out.println(purchase.getTranNo());
			
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		
		Purchase purchase = new Purchase();

		purchase.setTranNo(10008);
		purchase.setBuyer("user10");
		purchase.setPaymentOption("1");
		purchase.setReceiverName("테스트");
		purchase.setReceiverPhone("7777777");
		purchase.setDivyAddr("테스트");
		purchase.setDivyRequest("테스트");
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
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 		 	
	 }
}