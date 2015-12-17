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



String labels = "/common/labels/common.xml";

boolean orgStructure = request.getAttribute("orgStructure") != null;

%>



$(document).bind('keydown', function(e) { 
    if (e.which == 27) {
    	$('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
    	$('#simplePopup').addClass('hidden');
    }
}); 

$(document).on('click', '#closeMe', function() {
	$('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
	$('#simplePopup').addClass('hidden');
});


$(document).ready(function(){
		

	$('#ex2').zoom();
	

	$("body").append("<div id='simplePopup' class='hidden'></div>");

		//align element in the middle of the screen
		$.fn.alignCenter = function() {
			var marginLeft =  - $(this).width()/2 + 'px';
			var marginTop =  - $(this).height()/2 + 'px';
			return $(this).css({'margin-left':marginLeft, 'margin-top':marginTop});
		};

		
		$.fn.togglePopup = function(){

			
	     if($('#simplePopup').hasClass('hidden'))
	     {
	       //when IE - fade immediately
	       if($.browser.msie)
	       {
	         $('#opaco').height($(document).height()).toggleClass('hidden')
	                    .click(function(){$(this).togglePopup();});
	       }
	       
	       //in all the rest browsers - fade slowly
	       else       
	       {
	         $('#opaco').height($(document).height()).toggleClass('hidden').fadeTo('slow', 0.7)
	                    .click(function(){$(this).togglePopup();});
	       }

	       $('#simplePopup')
	         .html($(this).html())
	         .alignCenter()
	         .toggleClass('hidden');
	     }
	     else
	     {
	    	 
	    	 //visible - then hide
	    	 $('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
	       $('#simplePopup').toggleClass('hidden');
	     }
	   };

	   
	   html = '<div class="zoom" id="ex2"><img height="600px" rel="http://10.110.55.40/portal/opencms/common/images/Images2/4-5-19Gif.gif" src="http://10.110.55.40/portal/opencms/common/images/Images2/4-5-19Gif.gif" alt="" /></div>';
	   html += "<div style='position:absolute;bottom:5px;right:10px;font-size:10px;cursor:pointer;'><span id='closeMe'>Закрыть (ESC)</span></div>";
	   
	   $('#ex2').zoom();
	   $('#simplePopup').html(html);
	   $('#simplePopup').togglePopup();


});