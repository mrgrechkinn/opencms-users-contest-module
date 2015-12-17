 <jsp:useBean id="cmsbean" class="org.opencms.jsp.CmsJspBean">
 <% cmsbean.init(pageContext, request, response); %>
 </jsp:useBean>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*,org.opencms.jsp.*,org.opencms.workplace.explorer.*" %>
<%

ServletContext context = pageContext.getServletContext();
String contentType = request.getContentType();

         String str = "test";
         //if (contentType != null && (contentType.indexOf("multipart/form-data") >= 0)) {
             CmsJspActionElement cms2 = new CmsJspActionElement(pageContext, request,
             response);
             CmsNewResourceUpload upload2 = new CmsNewResourceUpload(cms2);
             //upload2.setParamUploadFile(str) ;
                      String allParams = upload2.allParamsAsRequest();

             System.out.println("UpLoadFile"+ upload2.getParamUploadFile());
            
             upload2.setParamUploadFolder("/sites/default/overview");
             upload2.setParamNewResourceName("titi.jpg") ;
             upload2.setParamUploadError("Error while Uploading") ;
             upload2.setParamUnzipFile("false") ;
             String str1=upload2.getParamUploadFile() ;
             System.out.println(str1);
             System.out.println(upload2.getParamResource());
             upload2.actionUpload() ;
             System.out.println(upload2.getParamResource());
                Map<String, String> p = new HashMap<String, String>();
             System.out.println(allParams);
             for(String s : allParams.split("&")) {
                 String[] splited = s.split("=");
                 p.put(splited[0], splited[1]);
             }
             System.out.println( p.get("path"));
             String extension = "";
             int i = upload2.getParamResource().lastIndexOf('.');
             if (i > 0) {
                 extension = upload2.getParamResource().substring(i+1);
             }
             cmsbean.getCmsObject().moveResource(upload2.getParamResource(), p.get("path") + UUID.randomUUID().toString() +"." +extension);
      //   }

 
 %>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="ru.mrgrechkinn.opencms.photocontest.workplace">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="gallery-page">

<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery(".fancybox-button").fancybox({
            groupAttr: 'data-rel',
            prevEffect: 'none',
            nextEffect: 'none',
            closeBtn: true,
            <c:if test="${cms:vfs(pageContext).property[cms.element.sitePath]['ttkCanDownload'] == 'true'}">
            afterLoad: function() {
                this.title = '<a href="' + this.href + '" download>Download</a> ' + this.title;
            },
            </c:if>
            helpers: {
                title: {
                    type: 'inside'
                    }
                }
        
            });
    });
</script>

    <c:if test="${not cms.element.settings.hidetitle}">
        <div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>
    </c:if>

    <c:choose>
        <c:when test="${cms.element.inMemoryOnly}">
            <div class="row"><div class="alert"><fmt:message key="bootstrap.imagegalleryshow.message.new" /></div></div>
        </c:when>
        <c:when test="${cms.edited}">
            <div class="row"><div class="alert"><fmt:message key="bootstrap.imagegalleryshow.message.edit" /></div></div>
            ${cms.enableReload}
        </c:when>
        <c:otherwise>
            <form method="post" enctype="multipart/form-data">
                <input name="FirstName" value=""/>
                <input type="file" name="filename" />
                <input type="hidden" value="<c:out value="${cms.vfs.requestContext.siteRoot}${value.ImageFolder.stringValue}"/>" name="path"/>
                <input type="submit" value="Загрузить" class="formbutton">
            </form>
            <c:set var="itemCount">3</c:set>
            <c:set var="collectorParam">&fq=type:image&fq=parent-folders:"${cms.vfs.requestContext.siteRoot}${value.ImageFolder.stringValue}"&fq=con_locales:*&sort=path asc&rows=1000</c:set>
            <cms:resourceload collector="byContext" param="${collectorParam}">
                <cms:contentinfo var="info" />
                <c:if test="${info.resultSize > 0}">
                    <cms:resourceaccess var="res" />
                    <c:if test="${info.resultIndex % itemCount == 1}">
                        <div class="row margin-bottom-20">
                    </c:if>
                    <div class="${cms:lookup(itemCount, '1:col-xs-12|2:col-sm-6|3:col-sm-4|4:col-md-3 col-sm-6|5:col-md-2 col-sm-6|6:col-md-2 col-sm-4')}">
                        <a class="thumbnail fancybox-button zoomer" data-rel="fancybox-button" title="<c:out value="${res.property['Title']}" />" href="<cms:link>${res.filename}</cms:link>">
                            <div class="overlay-zoom">  
                                <cms:img alt="${res.property['Title']}" title="${res.property['Title']}" src="${res.filename}" scaleType="2" scaleColor="transparent" scaleQuality="75" noDim="true" width="720" height="450" cssclass="img-responsive" />
                                <div class="zoom-icon"></div>                   
                            </div>                                              
                        </a>                                                                                    
                    </div>

                    <c:if test="${info.resultIndex % itemCount == 0 || info.lastResult}">
                        </div>
                    </c:if>
                </c:if>
            </cms:resourceload>

        </c:otherwise>

    </c:choose>
</div>

</cms:formatter>
</cms:bundle>

