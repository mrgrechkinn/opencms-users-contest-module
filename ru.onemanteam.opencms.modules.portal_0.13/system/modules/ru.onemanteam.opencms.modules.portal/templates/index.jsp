<%/*****************************************************************
* Project: TTK-Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

request.setAttribute("content", moduleBaseUri + "/contenttemplates/index.jsp");

request.setAttribute("isBirthDays", true);
request.setAttribute("isTagClouds", true);
request.setAttribute("isContentBg", true);
cms.include(moduleBaseUri + "/frametemplates/master.jsp");

%>