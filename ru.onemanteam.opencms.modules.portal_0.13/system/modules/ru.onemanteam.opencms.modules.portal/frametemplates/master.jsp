<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"
    import="java.text.*"
    import="org.opencms.file.*"

%>
<%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";
String pics = moduleBaseUri + "/resources/pics";

String labels = "/common/labels/common.xml";
Locale locale = cms.getRequestContext().getLocale();



boolean isBirthDays = request.getAttribute("isBirthDays") != null;
boolean isContentBg = request.getAttribute("isContentBg") != null;
/////boolean isTagClouds = request.getAttribute("isTagClouds") != null;



%><!DOCTYPE html>
<html lang="en">
<head>


<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta charset="utf-8" />


      <!--[if lt IE 9]>
    	<link rel="stylesheet" type="text/css" media="screen" href="<%= cms.link(moduleBaseUri +  "/resources/css/ie9.css") %>" />
      <![endif]-->




<!-- me3 -->
<meta name="author" content="OneManTeam">
<meta name="keywords" content="<%= cms.property("Keywords", "search", "") %>">
<meta name="description" content="<%= cms.property("Description", "search", "") %>">

<title><%= cms.property("Title", "search", "") %></title>

<link rel="shortcut icon" type="image/x-icon" href="http://ttk.ru/favicon.ico" />
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700&amp;subset=latin,cyrillic-ext,cyrillic,latin-ext' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="<%= cms.link(moduleBaseUri +  "/resources/css/reset.css") %>" />
<link rel="stylesheet" href="<%= cms.link(moduleBaseUri +  "/resources/css/text.css") %>" />
<link rel="stylesheet" href="<%= cms.link(moduleBaseUri +  "/resources/css/960_24_col.css") %>" />
<!--  link rel="stylesheet" href="<%= cms.link(moduleBaseUri +  "/resources/font/stylesheet.css") %>" / -->
<link rel="stylesheet" href="<%= cms.link(moduleBaseUri +  "/resources/css/ttk.css") %>" />

<link rel="stylesheet" href="<%= cms.link(moduleBaseUri +  "/resources/css/calendar.css") %>" />

<!-- me1 -->
<link rel="stylesheet" type="text/css" href="<%= cms.link(moduleBaseUri +  "/resources/css/slickmap.css") %>">

<style>

.navigation {
    height: 60px;
    position: relative;
}

.navigation ul {
	padding:0px !important;
    position: relative;
    

}

.stripe {
    /*position: relative;*/
    box-shadow: 0 8px 6px -6px #999999;
    z-index:3000;
} 

.hovermenu {
    background: none repeat scroll 0 0 #E8E9EC;
    box-shadow: 0 0 10px #999999;
    
    margin-left: -120px;    /*VA*/
    padding: 10px 0 0;
    padding-top:10px !important;
    position: relative;
    /*VA: top: -10px; */
    top: 1px;
    _top: 1px;
    left: 120px;

    width: 230px;
    text-align:left;
    z-index:10000;

}
.hovermenu .arrow {
    left: -87px; /* VA */
    top: -10px;
    margin-top: 0px;
    font-size:10px;
    position: relative;
}
.hovermenu li ul {
  padding-left: 10px;
}

.hovermenu li>ul>li>a{
  font-size:10px;
   padding: 6px 20px !important;
}

.topmenu {
	display:inline-block;
	width: 960px;
}
.topmenu li {
    float:left;
    display: block;
    position:relative;
    
}

.topmenu li a{
    padding: 20px 40px 20px 35px !important;
    display:block;
    font-weight:bold;
    font-size:14px;
}
.topmenu ul li {
    float: none;
    padding:0px !important;
    font-size:14px
    
}
.topmenu ul li a{
    padding: 10px !important;
    font-size:13px
}
.topmenu>li:hover > * {
	display:block;
}

.topmenu>li:hover {
	background-color: #f37165;
}

a:hover {
	opacity:none;
}

#search {
	margin-top:20px;
	position:relative;
	height: 40px; 
}
#search input{
	height: 22px; 
	border-radius: 5px; 
	outline: none; 
	padding: 0 !important; 
	display: inline-block; 
	width: 190px; 
	opacity: 1;
	background: #EE3524;
	border:1px solid #fff;
}

.white-bg {
	background: #fff !important;
}


.maincolor {
	background: none repeat scroll 0 0 #EE3524;
}

.search-block {
	position: absolute !important;
    right: 5px;
}
.search-block:hover {
	background: #EE3524 !important;
}
.search-block form {
	margin-bottom:0
}
.leftcolumn { min-height:550px;
}
.sitemap ul, .sitemap li {
list-style-type:none;
}


li.pointed {

    
    padding:0 5px;
}


.pointed ul{
    margin:0px -5px;
}
.submenu ul a{
	font-size:14px;
	
}

.pointed a {
    background-color: #E8E9EC;
    border-radius: 5px;
    display: block;
    margin-left: -30px;
    padding: 3px 3px 3px 25px;
    
}

