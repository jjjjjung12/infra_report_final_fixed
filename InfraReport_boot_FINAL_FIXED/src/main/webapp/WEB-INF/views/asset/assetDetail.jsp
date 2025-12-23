<!-- ========================================
자산관리 상세
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    body {
	    background: linear-gradient(135deg, #667eea, #764ba2);
	    font-family: 'Malgun Gothic';
	}
	.container { max-width: 1200px; }
	.section-box {
	    background: #fff;
	    border-radius: 16px;
	    box-shadow: 0 8px 25px rgba(0,0,0,.2);
	    padding: 30px;
	    margin: 30px 0;
	}
	.section-title {
	    font-weight: bold;
	    color: #667eea;
	    border-left: 6px solid #667eea;
	    padding-left: 12px;
	}
</style>
<div class="container">

<!-- ===================== 서비스 ===================== -->
<div class="section-box">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="section-title">서비스</h4>
        <c:choose>
            <c:when test="${not empty service}">
                <a href="/asset/serviceRegist?serviceIdx=${serviceIdx}"
                   class="btn btn-outline-primary btn-sm">수정</a>
            </c:when>
            <c:otherwise>
                <a href="/asset/serviceRegist"
                   class="btn btn-outline-success btn-sm">등록</a>
            </c:otherwise>
        </c:choose>
    </div>

    <h6>기본정보</h6>
    <table class="table table-bordered">
        <tr>
            <th width="20%">서비스명</th>
            <td>${service.serviceName}</td>
        </tr>
    </table>

    <h6 class="mt-4">자원이력정보</h6>
    <table class="table table-bordered">
        <thead>
            <tr><th>내용</th><th>비고</th></tr>
        </thead>
        <tbody>
            <c:forEach var="h" items="${serviceHistories}">
                <tr><td>${h.historyContent}</td><td>${h.historyRemark}</td></tr>
            </c:forEach>
            <c:if test="${empty serviceHistories}">
                <tr><td colspan="2" class="text-center text-muted">데이터가 없습니다</td></tr>
            </c:if>
        </tbody>
    </table>

    <h6 class="mt-4">담당자정보</h6>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>이름</th><th>전화번호</th><th>핸드폰번호</th><th>이메일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="m" items="${serviceManagers}">
                <tr>
                    <td>${m.managerName}</td>
                    <td>${m.managerPhoneNumber}</td>
                    <td>${m.managerMobileNumber}</td>
                    <td>${m.managerEmail}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty serviceManagers}">
                <tr><td colspan="4" class="text-center text-muted">데이터가 없습니다</td></tr>
            </c:if>
        </tbody>
    </table>
</div>

