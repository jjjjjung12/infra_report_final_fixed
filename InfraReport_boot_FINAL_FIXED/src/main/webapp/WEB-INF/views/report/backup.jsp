<!-- ========================================
백업 관리
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 엑셀 업로드 영역 -->
<div class="card mb-4">
	<div class="card-body">
		<div class="upload-area" onclick="document.getElementById('backupExcelFile').click()">
			<i class="fas fa-file-excel fa-3x mb-3 text-success"></i>
			<h5>엑셀 파일을 선택하거나 드래그하세요</h5>
			<p class="text-muted">지원 형식: .xlsx, .xls</p>
			<input type="file" id="backupExcelFile" data-type="backup" accept=".xlsx,.xls" style="display: none;" onchange="uploadExcel(this)">
		</div>
	</div>
</div>

<!-- 검색 폼 (백업 관리) - 가로 배치 -->
<div class="search-form">
<!-- 	<form action="report" method="get"> -->
		<input type="hidden" name="action" id="action" value="backup">
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
					<option value="SERVICE_NAME">서비스명</option>
					<option value="BACKUP_TYPE">백업유형</option>
					<option value="BACKUP_LIBRARY">백업장비</option>
					<option value="BACKUP_CATEGORY">백업구분</option>
					<option value="BACKUP_STATUS">상태</option>
					<option value="REMARKS">비고</option>
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
					<option value="SERVICE_NAME">서비스명</option>
					<option value="BACKUP_STATUS">백업상태</option>
					<option value="BACKUP_LEVEL">레벨</option>
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
				<button type="submit" class="btn btn-primary btn-sm w-100" onclick="searchBackupResultList();">
					<i class="fas fa-search"></i> 검색
				</button>
			</div>
		</div>
<!-- 	</form> -->
</div>

<!-- 백업 관리대장 테이블 -->
<div class="card">
	<div class="card-header">
		<h5 class="mb-0">
			백업 관리대장
			<button class="btn btn-sm btn-secondary float-end" onclick="newBackupRecord()">
				<i class="fas fa-plus"></i> 백업 등록
			</button>
		</h5>
	</div>
	<div class="card-body p-0">
		<table class="table mb-0" id="backupTable">
			<thead>
				<tr>
					<th onclick="sortTable('backupTable', 0)">서비스명 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 1)">백업유형 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 2)">백업장비 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 3)">백업구분 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 4)">레벨 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 5)">상태 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 6)">비고 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 7)">등록일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 8)">등록자 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 9)">수정일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('backupTable', 10)">수정자 <span class="sort-icon"></span></th>
					<th>상세</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="backupTableBody">
				<c:forEach var="bk" items="${backupResults}">
					<tr>
						<td>${bk.serviceName}</td>
						<td>${bk.backupType}</td>
						<td>${bk.backupLibrary}</td>
						<td>${bk.backupCategory}</td>
						<td>${bk.backupLevel}</td>
						<td><span class="badge ${bk.statusClass}">${bk.backupStatus}</span></td>
						<td>${bk.remarks}</td>
						<td><fmt:formatDate value="${bk.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${bk.createdBy}</td>
						<td><fmt:formatDate value="${bk.updatedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${bk.updatedBy}</td>
						<td>
							<button class="btn btn-sm btn-outline-primary" onclick="editBackup(${bk.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
						<td>
							<button class="btn btn-sm btn-danger" onclick="deleteBackup(${bk.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty backupResults}">
					<tr>
						<td colspan="13" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>

