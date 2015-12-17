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
%><%!

final String getXmlContentValue (CmsJspXmlContentBean cms, I_CmsXmlContentContainer container, String name, Locale locale) {
    String par = cms.contentshow(container, name, locale);
    if (par == null || ("".equals(par.trim()))||(par.startsWith("???"))) return null; 
    return par;
}
%><%

String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response); 
String thisUri = cms.getRequestContext().getUri();
String labels = "/common/labels/labels.xml";
Locale locale = cms.getRequestContext().getLocale();

I_CmsXmlContentContainer container = cms.contentload("singleFile", thisUri, locale, true);

while (container.hasMoreContent()) {
    String title = getXmlContentValue(cms, container, "Title", locale);
    String dateStart = getXmlContentValue(cms, container, "DateStart", locale);
    String dateEnd = getXmlContentValue(cms, container, "DateEnd", locale);
    SimpleDateFormat df = new SimpleDateFormat("dd.MM.yy", locale);
    String teaser = getXmlContentValue(cms, container, "Teaser", locale);
    String text = getXmlContentValue(cms, container, "Text", locale);


    %>
    
    	
    <div class="news item text">
           <h4>
           	<%
			if (date != null && Long.parseLong(date) > 0) { %>
                <%= df.format(new Date(Long.parseLong(date))) %>
            <%}%>
          	</h4>
           <h2><a href="index.html#"><%= title %> </a></h2>
           <%= teaser %>
           <%= text %>   	            
	</div>	

       
        

<% } %>