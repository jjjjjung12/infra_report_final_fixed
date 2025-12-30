<!-- ========================================
자산관리 서비스 등록 수정
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
    .content-card {
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,.08);
        padding: 24px;
        margin: 0 auto;
        max-width: 900px;
    }
    .page-title {
        font-weight: 700;
        color: #1a1a1a;
        font-size: 1.5rem;
        margin-bottom: 20px !important;
        padding-bottom: 12px;
        border-bottom: 2px solid #667eea;
    }
    
    /* 폼 */
    .form-label {
        font-size: 0.875rem;
        font-weight: 600;
        color: #495057;
        margin-bottom: 6px !important;
    }
    .form-control, .form-select {
        font-size: 0.875rem;
        padding: 8px 12px !important;
        border: 1px solid #dee2e6;
        border-radius: 6px;
    }
    .form-control:focus, .form-select:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
    }
    .mb-3 {
        margin-bottom: 16px !important;
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
        border-top: 1px solid #dee2e6 !important;
        border-bottom: 2px solid #dee2e6 !important;
    }
    .table td {
        padding: 10px !important;
        vertical-align: middle;
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
    
    /* 섹션 헤더 */
    .d-flex.justify-content-between.align-items-center {
        margin-bottom: 12px !important;
    }
    strong {
        font-size: 0.938rem;
        font-weight: 600;
        color: #495057;
    }
</style>

<div class="container">
    <div class="content-card">
        <h3 class="page-title mb-4">
        	<i class="fas fa-concierge-bell me-2"></i>
            <c:choose>
		        <c:when test="${not empty idx}">서비스 수정</c:when>
		        <c:otherwise>서비스 등록</c:otherwise>
		    </c:choose>
        </h3>

        <form id="serviceForm">
            <div class="mb-3">
                <label class="form-label">서비스명 <span class="text-danger">*</span></label>
                <input type="text" name="serviceName" class="form-control" maxlength="100" required value="${service.serviceName}">
            </div>

            <!-- 자원이력 테이블 -->
            <div class="mb-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <strong>자원이력정보</strong>
                    <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#historyModal">
                        등록
                    </button>
                </div>
                <table class="table table-bordered" id="historyTable">
                    <thead>
                        <tr>
                            <th>내용</th>
                            <th>비고</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="no-data">
				            <td colspan="3" class="text-center text-muted">데이터가 없습니다</td>
				        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 담당자 테이블 -->
            <div class="mb-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <strong>담당자정보</strong>
                    <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#managerModal">
                        등록
                    </button>
                </div>
                <table class="table table-bordered" id="managerTable">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>핸드폰번호</th>
                            <th>이메일</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr class="no-data">
				            <td colspan="5" class="text-center text-muted">데이터가 없습니다</td>
				        </tr>
                    </tbody>
                </table>
            </div>

            <div class="text-end">
                <a href="/asset/list" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-list"></i> 목록
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> 저장
                </button>
            </div>
        </form>

    </div>
</div>

<%@ include file="assetCommonModals.jsp" %>

<script>
  
document.getElementById('serviceForm').addEventListener('submit', function(e) {
	let url = '';
	
	if(!isNull('${idx}')) {
		url = 'updateService';	
	} else {
		url = 'addService';
	}
	
	e.preventDefault();

    const serviceData = {
    	"serviceIdx":'${idx}',
        "serviceName": document.querySelector('[name="serviceName"]').value,
        "histories": histories,
        "managers": managers
    };
    
    fetch('/asset/'+url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(serviceData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.isSuccess) {
            alert(data.message);
            window.location.href = "/asset/list"
        } else {
            alert(data.message);
        }
    });
});

</script>