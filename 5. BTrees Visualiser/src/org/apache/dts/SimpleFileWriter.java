package org.apache.dts;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class SimpleFileWriter
{
    public static String saveToFile(String strText) throws IOException {
        String strFileName = System.getProperty("user.dir") + File.separator;
        String strTimestamp = new SimpleDateFormat("MM.dd.yyyy.HH.mm.ss").format(new Date());
        StringBuilder buf = new StringBuilder();
        buf.append(strFileName)
           .append("BTree-")
           .append(strTimestamp)
           .append(".txt");

        strFileName = buf.toString();
        File savedFile = new File(strFileName);

        if (!savedFile.exists()) {
            savedFile.createNewFile();
        }

        FileWriter fw = new FileWriter(savedFile.getAbsoluteFile());
        BufferedWriter bw = new BufferedWriter(fw);
        bw.write(strText);
        bw.close();

        return strFileName;
    }
}