<!-- ===================== 하드웨어 ===================== -->
<div class="section-box">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="section-title">하드웨어</h4>
        <c:choose>
            <c:when test="${not empty hardware}">
                <a href="/asset/hardwareRegist?hardwareIdx=${hardwareIdx}"
                   class="btn btn-outline-primary btn-sm">수정</a>
            </c:when>
            <c:otherwise>
                <a href="/asset/hardwareRegist<c:if test='${not empty serviceIdx}'>?serviceIdx=${serviceIdx}</c:if>" class="btn btn-outline-success btn-sm">등록</a>
            </c:otherwise>
        </c:choose>
    </div>

    <h6>기본정보</h6>
    <table class="table table-bordered">
        <tr>
            <th>HW 구분</th><td>${hardware.hardwareType}</td>
            <th>제조사</th><td>${hardware.hardwareManufacturer}</td>
        </tr>
        <tr>
            <th>제품명</th><td>${hardware.hardwareProductName}</td>
            <th>버전</th><td>${hardware.hardwareVersion}</td>
        </tr>
        <tr>
            <th>개수</th><td colspan="3">${hardware.hardwareQuantity}</td>
        </tr>
    </table>

    <h6 class="mt-4">구성정보</h6>
    <table class="table table-bordered">
        <thead>
            <tr><th>구성</th><th>구성명칭</th><th>수량</th><th>설명</th></tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${hardwareComponents}">
                <tr>
                    <td>${c.componentType}</td>
                    <td>${c.componentName}</td>
                    <td>${c.componentQuantity}</td>
                    <td>${c.componentDescription}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty hardwareComponents}">
                <tr><td colspan="4" class="text-center text-muted">데이터가 없습니다</td></tr>
            </c:if>
        </tbody>
    </table>

    <h6 class="mt-4">자원이력정보</h6>
    <table class="table table-bordered">
        <thead><tr><th>내용</th><th>비고</th></tr></thead>
        <tbody>
            <c:forEach var="h" items="${hardwareHistories}">
                <tr><td>${h.historyContent}</td><td>${h.historyRemark}</td></tr>
            </c:forEach>
            <c:if test="${empty hardwareHistories}">
                <tr><td colspan="2" class="text-center text-muted">데이터가 없습니다</td></tr>
            </c:if>
        </tbody>
    </table>

    <h6 class="mt-4">담당자정보</h6>
    <table class="table table-bordered">
        <thead>
            <tr><th>이름</th><th>전화번호</th><th>핸드폰번호</th><th>이메일</th></tr>
        </thead>
        <tbody>
            <c:forEach var="m" items="${hardwareManagers}">
                <tr>
                    <td>${m.managerName}</td>
                    <td>${m.managerPhoneNumber}</td>
                    <td>${m.managerMobileNumber}</td>
                    <td>${m.managerEmail}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty hardwareManagers}">
                <tr><td colspan="4" class="text-center text-muted">데이터가 없습니다</td></tr>
            </c:if>
        </tbody>
    </table>
</div>

<!-- ===================== 소프트웨어 ===================== -->
<div class="section-box">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="section-title">소프트웨어</h4>
        <c:choose>
            <c:when test="${not empty software}">
                <a href="/asset/softwareRegist?softwareIdx=${softwareIdx}"
                   class="btn btn-outline-primary btn-sm">수정</a>
            </c:when>
            <c:otherwise>
                <a href="/asset/softwareRegist<c:if test='${not empty hardwareIdx}'>?hardwareIdx=${hardwareIdx}</c:if>" class="btn btn-outline-success btn-sm">등록</a>
            </c:otherwise>
        </c:choose>
    </div>

    <h6>기본정보</h6>
    <table class="table table-bordered">
        <tr>
            <th>SW 구분</th><td>${software.softwareType}</td>
            <th>제조사</th><td>${software.softwareManufacturer}</td>
        </tr>
        <tr>
            <th>제품명</th><td>${software.softwareProductName}</td>
            <th>버전</th><td>${software.softwareVersion}</td>
        </tr>
        <tr>
            <th>개수</th><td colspan="3">${software.softwareQuantity}</td>
        </tr>
    </table>

    <h6 class="mt-4">자원이력정보</h6>
    <table class="table table-bordered">
        <thead><tr><th>내용</th><th>비고</th></tr></thead>
        <tbody>
            <c:forEach var="h" items="${softwareHistories}">
                <tr><td>${h.historyContent}</td><td>${h.historyRemark}</td></tr>
            </c:forEach>
            <c:if test="${empty softwareHistories}">
                <tr><td colspan="2" class="text-center text-muted">데이터가 없습니다</td></tr>
            </c:if>
        </tbody>
    </table>

    <h6 class="mt-4">담당자정보</h6>
    <table class="table table-bordered">
        <thead>
            <tr><th>이름</th><th>전화번호</th><th>핸드폰번호</th><th>이메일</th></tr>
        </thead>
        <tbody>
            <c:forEach var="m" items="${softwareManagers}">
                <tr>
                    <td>${m.managerName}</td>
                    <td>${m.managerPhoneNumber}</td>
                    <td>${m.managerMobileNumber}</td>
                    <td>${m.managerEmail}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty softwareManagers}">
                <tr><td colspan="4" class="text-center text-muted">데이터가 없습니다</td></tr>
            </c:if>
        </tbody>
    </table>
</div>

<div class="text-end mb-5">
    <a href="/asset/list" class="btn btn-outline-secondary">목록</a>
</div>

</div>
