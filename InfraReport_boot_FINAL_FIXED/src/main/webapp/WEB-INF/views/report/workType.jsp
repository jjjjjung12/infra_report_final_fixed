<!-- ========================================
업무유형별 현황
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 통계 카드 행 -->
<div class="row mb-4">
	<div class="col-md-2">
		<div class="card stat-card">
			<div class="stat-number text-primary">${stats.dailyCheckCount}</div>
			<div>일상점검</div>
		</div>
	</div>
	<div class="col-md-2">
		<div class="card stat-card">
			<div class="stat-number text-info">${stats.securityCheckCount}</div>
			<div>보안점검</div>
		</div>
	</div>
	<div class="col-md-2">
		<div class="card stat-card">
			<div class="stat-number text-success">${stats.systemMgmtCount}</div>
			<div>시스템관리</div>
		</div>
	</div>
	<div class="col-md-2">
		<div class="card stat-card">
			<div class="stat-number text-warning">${stats.specialCheckCount}</div>
			<div>특별점검</div>
		</div>
	</div>
	<div class="col-md-2">
		<div class="card stat-card">
			<div class="stat-number text-danger">${stats.incidentCount}</div>
			<div>장애대응</div>
		</div>
	</div>
	<div class="col-md-2">
		<div class="card stat-card">
			<div class="stat-number text-secondary">${stats.workCount}</div>
			<div>작업</div>
		</div>
	</div>
</div>

<!-- 검색 폼 (업무유형별 현황) - 가로 배치로 개선 -->
<div class="search-form">
<!-- 	<form id="report" action="searchReportList" method="post"> -->
		<input type="hidden" name="action" id="action" value="daily">
		<div class="row g-2 align-items-end">
			<div class="col-md-2">
				<label class="form-label small">시작 날짜</label> 
				<input type="date" name="startReportDate" id="startReportDate" class="form-control form-control-sm" value="${startReportDate}">
			</div>
			<div class="col-md-2">
				<label class="form-label small">종료 날짜</label> 
				<input type="date" name="endReportDate" id="endReportDate" class="form-control form-control-sm" value="${endReportDate}">
			</div>
			<div class="col-md-2">
				<label class="form-label small">검색 필드</label> 
				<select name="searchField" id="searchField" class="form-select form-select-sm">
					<option value="">--전체--</option>
					<option value="SERVICE_CATEGORY">카테고리</option>
					<option value="SERVICE_NAME">서비스명</option>
					<option value="TASK_TYPE">업무유형</option>
					<option value="TASK_DESCRIPTION">업무내용</option>
					<option value="STATUS">상태</option>
					<option value="MANAGER">담당자</option>
					<option value="CREATED_BY">등록자</option>
					<option value="UPDATED_BY">수정자</option>
				</select>
			</div>
			<div class="col-md-2">
				<label class="form-label small">검색어</label> 
				<input type="text" name="searchKeyword" id="searchKeyword" class="form-control form-control-sm" placeholder="검색어 입력">
			</div>
			<div class="col-md-2">
				<label class="form-label small">정렬 기준</label> 
				<select name="sortField" id="sortField" class="form-select form-select-sm">
					<option value="CREATED_DATE">등록일시</option>
					<option value="UPDATED_DATE">수정일시</option>
					<option value="SERVICE_CATEGORY">카테고리</option>
					<option value="TASK_TYPE">업무유형</option>
					<option value="STATUS">상태</option>
					<option value="MANAGER">담당자</option>
				</select>
			</div>
			<div class="col-md-1">
				<label class="form-label small">순서</label> 
				<select name="sortOrder" id="sortOrder" class="form-select form-select-sm">
					<option value="DESC">내림차순</option>
					<option value="ASC">오름차순</option>
				</select>
			</div>
			<div class="col-md-1">
				<button class="btn btn-primary btn-sm w-100" onclick="searchReportList();">
					<i class="fas fa-search"></i> 검색
				</button>
			</div>
		</div>
<!-- 	</form> -->
</div>

