<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"	
    import="org.opencms.file.*"
    import="org.opencms.xml.page.*"  
    import="java.util.*"  
%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal/"; 

Locale locale = new Locale(cms.property("locale", "search"));
String thisUri = cms.getRequestContext().getUri();
String thisFolderUri = cms.getRequestContext().getFolderUri();
%>