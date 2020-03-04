package ycs.base.pojo.vo;

import ycs.base.pojo.po.Sysuser;

public class SysuserCustom extends Sysuser{

	private String sysmc;

	public String getSysmc() {
		return sysmc;
	}

	public void setSysmc(String sysmc) {
		this.sysmc = sysmc;
	}

	@Override
	public String toString() {
		return "SysuserCustom [sysmc=" + sysmc + "]";
	}

	
	
}