<!-- 업무 목록 테이블 카드 -->
<div class="card">
	<div class="card-header">
		<h5 class="mb-0">
			업무 목록
			<button class="btn btn-sm btn-success float-end" onclick="showAddModal()">
				<i class="fas fa-plus"></i> 새 업무
			</button>
		</h5>
	</div>
	<div class="card-body p-0">
		<table class="table table-hover mb-0" id="dailyTable">
			<thead>
				<tr>
					<th onclick="sortTable('dailyTable', 0)">카테고리 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 1)">서비스명 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 2)">업무유형 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 3)">업무내용 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 4)">상태 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 5)">담당자 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 6)">등록일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 7)">등록자 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 8)">수정일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('dailyTable', 9)">수정자 <span class="sort-icon"></span></th>
					<th>작업</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="workTypeTableBody">
				<c:forEach var="report" items="${reports}">
					<tr>
						<td><span class="badge category-${fn:toLowerCase(report.serviceCategory)}">${report.serviceCategory}</span></td>
						<td>${report.serviceName}</td>
						<td>${report.taskType}</td>
						<td>${report.taskDescription}</td>
						<td><span class="badge ${report.statusClass}">${report.status}</span></td>
						<td>${report.manager}</td>
						<td><fmt:formatDate value="${report.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${report.createdBy}</td>
						<td><fmt:formatDate value="${report.updatedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${report.updatedBy}</td>
						<td>
							<button class="btn btn-sm btn-outline-primary" onclick="editReport(${report.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
						<td>
							<button class="btn btn-sm btn-danger" onclick="deleteReport(${report.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty reports}">
					<tr>
						<td colspan="12" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>

