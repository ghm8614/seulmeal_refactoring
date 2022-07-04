package shop.seulmeal.service.product.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.net.ssl.SSLPeerUnverifiedException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Foodcategory;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.domain.Review;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.mapper.ProductMapper;
import shop.seulmeal.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductMapper productMapper;

	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	// Product CRUD
	@Override
	// test done
	public void insertProduct(Product product) throws Exception {
		productMapper.insertProduct(product);
	}

	@Override
	// test done
	public void updateProduct(Product product) throws Exception {
		productMapper.updateProduct(product);
	}

	public void updateProductStock(int productNo, int stock) throws Exception {
		Product product = productMapper.getProduct(productNo);
		product.setStock(stock);
		productMapper.updateProductStock(product);
	}

	@Override
	public Map<String, Object> getListProduct(Search search) throws Exception {
		if (search.getSearchKeyword() == null) {
			search.setSearchKeyword("");
		}
		List<Product> list = productMapper.getListProduct(search);
		int totalCount = productMapper.getProductTotalCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		System.out.println("@!#!@!@$!@$@:"+new Integer(totalCount));
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	public Map<String, Object> getListProductAsAdmin(Search search) throws Exception {
		if (search.getSearchKeyword() == null) {
			search.setSearchKeyword("");
		}
		List<Product> list = productMapper.getListProductAsAdmin(search);
		int totalCount = productMapper.getProductTotalCountAsAdmin(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	// test done
	public Product getProduct(int productNo) throws Exception {
		return productMapper.getProduct(productNo);
	}

	@Override
	// test done + need toggle
	public void deleteProduct(int productNo) throws Exception {
		productMapper.deleteProduct(productNo);
	}

	public void restoreProduct(int productNo) throws Exception {
		productMapper.restoreProduct(productNo);
	}

	// Food Category CRUD
	public void insertFoodCategory(String foodCategoryName) throws Exception {
		productMapper.insertFoodCategory(foodCategoryName);
	}

	public List<Foodcategory> getListFoodCategory() throws Exception {
		return (List<Foodcategory>) productMapper.getListFoodCategory();
	}

	public List<Foodcategory> getAdminFoodCategory(String status) throws Exception {
		return (List<Foodcategory>) productMapper.getAdminFoodCategory(status);
	}

	public void deleteFoodCategory(int foodCategoryNo) throws Exception {
		productMapper.deleteFoodCategory(foodCategoryNo);
	}

	@Override
	public void restoreFoodCategory(int foodCategoryNo) throws Exception {
		productMapper.restoreFoodCategory(foodCategoryNo);
	}

	// Review CRUD
	public String validationReview(Map<String, Object> map) throws Exception{
		System.out.println(map);
		if(productMapper.validationReview(map) > 0) {
			return "true";
		} else {
			return "false";
		}
	}
	
	@Override
	public void insertReview(Review review) throws Exception {
		productMapper.insertReview(review);
	}

	@Override
	public void updateReview(Review review) throws Exception {
		productMapper.updateReview(review);
	}

	@Override
	public Review getReview(int reviewNo) throws Exception {

		return productMapper.getReview(reviewNo);
	}

	@Override
	public Map<String, Object> getListReview(Search search) throws Exception {
		List<Review> list = productMapper.getListReview(search);
		int totalCount = productMapper.getReviewTotalCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	public Map<String, Object> getListReviewAsAdmin(Search search) throws Exception {
		List<Review> list = productMapper.getListReviewAsAdmin(search);
		int totalCount = productMapper.getReviewTotalCountAsAdmin(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	public void deleteReview(int reviewNo) throws Exception {
		productMapper.deleteReview(reviewNo);
	}

	@Override
	public void restoreReview(int reviewNo) throws Exception {
		productMapper.restoreReview(reviewNo);
	}

	public int insertReviewReport(Report report) throws Exception {
		return productMapper.insertReviewReport(report);
	}

	public Map<String, Object> getListReviewReport(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportList", productMapper.getListReviewReport(search));
		map.put("reportTotalCount", productMapper.getReportTotalCount());

		return map;
	}

	public int deleteReviewReport(int reviewNo) throws Exception {
		return productMapper.deleteReviewReport(reviewNo);
	}

	// Parts 관련
	@Override
	public int insertParts(Parts parts) throws Exception {

		return productMapper.insertParts(parts);
	}

	@Override
	public Parts getParts(Map<String, Object> map) throws Exception {

		return productMapper.getParts(map);
	}
	public List<Map> autoComplete(Map<String, Object> map) throws Exception{
		return productMapper.autoComplete(map);
	}
	@Override
	public int updateParts(Parts parts) throws Exception {

		return productMapper.updateParts(parts);
	}

	public void deleteParts(int no) throws Exception {
		productMapper.deleteParts(no);
	}

	public void restoreParts(int no) throws Exception {
		productMapper.restoreParts(no);
	}

	@Override
	public Map<String, Object> getListParts(Search search) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);

		map.put("list", productMapper.getListParts(map));
		map.put("totalCount", productMapper.getPartsTotalCount(map));

		return map;
	}

	// ProductParts 관련
	
	public int insertProductParts(List<Parts> list) throws Exception {		
		return productMapper.insertProductParts(list);
	}

	@Override
	public List<Parts> getProductParts(int productNo) throws Exception {
		return productMapper.getProductParts(productNo);
	}

	@Override
	public int deleteProductParts(int productPartsNo) throws Exception {
		return productMapper.deleteProductParts(productPartsNo);
	}
	
	public String checkOutLike(Map<String, Object> map) throws Exception{		
		return checkOutLike(map);
	}

	public String updateLikeProduct(Map<String, Object> map) throws Exception {

		if(productMapper.checkOutLike(map) == null) {
			productMapper.insertLikeProduct(map);
			return "Liked";
		}else {
			productMapper.deleteLikeProduct(map);
			return "Deleted";
		}
	}

	public Map<String, Object> getListLikeProduct(Map<String, Object> map) throws Exception {
		List<Product> list = productMapper.getListLikeProduct(map);

		Map<String, Object> result = new HashMap<String,Object>();
		
		String userId = (String) map.get("userId");
		int totalCount = productMapper.getLikeProductTotalCount(userId);
		
		result.put("list", list);
		result.put("totalCount", totalCount);

		return result;
	}

	@Override
	public List<Like> getListLikeAll(String userId) throws Exception {
		// TODO Auto-generated method stub
		return productMapper.getListLikeAll(userId);
	}

}