<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page buffer="none" 
	session="false"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.alkacon.opencms.formgenerator.*"
	import="java.lang.*"
	import="java.util.*"
%><%


	// initialize the form report bean
	CmsFormReport cms = new CmsFormReport(pageContext, request, response);
	
	if (cms.isLoadDynamic() && !cms.isShowReport()) {
		out.print(cms.getReportDataDynamic());
	} else {
		// show report output
		pageContext.setAttribute("cms", cms);

	
%>

	<script type="text/javascript">
	var data = <%= cms.getReportData()%>
	//var data = [[1382959415565,"234234","32 42342 ",""],[1382959410201,"test","test",""],[1382959410201,"test","test",""]];
	
	
	for(var i=0; i<data.length; i++) {
		
			if (data[i][3].length == 0) continue;
			
			document.write("<div style='margin-bottom:25px;'>");
			document.write("<h4 class='faq_date'>" + timeConverter(data[i][0]) + "</h4>");
			
			document.write("<h2 class='faq_theme'>" + data[i][1] + "</h2>");
			document.write("<div class='faq_question' style='cursor: pointer;'><p></p><p>" + data[i][2] + "</p></div>");
			document.write("<div class='faq_answer'><p>"  + data[i][3] + "</p></div>");
			
			
			document.write("</div><hr class=\"secondarycolor\">");
			
		
	}
	</script>
	
	<script type="text/javascript"><!--
SSS_faq = {
	init : function() {
		$('.faq_answer').not(':first').slideToggle('fast');
		$('.faq_question').click(function() { SSS_faq.toggle(this) });
	},

	toggle : function(elt) {
		//$(elt).toggleClass('active');
		$(elt).siblings('.faq_answer').slideToggle('fast');
	}
}

$(function() {
	SSS_faq.init();
});
//--></script>
	

<%
	}
%>