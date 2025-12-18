<!-- ========================================
HW/SW 점검 결과
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 검색 폼 (HW/SW 점검) - 가로 배치 -->
<div class="search-form">
<!-- 	<form action="report" method="get"> -->
		<input type="hidden" name="action" id="action" value="hwsw">
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
					<option value="SERVER_NAME">서버명</option>
					<option value="CHECK_ITEM">점검항목</option>
					<option value="CHECK_RESULT">결과</option>
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
					<option value="SERVER_NAME">서버명</option>
					<option value="CHECK_ITEM">점검항목</option>
					<option value="CHECK_RESULT">결과</option>
					<option value="MANAGER">담당자</option>
				</select>
			</div>
			<div class="col-md-1">
				<label class="form-label small">순서</label> 
				<select name="sortOrder" id="sortOrder" class="form-select form-select-sm">
					<option value="ASC">오름차순</option>
					<option value="DESC">내림차순</option>
				</select>
			</div>
			<div class="col-md-1">
				<button type="submit" class="btn btn-primary btn-sm w-100" onclick="searchHwswCheckList();">
					<i class="fas fa-search"></i> 검색
				</button>
			</div>
		</div>
<!-- 	</form> -->
</div>

<div class="card">
	<div class="card-header">
		<h5 class="mb-0">
			HW/SW 점검 결과
			<button class="btn btn-sm btn-primary float-end" onclick="showHwSwModal()">
				<i class="fas fa-plus"></i> 점검 결과 등록
			</button>
		</h5>
	</div>
	<div class="card-body p-0">
		<table class="table mb-0" id="hwswTable">
			<thead>
				<tr>
					<th onclick="sortTable('hwswTable', 0)">서버명 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 1)">점검항목 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 2)">점검내용 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 3)">결과 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 4)">에러내용 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 5)">조치사항 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 6)">담당자 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 7)">등록일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 8)">등록자 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 9)">수정일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('hwswTable', 10)">수정자 <span class="sort-icon"></span></th>
					<th>상세</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="hwswTableBody">
				<c:forEach var="check" items="${hwswChecks}">
					<tr>
						<td>${check.serverName}</td>
						<td>${check.checkItem}</td>
						<td>${check.checkContent}</td>
						<td class="text-center">
							<span class="${check.checkResultClass}">${check.checkResult}</span>
						</td>
						<td>${check.errorContent}</td>
						<td>${check.actionTaken}</td>
						<td>${check.manager}</td>
						<td><fmt:formatDate value="${check.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${check.createdBy}</td>
						<td><fmt:formatDate value="${check.updatedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${check.updatedBy}</td>
						<td>
							<button class="btn btn-sm btn-outline-primary" onclick="editHwswCheck(${check.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
						<td>
							<button class="btn btn-sm btn-danger" onclick="deleteHwswCheck(${check.reportId})">
								<i class="fas fa-edit"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty hwswChecks}">
					<tr>
						<td colspan="13" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>

<!-- HW/SW 점검 결과 등록 모달 -->
<div class="modal fade" id="hwSwModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">HW/SW 점검 결과 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<form id="hwSwForm">
				<div class="modal-body">
					<div class="mb-3">
						<label class="form-label">서버명</label> 
						<input type="text" class="form-control" name="serverName" required>
					</div>
					<div class="mb-3">
						<label class="form-label">점검항목</label> 
						<input type="text" class="form-control" name="checkItem" required>
					</div>
					<div class="mb-3">
						<label class="form-label">점검내용</label>
						<textarea class="form-control" name="checkContent" rows="2"></textarea>
					</div>
					<div class="mb-3">
						<label class="form-label">결과</label> 
						<select class="form-select" name="checkResult" required>
							<option value="O">O (정상)</option>
							<option value="X">X (비정상)</option>
						</select>
					</div>
					<div class="mb-3">
						<label class="form-label">에러내용</label> 
						<input type="text" class="form-control" name="errorContent">
					</div>
					<div class="mb-3">
						<label class="form-label">조치사항</label> 
						<input type="text" class="form-control" name="actionTaken">
					</div>
					<div class="mb-3">
						<label class="form-label">담당자</label> 
						<input type="text" class="form-control" name="manager">
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
					<input type="hidden" name="action" value="addHwSw">
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

//점검 결과 등록 모달 show
function showHwSwModal() {
    const hwswModal = new bootstrap.Modal(document.getElementById('hwSwModal'));
    
 	// 폼 초기화 (빈 값)
    const form = document.getElementById('hwSwForm');
    form.reset();
    form.querySelector('[name="action"]').value = 'addHwSw';
    
 	// 등록/수정 정보 숨기기
    document.getElementById('metaInfo').style.display = 'none';
    
    hwswModal.show();
}

