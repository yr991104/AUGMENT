<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.util.zip.*" %>

<%
	String realFolder = "";
 
	String Folder = "fileSave"; // out폴더에 fileSave 폴더 생성
	String encType = "utf-8";
	int maxSize = 30*1024*1024; // 최대 업로드 5mb
 
	ServletContext context = request.getServletContext();
	realFolder = context.getRealPath(Folder);
	int data = 1;
	String saveFolder = realFolder + "\\" + data;
	File targetDir = new File(saveFolder);
	
	String nameF = "";
    String fileN = "";
	
	while (targetDir.exists()) {
		data++;
		saveFolder = realFolder + "\\" + data;
		targetDir = new File(saveFolder);
	}
	
	if(!targetDir.exists()) {
		targetDir.mkdirs();
	}
	
	String title = "http://kennychae.kro.kr:8080/BBS/fileSave/" + data + "/" + "index.html";
	out.println("링크 : ");
%>	
	<a href="http://kennychae.kro.kr:8080/BBS/fileSave/" + data + "/" + "index.html"><%=title %></a>
<%

	out.println("<br>");
	out.println("QR 링크 : " + "https://chart.apis.google.com/chart?cht=qr&chs=300x300&chl=kennychae.kro.kr:8080/BBS/fileSave/" + data + "/" + "index.html" + "<br>");
	
	try {
	    MultipartRequest multi = null;
 
	    multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
 
	    Enumeration params = multi.getParameterNames();
 
	    while(params.hasMoreElements()) {
	        String name = (String) params.nextElement();
	        String value = multi.getParameter(name);
	    }
 
	    Enumeration files = multi.getFileNames();
	    
	    nameF = (String)files.nextElement();
	    fileN = multi.getOriginalFileName(nameF);
	    
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	File zipFile = new File(saveFolder + "\\" + fileN);
	File unzipFolder = new File(saveFolder);
	String directory = saveFolder;
	
	FileInputStream fis = null;
	ZipInputStream zis = null;
	ZipEntry zipentry = null;
	
	try {
		//파일 스트림
		fis = new FileInputStream(zipFile);
		//Zip 파일 스트림
		zis = new ZipInputStream(fis);
		
		//entry가 없을때까지 뽑기
		while ((zipentry = zis.getNextEntry()) != null) {
			String entryName = zipentry.getName();
			File file = new File(saveFolder + "/" + entryName);
			File file2 = new File(saveFolder + "/" + "Build");
			
			file2.mkdir();

			if (zipentry.isDirectory()) {
				file.mkdir();
			} else {
				FileOutputStream os = new FileOutputStream(file);

				// Transfer bytes from the ZIP file to the output file
				byte[] buf = new byte[1024];

				int len;
				while ((len = zis.read(buf)) > 0) {
					os.write(buf, 0, len);
				}
				os.close();
				zis.closeEntry();
			}
		}
	} catch (Throwable e) {
		throw e;
	} finally {
		if (zis != null)
		zis.close();
		if (fis != null)
		fis.close();
	}
%>