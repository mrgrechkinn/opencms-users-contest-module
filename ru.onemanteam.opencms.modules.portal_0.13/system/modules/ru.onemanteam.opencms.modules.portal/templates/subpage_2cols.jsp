<%/*****************************************************************
* Project: TTK
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

String pics = moduleBaseUri + "/resources/pics/";
String labels = "/common/labels/labels.xml";
Locale locale = cms.getRequestContext().getLocale();
String thisUri = cms.getRequestContext().getUri();

//request.setAttribute("left_column", moduleBaseUri + "/elements/left_column.jsp");

request.setAttribute("content", moduleBaseUri + "/contenttemplates/subpage_2cols.jsp");
request.setAttribute("twoCols", true);
request.setAttribute("isContentBg", false);

cms.include(moduleBaseUri + "/frametemplates/master.jsp");

%>