<!-- ========================================
자산관리 상세
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<style>
    body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
        font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', sans-serif;
        min-height: 100vh;
        padding: 20px;
    }
    .container { 
        max-width: 1200px;
    }
    .section-box {
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,.08);
        padding: 24px;
        margin: 16px 0;
    }
    .section-title {
        font-weight: 700;
        color: #1a1a1a;
        font-size: 1.125rem;
        margin-bottom: 16px;
        padding-bottom: 10px;
        border-bottom: 2px solid #667eea;
    }
    
    /* 테이블 */
    .table {
        font-size: 0.875rem;
        margin-bottom: 0 !important;
    }
    .table th {
        background: #f8f9fa !important;
        color: #495057 !important;
        font-weight: 600;
        padding: 10px !important;
        width: 140px;
        border-top: 1px solid #dee2e6 !important;
        border-bottom: 2px solid #dee2e6 !important;
    }
    .table td {
        padding: 10px !important;
    }
    .table-bordered {
        border: 1px solid #dee2e6;
        border-radius: 6px;
        overflow: hidden;
    }
    
    /* 버튼 */
    .btn {
        padding: 8px 16px !important;
        font-size: 0.875rem !important;
        font-weight: 500;
        border-radius: 6px;
    }
    .btn-sm {
        padding: 6px 12px !important;
        font-size: 0.813rem !important;
    }
    .btn-primary {
        background: #667eea !important;
        border: none !important;
    }
    .btn-primary:hover {
        background: #5568d3 !important;
    }
    .btn-outline-secondary {
        border-color: #dee2e6 !important;
        color: #6c757d !important;
    }
    .btn-outline-secondary:hover {
        background: #6c757d !important;
        color: white !important;
        border-color: #6c757d !important;
    }
    
    /* 정보 행 */
    .info-row {
        display: flex;
        margin-bottom: 10px;
        font-size: 0.875rem;
    }
    .info-label {
        font-weight: 600;
        color: #495057;
        min-width: 120px;
    }
    .info-value {
        color: #212529;
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
