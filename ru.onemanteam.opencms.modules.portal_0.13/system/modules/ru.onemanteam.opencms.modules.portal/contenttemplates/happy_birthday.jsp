<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";


cms.include(moduleBaseUri + "/elements/bdays-container.jsp");

%>