package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}
	
	public Purchase findPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}
	
	public Purchase findPurchase2(int prodNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase2", prodNo);
	}
	
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception{
		
		Map<String , Object>  map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId", buyerId);
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
		
		return list;
	}
	
	public List<Purchase> getSaleList(Search search){
		return null;
	}
	
	public int insertPurchase(Purchase purchase) throws Exception {
		return sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}
	
	public int updatePurchase(Purchase purchase) throws Exception {
		return sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	public int updateTranCode(Purchase purchase) throws Exception {
		return sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}
	
	public int getTotalCount(String buyerId) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", buyerId);
	}

}
