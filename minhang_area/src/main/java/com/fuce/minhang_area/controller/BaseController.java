package com.fuce.minhang_area.controller;

import com.fuce.minhang_area.exception.BackendClientException;
import com.fuce.minhang_area.utils.FileUtil;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@RestController
@RequestMapping("/src/excle")
public class BaseController {
    /**
     * 上传文件
     * @param file
     * @return
     * @throws Exception
     */
    @PostMapping("/uploadData")
    public String uploadData(@RequestParam("file")MultipartFile file) throws Exception {
        String contentType = file.getContentType();
        if (!contentType.equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
                && !contentType.equals("application/vnd.ms-excel")) {
            throw new BackendClientException("file only support xls/xlsx");
        }
        String uuid = UUID.randomUUID().toString();
        String type = file.getContentType().split("-")[1];
        String fileName = String.format("%s.%s", uuid, type);
        String url = String.format("src/excle/%s", fileName);
        FileUtil.storeFile(file.getBytes(),url);
        return fileName;
    }
}
