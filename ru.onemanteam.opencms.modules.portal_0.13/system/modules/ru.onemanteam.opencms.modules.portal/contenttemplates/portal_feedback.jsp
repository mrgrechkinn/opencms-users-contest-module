<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="org.opencms.main.*"
    import="org.opencms.file.*"
    import="java.util.*"
    import="org.opencms.file.collectors.*"
    import="java.text.SimpleDateFormat"
%><%!

static final String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

%><%


CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
Locale locale = cms.getRequestContext().getLocale();

String thisUri = cms.getRequestContext().getUri();

String pics = moduleBaseUri + "/resources/pics/";
String labels = "/common/labels/labels.xml";

boolean isForm = request.getAttribute("isForm") != null;


if (isForm) {

%>

         <div class="grid_6 suffix_1 leftcolumn">
			<% cms.include(moduleBaseUri + "/elements/menu-left.jsp"); %>
			<% cms.include(thisUri, "left", true); %>
		</div>
        
         <div class="grid_15 suffix_1 centercolumn">
        	<% //cms.include(moduleBaseUri + "/elements/breadcrumbs.jsp"); %>
			<% cms.include("/system/modules/com.alkacon.opencms.formgenerator/pages/form.jsp"); %>
		</div>

<% 
} %>