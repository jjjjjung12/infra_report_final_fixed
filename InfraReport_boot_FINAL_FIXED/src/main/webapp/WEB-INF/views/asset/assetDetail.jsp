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
        min-height: 100vh;
    }
    .content-card {
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0,0,0,.2);
        padding: 30px;
        margin: 30px auto;
    }
    .page-title {
        font-weight: bold;
        color: #667eea;
    }
</style>
<div class="container">

    <!-- ================= 서비스 ================= -->
    <div class="content-card mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="page-title">
                <i class="fas fa-cubes me-2"></i>서비스 정보
            </h4>
            <a href="/asset/service/edit?idx=${service.idx}" class="btn btn-warning btn-sm">
                수정
            </a>
        </div>

        <table class="table">
            <tr>
                <th width="20%">서비스명</th>
                <td>${service.serviceName}</td>
            </tr>
        </table>

        <!-- 서비스 자원이력 -->
        <h6 class="mt-3">자원이력정보</h6>
        <ul class="list-group mb-3">
            <c:forEach items="${serviceHistories}" var="h">
                <li class="list-group-item">
                    ${h.content}
                    <span class="text-muted">(${h.remark})</span>
                </li>
            </c:forEach>
        </ul>

        <!-- 서비스 담당자 -->
        <h6>담당자관리</h6>
        <ul class="list-group">
            <c:forEach items="${serviceManagers}" var="m">
                <li class="list-group-item">
                    ${m.managerName} / ${m.mobileNumber} / ${m.email}
                </li>
            </c:forEach>
        </ul>
    </div>

    <!-- ================= 하드웨어 ================= -->
    <c:forEach items="${hardwareList}" var="hw">
        <div class="content-card mb-4 border-start border-primary border-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="page-title">
                    <i class="fas fa-server me-2"></i>하드웨어
                </h4>
                <a href="/asset/hardware/edit?idx=${hw.idx}" class="btn btn-warning btn-sm">
                    수정
                </a>
            </div>

            <table class="table">
                <tr>
                    <th width="20%">제조사</th>
                    <td>${hw.manufacturer}</td>
                    <th width="20%">제품명</th>
                    <td>${hw.productName}</td>
                </tr>
                <tr>
                    <th>버전</th>
                    <td>${hw.version}</td>
                    <th>개수</th>
                    <td>${hw.quantity}</td>
                </tr>
            </table>

            <!-- 구성정보 -->
            <h6 class="mt-3">구성정보</h6>
            <table class="table table-sm">
                <thead>
                <tr>
                    <th>구성</th>
                    <th>구성명칭</th>
                    <th>수량</th>
                    <th>설명</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${hw.componentList}" var="c">
                    <tr>
                        <td>${c.componentType}</td>
                        <td>${c.componentName}</td>
                        <td>${c.quantity}</td>
                        <td>${c.description}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- 하드웨어 자원이력 -->
            <h6>자원이력정보</h6>
            <ul class="list-group mb-3">
                <c:forEach items="${hw.historyList}" var="h">
                    <li class="list-group-item">
                        ${h.content} (${h.remark})
                    </li>
                </c:forEach>
            </ul>

            <!-- 하드웨어 담당자 -->
            <h6>담당자관리</h6>
            <ul class="list-group mb-3">
                <c:forEach items="${hw.managerList}" var="m">
                    <li class="list-group-item">
                        ${m.managerName} / ${m.mobileNumber}
                    </li>
                </c:forEach>
            </ul>

            <!-- ================= 소프트웨어 ================= -->
            <c:forEach items="${hw.softwareList}" var="sw">
                <div class="card mb-3">
                    <div class="card-header d-flex justify-content-between">
                        <strong>
                            <i class="fas fa-desktop me-2"></i>소프트웨어
                        </strong>
                        <a href="/asset/software/edit?idx=${sw.idx}" class="btn btn-warning btn-sm">
                            수정
                        </a>
                    </div>
                    <div class="card-body">
                        <table class="table table-sm">
                            <tr>
                                <th width="20%">제조사</th>
                                <td>${sw.manufacturer}</td>
                                <th width="20%">제품명</th>
                                <td>${sw.productName}</td>
                            </tr>
                            <tr>
                                <th>버전</th>
                                <td>${sw.version}</td>
                                <th>개수</th>
                                <td>${sw.quantity}</td>
                            </tr>
                        </table>

                        <h6>자원이력정보</h6>
                        <ul class="list-group mb-2">
                            <c:forEach items="${sw.historyList}" var="h">
                                <li class="list-group-item">
                                    ${h.content} (${h.remark})
                                </li>
                            </c:forEach>
                        </ul>

                        <h6>담당자관리</h6>
                        <ul class="list-group">
                            <c:forEach items="${sw.managerList}" var="m">
                                <li class="list-group-item">
                                    ${m.managerName} / ${m.mobileNumber}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:forEach>

        </div>
    </c:forEach>

</div>

<script>

</script>