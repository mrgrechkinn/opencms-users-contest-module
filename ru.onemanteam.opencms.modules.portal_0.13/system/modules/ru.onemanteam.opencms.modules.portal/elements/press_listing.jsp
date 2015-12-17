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

CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
Locale locale = cms.getRequestContext().getLocale();


//String thisFolder = cms.getRequestContext().getFolderUri();


String thisUri = cms.getRequestContext().getUri();
String labels = "/common/labels/common.xml";


//String newsFolder = cms.getContent(labels, "PressFolder", locale);
//for start page press
String newsFolder = cms.getRequestContext().getFolderUri();
if ("/ru/".equals(newsFolder)) 
{
	newsFolder = cms.getContent(labels, "PressFolder", locale);
}



I_CmsXmlContentContainer containerTmp = cms.contentload("allInFolderPriorityDateDesc", newsFolder + "news_${number}.html|news|10000", locale, true);
int resultNum = containerTmp.getCollectorResult().size();

boolean indexPage = false;
int pageSize = 10;


if (thisUri.equals("/" + locale + "/index.html")) {
	indexPage = true;
    pageSize = 5;
}



%><div class="press listing" style="<%= (indexPage) ? "display:none;" : "" %>"><%



if(request.getAttribute("pageSize") != null) {
    pageSize = ((Integer)request.getAttribute("pageSize")).intValue();
}
int pageIndex = 1;
String pageIndexParam = request.getParameter("page_index");
if (pageIndexParam != null) {
    try {
        pageIndex = Integer.parseInt(pageIndexParam);
    } catch (Throwable e) {}
}

CmsJspTagContentLoad container = new CmsJspTagContentLoad();
container.setPageContext(cms.getJspContext());
container.setCollector("allInFolderPriorityDateDesc");
if(!indexPage) {
	container.setEditable("true");
}
container.setLocale(locale.toString());
container.setPageIndex(pageIndex + "");
container.setPageSize((resultNum < pageSize ? resultNum : pageSize) + "");
container.setParam(newsFolder + "news_${number}.html|news|10000");
container.doStartTag();
boolean firstRun = true;
boolean isMoreContent = true;


while (resultNum > 0 && (firstRun || (isMoreContent = container.hasMoreContent()))) {

    String title = getXmlContentValue(cms, container, "Title", locale);
    String teaser = getXmlContentValue(cms, container, "Teaser", locale);
    String text = getXmlContentValue(cms, container, "Text", locale);
    //SimpleDateFormat df = new SimpleDateFormat("dd MMMM yyyy", locale);
    SimpleDateFormat df = new SimpleDateFormat("dd MMMM yyyy", myDateFormatSymbols);
    String date = getXmlContentValue(cms, container, "Date", locale);
    String news_tags = (getXmlContentValue(cms, container, "Tags", locale) != null) ? getXmlContentValue(cms, container, "Tags", locale) : "";
    
    boolean hideLink = (date == null || Long.parseLong(date) == 0) && cms.getRequestContext().currentProject().isOnlineProject();
    if (!hideLink) { 
    
    	
    	
	    %>
	    <div class="press item text">
            <h4><%= df.format(new Date(Long.parseLong(date))) %></h4>
            <h2><a href="<%=cms.link(cms.contentshow(container, "${opencms.filename}")) %>"><%= title %></a></h2>
            <p><%=teaser %></p>
            
            <%if(text != null) {%>
			<p class="right">
    			<a href="<%=cms.link(cms.contentshow(container, "${opencms.filename}")) %>" class="secondarycolor more"><%= cms.getContent(labels, "TextReadMore", locale) %></a>
			</p>
			<%} %>
			
		</div>

		<%
	
    }
    firstRun = false;
}


if(indexPage) {

	%>
	<p class="center">
    <a href="<%=cms.link(newsFolder)%>" class="maincolor  more w225"><%= cms.getContent(labels, "MoreNewsText", locale) %></a>
	</p>
	<%

}





if( resultNum > pageSize && !indexPage ) {
    %><ul class="pagination"><%
    int pagesTotal = (int)Math.ceil((float)resultNum / pageSize);
    if (pageIndex > 1) {
        %><li><a class="linkPrev" href="<%= cms.link(thisUri + "?page_index=" + (pageIndex - 1)) %>">&laquo;<%//= cms.getContent(labels, "TextPrevious", locale) %></a></li><%
    }

   

    for (int i = 1; i <= pagesTotal; i++) {
	
	if ((i > pageIndex +5) || (i  < pageIndex -5)) continue;
	
        boolean isCurrent = (i == pageIndex) ? true : false;
        %><%= ((isCurrent) ? "<li class=\"active\"><a href=\"#\">" : "<li><a href=\"" + cms.link(thisUri + "?page_index=" + i) + "\">") + i + ((isCurrent) ? "</a></li>" : "</a></li>") %><%
    }
    

    
    if (pageIndex < pagesTotal) {
        %><li><a class="linkNext" href="<%= cms.link(thisUri + "?page_index=" + (pageIndex + 1)) %>">&raquo;<%//= cms.getContent(labels, "TextNext", locale) %></a></li><%
    }
    %></ul><%
}

%>
</div>