<!-- 새 업무 추가 모달 -->
<div class="modal fade" id="addReportModal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">새 업무 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<form id="addReportForm">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-4">
							<label for="serviceCategory" class="form-label">카테고리</label> 
							<select class="form-select" name="serviceCategory" required>
								<c:forEach var="cat" items="${serviceCategories}">
									<option value="${cat.cdName}">${cat.cdName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-4">
							<label for="serviceName" class="form-label">서비스명</label> 
							<input type="text" class="form-control" name="serviceName" required>
						</div>
						<div class="col-md-4">
							<label for="taskType" class="form-label">업무유형</label> 
							<select class="form-select" name="taskType">
								<c:forEach var="type" items="${taskTypes}">
									<option value="${type.cdName}">${type.cdName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="mb-3">
						<label for="taskDescription" class="form-label">업무내용</label>
						<textarea class="form-control" name="taskDescription" rows="3" required></textarea>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label for="status" class="form-label">상태</label> 
							<select class="form-select" name="status">
								<c:forEach var="status" items="${statusTypes}">
									<option value="${status.cdName}">${status.cdName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-4">
							<label for="manager" class="form-label">담당자</label> 
							<input type="text" class="form-control" name="manager">
						</div>
						<div class="col-md-4">
							<label for="checkTime" class="form-label">점검시간</label> 
							<input type="text" class="form-control" name="checkTime" placeholder="HH:MM-HH:MM">
						</div>
					</div>
					<div class="row mt-3" id="metaInfo" style="display: none;">
						<div class="col-md-6">
							<label class="form-label mb-0 fw-bold">등록일시 : </label> 
							<span id="createdDateText"></span>
						</div>
						<div class="col-md-6">
							<label class="form-label mb-0 fw-bold">등록자 : </label> 
							<span id="createdByText"></span>
						</div>
						<div class="col-md-6">
							<label class="form-label mb-0 fw-bold">수정일시 : </label> 
							<span id="updatedDateText"></span>
						</div>
						<div class="col-md-6">
							<label class="form-label mb-0 fw-bold">수정자 : </label> 
							<span id="updatedByText"></span>
						</div>
					</div>
					<input type="hidden" name="reportDate" value="${reportDate}">
					<input type="hidden" name="reportId" value=""> 
					<input type="hidden" name="action" value="add">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary">저장</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>

//조건 별 검색
function searchReportList() {
	
	const searchWorkTypeListData = {
		  "startReportDate" : $("#startReportDate").val()					/* 시작 날짜	*/
		, "endReportDate" : $("#endReportDate").val()                       /* 종료 날짜	*/
		, "searchField" : $('#searchField option:selected').val()   		/* 검색 필드	*/
		, "searchKeyword" : $("#searchKeyword").val()               		/* 검색어		*/
		, "sortField" : $('#sortField option:selected').val()               /* 정렬 기준	*/
		, "sortOrder" : $('#sortOrder option:selected').val()               /* 순서		*/
	};
	
	$.ajax({
		type: "POST",
		url: "/workType/searchReportList",
		data:searchWorkTypeListData,
		success: function(result) {
			const workTypeListResult = result;
			let workTypeListHtml = "";
			
			$('#workTypeTableBody').empty();
			
			if(!isNull(workTypeListResult) && workTypeListResult.length > 0) {
				
				workTypeListResult.forEach(report => {
					workTypeListHtml += `
					<tr>
						<td><span class="badge category-\${report.serviceCategory ? report.serviceCategory.toLowerCase() : ''}">\${report.serviceCategory}</span></td>
						<td>\${report.serviceName}</td>
						<td>\${report.taskType}</td>
						<td>\${report.taskDescription}</td>
						<td><span class="badge \${report.statusClass}">\${report.status}</span></td>
						<td>\${report.manager}</td>
						<td>\${formatDate(report.createdDate)}</td>
						<td>\${report.createdBy}</td>
						<td>\${formatDate(report.updatedDate)}</td>
						<td>\${report.updatedBy ?? ''}</td>
						<td>
							<button class="btn btn-sm btn-outline-primary" onclick="editReport(\${report.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
						<td>
							<button class="btn btn-sm btn-danger" onclick="deleteReport(\${report.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
					</tr>
					`;
				});
				
			} else {
				workTypeListHtml += `
					<tr>
						<td colspan="12" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				`;
			}
			
			$('#workTypeTableBody').html(workTypeListHtml);
		},
		error: function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

//새 업무 모달 show
function showAddModal() {
    const workTypeModal = new bootstrap.Modal(document.getElementById('addReportModal'));
    
    // 폼 초기화 (빈 값)
    const form = document.getElementById('addReportForm');
    form.reset();
    form.querySelector('[name="action"]').value = 'add';
    
 	// 등록/수정 정보 숨기기
    document.getElementById('metaInfo').style.display = 'none';
    
    workTypeModal.show();
}

//새 업무 등록, 수정
document.getElementById('addReportForm').addEventListener('submit', function(e) {
	let reportUrl = "";
	let reportAction = this.querySelector('[name="action"]').value;
	if(reportAction == 'add') {
		reportUrl = 'addReport';
	} else if(reportAction == 'update') {
		reportUrl = 'updateReport';
	}

	e.preventDefault();
    const workTypeAddFormData = new FormData(this);
    fetch('/workType/'+reportUrl, {
        method: 'POST',
        body: workTypeAddFormData
    })
    .then(response => response.json())
    .then(data => {
        if (data.isSuccess) {
            alert(data.message);
//             location.reload();
            reloadCurrentTab();
        } else {
            alert(data.message);
        }
    });
});

//업무 수정
function editReport(reportId) {
	const modal = new bootstrap.Modal(document.getElementById('addReportModal'));
    const form = document.getElementById('addReportForm');

    // action을 update로 변경
    form.querySelector('[name="action"]').value = 'update';
    
    const workTypeEditFormData = new URLSearchParams();
    workTypeEditFormData.append("reportId", reportId);
    
    fetch('/workType/getReport', {
        method: 'POST',
        body: workTypeEditFormData
    })
    .then(response => response.json())
    .then(data => {
        if (data) {
            form.querySelector('[name="serviceCategory"]').value = data.serviceCategory;
            form.querySelector('[name="serviceName"]').value = data.serviceName;
            form.querySelector('[name="taskType"]').value = data.taskType;
            form.querySelector('[name="taskDescription"]').value = data.taskDescription;
            form.querySelector('[name="status"]').value = data.status;
            form.querySelector('[name="manager"]').value = data.manager;
            form.querySelector('[name="checkTime"]').value = data.checkTime || '';
            
            document.getElementById('createdDateText').textContent = data.createdDate ? formatDate(data.createdDate) : '';
            document.getElementById('createdByText').textContent = data.createdBy || '';
            document.getElementById('updatedDateText').textContent = data.updatedDate ? formatDate(data.updatedDate) : '';
            document.getElementById('updatedByText').textContent = data.updatedBy || '';

            document.getElementById('metaInfo').style.display = 'flex'; // 한 줄로 표시
            
            let hidden = form.querySelector('[name="reportId"]');
            if (!hidden) {
                hidden = document.createElement('input');
                hidden.type = 'hidden';
                hidden.name = 'reportId';
                form.appendChild(hidden);
            }
            hidden.value = reportId;
            
            modal.show();
        } else {
            alert('데이터를 불러오는데 실패했습니다.');
        }
    })
    .catch(err => {
    	console.error(err);
        alert('서버와 연결할 수 없습니다.');
    });
}

//업무 삭제
function deleteReport(reportId) {
	if (!confirm("해당 업무를 삭제하시겠습니까?")) return;
	
	const workTypeDeleteFormData = new FormData();
    workTypeDeleteFormData.append("action", "delete");
    workTypeDeleteFormData.append("reportId", reportId);

    fetch("/workType/deleteReport", {
        method: "POST",
        body: workTypeDeleteFormData
    })
    .then(response => response.json())
    .then(data => {
        if (data.isSuccess) {
            alert(data.message);
//             location.reload();
            reloadCurrentTab();
        } else {
            alert(data.message);
        }
    })
    .catch(err => {
        console.error(err);
        alert("서버 오류가 발생했습니다.");
    });
}

</script>