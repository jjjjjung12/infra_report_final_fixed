<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 헤더 -->
<div class="header-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1><i class="fas fa-chart-line me-2"></i>일일업무보고서 통합관리</h1>
                <p class="mb-0">작성일자: <fmt:formatDate value="${currentDate}" pattern="yyyy년 MM월 dd일 (E)" /></p>
            </div>
            <div class="col-md-6 text-end">
                <sec:authorize access="isAuthenticated()">
                    <span class="me-3">
                        <i class="fas fa-user me-1"></i>
                        <sec:authentication property="principal.userName"/>
                        (<sec:authentication property="principal.role"/>)
                    </span>
                </sec:authorize>
                <a href="/work/process/admin" class="btn btn-info me-2">
                    <i class="fas fa-tasks"></i> 작업관리
                </a>
                <a href="/dr/manage" class="btn btn-warning me-2">
                    <i class="fas fa-shield-alt"></i> DR훈련
                </a>
                <a href="/asset/list" class="btn btn-primary me-2">
				    <i class="fas fa-warehouse"></i> 자산관리
				</a>
                <button class="btn btn-light me-2" onclick="location.reload()">
                    <i class="fas fa-sync-alt"></i> 새로고침
                </button>
                <button class="btn btn-success me-2" onclick="exportAll()">
                    <i class="fas fa-download"></i> 내보내기
                </button>
                <sec:authorize access="isAuthenticated()">
                    <a href="/mypage" class="btn btn-outline-light me-2">
                        <i class="fas fa-cog"></i>
                    </a>
                    <a href="/logout" class="btn btn-outline-light">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </sec:authorize>
            </div>
        </div>
    </div>
</div>
