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


static Calendar cudate = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
static long cudateMsec = cudate.getTimeInMillis();

%><%

CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
Locale locale = cms.getRequestContext().getLocale();



String thisUri = cms.getRequestContext().getUri();
String labels = "/common/labels/common.xml";

String requestedDate = request.getParameter("date");
if (requestedDate == null) {
	requestedDate = "";
}



%><div class="news listing"><%


// for start page news

String eventsFolder = cms.getRequestContext().getFolderUri();
if ("/ru/".equals(eventsFolder)) 
{
	eventsFolder = cms.getContent(labels, "EventsFolder", locale);
}

I_CmsXmlContentContainer containerTmp = cms.contentload("allInFolderPriorityDateDesc", eventsFolder + "event_${number}.html|event|10000", locale, true);
int resultNum = containerTmp.getCollectorResult().size();

CmsJspTagContentLoad container = new CmsJspTagContentLoad();
container.setPageContext(cms.getJspContext());
container.setCollector("allInFolderPriorityDateDesc");
container.setEditable("true");
container.setLocale(locale.toString());
container.setParam(eventsFolder + "event_${number}.html|event|10000");

// potom
//container.setParam(eventsFolder + "event_${number}.html|event|10000|" + requestedDate + "|" + locale.toString());

container.doStartTag();
boolean firstRun = true;
boolean isMoreContent = true;


while (resultNum > 0 && (firstRun || (isMoreContent = container.hasMoreContent()))) {

    String title = getXmlContentValue(cms, container, "Title", locale);
    String teaser = getXmlContentValue(cms, container, "Teaser", locale);
    String text = getXmlContentValue(cms, container, "Text", locale);
    SimpleDateFormat df = new SimpleDateFormat("dd.MM.yy", locale);
    String dateStart = getXmlContentValue(cms, container, "DateStart", locale);
    String dateEnd = getXmlContentValue(cms, container, "DateEnd", locale);
  
		    %>
		    <div class="news item text">
	            <h4><%= df.format(new Date(Long.parseLong(dateStart))) %><%= ((dateEnd != null) && !"0".equals(dateEnd)) ? " - " + df.format(new Date(Long.parseLong(dateEnd))) : "" %></h4>
	            
	            <h2><a href="<%=cms.link(cms.contentshow(container, "${opencms.filename}")) %>"><%= title %></a></h2>
	            <p><%=teaser %></p>
	            
	            <%if(text != null) {%>
				<p class="right">
	    			<a href="<%=cms.link(cms.contentshow(container, "${opencms.filename}")) %>" class="secondarycolor more"><%= cms.getContent(labels, "TextReadMore", locale) %></a>
				</p>
				<%} %>
				
			</div>

			<%
    firstRun = false;
}




%>
</div>