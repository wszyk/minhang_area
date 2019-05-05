package com.usx.control;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 
 * @author ok
 * 
 */
@Controller
@RequestMapping("/base")
public class BaseControl {

	/**
	 * 上传文件
	 * 
	 * @param req
	 * @param rep
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/upLoadFile.do")
	@ResponseBody
	public Map<String, Object> upLoadFile(HttpServletRequest req,
			HttpServletResponse rep) {
		Map<String, Object> result = new HashMap<String, Object>();
		// 将当前上下文初始化给 CommonsMutipartResolver （多部分解析器）
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				req.getSession().getServletContext());
		// 检查form中是否有enctype="multipart/form-data"
		if (multipartResolver.isMultipart(req)) {
			// 将request变成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) req;
			// 获取multiRequest 中所有的文件名
			Iterator iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 一次遍历所有文件
				MultipartFile file = multiRequest.getFile(iter.next()
						.toString());
				if (file != null) {
					String originalName = file.getOriginalFilename();
					String ext = originalName.substring(originalName.indexOf("."));
					ResourceBundle resource = ResourceBundle.getBundle("application");
					String fileName = new Date().getTime()+ext;
					String path = resource.getString("common.file.path") + fileName;
					// 上传
					try {
						file.transferTo(new File(path));
						/**
						 * {
							  "code": 0
							  ,"msg": ""
							  ,"data": {
							    "src": "http://cdn.abc.com/123.jpg"
							  }
							}
						 */
						result.put("code", 0);
						result.put("msg", "上传成功！");
						Map<String, Object> data = new HashMap<String, Object>();
						data.put("src", fileName);
						result.put("data", data);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}

			}

		}
		return result;
	}

}
