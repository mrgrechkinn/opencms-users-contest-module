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

String getNavigationList(String path, CmsJspNavBuilder nav, CmsJspActionElement cms, boolean firstElement) {
    StringBuilder result = new StringBuilder("");
    List<CmsJspNavElement> items = nav.getNavigationForFolder(path);
    int level = CmsResource.getPathLevel(path);
    
   		
    if (items.size() > 0) {
    	result.append("<ul");
    	result.append((level == 1) ? " class=\"topmenu uppercase\"" : " class=\"hovermenu\"" );
    	result.append(">");
        Iterator<CmsJspNavElement> it = items.iterator();

    	if (level == 2) {
    		result.append("<li class=\"arrow\">&nbsp;</li>");
    		
    	}

    	
        while (it.hasNext()) {
        	
        	//if (level > 1) break; // waitiong for VN
      	
            
        	CmsJspNavElement ne = it.next();
            String resource = ne.getResourceName();
            boolean current = cms.getRequestContext().getUri().startsWith(resource);
            //result.append("<li class=\"menu-item " + (firstElement ? " alpha " : "") + (current ? " active" : "") + "\">");
            
            result.append("<li" + (firstElement ? " class=\"home\"" : "") + ">");
            firstElement = false; //bullshit for the first element
            
            String navUri = checkNavUriProperty(cms, resource);
            if (!navUri.startsWith("http")) {
                navUri = cms.link(navUri);
            }
            result.append("<a href=\"" + navUri + "\">" + ne.getNavText() + "</a>");
            if (CmsResource.isFolder(resource) && nav.getNavigationForFolder(resource).size() > 0 && level < 2 ) {

                result.append(getNavigationList(resource, nav, cms, false));
            }
            result.append("</li>");
        }
        
        //result.append("<li><a href=\"#\" id=\"searchlink\"><img src=\"./css/img/zoom.png\"></a><input type=\"search\" name=\"search\"></li>");
        
        if (level == 1) {


        	
        	result.append("<li class=\"search-block\">");
        	result.append("<form action=\"" + cms.link("/ru/" + "search.html")  + "\" method=\"post\" id=\"search\">");        	
        	result.append("<span id=\"searchlink\"><img src=\"" +cms.link("/portal/opencms/system/modules/ru.onemanteam.opencms.modules.portal/resources/css/img/zoom.png") + "\" alt=\"\"></span>");
        	result.append("<input type=\"search\" name=\"query\" >");
        	//result.append("</span><input type=\"search\" name=\"query\">");
        	result.append("</form></li>"); 

        }
        
        result.append("</ul>");
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

if (path != null) {
%><%= getNavigationList("/ru/", nb, cms, true) %><%
}
%>
