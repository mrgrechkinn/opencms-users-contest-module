<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@ page import="java.io.*, java.lang.*, java.util.*, java.text.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="org.opencms.*, org.opencms.main.*,
org.opencms.flex.*, org.opencms.jsp.*, org.opencms.file.*,
org.opencms.file.types.*" %>
<%@ page import="org.apache.commons.lang.*" %>
<%@ page import="org.apache.commons.fileupload.*,
org.apache.commons.fileupload.disk.*,
org.apache.commons.fileupload.servlet.*" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%

if (request.getMethod().equals("POST")) {

FileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);

List<FileItem> items = null;

try {
    items = upload.parseRequest(request);
} catch (FileUploadException e) {
    out.println("Error parsing request");
    System.out.println(request.getRemoteAddr()+": Import: Error parsing request.");
    return;
}

Iterator<FileItem> iter = items.iterator();

String siteRoot = null;
String folderId = null;
String filename = null;
byte[] bytes = null;

while (iter.hasNext()) {
    FileItem item = (FileItem) iter.next();

    if (item.isFormField()) {

        if (item.getFieldName().equals("folderId")) {
        	folderId = item.getString();
        }

         if (item.getFieldName().equals("siteRoot")) {
            siteRoot = item.getString();
        } 

    } else {
        filename = item.getName();
        bytes = item.get();
    }
}

try {

    CmsObject cms = OpenCms.initCmsObject("Guest");
    cms.loginUser("Admin", "admin");

    CmsProject project = cms.readProject("Offline");
    cms.getRequestContext().setCurrentProject(project);

    cms.getRequestContext().setSiteRoot(siteRoot);
    

    if (!cms.existsResource("/.content")) {
        System.out.println("Creating /.content");
        cms.createResource("/.content", CmsResourceTypeFolder.RESOURCE_TYPE_ID);
    }

    if (!cms.existsResource("/.content/mg-photocontest")) {
        System.out.println("Creating /.content/mg-photocontest");
        cms.createResource("/.content/mg-photocontest", CmsResourceTypeFolder.RESOURCE_TYPE_ID);
    }

    if (!cms.existsResource("/.content/mg-photocontest/"+folderId)) {
        System.out.println("Creating /.content/mg-photocontest/"+folderId);
        cms.createResource("/.content/mg-photocontest/"+folderId,
CmsResourceTypeFolder.RESOURCE_TYPE_ID);
    }


    String newResname =
cms.getRequestContext().getFileTranslator().translateResource("/.content/mg-photocontest/"+folderId +"/"
+ filename);
    int resTypeId =
OpenCms.getResourceManager().getDefaultTypeForName(filename).getTypeId();
    cms.createResource(newResname, resTypeId, bytes, null);

    //cms.unlockResource("/images/articles");
    //cms.unlockResource("/images/articles/"+no_dossier);
    //cms.unlockResource("/images/articles/"+no_dossier+"/"+no_article);

   // cms.publishResource("/.content/mg-photocontest/"+folderId);
    OpenCms.getPublishManager().publishResource(cms, "/.content/mg-photocontest/"+folderId);
    OpenCms.getPublishManager().waitWhileRunning();

} catch (Exception e) {
    out.println("Error: "+e.getMessage() );
}
}
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
                <input name="FirstName" value="${cms.vfs.requestContext.siteRoot}.content/mg-photocontest/${content.id}"/>
                <input type="file" name="filename" />
                <input type="hidden" value="<c:out value="${content.id}"/>" name="folderId"/>
                <input type="hidden" value="<c:out value="${cms.vfs.requestContext.siteRoot}"/>" name="siteRoot"/>
                <input type="submit" value="Загрузить" class="formbutton">
            </form>
            <c:set var="itemCount">3</c:set>
            <c:set var="collectorParam">&fq=type:image&fq=parent-folders:"${cms.vfs.requestContext.siteRoot}.content/mg-photocontest/${content.id}"&fq=con_locales:*&sort=path asc&rows=1000</c:set>
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

