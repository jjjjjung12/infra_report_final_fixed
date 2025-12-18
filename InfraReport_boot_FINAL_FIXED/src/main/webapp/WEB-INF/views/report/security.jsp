<!-- ========================================
보안관제 현황
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 엑셀 업로드 영역 -->
<div class="card mb-4">
	<div class="card-body">
		<div class="upload-area" onclick="document.getElementById('securityExcelFile').click()">
			<i class="fas fa-file-excel fa-3x mb-3 text-success"></i>
			<h5>엑셀 파일을 선택하거나 드래그하세요</h5>
			<p class="text-muted">지원 형식: .xlsx, .xls</p>
			<input type="file" id="securityExcelFile" data-type="security" accept=".xlsx,.xls" style="display: none;" onchange="uploadExcel(this)">
		</div>
	</div>
</div>

<!-- 검색 폼 (보안관제 현황) - 가로 배치 -->
<div class="search-form">
<!-- 	<form action="report" method="get"> -->
		<input type="hidden" name="action" id="action" value="security">
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
					<option value="ACTIVITY_TYPE">활동유형</option>
					<option value="ACTION_STATUS">처리상태</option>
					<option value="DETAIL_INFO">상세정보</option>
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
					<option value="ACTIVITY_TYPE">활동유형</option>
					<option value="DETECTION_COUNT">탐지건수</option>
					<option value="ACTION_STATUS">처리상태</option>
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
				<button type="submit" class="btn btn-primary btn-sm w-100" onclick="searchSecurityActivityList();">
					<i class="fas fa-search"></i> 검색
				</button>
			</div>
		</div>
<!-- 	</form> -->
</div>

<!-- 보안관제 활동 현황 테이블 -->
<div class="card">
	<div class="card-header">
		<h5 class="mb-0">
			보안관제 활동 현황
			<button class="btn btn-sm btn-secondary float-end" onclick="newSecurityActivity();">
				<i class="fas fa-plus"></i> 활동 등록
			</button>
		</h5>
	</div>
	<div class="card-body p-0">
		<table class="table mb-0" id="securityTable">
			<thead>
				<tr>
					<th onclick="sortTable('securityTable', 0)">활동유형 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 1)">탐지건수 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 2)">차단건수 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 3)">상세정보 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 4)">처리상태 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 5)">등록일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 6)">등록자 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 7)">수정일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('securityTable', 8)">수정자 <span class="sort-icon"></span></th>
					<th>상세</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="securityTableBody">
				<c:forEach var="sa" items="${securityActivities}">
					<tr>
						<td>${sa.taskType}</td>
						<td><span class="badge bg-warning">${sa.detectionCount}</span></td>
						<td><span class="badge bg-danger">${sa.blockedCount}</span></td>
						<td>${sa.detailInfo}</td>
						<td><span class="badge ${sa.statusClass}">${sa.actionStatus}</span></td>
						<td><fmt:formatDate value="${sa.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${sa.createdBy}</td>
						<td><fmt:formatDate value="${sa.updatedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${sa.updatedBy}</td>
						<td>
							<button class="btn btn-sm btn-outline-primary" onclick="editSecurityActivity(${sa.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
						<td>
							<button class="btn btn-sm btn-danger" onclick="deleteSecurityActivity(${sa.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty securityActivities}">
					<tr>
						<td colspan="11" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<!-- 보안관제 활동 추가 모달 -->
<div class="modal fade" id="securityModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">보안관제 활동 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<form id="securityForm">
				<div class="modal-body">
					<div class="mb-3">
						<label class="form-label">활동유형</label> 
						<input type="text" class="form-control" name="taskType" required>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label class="form-label">탐지건수</label> 
							<input type="number" class="form-control" name="detectionCount" value="0">
						</div>
						<div class="col-md-6">
							<label class="form-label">차단건수</label> 
							<input type="number" class="form-control" name="blockedCount" value="0">
						</div>
					</div>
					<div class="mb-3">
						<label class="form-label">상세정보</label>
						<textarea class="form-control" name="detailInfo" rows="3"></textarea>
					</div>
					<div class="mb-3">
						<label class="form-label">처리상태</label> 
						<select class="form-select" name="actionStatus">
							<option value="완료">완료</option>
							<option value="진행중">진행중</option>
							<option value="미처리">미처리</option>
						</select>
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
					<input type="hidden" name="action" value="addSecurity">
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

