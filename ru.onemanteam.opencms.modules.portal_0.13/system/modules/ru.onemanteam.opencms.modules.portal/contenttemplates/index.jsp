<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"
    import="org.opencms.file.*"
    import="org.opencms.file.types.CmsResourceTypeImage"

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

String pics = moduleBaseUri + "/resources/pics/";
String labels = "/common/labels/labels.xml";
Locale locale = cms.getRequestContext().getLocale();
String thisUri = cms.getRequestContext().getUri();


%>
    <div class="grid_6 suffix_1 center leftcolumn">

        <% cms.include(thisUri, "left", true); %>
        
        <ul class="menu center li10" style="display:block">
			<% cms.include(moduleBaseUri + "/elements/links_sotial.jsp"); %>
        </ul>
        <!-- here was calendar br /><br /-->
	<% cms.include(thisUri, "left_bottom", true); %>
    </div>

	
	<div class="grid_11 suffix_1 centercolumn">
        <div class="left">
            
            <div class="switcher">
                <div class="active news center">
                    <a class="news" href="#">Новости</a>
                </div>
                <div class="press center">
                    <a class="press" href="#">Пресса о нас</a>
                </div>
            </div>
            
        </div>
        <hr class="secondarycolor">
        
        
        <% cms.include(moduleBaseUri + "/elements/news_listing.jsp");%>
        <% cms.include(moduleBaseUri + "/elements/press_listing.jsp");%>
    
     </div>
        
    
    <div class="grid_5 banners rightcolumn">
    	<% cms.include(thisUri, "right_top", true); %>
    	<% cms.include("/system/modules/com.alkacon.opencms.calendar/elements/calendar-side-month.jsp"); %>
		<%/* cms.include(moduleBaseUri + "/elements/tags_cloud.jsp"); */%>
		<% cms.include(thisUri, "right_bottom", true); %>
		
		
    </div>
</div>
	
	
	
	
	<!-- div class="content treecols">
		
		
		<div id="tabs">

		    <a href="#" id="tab1" class="visible" style="font-size:16px">Новости</a>&nbsp;&nbsp;&nbsp;&nbsp;
		    <a href="#" id="tab2" style="font-size:16px">Пресса о нас</a>
		    
		    <div id="con_tab1" class="visible"><%// cms.include(moduleBaseUri + "/elements/news_listing.jsp");%></div>
		    <div id="con_tab2"><%// cms.include(moduleBaseUri + "/elements/press_listing.jsp");%></div>
		</div>​
		
	</div-->

<!-- Startpage is OK -->