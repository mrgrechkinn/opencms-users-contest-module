<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="org.opencms.jsp.*" %>
<% 
  // Create a JSP action element
  org.opencms.jsp.CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);

  HttpServletRequest req = (HttpServletRequest)cms.getRequest();

  String ipAddress = req.getHeader("X-FORWARDED-FOR");
  if (ipAddress == null) {
      ipAddress = req.getRemoteAddr();
  }
  System.out.println("ipAddress:" + ipAddress);

%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="ru.mrgrechkinn.opencms.photocontest.workplace">
<cms:formatter var="content" val="value" rdfa="rdfa">
<c:choose>
    <c:when test="${param.n == 'true'}">
    <%
StringBuffer sb=new StringBuffer();
for(int i=1;i<=5;i++)
{
    sb.append((char)(int)(Math.random()*79+23+7));
}
String cap=new String(sb);
%>
    <div class="OpenCmsWebform photocontest">
        <style type="text/css">
            .photocontest .webform_wrapper {
                width: 410px;
            }
            .photocontest .webform_wrapper .webform_field {
                width: 200px;
                margin-right: 5px;
            }
            .photocontest .webform_wrapper .webform_label {
                width: 200px;
                padding-top: 8px;
            }
            .photocontest .webform_wrapper .webform_field input {
                padding: 9px 4px;
                margin-bottom: 10px;
            }
            .photocontest .webform_wrapper .webform_label label {
                font-weight: bold;
            }
            .photocontest .webform_wrapper .webform_button {
                text-align: left;
            }
            .photocontest .webform_wrapper .webform_button input.formbutton {
                width: 130px;
                height: 36px;
                font-size: 16px;
            }
            .photocontest .webform_wrapper .jq-file {
                width: 198px;
                border-radius: 2px;
            }
            .photocontest .webform_wrapper .jq-file .jq-file__name {
                border: 1px solid #888;
                border-bottom-color: #888;
                background: #fafbfb;
            }
            .photocontest .webform_wrapper .jq-file .jq-file__browse {
                background: #ee3524;
                box-shadow: none;
                color: white;
                text-shadow: none;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="/portal/opencms/system/modules/com.alkacon.opencms.v8.formgenerator/resources/css/webform.css">
        <script type="text/javascript" src="/portal/opencms/system/modules/com.alkacon.opencms.v8.formgenerator/resources/js/subfields.js"></script>
        <h3 style="font-size: 18px; color:black;">${value.Title}</h3>
        <hr/>
        <p style="font-size: 16px; color:black;">${value.Text}</p>
        <script>
        function validation(){
            var c = document.forms ["f1"]["captcha"].value;
            var c2 = document.forms ["f1"]["cap2"].value;
            if(c == null||c == "")
            {
               alert ("Please Enter Captcha");
               return false;
            } else if (c != c2) {
            	alert ("Not correct Captcha");
                return false;
            }
        }
        </script>
        <form method="post" enctype="multipart/form-data" onsubmit="return validation()" name="f1">
        <div class="webform_wrapper">
            <input type="hidden" value="<c:out value="${content.id}"/>" name="folderId"/>
            <input type="hidden" value="<c:out value="${cms.vfs.requestContext.siteRoot}"/>" name="siteRoot"/>
            <input type="hidden" name="cap2" value='<%=cap%>' readonly="readonly">
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
                  <div style="background-color: red; height: 50px; border-radius: 2px; padding-top: 15px;" onselectstart="return false" onmousedown="return false"><h2 style="text-align:center;"><s><i><font style="color:white;" face="casteller"><%=cap%></font></i></s></h2></div>
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
    <script>
        jQuery(function() {
            jQuery('input, select').styler();
        });
    </script>
    </c:when>
    <c:otherwise>
<%-- Gallery --%>
<div class="gallery-page photocontest">

<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery(".fancybox-button").fancybox({
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
<style type="text/css">
    .photocontest .webform_wrapper .webform_button {
        text-align: left;
    }
    .photocontest .webform_wrapper .webform_button input.formbutton {
        width: 130px;
        height: 36px;
        font-size: 16px;
    }
</style>

    <h3 style="font-size: 18px; color:black;">${value.Title}</h3>
    <hr/>
    <p style="font-size: 16px; color:black;">${value.Text}</p>
    <c:choose>
        <c:when test="${cms.element.inMemoryOnly}">
            <div class="row"><div class="alert"><fmt:message key="bootstrap.imagegalleryshow.message.new" /></div></div>
        </c:when>
        <c:when test="${cms.edited}">
            <div class="row"><div class="alert"><fmt:message key="bootstrap.imagegalleryshow.message.edit" /></div></div>
            ${cms.enableReload}
        </c:when>
        <c:otherwise>
            <form method="get">
                <div class="webform_wrapper">
                    <div class="webform_button">
                    <input type="hidden" value="true" name="n"> 
                    <input type="submit" value="Учавствовать" class="formbutton submitbutton">  
                    </div>
                </div>
            </form>
            <c:set var="itemCount">3</c:set>
            <c:set var="collectorParam">&fq=type:image&fq=parent-folders:"${cms.vfs.requestContext.siteRoot}/.content/mg-photocontest/${content.id}/"&fq=pcEnabled_exact:true&fq=con_locales:*&sort=path asc&rows=1000</c:set>
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
                        <div>
                            <div style="font-weight: bold;">${res.property['pcFirstName']} ${res.property['pcLastName']}</div>
                            <div>${res.property['pcPicTitle']}</div>
                        </div>
                        <div style="cursor:pointer;"><img style="float:left; margin-right: 10px;" src="<cms:link>%(link.weak:/system/modules/ru.mrgrechkinn.opencms.photocontest/resources/pics/not_voted.png)</cms:link>"><div style="font-weight: bold; color: red; text-decoration: underline;">Голосовать</div></div>
                        <%--<div><img style="float:left; margin-right: 10px;" src="<cms:link>%(link.weak:/system/modules/ru.mrgrechkinn.opencms.photocontest/resources/pics/voted.png)</cms:link>"><div style="font-weight: bold;">Голос учтен</div></div> --%>
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
