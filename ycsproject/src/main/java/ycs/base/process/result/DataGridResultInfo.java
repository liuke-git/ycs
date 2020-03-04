package ycs.base.process.result;

import java.util.ArrayList;
import java.util.List;
/**
 * 数据查询列表结果
 * @author Thinkpad
 *
 */
public class DataGridResultInfo {
	
	public DataGridResultInfo(){}
	public DataGridResultInfo(ResultInfo resultInfo){
		this.resultInfo = resultInfo;
	}
	
	//操作结果信息
	private ResultInfo resultInfo;
	
	private int code=0;
	private String msg="";
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List getData() {
		return data;
	}
	public void setData(List data) {
		this.data = data;
	}

	//总条数
	private int count;
	
	//结果集
	private List data = new ArrayList();
	@Override
	public String toString() {
		return "DataGridResultInfo [code=" + code + ", msg=" + msg + ", count=" + count + ", data=" + data + "]";
	}
	
	//总计告诉footer
	private List footer = new ArrayList();

	public ResultInfo getResultInfo() {
		return resultInfo;
	}

	public void setResultInfo(ResultInfo resultInfo) {
		this.resultInfo = resultInfo;
	}

	

	
	public List getFooter() {
		return footer;
	}
	public void setFooter(List footer) {
		this.footer = footer;
	}
	
	
	
	
}
