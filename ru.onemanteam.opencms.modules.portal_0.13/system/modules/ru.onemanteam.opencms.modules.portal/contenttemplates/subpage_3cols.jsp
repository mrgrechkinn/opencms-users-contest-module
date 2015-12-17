<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"
    import="org.opencms.file.*"
    import="org.opencms.file.types.CmsResourceTypeImage"

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

String pics = moduleBaseUri + "/resources/pics/";
String labels = "/common/labels/labels.xml";
Locale locale = cms.getRequestContext().getLocale();
String thisUri = cms.getRequestContext().getUri();



%>

        <div class="grid_6 suffix_1 leftcolumn">
			<% cms.include(moduleBaseUri + "/elements/menu-left.jsp"); %>
        	<% cms.include(thisUri, "left", true); %>
		</div>
        
       
        <div class="grid_11 suffix_1 centercolumn">
        	<%// cms.include(moduleBaseUri + "/elements/breadcrumbs.jsp"); %>
			<% cms.include(thisUri, "body", true); %>
		</div>
		
		
        <div class="grid_5 banners rightcolumn">
        	<% cms.include(thisUri, "right", true); %>
        </div>