.pointed a.active {
	line-height: 17px;
}



.pointed ul a {
    /* background-color: #FFFFFF; VA OMG */
    margin: 0;
    padding: 0;
}


/* omg! */

.leftcolumn,
.rightcolumn,
.centercolumn {
	padding-top:30px;
}

.rightcolumn{

	width:100%
}

.leftcolumn{

	
	
}
.leftcolumn li {
	list-style-type:none !important;
	list-style-image:none !important;
}
.centercolumn {
	
}

.birthdays{
	margin-top:0px !important
}
.pointed a {
 
    border-radius: 5px 0 0 5px !important;
    padding: 5px 3px 5px 25px !important;

}
.submenu li {
    margin: 0 0 10px 30px !important;
}

li.pointed {
    padding: 0 !important;
}
.pointed ul {
    margin: 0 0 0 -30px !important;

}
.pointed a.active {
    background: #FFFFFF;
}

/* end of omg! */
</style>


<%
cms.editable(true);

CmsRequestContext rContext = cms.getRequestContext();
if (rContext.currentProject().isOnlineProject()) {
	
	%>
	<script src="<%= cms.link(moduleBaseUri + "/resources/js/jquery/jquery-1.8.2.js") %>"></script>
	<!--  script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script-->
	
	<%
}
%>
	<script src="<%= cms.link(moduleBaseUri + "/resources/js/application.js") %>"></script>

	<!-- script src="<%= cms.link(moduleBaseUri + "/resources/js/jQueryRotate.2.2.js") %>"></script -->
	<script src="/portal/resources/jquery/unpacked/jquery.flydom.js"></script>
	<!--  script src="<%= cms.link(moduleBaseUri + "/resources/js/functions.js") %>"></script -->


<script src="<%= cms.link(moduleBaseUri + "/resources/js/jquery/jquery.carouFredSel-6.2.1-packed.js") %>"></script>
<script src="<%= cms.link(moduleBaseUri + "/resources/js/targetblank.js") %>"></script>



<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-60620748-1', 'auto');
  ga('send', 'pageview');

</script>



<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter28989830 = new Ya.Metrika({id:28989830,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
        } catch(e) { }
    });

    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/28989830" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->



	
</head>



<body>



<div class="container_24 header">
    <div>
        <a href="<%= cms.link("/ru/") %>"><img alt="TTK" src="<%= cms.link(pics + "/logo.jpg") %>"></a><h3 class="inline">корпоративный портал</h3>
    </div>
</div>

<div class="stripeup center maincolor">
     <div class="container_24 navigation maincolor center" >
    
    <% cms.include(moduleBaseUri + "/elements/menu-top.jsp"); %>
    
    </div>
</div>


<div class="container_24 content <%= (isContentBg) ? " BG" : "" %>">

	<% if (request.getAttribute("content") != null) cms.include((String)request.getAttribute("content")); %>
    
</div>





<%/* %>



<footer id="site-footer" class="grid12" role="contentinfo">
		<% cms.include(moduleBaseUri + "/elements/links_bottom.jsp"); %>
		<span style="color:#fff;font-size: 0.9em">
      	<a href="mailto:<%= cms.getContent(labels, "contactMail", locale)%>"><%= cms.getContent(labels, "copyRights", locale).replaceAll("\\$\\{mail\\}", cms.getContent(labels, "contactMail", locale)) %></a>
		</span>
</footer>



<nav id="site-nav">
		<% cms.include(moduleBaseUri + "/elements/menu-top.jsp"); %>
		<form action="<%= cms.link("/ru/" + "search.html") %>" method="post" id="search">
		    <input id="searchConteiner" autocomplete="off" type="text" name="query" value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>"/>
		</form>  
</nav>
<%*/ %>




<%if (isBirthDays) {
	cms.include(moduleBaseUri + "/elements/bdays-container.jsp");
} %>


<div class="stripe center footer secondarycolor">
        <% cms.include(moduleBaseUri + "/elements/links_bottom.jsp"); %>
        <hr class="dark">
        <h4><%= cms.getContent(labels, "copyRights", locale)%></h4>
</div>

<div id="opaco" class="hidden"></div>

<script>



var ie = (function(){
	 
    var undef,
        v = 3,
        div = document.createElement('div'),
        all = div.getElementsByTagName('i');
 
    while (
        div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->',
        all[0]
    );
 
    return v > 4 ? v : undef;
 
}());




$.fn.followTo = function (pos) {
    var $this = this,
        $window = $(window);

    $window.scroll(function (e) {
        if ($(window).scrollTop() + $(window).height() >= $(document).height() - pos) {
            $this.css({
                position: 'absolute',
                bottom: pos
            });
        } else {
            $this.css({
                position: 'fixed',
                bottom: 30
            });
        }
    });
};

var pos = Number($('.footer').height() + $('.birthdays').height() + 20);
$('.tree').followTo(pos);



</script>


<!-- Tomcat is OK -->
</body>


</html>