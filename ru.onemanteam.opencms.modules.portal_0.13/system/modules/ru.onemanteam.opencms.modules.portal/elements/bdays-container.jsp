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

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";
String pics = "/common/images/site_icons/";
String mordes = moduleBaseUri + "/resources/pics";
Locale locale = cms.getRequestContext().getLocale();
String thisUri = cms.getRequestContext().getUri();

boolean indexPage = false;

int dayPeriod = 7;

if (thisUri.equals("/" + locale + "/index.html")) {
	indexPage = true;
	dayPeriod = 1;
}


%>


<script type="text/javascript">

var indexPage = <%=indexPage%>;

String.prototype.replaceAll = function(search, replace){
	  return this.split(search).join(replace);
	}



function sortByKey(array, key) {
    return array.sort(function(a, b) {
        var x = new Date(a[key]); 
        x.setFullYear(0000);
        var y = new Date(b[key]);
        y.setFullYear(0000);
        
        
        return ((x < y) ? -1 : ((x > y) ? 1 : 0));
    });
}


function processData(data) {
	
	var html = "";
	var hidden  = "";
	var entries = data.response.cpersons;  

	for(var i = entries.length-1; i--;){
	
		if (entries[i].position == "Агент") entries.splice(i, 1);
	}
	
	/*
	entries.sort(function(a, b) {
		var a = new Date(a.bdate.replaceAll('.', '-'));
		var b = new Date(b.bdate.replaceAll('.', '-'));
		return a<b?-1:a>b?1:0;
	});
	*/
	entries = sortByKey(entries, 'bdate');
	
	if (entries.length > 0) {
		for (var i = 0; i < entries.length; i++) {
			var entry = entries[i];

			
			if (hereWeGo[entry.photo] != undefined) continue; //cheaters
			
			
			if(indexPage) {
				hidden = (i>=4) ? "hidden" : "";
			}
			
			
			html += '<div class="person left grid_6 ' + hidden +'" id="' + entry.id + '">';
			
			if (entry.photo == ''  || entry.photo =='undefined' || entry.photo == null) {
				
				if (ie < 9) {
					html += '<div class="photo" style="filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\'<%=cms.link("/common/images/no-photo.jpg")%>\', sizingMethod=\'scale\');-ms-filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\'<%=cms.link("/common/images/no-photo.jpg")%>\', sizingMethod=\'scale\')";">&nbsp;</div>';
				} else {
					
					html += '<div class="photo" style="background-image:url(\'<%=cms.link("/common/images/no-photo.jpg")%>\')">&nbsp;</div>';
				}

			
			} else {
				
				if (ie < 9) { 
				
					html += '<div class="photo" style="filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=' + photoUri + entry.photo +', sizingMethod=\'scale\');-ms-filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(src=' + photoUri + entry.photo +', sizingMethod=\'scale\')";">&nbsp;</div>';
				
				} else {
					
					html += '<div class="photo" style="background-image:url(' + photoUri + entry.photo +')">&nbsp;</div>';					
					
				}
				
				

				

			}
			
			if(!indexPage) {
				html += '<div style="">' + entry.bdate.substring(0, 5) + '</div>';
			}
			html += '<h4>' + entry.name.replace(' ', '<br/>') + '</h4>';
			
			
			
			html += '<p>' + entry.position + '</p>';
			html += '</div>';
			
		}
		

		if ((indexPage)&&(entries.length>4)) {
			html += '<p class="center"><a  style="margin-left:40px" href="#" class="maincolor more w225">Все дни рождения на сегодня</a></p>';
		}
		
		$("#bdcontainer").html(html);

	}
}




$(document).ready(function()
{

	var hereWeGo = {
			'b5cbd8d1-b60e-449b-b352-c2f16f51d346':'corwin', 
			'308e6649-39f9-49f4-a4b6-3c07bef9b021':'scorpion'
			};
	
	
	
	bdaysUri = "http://10.110.56.40/orgstruct-ws/ObjectProxy/rest/json/birthdays?date=";
	photoUri = "http://10.110.56.40/orgstruct-ws/AttachmentLoader?id=";
	
	
	
	
	
	var day = new Date();
	day.setDate(day.getDate() + <%=dayPeriod%>);

	var dd = day.getDate();
	var mm = day.getMonth()+1; 
	var yyyy = day.getFullYear();

	dd = (dd<10) ? '0' + dd : dd;
	mm = (mm<10) ? '0' + mm : mm;
	
	//alert( mm + '.' + dd + '.' + yyyy );

	
	
	
	if ($.browser.msie && window.XDomainRequest) {
    
		// Use Microsoft XDR
    	var xdr = new XDomainRequest();
    	xdr.open("get",  bdaysUri + dd + '.' + mm + '.' + yyyy);
    	xdr.onload = function () {
    
    	var JSON = $.parseJSON(xdr.responseText);
    	
    	if (JSON == null || typeof (JSON) == 'undefined')
    	{
        	JSON = $.parseJSON(data.firstChild.textContent);
    	}
    		processData(JSON);
    	};
    	xdr.send();
	
	} else {
	
		$.ajax({
			url: bdaysUri + dd + '.' + mm + '.' + yyyy,
		    cache: false, 
        
			dataType: "json",
        
		    success:function(data){
				
		    	processData(data);
		    	
		    },
		    error: function(XMLHttpRequest, textStatus, errorThrown) {alert(textStatus);}
		});
	
	}

	

	
	
  
});
</script>
<script src="<%= cms.link(moduleBaseUri + "/resources/js/orgstucture.js")%>"></script>

<%if(indexPage) { %>
	<div class="stripe center birthdays" style="min-height:215px">
	    <h2 class="uppercase spacing1">Поздравляем сегодня</h2>
	    <hr class="darkgray">
	    
	    <div class="container_24" id="bdcontainer"></div>
	
	</div>
<%} else {%>
	<div class=" center birthdays" style="background:transparent;margin-top:0;">
		<h2 class="uppercase spacing1"><% cms.include(thisUri, "body", true); %></h2>
	    <div class="container_24" id="bdcontainer"></div>
	</div>
<%}%>