<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
<c:when test="${pageContext.request.method=='POST' && not cms.element.inMemoryOnly}">
<cms:include file="/system/modules/ru.mrgrechkinn.opencms.photocontest/elements/mg-photocontest-post.jsp" />
</c:when>
<c:otherwise>
<cms:include file="/system/modules/ru.mrgrechkinn.opencms.photocontest/elements/mg-photocontest-get.jsp" />
</c:otherwise>
</c:choose>
