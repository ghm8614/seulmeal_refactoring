package shop.seulmeal.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Page {
	///Field
	private int currentPage;		// ����������
	private int totalCount;			// �� �Խù� ��
	private int pageUnit;			// �ϴ� ������ ��ȣ ȭ�鿡 �������� ��
	private int pageSize;			// �� �������� �������� �Խù���
	private int maxPage;			// �ִ� ������ ��ȣ(��ü ������)
	private int beginUnitPage;	//ȭ�鿡 �������� ������ ��ȣ�� �ּҼ�
	private int endUnitPage;		//ȭ�鿡 �������� ������ ��ȣ�� �ִ��
	
	///Constructor
	public Page() {
	}
	public Page( int currentPage, int totalCount,	int pageUnit, int pageSize ) {
		this.totalCount = totalCount;
		this.pageUnit = pageUnit;
		this.pageSize = pageSize;
		
		this.maxPage = (pageSize == 0) ? totalCount :  (totalCount-1)/pageSize +1;
		this.currentPage = ( currentPage > maxPage) ? maxPage : currentPage;
		
		this.beginUnitPage = ( (currentPage-1) / pageUnit ) * pageUnit +1 ;
		
		if( maxPage <= pageUnit ){
			this.endUnitPage = maxPage;
		}else{
			this.endUnitPage = beginUnitPage + (pageUnit -1);
			if( maxPage <= endUnitPage){
				this.endUnitPage = maxPage;
			}
		}
	}

}
