<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body { background-color: #f4f6f9; font-family: 'Malgun Gothic', sans-serif; }
    
    /* 네비게이션 커스텀 */
    .navbar-custom { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); padding: 15px 20px; }
    .nav-btn { color: white; border: 1px solid rgba(255,255,255,0.3); margin-left: 10px; transition: 0.3s; }
    .nav-btn:hover { background: rgba(255,255,255,0.2); color: white; }

    /* 3단 워크플로우 레이아웃 */
    .phase-container { display: flex; gap: 20px; padding: 20px 0; min-height: 650px; }
    
    /* 문서 아이템 스타일 */
    .doc-item { background: white; padding: 12px; margin-bottom: 10px; border: 1px solid #e5e7eb; border-radius: 6px; position: relative; transition: 0.2s; }
    .doc-item:hover { box-shadow: 0 2px 5px rgba(0,0,0,0.1); transform: translateY(-2px); }
    
    .btn-del { position: absolute; top: 10px; right: 10px; color: #ef4444; cursor: pointer; opacity: 0.6; transition: 0.2s; }
    .btn-del:hover { opacity: 1; transform: scale(1.1); }
    
    .table th {
	    vertical-align: middle;
	    text-align: center;
	}
	
	.doc-item a:hover {
	    text-decoration: underline;
	    color: #0d6efd;
	}

</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#"><i class="fas fa-user-shield me-2"></i>작업 관리 시스템 (관리자)</a>
        <div class="d-flex align-items-center">
            <a href="/dashboard/tv" class="btn btn-sm nav-btn"><i class="fas fa-tv me-1"></i> TV 대시보드</a>
            <a href="/report/main" class="btn btn-sm nav-btn"><i class="fas fa-chart-line me-1"></i> 일일보고서</a>
            <form action="/logout" method="post" class="d-inline">
                <button class="btn btn-sm btn-danger ms-3"><i class="fas fa-sign-out-alt me-1"></i> 로그아웃</button>
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid p-4">

    <div class="d-flex gap-3 mb-3 align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-3">
            <h4 class="mb-0 fw-bold text-secondary">작업 목록</h4>
        </div>
    </div>

    <div class="phase-container" id="wfView">
        <table class="table table-bordered text-center align-middle">
	        <thead class="table-light">
	            <tr>
	                <th rowspan="2">작업명</th>
	                <th rowspan="2">작업자</th>
	                <th colspan="3">의뢰</th>
	                <th colspan="5">계획</th>
	                <th colspan="3">결과</th>
	            </tr>
	            <tr>
	                <th>요청일</th>
	                <th>승인일</th>
	                <th>상태</th>
	
	                <th>작업시작일</th>
	                <th>작업종료일</th>
	                <th>요청일</th>
	                <th>승인일</th>
	                <th>상태</th>
	
	                <th>요청일</th>
	                <th>승인일</th>
	                <th>상태</th>
	            </tr>
	        </thead>
	        <tbody id="tasksBody">
	            <c:choose>
				    <c:when test="${not empty tasks}">
				        <c:forEach var="task" items="${tasks}">
				            <tr>
				                <td rowspan="2">${task.tasksName}</td>
				                <td rowspan="2">${task.createdBy}</td>
				                
				                <!-- 의뢰(REQUEST) -->
				                <td><fmt:formatDate value="${task.requestDate}" pattern="yyyy-MM-dd HH:mm"/></td>
				                <td>
				                	<c:choose>
								        <c:when test="${not empty task.requestDate}">
								            <c:choose>
								                <c:when test="${not empty task.requestApprovedDate}">
								                    <fmt:formatDate value="${task.requestApprovedDate}" pattern="yyyy-MM-dd HH:mm"/>
								                </c:when>
								                <c:otherwise>
								                    <button class="btn btn-sm btn-outline-success" 
								                            onclick="approveTaskRequest(${task.idx}, 'REQUEST')">
								                        승인
								                    </button>
								                </c:otherwise>
								            </c:choose>
								        </c:when>
								        <c:otherwise>
								            <span></span>
								        </c:otherwise>
								    </c:choose>
				                </td>
				                <td>${task.requestStatus}</td>
				                
				                <!-- 계획(PLAN) -->
				                <td><fmt:formatDate value="${task.planStartDate}" pattern="yyyy-MM-dd"/></td>
				                <td><fmt:formatDate value="${task.planEndDate}" pattern="yyyy-MM-dd"/></td>
				                <td><fmt:formatDate value="${task.planRequestDate}" pattern="yyyy-MM-dd HH:mm"/></td>
				                <td>
				                	<c:choose>
								        <c:when test="${not empty task.planRequestDate}">
								            <c:choose>
								                <c:when test="${not empty task.planApprovedDate}">
								                    <fmt:formatDate value="${task.planApprovedDate}" pattern="yyyy-MM-dd HH:mm"/>
								                </c:when>
								                <c:otherwise>
								                    <button class="btn btn-sm btn-outline-success" 
								                            onclick="approveTaskRequest(${task.idx}, 'PLAN')">
								                        승인
								                    </button>
								                </c:otherwise>
								            </c:choose>
								        </c:when>
								        <c:otherwise>
								            <span></span>
								        </c:otherwise>
								    </c:choose>
				                </td>
				                <td>${task.planStatus}</td>
				                
				                <!-- 결과(RESULT) -->
				                <td><fmt:formatDate value="${task.resultRequestDate}" pattern="yyyy-MM-dd HH:mm"/></td>
				                <td>
				                	<c:choose>
								        <c:when test="${not empty task.resultRequestDate}">
								            <c:choose>
								                <c:when test="${not empty task.resultApprovedDate}">
								                    <fmt:formatDate value="${task.resultApprovedDate}" pattern="yyyy-MM-dd HH:mm"/>
								                </c:when>
								                <c:otherwise>
								                    <button class="btn btn-sm btn-outline-success" 
								                            onclick="approveTaskRequest(${task.idx}, 'RESULT')">
								                        승인
								                    </button>
								                </c:otherwise>
								            </c:choose>
								        </c:when>
								        <c:otherwise>
								            <span></span>
								        </c:otherwise>
								    </c:choose>
				                </td>
				                <td>${task.resultStatus}</td>
				            </tr>
				            
				            <tr>
				                <!-- 의뢰 파일 -->
				                <td colspan="2">
				                    <c:forEach var="file" items="${tasksFile}">
				                        <c:if test="${file.tasksIdx == task.idx && file.tasksStage == 'REQUEST'}">
				                            <div class="doc-item d-flex justify-content-between align-items-center">
							                    <a href="/tasks/downloadFile?idx=${file.idx}"
												   class="text-decoration-none"
												   title="다운로드">
												    <i class="fas fa-download me-1"></i>
												    ${file.orgFileName}
												</a>
							                </div>
				                        </c:if>
				                    </c:forEach>
				                </td>
				                <td>
				                	<button class="btn btn-sm btn-outline-primary mt-1" onclick="openTasks('${task.idx}', 'REQUEST')">
							            <i class="fas fa-upload"></i> 업로드
							        </button>
				                </td>
				                
				                <!-- 계획 파일 -->
				                <td colspan="4">
				                    <c:forEach var="file" items="${tasksFile}">
				                        <c:if test="${file.tasksIdx == task.idx && file.tasksStage == 'PLAN'}">
				                            <div class="doc-item d-flex justify-content-between align-items-center">
							                    <a href="/tasks/downloadFile?idx=${file.idx}"
												   class="text-decoration-none"
												   title="다운로드">
												    <i class="fas fa-download me-1"></i>
												    ${file.orgFileName}
												</a>
							                </div>
				                        </c:if>
				                    </c:forEach>
				                </td>
				                <td>
				                	<button class="btn btn-sm btn-outline-primary mt-1" onclick="openTasks('${task.idx}', 'PLAN', 
				                		'<fmt:formatDate value="${task.planStartDate}" pattern="yyyy-MM-dd"/>',
        								'<fmt:formatDate value="${task.planEndDate}" pattern="yyyy-MM-dd"/>')">
							            <i class="fas fa-upload"></i> 업로드
							        </button>
				                </td>
				                
				                <!-- 결과 파일 -->
				                <td colspan="2">
				                    <c:forEach var="file" items="${tasksFile}">
				                        <c:if test="${file.tasksIdx == task.idx && file.tasksStage == 'RESULT'}">
				                            <div class="doc-item d-flex justify-content-between align-items-center">
							                    <a href="/tasks/downloadFile?idx=${file.idx}"
												   class="text-decoration-none"
												   title="다운로드">
												    <i class="fas fa-download me-1"></i>
												    ${file.orgFileName}
												</a>
							                </div>
				                        </c:if>
				                    </c:forEach>
				                </td>
				                <td>
				                	<button class="btn btn-sm btn-outline-primary mt-1" onclick="openTasks('${task.idx}', 'RESULT')">
							            <i class="fas fa-upload"></i> 업로드
							        </button>
				                </td>
				            </tr>
				        </c:forEach>
				    </c:when>
				    <c:otherwise>
				        <tr><td colspan="12" class="text-center">등록된 작업이 없습니다.</td></tr>
				    </c:otherwise>
				</c:choose>
	        </tbody>
	    </table>
    </div>
</div>

<!-- 의뢰 결과 파일 업로드 팝업 -->
<div class="modal fade" id="updateTasksModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white"><h5>작업 수정</h5><button class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
            	<input type="file" name="file" id="updateFileInput" class="form-control mb-2 fileInput" onchange="fileSetting(this);">
            </div>
            <div class="modal-footer"><button type="button" class="btn btn-primary w-100" onclick="updateTasks();">수정하기</button></div>
        </div>
    </div>
</div>

<!-- 계획 파일 업로드 팝업 -->
<div class="modal fade" id="updatePlanTasksModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white"><h5>작업 수정</h5><button class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div class="row align-items-center mb-2">
			        <label for="planStartDate" class="col-4 col-form-label">작업시작일</label>
			        <div class="col-8">
			            <input type="date" name="planStartDate" id="planStartDate" class="form-control form-control-sm">
			        </div>
			    </div>
			    <div class="row align-items-center mb-2">
			        <label for="planEndDate" class="col-4 col-form-label">작업종료일</label>
			        <div class="col-8">
			            <input type="date" name="planEndDate" id="planEndDate" class="form-control form-control-sm">
			        </div>
			    </div>
                <div class="fileDiv">
	                <input type="file" name="file" id="updatePlanFileInput" class="form-control mb-2 fileInput" onchange="fileSetting(this);">
	            </div>
            </div>
            <div class="modal-footer"><button type="button" class="btn btn-primary w-100" onclick="updateTasks();">수정하기</button></div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

let tasksIdx = "";
let tasksStage = "";

//파일 선택 셋팅
function fileSetting(el) {
	var fileInput = el.id;
	var file = fileInput.files;
	
	var size = file[0].size*0.000001;
	
	if(size > 6) {
		alert("업로드 최대 용량은 5MB 입니다.");
		return;
	}
}

//작업 및 파일 업로드
function openTasks(paramTasksIdx, flag, planStartDate, planEndDate) {
	
	tasksIdx = paramTasksIdx;
	tasksStage = flag;
	
	//핍업 조회
	if(flag != 'PLAN') {
		$('#updateTasksModal').modal('show');
	} else {
		$('#updatePlanTasksModal').modal('show');
		$("#planStartDate").val(planStartDate);
		$("#planEndDate").val(planEndDate);
	}
}

//업로드
function updateTasks() {
	var tasksData = new FormData();
	tasksData.append('tasksIdx', tasksIdx);
	tasksData.append('tasksStage', tasksStage);
	
	fileInputId = "";
	if(tasksStage != 'PLAN') {
		fileInputId = document.getElementById('updateFileInput');
	} else {
		fileInputId = document.getElementById('updatePlanFileInput');
		tasksData.append('planStartDate', $("#planStartDate").val());
		tasksData.append('planEndDate', $("#planEndDate").val());
	}
	
	if(fileInputId.files.length === 0){ 
        alert("파일을 선택해주세요."); 
        return; 
    }
	
	for(var i = 0; i < fileInputId.files.length; i++){
        tasksData.append('fileArr', fileInputId.files[i]);
    }
	
	$.ajax({
		url:'/tasks/updateTasks'
	  	, type:'POST'
  		, data:tasksData
    	, processData:false
    	, contentType:false
    	, success:function(data){
    		if (data.isSuccess) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
    	}
	});
}

//단계별 승인
function approveTaskRequest(idx, flag) {
	$.ajax({
		url:'/tasks/updateApproved'
	  	, type:'POST'
  		, data:{"idx":idx, "tasksStage":flag}
    	, success:function(data){
    		if (data.isSuccess) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
    	}
	});
}

</script>