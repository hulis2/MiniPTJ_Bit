package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.ProductDao;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDAO;
	
	public void setProductDAO(ProductDao productDAO) {
		this.productDAO = productDAO;
	}

	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	public int addProduct(Product product) throws Exception {
		return productDAO.addProduct(product);
	}

	
	public Product getProduct(int prodNo) throws Exception {
		return productDAO.getProduct(prodNo);
	}

	
	public Map<String, Object> getProductList(Search search) throws Exception {
		
		List<Product> list= productDAO.getProductList(search);
		int totalCount = productDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	
	public int updateProduct(Product product) throws Exception {
		return productDAO.updateProduct(product);		
	}

	
}