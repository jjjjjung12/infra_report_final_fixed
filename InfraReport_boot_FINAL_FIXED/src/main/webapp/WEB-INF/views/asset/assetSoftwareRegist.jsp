<!-- ========================================
자산관리 하드웨어 등록 수정
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
    <div class="content-card">
        <h3 class="page-title mb-4">
            <i class="fas fa-code me-2"></i>소프트웨어 등록
        </h3>

        <form id="softwareForm">
        	<div class="row g-3 mb-3">
			    <div class="col-md-6">
			        <label class="form-label">하드웨어</label>
			        <select name="hardwareIdx" id="hardwareSelect" class="form-select">
			            <option value="">하드웨어를 선택하세요</option>
			
			            <c:forEach var="hardware" items="${assetHardwareList}">
			                <option value="${hardware.hardwareIdx}">
			                    ${hardware.hardwareProductName}
			                </option>
			            </c:forEach>
			
			        </select>
			    </div>
			</div>
            <div class="row g-3">
            	<div class="col-md-6">
                    <label class="form-label">SW 구분 <span class="text-danger">*</span></label>
                    <input type="text" name="softwareType" class="form-control" maxlength="50" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">제조사 <span class="text-danger">*</span></label>
                    <input type="text" name="manufacturer" class="form-control" maxlength="100" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">제품명 <span class="text-danger">*</span></label>
                    <input type="text" name="productName" class="form-control" maxlength="100" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">버전 <span class="text-danger">*</span></label>
                    <input type="text" name="version" class="form-control" maxlength="20" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">개수 <span class="text-danger">*</span></label>
                    <input type="number" name="quantity" class="form-control" maxlength="20" required>
                </div>
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
document.getElementById('softwareForm').addEventListener('submit', function(e) {
	e.preventDefault();

    const softwareData = {
    	"hardwareIdx": document.getElementById('hardwareSelect').value,
        "softwareType": document.querySelector('[name="softwareType"]').value,
        "manufacturer": document.querySelector('[name="manufacturer"]').value,
        "productName": document.querySelector('[name="productName"]').value,
        "version": document.querySelector('[name="version"]').value,
        "quantity": document.querySelector('[name="quantity"]').value,
        "histories": histories,
        "managers": managers
    };
    
    fetch('/asset/addSoftware', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(softwareData)
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