<!-- 백업 결과 추가 모달 -->
<div class="modal fade" id="backupModal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">백업 결과 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<form id="backupForm">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6">
							<label class="form-label">서비스명</label> 
							<input type="text" class="form-control" name="serviceName" required>
						</div>
						<div class="col-md-6">
							<label class="form-label">백업유형</label> 
							<input type="text" class="form-control" name="backupType">
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label class="form-label">백업장비</label> 
							<input type="text" class="form-control" name="backupLibrary">
						</div>
						<div class="col-md-6">
							<label class="form-label">백업구분</label> 
							<select class="form-select" name="backupCategory">
								<c:forEach var="bc" items="${backupCategories}">
									<option value="${bc.cdName}">${bc.cdName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label class="form-label">레벨</label> 
							<select class="form-select" name="backupLevel">
								<option value="1">1</option>
								<option value="2">2</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label">상태</label> 
							<select class="form-select" name="backupStatus">
								<option value="성공">성공</option>
								<option value="실패">실패</option>
							</select>
						</div>
					</div>
					<div class="mb-3">
						<label class="form-label">비고</label> 
						<input type="text" class="form-control" name="remarks">
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
					<input type="hidden" name="action" value="addBackup">
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

function newBackupRecord() {
	const backupModal = new bootstrap.Modal(document.getElementById('backupModal'));
    
    // 폼 초기화 (빈 값)
    const form = document.getElementById('backupForm');
    form.reset();
    form.querySelector('[name="action"]').value = 'addBackup';
    
 	// 등록/수정 정보 숨기기
    document.getElementById('metaInfo').style.display = 'none';
    
    backupModal.show();
}

document.getElementById('backupForm').addEventListener('submit', function(e) {
	let backupUrl = "";
	let backupAction = this.querySelector('[name="action"]').value;
	
	if(backupAction == 'addBackup') {
		backupUrl = 'addBackupResult';
	} else if(backupAction == 'updateBackup') {
		backupUrl = 'updateBackupResult';
	}
	
    e.preventDefault();
    const backupAddFormData = new FormData(this);
    fetch('/backup/'+backupUrl, {
        method: 'POST',
        body: backupAddFormData
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
function searchBackupResultList() {
	
	const searchBackupResultListData = {
		  "startReportDate" : $("#startReportDate").val()					/* 시작 날짜	*/
		, "endReportDate" : $("#endReportDate").val()                       /* 종료 날짜	*/
		, "searchField" : $('#searchField option:selected').val()   		/* 검색 필드	*/
		, "searchKeyword" : $("#searchKeyword").val()               		/* 검색어		*/
		, "sortField" : $('#sortField option:selected').val()               /* 정렬 기준	*/
		, "sortOrder" : $('#sortOrder option:selected').val()               /* 순서		*/
	};
	
	$.ajax({
		type: "POST",
		url: "/backup/searchBackupResultList",
		data:searchBackupResultListData,
		success: function(result) {
			const backupResultListResult = result;
			let backupResultHtml = "";
			
			$('#backupTableBody').empty();
			
			if(!isNull(backupResultListResult) && backupResultListResult.length > 0) {
				
				backupResultListResult.forEach(bk => {
					backupResultHtml += `
						<tr>
							<td>\${bk.serviceName ?? ''}</td>
							<td>\${bk.backupType ?? ''}</td>
							<td>\${bk.backupLibrary ?? ''}</td>
							<td>\${bk.backupCategory ?? ''}</td>
							<td>\${bk.backupLevel ?? ''}</td>
							<td><span class="badge \${bk.statusClass ?? ''}">\${bk.backupStatus ?? ''}</span></td>
							<td>\${bk.remarks ?? ''}</td>
							<td>\${formatDate(bk.createdDate)}</td>
							<td>\${bk.createdBy}</td>
							<td>\${formatDate(bk.updatedDate)}</td>
							<td>\${bk.updatedBy ?? ''}</td>
							<td>
								<button class="btn btn-sm btn-outline-primary" onclick="editBackup(\${bk.reportId ?? ''})">
									<i class="fas fa-edit"></i>
								</button>
							</td>
							<td>
								<button class="btn btn-sm btn-danger" onclick="deleteBackup(\${bk.reportId ?? ''})">
									<i class="fas fa-edit"></i>
								</button>
							</td>
						</tr>
					`;
				});
				
			} else {
				backupResultHtml += `
					<tr>
						<td colspan="13" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				`;
			}
			
			$('#backupTableBody').html(backupResultHtml);
		},
		error: function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

//백업 결과 수정
function editBackup(reportId) {
	const modal = new bootstrap.Modal(document.getElementById('backupModal'));
    const form = document.getElementById('backupForm');

    // action을 update로 변경
    form.querySelector('[name="action"]').value = 'updateBackup';
    
    const backupEditFormData = new URLSearchParams();
    backupEditFormData.append("reportId", reportId);
    
    fetch('/backup/getBackupResult', {
        method: 'POST',
        body: backupEditFormData
    })
    .then(response => response.json())
    .then(data => {
        if (data) {
            form.querySelector('[name="serviceName"]').value = data.serviceName;
            form.querySelector('[name="backupType"]').value = data.backupType;
            form.querySelector('[name="backupLibrary"]').value = data.backupLibrary;
            form.querySelector('[name="backupCategory"]').value = data.backupCategory;
            form.querySelector('[name="backupLevel"]').value = data.backupLevel;
            form.querySelector('[name="backupStatus"]').value = data.backupStatus;
            form.querySelector('[name="remarks"]').value = data.remarks;
            
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

//백업 결과 삭제
function deleteBackup(reportId) {
	if (!confirm("해당 결과를 삭제하시겠습니까?")) return;
	
	const backupDeleteFormData = new FormData();
    backupDeleteFormData.append("action", "deleteBackup");
    backupDeleteFormData.append("reportId", reportId);

    fetch("/backup/deleteBackupResult", {
        method: "POST",
        body: backupDeleteFormData
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