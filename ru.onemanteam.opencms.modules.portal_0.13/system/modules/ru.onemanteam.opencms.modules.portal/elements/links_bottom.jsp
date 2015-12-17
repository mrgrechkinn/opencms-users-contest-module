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

<ul class="menu uppercase downtarget">
<%

if (cms.getCmsObject().existsResource("/common/labels/links_bottom.xml")) {

	I_CmsXmlContentContainer container = cms.contentload("singleFile", "/common/labels/links_bottom.xml", false);

	while (container.hasMoreContent()) {
		CmsJspTagContentLoop container2 = (CmsJspTagContentLoop)cms.contentloop(container, "ElementEntry");
		while (container2.hasMoreContent()) {
			String elementText = cms.contentshow(container2, "ElementText", locale);
			String elementUrl = cms.contentshow(container2, "ElementUrl", locale);

			if (!CmsMessages.isUnknownKey(elementText)) {
				%><li><h4><a href="<%= cms.link(elementUrl) %>"><%= elementText %></a></h4></li><%
			}
		}
		
	}
}
%>

</ul>