function newSecurityActivity() {
	const securityModal = new bootstrap.Modal(document.getElementById('securityModal'));
    
    // 폼 초기화 (빈 값)
    const form = document.getElementById('securityForm');
    form.reset();
    form.querySelector('[name="action"]').value = 'addSecurity';
    
 	// 등록/수정 정보 숨기기
    document.getElementById('metaInfo').style.display = 'none';
    
    securityModal.show();
}

document.getElementById('securityForm').addEventListener('submit', function(e) {
	let securityUrl = "";
	let securityAction = this.querySelector('[name="action"]').value;
	
	if(securityAction == 'addSecurity') {
		securityUrl = 'addSecurityActivity';
	} else if(securityAction == 'updateSecurity') {
		securityUrl = 'updateSecurityActivity';
	}
	
    e.preventDefault();
    const securityAddFormData = new FormData(this);
    fetch('/security/'+securityUrl, {
        method: 'POST',
        body: securityAddFormData
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

//조건 별 검색
function searchSecurityActivityList() {
	
	const searchSecurityActivityListData = {
		  "startReportDate" : $("#startReportDate").val()					/* 시작 날짜	*/
		, "endReportDate" : $("#endReportDate").val()                       /* 종료 날짜	*/
		, "searchField" : $('#searchField option:selected').val()   		/* 검색 필드	*/
		, "searchKeyword" : $("#searchKeyword").val()               		/* 검색어		*/
		, "sortField" : $('#sortField option:selected').val()               /* 정렬 기준	*/
		, "sortOrder" : $('#sortOrder option:selected').val()               /* 순서		*/
	};
	
	$.ajax({
		type: "POST",
		url: "/security/searchSecurityActivityList",
		data:searchSecurityActivityListData,
		success: function(result) {
			const securityActivityListResult = result;
			let securityActivityListHtml = "";
			
			$('#securityTableBody').empty();
			
			if(!isNull(securityActivityListResult) && securityActivityListResult.length > 0) {
				
				securityActivityListResult.forEach(sa => {
					securityActivityListHtml += `
						<tr>
							<td>\${sa.taskType ?? ''}</td>
							<td><span class="badge bg-warning">\${sa.detectionCount ?? ''}</span></td>
							<td><span class="badge bg-danger">\${sa.blockedCount ?? ''}</span></td>
							<td>\${sa.detailInfo ?? ''}</td>
							<td><span class="badge \${sa.statusClass ?? ''}">\${sa.actionStatus ?? ''}</span></td>
							<td>\${formatDate(sa.createdDate)}</td>
							<td>\${sa.createdBy}</td>
							<td>\${formatDate(sa.updatedDate)}</td>
							<td>\${sa.updatedBy ?? ''}</td>
							<td>
								<button class="btn btn-sm btn-outline-primary" onclick="editSecurityActivity(\${sa.reportId ?? ''})">
									<i class="fas fa-edit"></i>
								</button>
							</td>
							<td>
								<button class="btn btn-sm btn-danger" onclick="deleteSecurityActivity(\${sa.reportId ?? ''})">
									<i class="fas fa-edit"></i>
								</button>
							</td>
						</tr>
					`;
				});
				
			} else {
				securityActivityListHtml += `
					<tr>
						<td colspan="11" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				`;
			}
			
			$('#securityTableBody').html(securityActivityListHtml);
		},
		error: function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

//HW/SW 점검 결과 수정
function editSecurityActivity(reportId) {
	const modal = new bootstrap.Modal(document.getElementById('securityModal'));
    const form = document.getElementById('securityForm');

    // action을 update로 변경
    form.querySelector('[name="action"]').value = 'updateSecurity';
    
    const securityEditFormData = new URLSearchParams();
    securityEditFormData.append("reportId", reportId);
    
    fetch('/security/getSecurityActivity', {
        method: 'POST',
        body: securityEditFormData
    })
    .then(response => response.json())
    .then(data => {
        if (data) {
            form.querySelector('[name="taskType"]').value = data.taskType;
            form.querySelector('[name="detectionCount"]').value = data.detectionCount;
            form.querySelector('[name="blockedCount"]').value = data.blockedCount;
            form.querySelector('[name="detailInfo"]').value = data.detailInfo;
            form.querySelector('[name="actionStatus"]').value = data.actionStatus;
            
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

//HW/SW 점검 결과 삭제
function deleteSecurityActivity(reportId) {
	if (!confirm("해당 활동을 삭제하시겠습니까?")) return;
	
	const securityDeleteFormData = new FormData();
    securityDeleteFormData.append("action", "deleteSecurity");
    securityDeleteFormData.append("reportId", reportId);

    fetch("/security/deleteSecurityActivity", {
        method: "POST",
        body: securityDeleteFormData
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