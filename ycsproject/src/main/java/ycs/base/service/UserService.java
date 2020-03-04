package ycs.base.service;

import java.util.List;

import ycs.base.pojo.po.Sysuser;
import ycs.base.pojo.po.Usergys;
import ycs.base.pojo.po.Userjd;
import ycs.base.pojo.po.Useryy;
import ycs.base.pojo.vo.SysuserCustom;
import ycs.base.pojo.vo.SysuserQueryVo;

public interface UserService {
	//根据条件查询用户信息
	public List<SysuserCustom> findSysuserList(SysuserQueryVo sysuserQueryVo) throws Exception;
	
	//查询总数
	public int findSysuserCount(SysuserQueryVo sysuserQueryVo) throws Exception;
	
	// 根据用户账号查询用户信息
	public Sysuser findSysuserByUserid(String userId) throws Exception;
	
	// 根据单位名称查询单位信息
	public Userjd findUserjdByMc(String mc) throws Exception;
	
	// 根据单位名称查询单位信息
	public Useryy findUseryyByMc(String mc) throws Exception;
	
	// 根据单位名称查询单位信息
	public Usergys findUsergysByMc(String mc) throws Exception;
	
	// 添加用户
	public void insertSysuser(SysuserCustom sysuserCustom) throws Exception;
	//删除用户
	public void deleteSysuser(String id) throws Exception;
	//批量删除用户
	public void batch_deleteSysuser(String ids) throws Exception;
	//修改用户
	public void updateSysuser(String id, SysuserCustom sysuserCustom) throws Exception;
	//根据id查询出用户，用于数据回显
	public SysuserCustom findSysuserById(String id) throws Exception;
}
