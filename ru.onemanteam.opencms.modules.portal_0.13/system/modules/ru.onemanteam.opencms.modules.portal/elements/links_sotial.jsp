<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@page language="java"
	session="true"
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="org.opencms.jsp.*"
	import="org.opencms.util.*"
	import="java.util.*"
    import="java.text.SimpleDateFormat"
	import="com.gridnine.commons.util.*"
	import="org.opencms.i18n.CmsMessages"

%><%

CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response);
Locale locale = cms.getCmsObject().getRequestContext().getLocale();


%>

<ul class="menu center li10">
<%

if (cms.getCmsObject().existsResource("/common/labels/links_sotial.xml")) {

	I_CmsXmlContentContainer container = cms.contentload("singleFile", "/common/labels/links_sotial.xml", true);

	while (container.hasMoreContent()) {
		CmsJspTagContentLoop container2 = (CmsJspTagContentLoop)cms.contentloop(container, "ElementEntry");
		while (container2.hasMoreContent()) {

			String elementIcon = cms.contentshow(container2, "ElementIcon", locale);
			String elementUrl = cms.contentshow(container2, "ElementUrl", locale);

			if (!CmsMessages.isUnknownKey(elementIcon)) {
				%><li><a href="<%= cms.link(elementUrl) %>"><img src="<%= cms.link(elementIcon)%>"/></a></li><%
						
			}
		}
		
	}
}
%>
</ul>
