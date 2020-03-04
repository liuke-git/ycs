package ycs.base.service.impl;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import ycs.base.mapper.SysuserMapper;
import ycs.base.mapper.SysuserMapperCustom;
import ycs.base.mapper.UsergysMapper;
import ycs.base.mapper.UserjdMapper;
import ycs.base.mapper.UseryyMapper;
import ycs.base.pojo.po.Sysuser;
import ycs.base.pojo.po.SysuserExample;
import ycs.base.pojo.po.Usergys;
import ycs.base.pojo.po.UsergysExample;
import ycs.base.pojo.po.Userjd;
import ycs.base.pojo.po.UserjdExample;
import ycs.base.pojo.po.Useryy;
import ycs.base.pojo.po.UseryyExample;
import ycs.base.pojo.vo.SysuserCustom;
import ycs.base.pojo.vo.SysuserQueryVo;
import ycs.base.process.context.Config;
import ycs.base.process.result.ExceptionResultInfo;
import ycs.base.process.result.ResultInfo;
import ycs.base.process.result.ResultUtil;
import ycs.base.service.UserService;
import ycs.utils.MD5;
import ycs.utils.UUIDBuild;

public class UserServiceImpl implements UserService {

	// 注入mapper
	@Autowired
	private SysuserMapper sysuserMapper;
	@Autowired
	private UserjdMapper userjdMapper;
	@Autowired
	private UseryyMapper useryyMapper;
	@Autowired
	private UsergysMapper usergysMapper;
	@Autowired
	private SysuserMapperCustom sysuserMapperCustom;

	@Override
	public List<SysuserCustom> findSysuserList(SysuserQueryVo sysuserQueryVo) throws Exception {
		return sysuserMapperCustom.findSysuserList(sysuserQueryVo);
	}

	@Override
	public int findSysuserCount(SysuserQueryVo sysuserQueryVo) throws Exception {
		return sysuserMapperCustom.findSysuserCount(sysuserQueryVo);
	}

	// 根据账号查询用户方法
	@Override
	public Sysuser findSysuserByUserid(String userId) throws Exception {
		SysuserExample sysuserExample = new SysuserExample();
		SysuserExample.Criteria criteria = sysuserExample.createCriteria();
		// 设置查询条件
		criteria.andUseridEqualTo(userId);
		List<Sysuser> list = sysuserMapper.selectByExample(sysuserExample);
		if (list != null && list.size() == 1) {
			return list.get(0);
		}
		return null;
	}

	// 根据单位名称 查询单位信息
	@Override
	public Userjd findUserjdByMc(String mc) throws Exception {

		UserjdExample userjdExample = new UserjdExample();
		UserjdExample.Criteria criteria = userjdExample.createCriteria();
		criteria.andMcEqualTo(mc);
		List<Userjd> list = userjdMapper.selectByExample(userjdExample);
		if (list != null && list.size() == 1) {
			return list.get(0);
		}

		return null;
	}

