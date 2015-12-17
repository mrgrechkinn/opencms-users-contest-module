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
    import="java.text.SimpleDateFormat"
%><%!

static final String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

%><%


CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
Locale locale = cms.getRequestContext().getLocale();

String thisUri = cms.getRequestContext().getUri();



/*

https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSectionList
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSectionList?sectionId=137d902d-567f-4053-b2f5-4dc6681a357e
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSectionPersonsList?sectionId=7fdd588d-1d31-45fb-8561-c3625a4f5e05
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSection?sectionId=7fdd588d-1d31-45fb-8561-c3625a4f5e05
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getPerson?personId=41f95224-aeb9-4fa7-996e-5c6cd3d96f91
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/searchPersonsByName?name=Р�РІР°РЅРѕРІ
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getContactsForPerson?personId=41f95224-aeb9-4fa7-996e-5c6cd3d96f91

*/



String labels = "/common/labels/common.xml";

boolean orgStructure = request.getAttribute("orgStructure") != null;

%>

		<script src="<%= cms.link(moduleBaseUri + "/resources/js/orgstucture.js")%>"></script>

        <div class="grid_6 suffix_1 leftcolumn">
			<% cms.include(moduleBaseUri + "/elements/menu-left.jsp"); %>
			<% cms.include(thisUri, "left", true); %>
		</div>
        
        <div class="grid_11 suffix_1 centercolumn">
        	<ul id="orgStruct"></ul>
		</div>
		
		<!-- div id="personPopup" class="hidden"></div>
		<div class="personInfo"></div-->		



