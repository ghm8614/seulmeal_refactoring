package shop.seulmeal.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Foodcategory;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.domain.Review;

@Mapper
public interface ProductMapper {

	// PRODUCT
	public void insertProduct(Product product) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	public void updateProductStock(Product product) throws Exception;

	public Product getProduct(int productNo) throws Exception;

	public List<Product> getListProduct(Search search) throws Exception;

	public List<Product> getListProductAsAdmin(Search search) throws Exception;

	public void deleteProduct(int productNo) throws Exception;

	public void restoreProduct(int productNo) throws Exception;	

	// FOODCATEGORY
	public void insertFoodCategory(String foodCategoryName) throws Exception;

	public List<Foodcategory> getListFoodCategory() throws Exception;

	public List<Foodcategory> getAdminFoodCategory(String status) throws Exception;

	public void deleteFoodCategory(int foodCategoryNo) throws Exception;

	public void restoreFoodCategory(int foodCategoryNo) throws Exception;

	// REVIEW
	public int validationReview(Map<String, Object> map) throws Exception;
	
	public void insertReview(Review review) throws Exception;

	public void updateReview(Review review) throws Exception;

	public Review getReview(int reviewNo) throws Exception;

	public List<Review> getListReview(Search search) throws Exception;

	public List<Review> getListReviewAsAdmin(Search search) throws Exception;

	public void deleteReview(int reviewNo) throws Exception;

	public void restoreReview(int reviewNo) throws Exception;

	public int insertReviewReport(Report report) throws Exception;

	public Map<String, Object> getListReviewReport(Search search) throws Exception;

	public int deleteReviewReport(int reviewNo) throws Exception;

	// PARTS
	public int insertParts(Parts parts) throws Exception;

	public Parts getParts(Map<String, Object> map) throws Exception;

	public List<Map> autoComplete(Map<String, Object> map) throws Exception;

	public int updateParts(Parts parts) throws Exception;

	public int deleteParts(int no) throws Exception;

	public int restoreParts(int no) throws Exception;

	public List<Parts> getListParts(Map<String, Object> map) throws Exception;

	// productParts
	public int insertProductParts(List<Parts> list) throws Exception;

	public List<Parts> getProductParts(int productNo) throws Exception;

	public int deleteProductParts(int productPartsNo) throws Exception;

	// productLike
	public Like checkOutLike(Map<String, Object> map) throws Exception;
	
	public void insertLikeProduct(Map<String, Object> map) throws Exception;

	public List<Product> getListLikeProduct(Map<String, Object> map) throws Exception;

	public void deleteLikeProduct(Map<String, Object> map) throws Exception;

	// TotalCount
	public int getProductTotalCount(Search search) throws Exception;

	public int getProductTotalCountAsAdmin(Search search) throws Exception;

	public int getFoodCategoryTotalCount() throws Exception;

	public int getReviewTotalCount() throws Exception;
	
	public int getReportTotalCount() throws Exception;

	public int getFoodCategoryTotalCount(Search search) throws Exception;

	public int getReviewTotalCount(Search search) throws Exception;

	public int getReviewTotalCountAsAdmin(Search search) throws Exception;

	public int getPartsTotalCount(Map<String, Object> map) throws Exception;

	public int getLikeProductTotalCount(String userId) throws Exception;
	
	public List<Like> getListLikeAll(String userId) throws Exception;
}
