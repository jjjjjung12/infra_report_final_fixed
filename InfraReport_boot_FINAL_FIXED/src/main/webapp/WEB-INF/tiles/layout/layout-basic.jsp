<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <tiles:insertAttribute name="tiles_head" ignore="true" />
    <title>일일업무보고서 통합관리시스템</title>
</head>
<body>
	<tiles:insertAttribute name="tiles_header" ignore="true" />
	<tiles:insertAttribute name="tiles_content"/>
	<tiles:insertAttribute name="tiles_footer" ignore="true"/>
</body>
</html>