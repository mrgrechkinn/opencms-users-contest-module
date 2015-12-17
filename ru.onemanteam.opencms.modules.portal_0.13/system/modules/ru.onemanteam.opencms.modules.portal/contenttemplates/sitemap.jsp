<%/*****************************************************************
* Gridnine AB http://www.gridnine.com
* Project: Recipharm
* Legal notice: (c) Gridnine AB. All rights reserved.
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="org.opencms.file.*"
    import="java.util.*"
%><%!

final String checkNavUriProperty(CmsJspActionElement cms, String path) {
    String navUrlProp = cms.property("NavUri", path);
    if(navUrlProp != null && !"".equals(navUrlProp.trim())) {
        return navUrlProp.trim();
    }
    return path;
}

String getNavigationList(String path, CmsJspNavBuilder nav, CmsJspActionElement cms, boolean firstRun) {
    StringBuilder result = new StringBuilder("");
    List<CmsJspNavElement> items = nav.getNavigationForFolder(path);
    int level = CmsResource.getPathLevel(path);
    
    boolean firstElement = true; // megabullshit

    		
    if (items.size() > 0) {
    	if (firstRun) {
    		result.append("<ul id=\"primaryNav\" class=\"col" + (items.size() - 1) + "\">");
    	} else {
    		result.append("<ul>");
    	}
    	
   	    	
        Iterator<CmsJspNavElement> it = items.iterator();
        while (it.hasNext()) {
            CmsJspNavElement ne = it.next();
            String resource = ne.getResourceName();
            String navUri = checkNavUriProperty(cms, resource);
            
            boolean current = cms.getRequestContext().getUri().startsWith(resource);
            
            if (firstElement) {
            	firstElement = false;
            	continue;
            }
            
            result.append("<li");
            
            if ((navUri).equals(cms.getRequestContext().getUri())) {
            	result.append(" class=\"first-child\" ");
            }

            // my hack for IE for not use :last-child
            if (!it.hasNext()) {
            	result.append(" class=\"last-child\" ");
            }
            
       		result.append(">");
            
            
            if (!navUri.startsWith("http")) {
                navUri = cms.link(navUri);
            }
            result.append("<a href=\"" + navUri + "\">" + ne.getNavText() + "</a>");
            if (CmsResource.isFolder(resource) && nav.getNavigationForFolder(resource).size() > 0) {

                result.append(getNavigationList(resource, nav, cms, false));
            }
            result.append("</li>");
            
            
        }
        result.append("</ul>");
        
        firstRun = false;
    }
    return result.toString();
}

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";
Locale locale = cms.getRequestContext().getLocale();
CmsJspNavBuilder nb = cms.getNavigation();
String thisFolder = cms.getRequestContext().getFolderUri();
String thisUri = cms.getRequestContext().getUri();
CmsObject cmsObj = cms.getCmsObject();

List<CmsJspNavElement> bc = null;
String path = null;
boolean isSubFolder = false;
boolean firstRun = true;

int pathLevel = 0;

for (String f = cms.getRequestContext().getFolderUri(); !"/".equals(f); f = CmsResource.getParentFolder(f)) {
    
		isSubFolder = true;
        path = f;
        pathLevel = CmsResource.getPathLevel(path);
        break;
    
}

if (isSubFolder) {
    
	path = CmsResource.getPathPart(thisUri, pathLevel + 1);
    
} else {
    
	bc = nb.getNavigationBreadCrumb(2, 2);
    if (bc.size() > 0) {
        path = bc.get(0).getResourceName();
    }
    
}

cms.include(thisUri, "body", true);

if (path != null) {
%>
<div class="sitemap"><%= getNavigationList("/ru/", nb, cms, firstRun) %></div>
<%
}
%>