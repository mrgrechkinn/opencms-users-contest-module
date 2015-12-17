<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="org.opencms.jsp.CmsJspActionElement"    
%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";
//request.setAttribute("left_column", moduleBaseUri + "/elements/left_column.jsp");
request.setAttribute("content", moduleBaseUri + "/contenttemplates/sitemap.jsp");
//request.setAttribute("twoCols", true);
cms.include(moduleBaseUri + "/frametemplates/master.jsp");

%>