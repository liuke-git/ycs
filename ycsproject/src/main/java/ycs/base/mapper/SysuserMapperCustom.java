package ycs.base.mapper;

import java.util.List;

import ycs.base.pojo.vo.SysuserCustom;
import ycs.base.pojo.vo.SysuserQueryVo;

public interface SysuserMapperCustom {
	
	//根据条件查询用户信息
	public List<SysuserCustom> findSysuserList(SysuserQueryVo sysuserQueryVo) throws Exception;
	
	//查询总数
	public int findSysuserCount(SysuserQueryVo sysuserQueryVo) throws Exception;

}
