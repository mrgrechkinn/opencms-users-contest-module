<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="ru.mrgrechkinn.opencms.photocontest.workplace">
<cms:formatter var="content" val="value" rdfa="rdfa">
<c:choose>
    <c:when test="${param.n == 'true'}">
    <div class="OpenCmsWebform">
        <link rel="stylesheet" type="text/css" href="/portal/opencms/system/modules/com.alkacon.opencms.v8.formgenerator/resources/css/webform.css"><script type="text/javascript" src="/portal/opencms/system/modules/com.alkacon.opencms.v8.formgenerator/resources/js/subfields.js"></script><p>Третий опрос, тестовое сообщение</p>
        <form method="post" enctype="multipart/form-data">
        <div class="webform_wrapper">
            <input type="hidden" value="<c:out value="${content.id}"/>" name="folderId"/>
            <input type="hidden" value="<c:out value="${cms.vfs.requestContext.siteRoot}"/>" name="siteRoot"/>
            <div class="webform_row">
                <div class="webform_field">
                    <input type="text" name="firstName" id="firstName" value="">
                </div>
                <div class="webform_label">
                    <label for="firstName">Имя</label>
                </div>
            </div>
            <div class="webform_row">
                <div class="webform_field">
                    <input type="text" name="lastName" id="lastName" value="">
                </div>
                <div class="webform_label">
                    <label for="lastName">Фамилия</label>
                </div>
            </div>
            <div class="webform_row">
                <div class="webform_field">
                    <input type="text" name="email" id="email" value="">
                </div>
                <div class="webform_label">
                    <label for="email">E-mail</label>
                </div>
            </div>
            <div class="webform_row">
                <div class="webform_field">
                    <input type="file" name="filename" id="filename" value="">
                </div>
                <div class="webform_label">
                    <label for="filename">Фотография</label>
                </div>
            </div>
            <div class="webform_row">
                <div class="webform_field">
                    <input type="text" name="picTitle" id="picTitle" value="">
                </div>
                <div class="webform_label">
                    <label for="picTitle">Название работы</label>
                </div>
            </div>
            <div class="webform_row">
                <div class="webform_field">
                    <input type="text" name="captcha" id="captcha" value="">
                </div>
                <div class="webform_label">
                    <label for="captcha">Введите слово на картинке</label>
                </div>
            </div>
            <div class="webform_button">
                <input type="submit" value="Отправить" class="formbutton submitbutton">  
            </div>
        </div>
        </form>
        <br style="clear:both;">
    </div>
    </c:when>
    <c:otherwise>
<%-- Gallery --%>
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

    <div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>
    <c:choose>
        <c:when test="${cms.element.inMemoryOnly}">
            <div class="row"><div class="alert"><fmt:message key="bootstrap.imagegalleryshow.message.new" /></div></div>
        </c:when>
        <c:when test="${cms.edited}">
            <div class="row"><div class="alert"><fmt:message key="bootstrap.imagegalleryshow.message.edit" /></div></div>
            ${cms.enableReload}
        </c:when>
        <c:otherwise>
            <c:set var="itemCount">3</c:set>
            <c:set var="collectorParam">&fq=type:image&fq=parent-folders:"${cms.vfs.requestContext.siteRoot}/.content/mg-photocontest/${content.id}/"&fq=con_locales:*&sort=path asc&rows=1000</c:set>
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

    </c:otherwise>
</c:choose>
</cms:formatter>
</cms:bundle>