//HW/SW 점검 결과 등록, 수정
document.getElementById('hwSwForm').addEventListener('submit', function(e) {
	let hwswUrl = "";
	let hwswAction = this.querySelector('[name="action"]').value;
	
	if(hwswAction == 'addHwSw') {
		hwswUrl = 'addHwswCheck';
	} else if(hwswAction == 'updateHwsw') {
		hwswUrl = 'updateHwswCheck';
	}
	
    e.preventDefault();
    const hwswAddFormData = new FormData(this);
    fetch('/hwsw/'+hwswUrl, {
        method: 'POST',
        body: hwswAddFormData
    })
    .then(response => response.json())
    .then(data => {
    	if (data.isSuccess) {
            alert(data.message);
//             const modalEl = document.getElementById('hwSwModal');
//             const modalInstance = bootstrap.Modal.getInstance(modalEl);
//             if (modalInstance) modalInstance.hide();
//             document.getElementById('hwSwForm').reset();
            
            reloadCurrentTab();
            
        } else {
            alert(data.message);
        }
    });
});

//조건 별 검색
function searchHwswCheckList() {
	
	const searchHwswCheckListData = {
		  "startReportDate" : $("#startReportDate").val()					/* 시작 날짜	*/
		, "endReportDate" : $("#endReportDate").val()                       /* 종료 날짜	*/
		, "searchField" : $('#searchField option:selected').val()   		/* 검색 필드	*/
		, "searchKeyword" : $("#searchKeyword").val()               		/* 검색어		*/
		, "sortField" : $('#sortField option:selected').val()               /* 정렬 기준	*/
		, "sortOrder" : $('#sortOrder option:selected').val()               /* 순서		*/
	};
	
	$.ajax({
		type: "POST",
		url: "/hwsw/searchHwswCheckList",
		data:searchHwswCheckListData,
		success: function(result) {
			const hwswCheckListResult = result;
			let hwswCheckListHtml = "";
			
			$('#hwswTableBody').empty();
			
			if(!isNull(hwswCheckListResult) && hwswCheckListResult.length > 0) {
				
				hwswCheckListResult.forEach(check => {
					hwswCheckListHtml += `
						<tr>
							<td>\${check.serverName ?? ''}</td>
							<td>\${check.checkItem ?? ''}</td>
							<td>\${check.checkContent ?? ''}</td>
							<td class="text-center">
								<span class="\${check.checkResultClass ?? ''}">\${check.checkResult ?? ''}</span>
							</td>
							<td>\${check.errorContent ?? ''}</td>
							<td>\${check.actionTaken ?? ''}</td>
							<td>\${check.manager ?? ''}</td>
							<td>\${formatDate(check.createdDate)}</td>
							<td>\${check.createdBy}</td>
							<td>\${formatDate(check.updatedDate)}</td>
							<td>\${check.updatedBy ?? ''}</td>
							<td>
								<button class="btn btn-sm btn-outline-primary" onclick="editHwswCheck(\${check.reportId})">
									<i class="fas fa-edit"></i>
								</button>
							</td>
							<td>
								<button class="btn btn-sm btn-danger" onclick="deleteHwswCheck(\${check.reportId})">
									<i class="fas fa-edit"></i>
								</button>
							</td>
						</tr>
					`;
				});
				
			} else {
				hwswCheckListHtml += `
					<tr>
						<td colspan="13" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				`;
			}
			
			$('#hwswTableBody').html(hwswCheckListHtml);
		},
		error: function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

//HW/SW 점검 결과 수정
function editHwswCheck(reportId) {
	const modal = new bootstrap.Modal(document.getElementById('hwSwModal'));
    const form = document.getElementById('hwSwForm');

    // action을 update로 변경
    form.querySelector('[name="action"]').value = 'updateHwsw';
    
    const hwswEditFormData = new URLSearchParams();
    hwswEditFormData.append("reportId", reportId);
    
    fetch('/hwsw/getHwswCheck', {
        method: 'POST',
        body: hwswEditFormData
    })
    .then(response => response.json())
    .then(data => {
        if (data) {
            form.querySelector('[name="serverName"]').value = data.serverName;
            form.querySelector('[name="checkItem"]').value = data.checkItem;
            form.querySelector('[name="checkContent"]').value = data.checkContent;
            form.querySelector('[name="checkResult"]').value = data.checkResult;
            form.querySelector('[name="errorContent"]').value = data.errorContent;
            form.querySelector('[name="actionTaken"]').value = data.actionTaken;
            form.querySelector('[name="manager"]').value = data.manager;
            
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
function deleteHwswCheck(reportId) {
	if (!confirm("해당 결과를 삭제하시겠습니까?")) return;
	
	const hwswDeleteFormData = new FormData();
    hwswDeleteFormData.append("action", "deleteHwsw");
    hwswDeleteFormData.append("reportId", reportId);

    fetch("/hwsw/deleteHwswCheck", {
        method: "POST",
        body: hwswDeleteFormData
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