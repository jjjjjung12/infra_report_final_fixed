<!-- ========================================
자산관리 하드웨어 등록 수정
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
            <i class="fas fa-microchip me-2"></i>하드웨어 등록
        </h3>

        <form id="hardwareForm">
        	<div class="row g-3 mb-3">
			    <div class="col-md-6">
			        <label class="form-label">서비스</label>
			        <select name="serviceIdx" id="serviceSelect" class="form-select">
			            <option value="">서비스를 선택하세요</option>
			
			            <c:forEach var="service" items="${assetServiceList}">
			                <option value="${service.serviceIdx}">
			                    ${service.serviceName}
			                </option>
			            </c:forEach>
			
			        </select>
			    </div>
			</div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">HW 구분 <span class="text-danger">*</span></label>
                    <input type="text" name="hardwareType" class="form-control" maxlength="50" required>
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
<!--                     <input type="text" name="quantity" class="form-control" maxlength="20" oninput="onlyNumber(this)" required> -->
                </div>
            </div>
            
            <!-- 구성정보 테이블 -->
            <div class="mb-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <strong>구성정보</strong>
                    <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#componentModal">
                        등록
                    </button>
                </div>
                <table class="table table-bordered" id="componentTable">
                    <thead>
                        <tr>
                            <th>구성</th>
                            <th>구성명칭</th>
                            <th>수량</th>
                            <th>설명</th>
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

<!-- 구성정보 팝업 -->
<div class="modal fade" id="componentModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-sitemap me-2"></i>구성정보
                </h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row g-2">
                    <div class="col-md-6">
                        <label class="form-label">구성</label>
                        <input type="text" id="componentType" name="componentType" class="form-control" maxlength="20">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">구성명칭</label>
                        <input type="text" id="componentName" name="componentName" class="form-control" maxlength="100">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">수량</label>
                        <input type="number" id="componentQuantity" name="componentQuantity" class="form-control" maxlength="20">
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">설명</label>
                        <textarea  id="componentDescription" name="componentDescription" class="form-control" rows="3"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button class="btn btn-primary" onclick="addComponentRow()">저장</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="assetCommonModals.jsp" %>

<script>
let components = [];

//구성정보 초기화
const componentModalEl = document.getElementById('componentModal');
componentModalEl.addEventListener('show.bs.modal', function (event) {
    const inputs = historyModalEl.querySelectorAll('input, textarea, select');
    inputs.forEach(input => {
        if(input.type === 'checkbox' || input.type === 'radio') {
            input.checked = false;
        } else {
            input.value = '';
        }
    });
});

//구성정보 테이블 등록
function addComponentRow() {

    const type = document.getElementById('componentType').value.trim();
    const name  = document.getElementById('componentName').value.trim();
    const quantity  = document.getElementById('componentQuantity').value.trim();
    const description  = document.getElementById('componentDescription').value.trim();

    if (!type) return alert('구성을 입력하세요');
    if (!name) return alert('구성명칭을 입력하세요');
    if (!quantity) return alert('수량을 입력하세요');
    
    components.push({
    	"type":type,
    	"name":name,
    	"quantity":quantity,
    	"description":description
    });

    const tableBody = document.querySelector('#componentTable tbody');

    const noDataRow = tableBody.querySelector('.no-data');
    if (noDataRow) noDataRow.remove();

    const tr = document.createElement('tr');
    tr.dataset.index = components.length - 1;
	
    //구성
    const tdType = document.createElement('td');
    tdType.textContent = type;

    //구성명칭
    const tdName = document.createElement('td');
    tdName.textContent = name;

    //수량
    const tdQuantity = document.createElement('td');
    tdQuantity.textContent = quantity;

    //설명
    const tdDescription = document.createElement('td');
    tdDescription.textContent = description;

    //삭제 버튼
    const tdDel = document.createElement('td');
    const btnDel = document.createElement('button');
    btnDel.type = 'button';
    btnDel.className = 'btn btn-sm btn-danger';
    btnDel.textContent = '삭제';
    btnDel.onclick = function() {
        const tr = this.closest('tr');
        const index = parseInt(tr.dataset.index, 10);

        // 배열에서 삭제
        components.splice(index, 1);

        // tr 삭제
        tr.remove();

        // index 재정렬
        document.querySelectorAll('#componentTable tbody tr').forEach((row, i) => {
            row.dataset.index = i;
        });

        // 데이터 없으면 no-data 표시
        if(components.length === 0){
            const tbody = document.querySelector('#componentTable tbody');
            tbody.innerHTML = `<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>`;
            
            components = [];
        }
    };
    tdDel.appendChild(btnDel);

    tr.appendChild(tdType);
    tr.appendChild(tdName);
    tr.appendChild(tdQuantity);
    tr.appendChild(tdDescription);
    tr.appendChild(tdDel);

    tableBody.appendChild(tr);

    // 모달 닫기
    bootstrap.Modal.getInstance(
        document.getElementById('componentModal')
    ).hide();

    // 입력 초기화
    document.getElementById('componentType').value = '';
    document.getElementById('componentName').value = '';
    document.getElementById('componentQuantity').value = '';
    document.getElementById('componentDescription').value = '';
}

document.getElementById('hardwareForm').addEventListener('submit', function(e) {
	e.preventDefault();

    const hardwareData = {
    	"serviceIdx": document.getElementById('serviceSelect').value,
        "hardwareType": document.querySelector('[name="hardwareType"]').value,
        "manufacturer": document.querySelector('[name="manufacturer"]').value,
        "productName": document.querySelector('[name="productName"]').value,
        "version": document.querySelector('[name="version"]').value,
        "quantity": document.querySelector('[name="quantity"]').value,
        "components": components,
        "histories": histories,
        "managers": managers
    };
    
    fetch('/asset/addHardware', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(hardwareData)
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