	@Override
	public Useryy findUseryyByMc(String mc) throws Exception {

		UseryyExample useryyExample = new UseryyExample();
		UseryyExample.Criteria criteria = useryyExample.createCriteria();
		criteria.andMcEqualTo(mc);
		List<Useryy> list = useryyMapper.selectByExample(useryyExample);

		if (list != null && list.size() == 1) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public Usergys findUsergysByMc(String mc) throws Exception {

		UsergysExample usergysExample = new UsergysExample();
		UsergysExample.Criteria criteria = usergysExample.createCriteria();
		criteria.andMcEqualTo(mc);
		List<Usergys> list = usergysMapper.selectByExample(usergysExample);
		if (list != null && list.size() == 1) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public void insertSysuser(SysuserCustom sysuserCustom) throws Exception {

		// 进行参数校验
		// 校验账号是否重复
		Sysuser sysuser = this.findSysuserByUserid(sysuserCustom.getUserid());
		if (sysuser != null) {
			// 账号重复，抛出异常
			// throw new Exception("账号重复");
			/*
			 * ResultInfo resultInfo = new ResultInfo();
			 * resultInfo.setType(ResultInfo.TYPE_RESULT_FAIL);
			 * resultInfo.setMessage("账号重复"); System.out.println(resultInfo); throw new
			 * ExceptionResultInfo(resultInfo);
			 */
			ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 101, null));
		}
		// 根据用户类型，输入单位名称必须存在相对应的单位表
		String groupid = sysuserCustom.getGroupid();// 用户类型
		String sysmc = sysuserCustom.getSysmc();
		String sysid = null; // 单位id
		if (groupid.equals("1") || groupid.equals("2")) {
			// 监督单位，根据单位名称查询单位信息
			Userjd userjd = this.findUserjdByMc(sysmc);
			if (userjd == null) {
				// 抛出异常
				/* throw new Exception("单位名称输入错误"); */
				ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 102, null));
			}
			sysid = userjd.getId();
		} else if (groupid.equals("3")) {
			// 监督单位，根据单位名称查询单位信息
			Useryy useryy = this.findUseryyByMc(sysmc);
			if (useryy == null) {
				// 抛出异常
				ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 102, null));
			}
			sysid = useryy.getId();
		} else if (groupid.equals("4")) {
			// 监督单位，根据单位名称查询单位信息
			Usergys usergys = this.findUsergysByMc(sysmc);
			if (usergys == null) {
				// 抛出异常
				ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 102, null));
			}
			sysid = usergys.getId();
		}
		// 设置主键
		sysuserCustom.setId(UUIDBuild.getUUID());
		// 设置单位id
		sysuserCustom.setSysid(sysid);
		sysuserMapper.insert(sysuserCustom);

	}

	@Override
	public void deleteSysuser(String id) throws Exception {
		// 校验约束
		// 校验用户是否存在
		Sysuser sysuser = sysuserMapper.selectByPrimaryKey(id);
		if (sysuser == null) {
			// 用户不存在
			ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 103, null));
		}
		// 执行删除
		sysuserMapper.deleteByPrimaryKey(id);

	}

	@Override
	public void batch_deleteSysuser(String ids) throws Exception {
		String user[] = ids.split(",");
		for (int i = 0; i < user.length; i++) {
			// 执行删除
			sysuserMapper.deleteByPrimaryKey(user[i]);
		}
	}

	// 修改用户
	@Override
	public void updateSysuser(String id, SysuserCustom sysuserCustom) throws Exception {
		// 校验
		String userid_page = sysuserCustom.getUserid();
		// 通过id查询数据库
		Sysuser sysuser = sysuserMapper.selectByPrimaryKey(id);
		if (sysuser == null) {
			// 抛出异常
			// 找不到要修改用户信息
			ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 104, null));
		}
		// 原始用户账号
		String userid = sysuser.getUserid();
		if (!userid_page.equals(userid)) {
			// 通过页面提交的账号查询数据库，如果查到说明暂用别人的账号
			Sysuser sysuser_1 = this.findSysuserByUserid(userid_page);
			if (sysuser_1 != null) {
				ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 105, null));
			}
		}
		// 根据用户类型，输入单位名称必须存在相对应的单位表
		String groupid = sysuserCustom.getGroupid();// 用户类型
		String sysmc = sysuserCustom.getSysmc();
		String sysid = null; // 单位id
		if (groupid.equals("1") || groupid.equals("2")) {
			// 监督单位，根据单位名称查询单位信息
			Userjd userjd = this.findUserjdByMc(sysmc);
			if (userjd == null) {
				// 抛出异常
				/* throw new Exception("单位名称输入错误"); */
				ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 102, null));
			}
			sysid = userjd.getId();
		} else if (groupid.equals("3")) {
			// 监督单位，根据单位名称查询单位信息
			Useryy useryy = this.findUseryyByMc(sysmc);
			if (useryy == null) {
				// 抛出异常
				ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 102, null));
			}
			sysid = useryy.getId();
		} else if (groupid.equals("4")) {
			// 监督单位，根据单位名称查询单位信息
			Usergys usergys = this.findUsergysByMc(sysmc);
			if (usergys == null) {
				// 抛出异常
				ResultUtil.throwExcepion(ResultUtil.createFail(Config.MESSAGE, 102, null));
			}
			sysid = usergys.getId();
		}
		
		//密码修改
		//如果从页面提交的密码值为空说明用户不修改密码，否则 就需要对密码进行加密存储
		String pwd_page = sysuserCustom.getPwd().trim();
		String pwd_md5 = null;
		if(pwd_page!=null && !pwd_page.equals("")) {
			//说明用户修改了密码
			pwd_md5 = new MD5().getMD5ofStr(pwd_page);
		}
		//设置更新用户信息
		//调用mapper更新用户,先查询用户
		Sysuser sysuser_update = sysuserMapper.selectByPrimaryKey(id);
		sysuser_update.setUserid(sysuserCustom.getUserid());
		sysuser_update.setUsername(sysuserCustom.getUsername());
		sysuser_update.setUserstate(sysuserCustom.getUserstate());
		if (pwd_md5!=null) {
			sysuser_update.setPwd(pwd_md5);
		}
		sysuser_update.setGroupid(sysuserCustom.getGroupid());
		sysuser_update.setSysid(sysid);//单位id
		sysuserMapper.updateByPrimaryKey(sysuser_update);

	}

	//用户数据回显
	@Override
	public SysuserCustom findSysuserById(String id) throws Exception {

		//从数据库查询用户
		Sysuser sysuser = sysuserMapper.selectByPrimaryKey(id);
		//根据sysid查询单位名称
		String groupid = sysuser.getGroupid();
		String sysid = sysuser.getSysid();
		String sysmc = null;
		if (groupid.equals("1") || groupid.equals("2")) {
			//监督单位
			//根据单位id查询单位信息
			Userjd userjd = userjdMapper.selectByPrimaryKey(sysid);
			sysmc = userjd.getMc();
		}else if(groupid.equals("3")) {
			//卫生室
			Useryy useryy = useryyMapper.selectByPrimaryKey(sysid);
			sysmc = useryy.getMc();
		}else if(groupid.equals("4")){
			//供货商
			//根据单位id查询单位信息
			Usergys usergys = usergysMapper.selectByPrimaryKey(sysid);
			sysmc = usergys.getMc();
		}
		SysuserCustom sysuserCustom = new SysuserCustom();
		//将sysuser中的数据封装到sysuserCustom
		BeanUtils.copyProperties(sysuser, sysuserCustom);
		sysuserCustom.setSysmc(sysmc);
		return sysuserCustom;
	}
}
