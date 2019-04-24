package com.fuce.minhang_area.interceptor;

import com.alibaba.fastjson.JSON;
import com.fuce.minhang_area.DTO.LoginInfo;
import com.fuce.minhang_area.exception.BackendClientException;
import com.fuce.minhang_area.exception.BackendUnauthenticationException;
import com.fuce.minhang_area.utils.AES;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Date;

@Component
public class TokenInterceptor implements HandlerInterceptor {

    @Value("${token.aes.secret}")
    private String aesSecret;

    //过滤拦截 TODO
    private String[] urls = {
            "sys/user/login",
            "sys/error",
    };

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws BackendUnauthenticationException, BackendClientException {
        String method = request.getMethod();
        if(method.equals("OPTIONS")){
            return true;
        }

        boolean contains = Arrays.asList(urls).contains(request.getRequestURI());//是否包括uri
        if(contains){
            return true;
        }
        String authorizationStr = request.getHeader("Authorization");//获取头信息
        if(authorizationStr == null){
            throw new BackendUnauthenticationException("Unauthentication");
        }
        String[] s = authorizationStr.split(" ");//解析头信息
        String token = s[1];
        LoginInfo loginInfo;
        try {
            //byte[] decode = Base64.getDecoder().decode(token);//base64解码
            //String loginJsonStr = new String(decode, "UTF-8");
            String loginJsonStr = AES.decrypt(token,aesSecret);
            loginInfo = JSON.parseObject(loginJsonStr,LoginInfo.class);
        } catch (Exception e) {
            throw new BackendClientException("auth invalid caused by some issues");
        }
        Integer id = loginInfo.getId();//获取用户id
        String loginname = loginInfo.getLoginname();
        if(loginname == null){
            throw new BackendUnauthenticationException("Unauthentication");
        }
        long expireTimestamp = loginInfo.getExpirationTime().getTime();//获取过期时间戳
        Date currentTime = new Date();
        long currentTimestamp = currentTime.getTime();//当前时间戳
        if(loginname == null || loginname.isEmpty()){
            throw new BackendUnauthenticationException("Unauthentication: loginname is null or empty");
        }
        if(currentTimestamp > expireTimestamp){
            throw new BackendUnauthenticationException("Unauthentication: token is expired");
        }
        //根据token取出当前用户信息
        request.setAttribute("currentId",id);
        request.setAttribute("loginname",loginname);
        return true;
    }
}
