<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"
    import="org.opencms.file.CmsResource"

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";
String pics = moduleBaseUri + "/resources/pics/";
Locale locale = cms.getRequestContext().getLocale();

CmsJspNavBuilder nb = cms.getNavigation();
String thisUri = cms.getRequestContext().getUri();

String current = CmsResource.getPathPart(thisUri, 2);
String last_segment = CmsResource.getPathPart(thisUri, 3);
List items = nb.getNavigationForFolder(current);
List bCrumb = nb.getNavigationBreadCrumb(2, true);



//breadcrumbs and sub_navigations
//cms.include(moduleBaseUri + "/elements/navBar.jsp");


%>
	<div class="grid_6 suffix_1 leftcolumn">
		<% cms.include(moduleBaseUri + "/elements/menu-left.jsp"); %>
		<% //cms.include(thisUri, "left", true); %>
	</div>
		
	<div class="grid_11 suffix_1 centercolumn">
		<%
		//cms.include(moduleBaseUri + "/elements/breadcrumbs.jsp");
		cms.include(moduleBaseUri + "/elements/press_listing.jsp");
		%>
	</div>