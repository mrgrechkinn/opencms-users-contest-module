<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ page import="java.io.*, java.lang.*, java.util.*, java.text.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="org.opencms.*, org.opencms.main.*, org.opencms.flex.*, org.opencms.jsp.*, org.opencms.file.*, org.opencms.file.types.*" %>
<%@ page import="org.apache.commons.lang.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
if (!request.getMethod().equals("POST")) {
    System.out.println("Only POST method allowed");
    return;
}

FileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");
List<FileItem> items = null;
try {
    items = upload.parseRequest(request);
    Iterator<FileItem> iter = items.iterator();

     // Hidden Fields
     String siteRoot = null;
     String folderId = null;
    
     //Form public fields
     String lastName = null;
     String email = null;
     String picTitle = null;
     String filename = null;
     String captcha = null;
    
     byte[] bytes = null;
     List<CmsProperty> properties = new ArrayList<CmsProperty>();
     while (iter.hasNext()) {
         FileItem item = (FileItem) iter.next();
    
         if (item.isFormField()) {
             if (item.getFieldName().equals("folderId")) {
                 folderId = item.getString();
             }
             if (item.getFieldName().equals("siteRoot")) {
                 siteRoot = item.getString();
             } 
             if (item.getFieldName().equals("firstName")) {
                 properties.add(new CmsProperty("pcFirstName", item.getString("UTF-8"), null));
             }
             if (item.getFieldName().equals("lastName")) {
            	 properties.add(new CmsProperty("pcLastName", item.getString("UTF-8"), null));
             }
             if (item.getFieldName().equals("email")) {
            	 properties.add(new CmsProperty("pcEmail", item.getString("UTF-8"), null));
             }
             if (item.getFieldName().equals("picTitle")) {
            	 properties.add(new CmsProperty("pcPicTitle", item.getString("UTF-8"), null));
             }
             if (item.getFieldName().equals("captcha")) {
                 captcha = item.getString();
             }
         } else {
             filename = item.getName();
             bytes = item.get();
         }
     }
    
     try {
         CmsObject cms = OpenCms.initCmsObject("Guest");
         cms.loginUser("Admin", "admin");
         CmsProject project = cms.readProject("Offline");
         cms.getRequestContext().setCurrentProject(project);
         cms.getRequestContext().setSiteRoot(siteRoot);
    
         if (!cms.existsResource("/.content")) {
             System.out.println("Creating /.content");
             cms.createResource("/.content", CmsResourceTypeFolder.RESOURCE_TYPE_ID);
         }
    
         if (!cms.existsResource("/.content/mg-photocontest")) {
             System.out.println("Creating /.content/mg-photocontest");
             cms.createResource("/.content/mg-photocontest", CmsResourceTypeFolder.RESOURCE_TYPE_ID);
         }
    
         if (!cms.existsResource("/.content/mg-photocontest/" + folderId)) {
             System.out.println("Creating /.content/mg-photocontest/" + folderId);
             cms.createResource("/.content/mg-photocontest/" + folderId, CmsResourceTypeFolder.RESOURCE_TYPE_ID);
         }
    
         String newResname = cms.getRequestContext().getFileTranslator().translateResource("/.content/mg-photocontest/"
                                                                                         + folderId + "/"
                                                                                         + filename);
         int resTypeId = OpenCms.getResourceManager().getDefaultTypeForName(filename).getTypeId();
         cms.createResource(newResname, resTypeId, bytes, properties);
    
         OpenCms.getPublishManager().publishResource(cms, "/.content/mg-photocontest/" + folderId);
         OpenCms.getPublishManager().waitWhileRunning();
    
     } catch (Exception e) {
         System.out.println("Error: "+e.getMessage() );
     }
} catch (FileUploadException e) {
}

%>