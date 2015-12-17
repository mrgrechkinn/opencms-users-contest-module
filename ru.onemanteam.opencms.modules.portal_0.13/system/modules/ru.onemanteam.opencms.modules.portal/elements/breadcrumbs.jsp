<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="org.opencms.file.*"
    import="java.util.*"
    import="java.text.SimpleDateFormat"

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";
Locale locale = cms.getRequestContext().getLocale();

CmsJspNavBuilder nb = cms.getNavigation();
String thisUri = cms.getRequestContext().getUri();
String thisFolder = cms.getRequestContext().getFolderUri();
CmsObject cmsObj = cms.getCmsObject();
boolean isArticle = request.getAttribute("isArticle") != null;
boolean isNews = request.getAttribute("isNews") != null;
String requestedYear = request.getParameter("year");

int startlevel = 0;
for (String f = cms.getRequestContext().getFolderUri(); !"/".equals(f); f = CmsResource.getParentFolder(f)) {
   /*
	if (!cmsObj.readPropertyObject(f, "Is_Sub_Site", false).isNullProperty()) {
        startlevel = CmsResource.getPathLevel(f);
        break;
    }
   */
}

if (startlevel == 0) {
    startlevel = 1;
}

String title = cms.property("Title", thisUri);

List<CmsJspNavElement> bcList = nb.getNavigationBreadCrumb(startlevel, true);

if (bcList.size() > 0) {
%>
<ul class="breadcrumbs">
<%
    for (int i=0; i<bcList.size();i++) {
        CmsJspNavElement ne = bcList.get(i);
        if (i==0) {
            %><li><a href="<%= cms.link(ne.getResourceName()) %>">Портал</a></li><%
        } else if (i == bcList.size() ) {
            String navText = ne.getNavText();
            %><li>&raquo;</li><li><%= navText == null || "".equals(navText) || navText.startsWith("???") ? cms.property("Title", thisUri) : navText %></li><%
        } else {
            String navText = ne.getNavText();
            %><li>&raquo;</li><li><a href="<%= cms.link(ne.getResourceName()) %>"><%= navText == null || "".equals(navText) || navText.startsWith("???") ? cms.property("Title", ne.getResourceName()) : navText %></a><li><%
        }
    }

    
    if (title != null) {
        %><li>&raquo;</li><%= title %><%
    }
}
%>
</ul>