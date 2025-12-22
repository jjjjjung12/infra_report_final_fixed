<!-- ========================================
자산관리 목록
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
    .table-responsive {
	    overflow-x: auto;
	    -webkit-overflow-scrolling: touch; /* 모바일 스크롤 부드럽게 */
	}
	table th, table td {
	    white-space: nowrap; 		/* 줄바꿈 방지 			*/
	    max-width: 150px;    		/* 최대 폭 			*/
	    overflow: hidden;    		/* 넘치는 텍스트 숨김 	*/
	    text-overflow: ellipsis; 	/* ... 표시 			*/
	}
</style>

<div class="container">
    <div class="content-card">
        <h3 class="page-title mb-4">
            <i class="fas fa-warehouse me-2"></i>자산 목록
        </h3>

        <!-- 검색조건 -->
		<form id="searchForm" class="mb-4">
		
		    <!-- 서비스 -->
		    <div class="mb-2">
		        <strong class="me-3">서비스</strong>
		        <c:forEach items="${serviceList}" var="svc" varStatus="st">
		            <c:if test="${st.index < 5}">
		                <label class="me-2">
		                    <input type="checkbox" name="serviceIdx" value="${svc.serviceIdx}">
		                    ${svc.serviceName}
		                </label>
		            </c:if>
		        </c:forEach>
		        <a href="javascript:void(0)" onclick="toggleMore('serviceMore')" class="text-primary ms-2">
		            더보기
		        </a>
		
		        <div id="serviceMore" class="d-none mt-2">
		            <c:forEach items="${serviceList}" var="svc" varStatus="st">
		                <c:if test="${st.index >= 5}">
		                    <label class="me-2">
		                        <input type="checkbox" name="serviceIdx" value="${svc.serviceIdx}">
		                        ${svc.serviceName}
		                    </label>
		                </c:if>
		            </c:forEach>
		        </div>
		    </div>
		
		    <!-- 하드웨어 -->
		    <div class="mb-2">
		        <strong class="me-3">하드웨어</strong>
		        <c:forEach items="${hardwareList}" var="hw" varStatus="st">
		            <c:if test="${st.index < 5}">
		                <label class="me-2">
		                    <input type="checkbox" name="hardwareIdx" value="${hw.hardwareIdx}">
		                    ${hw.hardwareProductName}
		                </label>
		            </c:if>
		        </c:forEach>
		        <a href="javascript:void(0)" onclick="toggleMore('hardwareMore')" class="text-primary ms-2">
		            더보기
		        </a>
		
		        <div id="hardwareMore" class="d-none mt-2">
		            <c:forEach items="${hardwareList}" var="hw" varStatus="st">
		                <c:if test="${st.index >= 5}">
		                    <label class="me-2">
		                        <input type="checkbox" name="hardwareIdx" value="${hw.hardwareIdx}">
		                        ${hw.hardwareProductName}
		                    </label>
		                </c:if>
		            </c:forEach>
		        </div>
		    </div>
		
		    <!-- 소프트웨어 -->
		    <div class="mb-3">
		        <strong class="me-3">소프트웨어</strong>
		        <c:forEach items="${softwareList}" var="sw" varStatus="st">
		            <c:if test="${st.index < 5}">
		                <label class="me-2">
		                    <input type="checkbox" name="softwareIdx" value="${sw.softwareIdx}">
		                    ${sw.softwareProductName}
		                </label>
		            </c:if>
		        </c:forEach>
		        <a href="javascript:void(0)" onclick="toggleMore('softwareMore')" class="text-primary ms-2">
		            더보기
		        </a>
		
		        <div id="softwareMore" class="d-none mt-2">
		            <c:forEach items="${softwareList}" var="sw" varStatus="st">
		                <c:if test="${st.index >= 5}">
		                    <label class="me-2">
		                        <input type="checkbox" name="softwareIdx" value="${sw.softwareIdx}">
		                        ${sw.softwareProductName}
		                    </label>
		                </c:if>
		            </c:forEach>
		        </div>
		    </div>
		
		    <!-- 검색 버튼 -->
		    <div class="text-end">
		        <button class="btn btn-primary">
		            <i class="fas fa-search"></i> 검색
		        </button>
		    </div>
		
		</form>
        
		<div class="d-flex justify-content-between align-items-center mb-3">
		    <div class="text-muted"></div>
		    <div class="btn-group">
		        <a href="serviceRegist" class="btn btn-success">
		            <i class="fas fa-concierge-bell me-1"></i> 서비스 등록
		        </a>
		        <a href="hardwareRegist" class="btn btn-primary">
		            <i class="fas fa-microchip me-1"></i> 하드웨어 등록
		        </a>
		        <a href="softwareRegist" class="btn btn-warning">
		            <i class="fas fa-code me-1"></i> 소프트웨어 등록
		        </a>
		    </div>
		</div>
		
        <!-- 목록 -->
        <div class="table-responsive">
        <table class="table table-hover" id="assetTable">
            <thead class="table-light">
            <tr>
                <th>서비스명</th>
                <th>HW-구분</th>
                <th>제조사</th>
                <th>제품명</th>
                <th>버전</th>
                <th>SW-구분</th>
                <th>제조사</th>
                <th>제품명</th>
                <th>버전</th>
                <th>상세</th>
            </tr>
            </thead>
            <tbody id="assetTableBody">
            <c:forEach items="${list}" var="row">
                <tr>
                    <td>${row.SERVICE_NAME}</td>
                    <td>${row.HARDWARE_TYPE}</td>
                    <td>${row.HARDWARE_MANUFACTURER}</td>
                    <td>${row.HARDWARE_PRODUCT_NAME}</td>
                    <td>${row.HARDWARE_VERSION}</td>
                    <td>${row.SOFTWARE_TYPE}</td>
                    <td>${row.SOFTWARE_MANUFACTURER}</td>
                    <td>${row.SOFTWARE_PRODUCT_NAME}</td>
                    <td>${row.SOFTWARE_VERSION}</td>
                    <td>
                        <a href="detail?serviceIdx=${row.SERVICE_IDX}&hardwareIdx=${row.HARDWARE_IDX}&softwareIdx=${row.SOFTWARE_IDX}" class="btn btn-sm btn-outline-primary">
                            상세
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </div>
    </div>
