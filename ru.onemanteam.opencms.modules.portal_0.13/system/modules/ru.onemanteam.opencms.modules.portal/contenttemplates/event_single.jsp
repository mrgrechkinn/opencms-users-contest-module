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

String labels = "/common/labels/common.xml";
String newsFolder = cms.getContent(labels, "NewsFolder", locale);

CmsJspNavBuilder nb = cms.getNavigation();
String thisUri = cms.getRequestContext().getUri();

String current = CmsResource.getPathPart(thisUri, 2);
String last_segment = CmsResource.getPathPart(thisUri, 3);
List items = nb.getNavigationForFolder(current);
List bCrumb = nb.getNavigationBreadCrumb(2, true);



//breadcrumbs and sub_navigations
//cms.include(moduleBaseUri + "/elements/navBar.jsp");


%>

    <div class="grid_6 suffix_1 center leftcolumn">
    
		<% cms.include("/system/modules/com.alkacon.opencms.calendar/elements/calendar-side-month.jsp"); %>
			<% cms.include(moduleBaseUri + "/elements/menu-left.jsp"); %>
	</div>
        
	<div class="grid_15 suffix_1 centercolumn">
	      
      	<%// cms.include(moduleBaseUri + "/elements/breadcrumbs.jsp"); %>
      	<!--  a href="<%=cms.link(newsFolder)%>">&laquo; Все новости</a -->
		<% cms.include("/system/modules/com.alkacon.opencms.calendar/pages/detail-entry.jsp"); %>

	</div>
