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

request.setAttribute("isForm", true);
request.setAttribute("isContentBg", true);
request.setAttribute("content", moduleBaseUri + "/contenttemplates/portal_feedback.jsp");
cms.include(moduleBaseUri + "/frametemplates/master.jsp");

%>