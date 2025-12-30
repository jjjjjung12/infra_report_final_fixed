<!-- ========================================
자산관리 목록
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
        max-width: 1400px;
    }
    .page-title {
        font-weight: 700;
        color: #1a1a1a;
        font-size: 1.5rem;
        margin-bottom: 20px !important;
        padding-bottom: 12px;
        border-bottom: 2px solid #667eea;
    }
    
    /* 검색 필터 */
    #searchForm {
        background: #fff;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px !important;
    }
    #searchForm .filter-row {
        display: flex;
        align-items: flex-start;
        flex-wrap: wrap;
        gap: 8px;
        margin-bottom: 16px !important;
    }
    #searchForm strong {
        min-width: 80px;
        font-size: 0.938rem;
        font-weight: 600;
        color: #495057;
        flex-shrink: 0;
        padding-top: 8px;
    }
    
    /* 숨겨진 항목 컨테이너 */
    .hidden-items {
        display: none;
        gap: 8px;
        flex-wrap: wrap;
    }
    .hidden-items.show {
        display: flex;
        flex-wrap: wrap;
    }
    
    /* 체크박스를 버튼처럼 보이게 */
    #searchForm label {
        position: relative;
        font-size: 0.875rem;
        margin: 0 !important;
        padding: 8px 16px;
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.2s;
        color: #6c757d;
        font-weight: 500;
        white-space: nowrap;
    }
    #searchForm label:hover {
        border-color: #667eea;
        background: #f0f4ff;
        color: #667eea;
    }
    #searchForm input[type="checkbox"] {
        display: none;
    }
    #searchForm input[type="checkbox"]:checked + span,
    #searchForm label:has(input[type="checkbox"]:checked) {
        background: #667eea;
        border-color: #667eea;
        color: white;
        font-weight: 600;
    }
    
    /* 더보기 버튼 */
    .more-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 28px;
        height: 28px;
        background: #667eea;
        color: white;
        border-radius: 4px;
        text-decoration: none;
        font-weight: 700;
        font-size: 1.2rem;
        line-height: 1;
        transition: all 0.2s;
        border: none;
        cursor: pointer;
    }
    .more-btn:hover {
        background: #5568d3;
        color: white;
        transform: scale(1.05);
    }
    
    /* 테이블 */
    .table {
        font-size: 0.875rem;
        margin-bottom: 0 !important;
        border-collapse: separate;
        border-spacing: 0;
    }
    .table th {
        background: #f8f9fa !important;
        color: #495057 !important;
        font-weight: 600;
        padding: 12px 10px !important;
        border-top: 1px solid #dee2e6 !important;
        border-bottom: 2px solid #dee2e6 !important;
        text-align: center;
    }
    .table td {
        padding: 10px !important;
        vertical-align: middle;
        border-bottom: 1px solid #e9ecef;
    }
    .table tbody tr:hover {
        background: #f8f9fa;
    }
    .table-responsive {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
        border-radius: 6px;
        border: 1px solid #dee2e6;
    }
    table th, table td {
        white-space: nowrap;
        max-width: 150px;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    /* 버튼 */
    .btn {
        padding: 8px 16px !important;
        font-size: 0.875rem !important;
        font-weight: 500;
        border-radius: 6px;
        transition: all 0.2s;
    }
    .btn-primary {
        background: #667eea !important;
        border: none !important;
        color: white !important;
    }
    .btn-primary:hover {
        background: #5568d3 !important;
    }
    .btn-success, .btn-warning {
        background: #667eea !important;
        border: none !important;
        color: white !important;
    }
    .btn-success:hover, .btn-warning:hover {
        background: #5568d3 !important;
    }
    
    /* 상세 버튼 */
    .btn-detail {
        background: #667eea !important;
        border: none !important;
        color: white !important;
        font-weight: 600 !important;
        padding: 8px 20px !important;
        font-size: 0.875rem !important;
        border-radius: 6px;
        box-shadow: 0 2px 4px rgba(102, 126, 234, 0.2);
        transition: all 0.2s;
    }
    .btn-detail:hover {
        background: #5568d3 !important;
        box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        transform: translateY(-1px);
    }
    
    /* 등록 버튼 그룹 */
    .btn-group {
        gap: 8px;
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
		    <div class="mb-2 filter-row">
		        <strong class="me-3">서비스</strong>
		        <c:forEach items="${serviceList}" var="svc" varStatus="st">
		            <c:if test="${st.index < 5}">
		                <label class="me-2">
		                    <input type="checkbox" name="serviceIdx" value="${svc.serviceIdx}">
		                    ${svc.serviceName}
		                </label>
		            </c:if>
		        </c:forEach>
		        
		        <span id="serviceMore" class="hidden-items">
		            <c:forEach items="${serviceList}" var="svc" varStatus="st">
		                <c:if test="${st.index >= 5}">
		                    <label class="me-2">
		                        <input type="checkbox" name="serviceIdx" value="${svc.serviceIdx}">
		                        ${svc.serviceName}
		                    </label>
		                </c:if>
		            </c:forEach>
		        </span>
		        
		        <c:if test="${fn:length(serviceList) > 5}">
		            <a href="javascript:void(0)" onclick="toggleMore('serviceMore', this)" class="more-btn ms-2" title="더보기">
		                +
		            </a>
		        </c:if>
		    </div>
		
		    <!-- 하드웨어 -->
		    <div class="mb-2 filter-row">
		        <strong class="me-3">하드웨어</strong>
		        <c:forEach items="${hardwareList}" var="hw" varStatus="st">
		            <c:if test="${st.index < 5}">
		                <label class="me-2">
		                    <input type="checkbox" name="hardwareIdx" value="${hw.hardwareIdx}">
		                    ${hw.hardwareProductName}
		                </label>
		            </c:if>
		        </c:forEach>
		        
		        <span id="hardwareMore" class="hidden-items">
		            <c:forEach items="${hardwareList}" var="hw" varStatus="st">
		                <c:if test="${st.index >= 5}">
		                    <label class="me-2">
		                        <input type="checkbox" name="hardwareIdx" value="${hw.hardwareIdx}">
		                        ${hw.hardwareProductName}
		                    </label>
		                </c:if>
		            </c:forEach>
		        </span>
		        
		        <c:if test="${fn:length(hardwareList) > 5}">
		            <a href="javascript:void(0)" onclick="toggleMore('hardwareMore', this)" class="more-btn ms-2" title="더보기">
		                +
		            </a>
		        </c:if>
		    </div>
		
		    <!-- 소프트웨어 -->
		    <div class="mb-3 filter-row">
		        <strong class="me-3">소프트웨어</strong>
		        <c:forEach items="${softwareList}" var="sw" varStatus="st">
		            <c:if test="${st.index < 5}">
		                <label class="me-2">
		                    <input type="checkbox" name="softwareIdx" value="${sw.softwareIdx}">
		                    ${sw.softwareProductName}
		                </label>
		            </c:if>
		        </c:forEach>
		        
		        <span id="softwareMore" class="hidden-items">
		            <c:forEach items="${softwareList}" var="sw" varStatus="st">
		                <c:if test="${st.index >= 5}">
		                    <label class="me-2">
		                        <input type="checkbox" name="softwareIdx" value="${sw.softwareIdx}">
		                        ${sw.softwareProductName}
		                    </label>
		                </c:if>
		            </c:forEach>
		        </span>
		        
		        <c:if test="${fn:length(softwareList) > 5}">
		            <a href="javascript:void(0)" onclick="toggleMore('softwareMore', this)" class="more-btn ms-2" title="더보기">
		                +
		            </a>
		        </c:if>
		    </div>
		
		    <!-- 검색 버튼 -->
		    <div class="text-end">
		        <button type="button" class="btn btn-primary" onclick="searchAssets()">
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
                        <a href="detail?serviceIdx=${row.SERVICE_IDX}&hardwareIdx=${row.HARDWARE_IDX}&softwareIdx=${row.SOFTWARE_IDX}" class="btn btn-sm btn-detail">
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
function toggleMore(id, btn) {
    const el = document.getElementById(id);
    el.classList.toggle('show');
    
    // 버튼 텍스트 변경
    if (el.classList.contains('show')) {
        btn.textContent = '-';
        btn.title = '접기';
    } else {
        btn.textContent = '+';
        btn.title = '더보기';
    }
}

function searchAssets() {
	var serviceIdxArr = [];
	var hardwareIdxArr = [];
	var softwareIdxArr = [];
	
	$("input[name='serviceIdx']:checked").each(function() {
		serviceIdxArr.push($(this).val());
	});
	$("input[name='hardwareIdx']:checked").each(function() {
		hardwareIdxArr.push($(this).val());
	});
	$("input[name='softwareIdx']:checked").each(function() {
		softwareIdxArr.push($(this).val());
	});
	
	$.ajax({
		url: '/asset/getAssetList',
		type: 'GET',
		data: {
			serviceIdxArr: serviceIdxArr,
			hardwareIdxArr: hardwareIdxArr,
			softwareIdxArr: softwareIdxArr
		},
		traditional: true,
		success: function(res) {
			renderList(res.list);
		},
		error: function(xhr, status, err) {
			alert('검색에 실패했습니다: ' + err);
		}
	});
}

function renderList(list) {
	var html = '';
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
	            html += '        <a href="detail?serviceIdx='+(list[i].SERVICE_IDX ?? '')+'&hardwareIdx='+(list[i].HARDWARE_IDX ?? '')+'&softwareIdx='+(list[i].SOFTWARE_IDX ?? '')+'" class="btn btn-sm btn-detail">';
	            html += '            상세';
	            html += '        </a>';
	            html += '    </td>';
	            html += '</tr>';
			}
		} else {
            html += '<tr><td colspan="10" class="text-center">데이터가 없습니다.</td></tr>';
		}
	} else {
        html += '<tr><td colspan="10" class="text-center">데이터가 없습니다.</td></tr>';
	}
	$('#assetTableBody').html(html);
}

function isNull(obj) {
	return (typeof obj == "undefined" || obj == null || obj == "");
}
</script>
