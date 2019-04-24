package com.fuce.minhang_area.utils;

import java.io.FileOutputStream;

public class FileUtil {
    public static void storeFile(byte[] fileData, String fileName) throws Exception {
        FileOutputStream out = new FileOutputStream(fileName);
        out.write(fileData);
        out.close();
    }
}
