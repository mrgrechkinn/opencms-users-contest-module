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
    import="java.text.DateFormatSymbols"
%><%!

final String getXmlContentValue (CmsJspXmlContentBean cms, I_CmsXmlContentContainer container, String name, Locale locale) {
    String par = cms.contentshow(container, name, locale);
    if (par == null || ("".equals(par.trim()))||(par.startsWith("???"))) return null; 
    return par;
}

private static DateFormatSymbols myDateFormatSymbols = new DateFormatSymbols(){

    @Override
    public String[] getMonths() {
        return new String[]{"января", "февраля", "марта",
        					"апреля", "мая", "июня",           
        					"июля", "августа", "сентября", 
        					"октября", "ноября", "декабря"};
    }
    
};

%><%

String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response); 
String thisUri = cms.getRequestContext().getUri();
String labels = "/common/labels/labels.xml";
Locale locale = cms.getRequestContext().getLocale();

I_CmsXmlContentContainer container = cms.contentload("singleFile", thisUri, locale, true);

while (container.hasMoreContent()) {
    String title = getXmlContentValue(cms, container, "Title", locale);
    String date = getXmlContentValue(cms, container, "Date", locale);
    //SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy", locale);
    SimpleDateFormat df = new SimpleDateFormat("dd MMMM yyyy", myDateFormatSymbols);
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
           <h2><a href="index.html#"><%= (title != null) ? title : "" %> </a></h2>
           <p></p>
           <%= (teaser != null) ? teaser : "" %>
           <%= (text != null) ? text : "" %>   	            
	</div>	

       
        

<% } %>