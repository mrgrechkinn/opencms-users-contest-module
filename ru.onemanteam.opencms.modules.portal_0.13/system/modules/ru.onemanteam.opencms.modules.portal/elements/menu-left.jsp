<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="org.opencms.file.*"
    import="java.util.*"
        
    import="org.opencms.main.CmsException"
    
%><%!

final String checkNavUriProperty(CmsJspActionElement cms, String path) {
    String navUrlProp = cms.property("NavUri", path);
    if(navUrlProp != null && !"".equals(navUrlProp.trim())) {
        return navUrlProp.trim();
    }
    return path;
}

String getNavigationList(String path, CmsJspNavBuilder nav, CmsJspActionElement cms) {

    String thisUri = cms.getRequestContext().getUri();
    String thisFolder = cms.getRequestContext().getFolderUri();

    CmsObject cmsObject = cms.getCmsObject();
    
    
    //int currentLevel = CmsResource.getPathLevel(thisUri);
    
	StringBuilder result = new StringBuilder("");
    List<CmsJspNavElement> items = nav.getNavigationForFolder(path);
    if (items.size() > 0) {
    	/*
    	if (items.size() > 1) {
    		result.append("<ul class=\"leftmenu nopadding\">");
    	} else {
	    	result.append("<ul class=\"leftmenu submenu\">");
    	}
    	*/
    	


   		result.append("<ul class=\"submenu\">");
    	
        Iterator<CmsJspNavElement> it = items.iterator();
        while (it.hasNext()) {
            CmsJspNavElement ne = it.next();
            String resource = ne.getResourceName();
            
            
            
            boolean pointed = false;
            
  			// .html 
            if (thisUri.equals(checkNavUriProperty(cms,resource))) {
            	pointed = true;
            }
			
  			// folders
            else if  ( CmsResource.isFolder(resource) && (thisUri).equals(checkNavUriProperty(cms, resource)+"index.html") ){
            	pointed = true;
            } 
            

           
           
            boolean current = cms.getRequestContext().getUri().startsWith(resource);
            
            result.append("<li" + (pointed ? " class=\"pointed\"" : "") + ">");
            String navUri = checkNavUriProperty(cms, resource);
            if (!navUri.startsWith("http")) {
                navUri = cms.link(navUri);
            }
            
          
            if (CmsResource.isFolder(resource) && nav.getNavigationForFolder(resource).size() > 0 && current) {
            	result.append("<a " + (current ? " class=\"active\"" : "") +  " href=\"" + navUri + "\">" + ne.getNavText() + "</a>");
            	result.append(getNavigationList(resource, nav, cms));
            } else {
            	result.append("<a " + (current ? " class=\"active\"" : "") +  " href=\"" + navUri + "\">" + ne.getNavText() + "</a>");
            }
            
            result.append("</li>");
        }
        result.append("</ul>");
    }
    return result.toString();
}



%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "ru.onemanteam.opencms.modules.portal";
Locale locale = cms.getRequestContext().getLocale();
CmsJspNavBuilder nb = cms.getNavigation();

String thisFolder = cms.getRequestContext().getFolderUri();
String thisUri = cms.getRequestContext().getUri();

CmsObject cmsObj = cms.getCmsObject();

List<CmsJspNavElement> bc = null;
String path = null;


bc = nb.getNavigationBreadCrumb(2, 2);


if (bc.size() > 0) {
	path = bc.get(0).getResourceName();
}


if (path != null) {
%>
<div class="menu-left">
	<%= getNavigationList(path, nb, cms) %>
 </div>
<%
}
%>
