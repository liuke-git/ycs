package ycs.base.action;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ycs.base.pojo.vo.SysuserCustom;
import ycs.base.pojo.vo.SysuserQueryVo;
import ycs.base.process.context.Config;
import ycs.base.process.result.DataGridResultInfo;
import ycs.base.process.result.ResultUtil;
import ycs.base.process.result.SubmitResultInfo;
import ycs.base.service.UserService;

@Controller
@RequestMapping("/user")
public class UserAction {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/queryUser")
	public String queryUser(Model model) {
		
		return "/base/user/queryUser";
	}
	
	@RequestMapping("/queryuser_result")
	public @ResponseBody DataGridResultInfo queryuser_result(SysuserQueryVo sysuserQueryVo, int page, int limit) throws Exception {
		page = (page - 1) * limit;
		//非空校验
		sysuserQueryVo = sysuserQueryVo!=null?sysuserQueryVo:new SysuserQueryVo();
		//查询总数
		int total = userService.findSysuserCount(sysuserQueryVo);
		sysuserQueryVo.setPage(page);
		sysuserQueryVo.setLimit(limit);
		//数据列表
		List<SysuserCustom> list = userService.findSysuserList(sysuserQueryVo);
		DataGridResultInfo dataGridResultInfo = new DataGridResultInfo();
		dataGridResultInfo.setCode(0);
		dataGridResultInfo.setMsg("");
		dataGridResultInfo.setCount(total);
		dataGridResultInfo.setData(list);
		//转换为json格式
		/*ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(dataGridResultInfo);
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(json);
		System.out.println(json);*/
		return dataGridResultInfo;
	}
	//调出添加页面
	@RequestMapping("/addUserpage")
	public String addUserPage(Model model) {
		
		return "/base/user/addUser";
	}
	
	//添加用户
	@RequestMapping("/addSysuser")
	public @ResponseBody SubmitResultInfo addSysUser(SysuserQueryVo sysuserQueryVo) throws Exception{
		//提示用户信息
		//String message = "添加成功！！";
		//int type = 0; //默认成功
		/*ResultInfo resultInfo = new ResultInfo();
		resultInfo.setType(ResultInfo.TYPE_RESULT_SUCCESS);
		resultInfo.setMessage("操作成功！");*/
		/*try {
			userService.insertSysuser(sysuserQueryVo.getSysuserCustom());
		} catch (Exception e) {
			e.printStackTrace();
			//输出异常信息
			message = e.getMessage();
			type = 1;//失败
		}*/
		/*Map<String, Object> result_map = new HashMap<String, Object>();
		result_map.put("type", type);
		result_map.put("message", message);
		return result_map;*/
		//userService.insertSysuser(sysuserQueryVo.getSysuserCustom());
		//SubmitResultInfo submitResultInfo = new SubmitResultInfo(resultInfo);
		//使用全局异常处理器后，在actoin不用进行try/catch捕获
		userService.insertSysuser(sysuserQueryVo.getSysuserCustom());
		return ResultUtil.createSubmitResult(ResultUtil.createSuccess(Config.MESSAGE, 100, null));
	}
	
	//删除用户
	@RequestMapping("/deleteSysuser")
	public @ResponseBody SubmitResultInfo deletesysuser(String id) throws Exception{
		//调用service
		userService.deleteSysuser(id);

		return ResultUtil.createSubmitResult(ResultUtil.createSuccess(Config.MESSAGE, 100, null));
	}
	@RequestMapping("/batch_deleteSysuser")
	public @ResponseBody SubmitResultInfo batch_deleteSysuser(String ids) throws Exception{
		
		//调用service
		userService.batch_deleteSysuser(ids);
		return ResultUtil.createSubmitResult(ResultUtil.createSuccess(Config.MESSAGE, 100, null));
	}
	//修改用户页面
	@RequestMapping("/editSysuser")
	public String editSysuser(Model model, String id) throws Exception{
		//通过id取出用户信息,传向页面,用户数据回显
		SysuserCustom sysuserCustom = userService.findSysuserById(id);
		model.addAttribute("sysuserCustom", sysuserCustom);
		return "/base/user/editUser";
	}
	
	//修改用户提交
	@RequestMapping("/editSysusersubmit")
	public @ResponseBody SubmitResultInfo updateSysuser(String id, SysuserQueryVo sysuserQueryVo) throws Exception{
		
		userService.updateSysuser(id, sysuserQueryVo.getSysuserCustom());
		return ResultUtil.createSubmitResult(ResultUtil.createSuccess(Config.MESSAGE, 100, null));
	}
}