</div>


<script>
function toggleMore(id) {
    const el = document.getElementById(id);
    el.classList.toggle('d-none');
}

document.getElementById('searchForm').addEventListener('submit', function(e) {
	
	e.preventDefault();
	
	const form = document.getElementById('searchForm');
    const formData = new FormData(form);

    // 리스트 형태로 보내기
    const data = {};
    formData.forEach((value, key) => {
        if (!data[key]) data[key] = [];
        data[key].push(Number(value));
    });
    
    fetch('/asset/getAssetList', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
    	updateTable(result);
    });
});

function updateTable(list) {
	let html = "";
	
	$("#assetTableBody").empty();
	
	if(!isNull(list)) {
		if(list.length > 0) {
			for(var i=0; i<list.length; i++) {
				html += '<tr>';
	            html += '    <td>'+(list[i].SERVICE_NAME ?? '')+'</td>';
	            html += '    <td>'+(list[i].HARDWARE_TYPE ?? '')+'</td>';
	            html += '    <td>'+(list[i].HARDWARE_MANUFACTURER ?? '')+'</td>';
	            html += '    <td>'+(list[i].HARDWARE_PRODUCT_NAME ?? '')+'</td>';
	            html += '    <td>'+(list[i].HARDWARE_VERSION ?? '')+'</td>';
	            html += '    <td>'+(list[i].SOFTWARE_TYPE ?? '')+'</td>';
	            html += '    <td>'+(list[i].SOFTWARE_MANUFACTURER ?? '')+'</td>';
	            html += '    <td>'+(list[i].SOFTWARE_PRODUCT_NAME ?? '')+'</td>';
	            html += '    <td>'+(list[i].SOFTWARE_VERSION ?? '')+'</td>';
	            html += '    <td>';
	            html += '        <a href="detail?serviceIdx='+(list[i].SERVICE_IDX ?? '')+'&hardwareIdx='+(list[i].HARDWARE_IDX ?? '')+'&softwareIdx='+(list[i].SOFTWARE_IDX ?? '')+'" class="btn btn-sm btn-outline-primary">';
	            html += '            상세';
	            html += '        </a>';
	            html += '    </td>';
	            html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="10">조회된 데이터가 없습니다.</td></tr>';	
		}
	} else {
		html += '<tr><td colspan="10">조회된 데이터가 없습니다.</td></tr>';
	}
	$("#assetTableBody").append(html);
}
</script>