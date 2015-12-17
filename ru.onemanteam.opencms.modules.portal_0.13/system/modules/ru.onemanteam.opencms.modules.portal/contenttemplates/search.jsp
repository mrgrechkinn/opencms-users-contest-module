<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"
    import="org.opencms.search.*"
    import="org.opencms.file.*"

%><%!

static final String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
Locale locale = cms.getRequestContext().getLocale();
String labels = "/common/labels/common.xml";


int minQueryLength = 3;
int matchesPerPage = 10;
int searchPage = 1;

if(request.getParameter("searchPage") != null) {
	searchPage = Integer.valueOf(request.getParameter("searchPage")).intValue();
}

if ("POST".equals(request.getMethod()) || "search".equals(request.getParameter("action"))) { // form or paging
   String queryString = request.getParameter("query");
   if(queryString != null) {
	   queryString = queryString.trim();
       } else {
    queryString = "";
}
    

   
   queryString = new String(queryString.getBytes("UTF-8"), "UTF-8");
   
   
   
%><h2 style="margin-top:40px"><%= cms.getContent(labels, "SearchHeading", locale) %>: <%= queryString %></h2><%
   

if(queryString.length() < minQueryLength) {
    	
    	%><%//= cms.getContent(labels, "QueryLengthSmall", locale).replaceAll("\\$\\{QueryMinLength\\}", String.valueOf(minQueryLength)) %><%
    	%>Слишком короткое ключевое слово для поиска.<%
    		
	} else {
	    	
	    	if (searchPage == 1) {
	    	
		    	%>
				<div style="background:#fff;margin-top:0;" class="center birthdays">
				<div id="foundPersons" class="container_24 content"></div>
				<script type="text/javascript">
		
				$(document).ready(function(){
		
					queryString = "<%=queryString%>";
					serchPersonsUri = "http://kttk-jbp1app1.transtk.ru:8080/orgstruct-ws/ObjectProxy/rest/json/searchPersonsByName?maxRecords=1000&name=";
					photoUri = "http://kttk-jbp1app1.transtk.ru:8080/orgstruct-ws/AttachmentLoader?id=";
					
					$.ajax({
						url: serchPersonsUri  + queryString ,
						
					    dataType: 'json',
						crossDomain: 'true',
					    success:function(data){
					    	
					    	var html = "";
					    	var entries = data.response.rows;  
		
					    	if (entries.length > 0) {
					    	
					    		for (var i = 0; i < entries.length; i++) {
					    			var entry = entries[i];
					    			
					    			html += '<div class="person left grid_6" id="' + entry.id + '">';
				    					
					    			if (entry.photo == ''  || entry.photo =='undefined' || entry.photo == null) {
					    				html += '<div class="photo" style="background-image:url(\'<%=cms.link("/common/images/no-photo.jpg")%>\')">&nbsp;</div>';
					    			} else {
					    				html += '<div class="photo" style="background-image:url(' + photoUri + entry.photo +')">&nbsp;</div>';	
					    			}
				    				
				    				html += '<h4>' + entry.displayName.replace(' ', '<br/>') + '</h4>';
					    			html += '<p>' + entry.position + '</p>';
					    			html += '</div>';
					    			
					    		}

				    			$("#foundPersons").html(html);
					    	}
					    	
					    },
						error:function(){
							
					    },
					});
		
				});
		
		
				</script>
				<script src="<%= cms.link(moduleBaseUri + "/resources/js/orgstucture.js")%>"></script>
				</div>
			<%
			}    	
		
		
/* ----------------------------------------------------------------------------------------------------------------------- */		
		
		
		CmsSearch search = new CmsSearch();
	    search.init(cmsObj);
	
	    
	    String index = locale.toString() + " " + (cms.getRequestContext().currentProject().isOnlineProject() ? "online" : "offline");
	    search.setIndex(index);
	    search.setField(new String[] {"title", "content"});
	    search.setQuery(queryString); 
	    search.setQueryLength(minQueryLength);
	    search.setSearchPage(0);
	    
	    int total = search.getSearchResult() != null ? search.getSearchResult().size() : 0;
	  
	    search.setMatchesPerPage(matchesPerPage);
		search.setSearchPage(searchPage);
	    
		
		
		
	    List<CmsSearchResult> result = search.getSearchResult();
	    
	    
	    if (total == 0) {
	    
	    	%><%= cms.getContent(labels, "NothingFound", locale) %><%
	    
	    } else {
	    	
	        %><%= cms.getContent(labels, "SearchResultCountHeading", locale).replaceAll("\\$\\{ArticleHits\\}", String.valueOf(total)) %>
	        <%	
	        Iterator<CmsSearchResult> it = result.iterator();
	        while(it.hasNext()) { 
	            CmsSearchResult searchItem = it.next();
	            String link = cms.getRequestContext().removeSiteRoot(searchItem.getPath());
	            CmsProperty value = cmsObj.readPropertyObject(link, "Title", link.endsWith("/index.html"));
	            
	            String title = value.isNullProperty() ? null : value.getValue(); 
	            String excerpt = searchItem.getExcerpt();
	            
	            %><div class="searchResultItem">
	                <h1><a href="<%=cms.link(link) %>"><%=(title == null) ? cms.getContent(labels, "UntitledResource", locale) : title %></a></h1>
	                <h2><a href="<%=cms.link(link) %>"><%=cms.link(link) %></a></h2>
	                
	                <% if (excerpt != null) { %><%= excerpt %><% } %>
	                <!-- a class="linkNext" href="<%=cms.link(link) %>"><%=cms.getContent(labels, "ReadMore", locale) %></a-->
	              </div>
	            <%
	        }
	        
	    }
	
	    Map<Integer, String> pages = search.getPageLinks();
	    Iterator<Integer> it2 = pages.keySet().iterator();
	
	    
	    
	   
	    if (!pages.isEmpty() && total > matchesPerPage) {
	        %><ul class="pagination"><%
	        int pagesTotal = (int)Math.ceil((float)total / matchesPerPage);
	        int pageIndex = 1;
	
	        String pageIndexParam = request.getParameter("searchPage");
	        if (pageIndexParam != null) {
	            try {
	                pageIndex = Integer.parseInt(pageIndexParam);
	            } catch (Throwable e) {
	            	//noop
	            }
	        }
	
	        if (pageIndex > 1) {
	            %><li><a class="linkPrev" href="<%= cms.link(pages.get(pageIndex - 1)) %>">&laquo;<%//= cms.getContent(labels, "Previous", locale) %></a></li><%
	        }
	        while(it2.hasNext()) {
	            Integer i = it2.next();
	            if(("" + i).equals("" + searchPage)) {
	                
	                %><li class="active"><a href="#"><%=i %></a></li><%
	            } else {
	            	   %><li><a href="<%=cms.link(pages.get(i)) %>"><%=i %></a></li><%
	            }
	        }
	        if (pageIndex < pagesTotal) {
	            %><li><a class="linkNext" href="<%= cms.link(pages.get(pageIndex + 1)) %>">&raquo;<%//= cms.getContent(labels, "Next", locale) %></a></li><%
	        }
	        %></ul><%
	    }
	    
	
	}
}

%>