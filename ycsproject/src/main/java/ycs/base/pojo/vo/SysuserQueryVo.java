package ycs.base.pojo.vo;

public class SysuserQueryVo {

	private SysuserCustom sysuserCustom;

	//当前页
	private int page;
	//每页显示条数
	private int limit;
	
	
	
	

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public SysuserCustom getSysuserCustom() {
		return sysuserCustom;
	}

	public void setSysuserCustom(SysuserCustom sysuserCustom) {
		this.sysuserCustom = sysuserCustom;
	}
	
	
}
