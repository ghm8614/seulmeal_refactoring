package shop.seulmeal.service.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Foodcategory;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.domain.Review;

public interface ProductService {
	// Product
	public void insertProduct(Product product) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	public void updateProductStock(int productNo, int stock) throws Exception;

	public Map<String, Object> getListProduct(Search search) throws Exception;

	public Map<String, Object> getListProductAsAdmin(Search search) throws Exception;

	public Product getProduct(int productNo) throws Exception;

	public void deleteProduct(int productNo) throws Exception;
	
	public void restoreProduct(int productNo) throws Exception;

	// foodCategory 관련
	public void insertFoodCategory(String foodCategoryName) throws Exception;

	public List<Foodcategory> getListFoodCategory() throws Exception;
	
	public List<Foodcategory> getAdminFoodCategory(String status) throws Exception;

	public void deleteFoodCategory(int foodCategoryNo) throws Exception;
	
	public void restoreFoodCategory(int foodCategoryNo) throws Exception;

	// Review
	public String validationReview(Map<String,Object> map) throws Exception;
	
	public void insertReview(Review review) throws Exception;

	public void updateReview(Review review) throws Exception;

	public Review getReview(int reviewNo) throws Exception;

	public Map<String, Object> getListReview(Search search) throws Exception;
	
	public Map<String, Object> getListReviewAsAdmin(Search search) throws Exception;

	public void deleteReview(int reviewNo) throws Exception;
	
	public void restoreReview(int reviewNo) throws Exception;
	
	public int insertReviewReport(Report report) throws Exception;

	public Map<String, Object> getListReviewReport(Search search) throws Exception;

	public int deleteReviewReport(int reviewNo) throws Exception;
	

	// Parts 넣기
	public int insertParts(Parts parts) throws Exception;

	public Parts getParts(Map<String, Object> map) throws Exception;

	public List<Map> autoComplete(Map<String, Object> map) throws Exception;

	public int updateParts(Parts parts) throws Exception;

	public void deleteParts(int no) throws Exception;
	
	public void restoreParts(int no) throws Exception;

	public Map<String, Object> getListParts(Search search) throws Exception;

	// ProductParts
	public int insertProductParts(List<Parts> list) throws Exception;

	public List<Parts> getProductParts(int productNo) throws Exception;

	public int deleteProductParts(int productPartsNo) throws Exception;
	
	// LikeProduct 관련
	public String checkOutLike(Map<String, Object> map)throws Exception;
	
	public Map<String, Object> getListLikeProduct(Map<String,Object> map) throws Exception;

	public String updateLikeProduct(Map<String, Object> map) throws Exception;
	
	public List<Like> getListLikeAll(String userId) throws Exception;
}

