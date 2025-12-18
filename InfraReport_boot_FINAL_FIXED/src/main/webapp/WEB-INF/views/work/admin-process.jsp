<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
    .phase-col { flex: 1; min-width: 320px; }
    .phase-card { background: #fff; border: 1px solid #ddd; border-radius: 8px; height: 100%; display: flex; flex-direction: column; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
    
    /* 단계별 헤더 색상 */
    .ph-init { background-color: #d1fae5; color: #065f46; border-bottom: 3px solid #34d399; } 
    .ph-const { background-color: #dbeafe; color: #1e40af; border-bottom: 3px solid #60a5fa; } 
    .ph-comp { background-color: #f3f4f6; color: #1f2937; border-bottom: 3px solid #9ca3af; } 
    
    .phase-header { padding: 15px; font-weight: bold; text-align: center; font-size: 1.1rem; display: flex; justify-content: space-between; align-items: center; border-radius: 8px 8px 0 0; }
    .phase-body { padding: 15px; background: #f9fafb; flex: 1; overflow-y: auto; }
    
    /* 문서 아이템 스타일 */
    .doc-item { background: white; padding: 12px; margin-bottom: 10px; border: 1px solid #e5e7eb; border-radius: 6px; position: relative; transition: 0.2s; }
    .doc-item:hover { box-shadow: 0 2px 5px rgba(0,0,0,0.1); transform: translateY(-2px); }
    
    .btn-del { position: absolute; top: 10px; right: 10px; color: #ef4444; cursor: pointer; opacity: 0.6; transition: 0.2s; }
    .btn-del:hover { opacity: 1; transform: scale(1.1); }

    /* 상태 뱃지 */
    .st-APPROVED { background: #d1fae5; color: #065f46; }
    .st-PENDING { background: #fef3c7; color: #92400e; }
    .st-REJECTED { background: #fee2e2; color: #b91c1c; }
    .st-NOT_UPLOADED { background: #f3f4f6; color: #6b7280; }
    .doc-badge { font-size: 0.75rem; padding: 3px 8px; border-radius: 12px; font-weight: 600; }
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
    <div class="card shadow-sm mb-4 border-0">
        <div class="card-body d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-3">
                <h5 class="mb-0 fw-bold text-secondary">프로젝트 선택:</h5>
                <select id="projectSelect" class="form-select border-primary fw-bold" style="width: 300px;" onchange="loadProjectData(this.value)">
                    <option value="">▶ 작업할 프로젝트를 선택하세요</option>
                    <c:forEach var="p" items="${projects}">
                        <option value="${p.projectId}">[${p.projectStatus}] ${p.projectName} (${p.userName})</option>
                    </c:forEach>
                </select>
                <button class="btn btn-outline-danger btn-sm" onclick="deleteProject()">
                    <i class="fas fa-trash-alt me-1"></i>프로젝트 삭제
                </button>
                <span id="currentStageBadge" class="badge bg-dark ms-2" style="display:none;"></span>
            </div>
            <button class="btn btn-primary" onclick="$('#templateModal').modal('show')">
                <i class="fas fa-cog me-2"></i>표준 양식 관리
            </button>
        </div>
    </div>

    <div class="phase-container" id="workflowView" style="display:none;">
        
        <c:forEach var="stage" items="${['INITIATION', 'CONSTRUCTION', 'COMPLETION']}">
            <div class="phase-col">
                <div class="phase-card">
                    <div class="phase-header ${stage=='INITIATION'?'ph-init':stage=='CONSTRUCTION'?'ph-const':'ph-comp'}">
                        <span>
                            <i class="fas ${stage=='INITIATION'?'fa-flag':stage=='CONSTRUCTION'?'fa-tools':'fa-check-circle'} me-2"></i>
                            ${stage=='INITIATION'?'착수':stage=='CONSTRUCTION'?'구축':'완료'} 단계
                        </span>
                        <button id="btn-next-${stage}" class="btn btn-sm btn-light text-dark fw-bold shadow-sm" style="display:none;" onclick="approveStage('${stage}')">
                            ${stage=='COMPLETION'?'최종 완료':'단계 승인'} <i class="fas fa-forward ms-1"></i>
                        </button>
                    </div>
                    
                    <div class="phase-body" id="col-${stage}"></div>
                    
                    <div class="p-3 border-top bg-white">
                        <div class="input-group input-group-sm">
                            <select id="addSelect-${stage}" class="form-select">
                                <option value="">+ 추가할 양식 선택</option>
                                <c:forEach var="t" items="${templates}">
                                    <c:if test="${t.stage == stage}">
                                        <option value="${t.templateId}">${t.documentName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <button class="btn btn-outline-primary" onclick="addDoc('${stage}')">추가</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
    
    <div id="emptyMsg" class="text-center py-5 text-muted opacity-50">
        <i class="fas fa-project-diagram fa-4x mb-3"></i>
        <h3>상단에서 프로젝트를 선택해주세요.</h3>
    </div>
</div>

<div class="modal fade" id="approveModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white"><h5 class="modal-title"><i class="fas fa-check-double me-2"></i>문서 승인</h5><button class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body bg-light">
                <div class="card mb-3 p-3 border-0 shadow-sm d-flex flex-row justify-content-between align-items-center">
                    <div><span class="text-muted small">문서명</span><br><strong id="modalDocName" class="fs-5"></strong></div>
                    <a id="modalDownBtn" href="#" class="btn btn-primary btn-sm"><i class="fas fa-download me-1"></i> 다운로드</a>
                </div>
                
                <h6 class="text-secondary fw-bold"><i class="fas fa-history me-1"></i>이전 단계 산출물 참조 (Cross Check)</h6>
                <div class="card card-body bg-white p-2 mb-3 border-0" style="max-height:150px; overflow-y:auto;">
                    <ul id="prevDocsList" class="list-group list-group-flush small"></ul>
                </div>
                
                <label class="form-label fw-bold">승인 코멘트 / 반려 사유</label>
                <textarea id="approveComment" class="form-control" rows="3" placeholder="내용을 입력하세요"></textarea>
                <input type="hidden" id="curDocId">
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger" onclick="processDoc('reject')">반려</button>
                <button class="btn btn-success" onclick="processDoc('approve')">승인 확정</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="templateModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white"><h5><i class="fas fa-file-upload me-2"></i>양식 등록</h5><button class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <form id="tplForm">
                    <label class="form-label small text-muted">단계 및 유형</label>
                    <div class="row g-2 mb-2">
                        <div class="col"><select name="stage" class="form-select form-select-sm"><option value="INITIATION">착수</option><option value="CONSTRUCTION">구축</option><option value="COMPLETION">완료</option></select></div>
                        <div class="col"><input name="documentType" class="form-control form-control-sm" placeholder="코드(WBS)"></div>
                    </div>
                    <label class="form-label small text-muted">문서명 및 파일</label>
                    <input name="documentName" class="form-control mb-2" placeholder="문서명 (예: 착수보고서)">
                    <input type="file" name="file" class="form-control mb-2">
                </form>
            </div>
            <div class="modal-footer"><button class="btn btn-primary w-100" onclick="uploadTemplate()">등록하기</button></div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
let curPid = null;

// 프로젝트 데이터 로드
function loadProjectData(pid) {
    if(!pid) { $('#workflowView').hide(); $('#emptyMsg').show(); return; }
    curPid = pid;
    $('#emptyMsg').hide(); $('#workflowView').css('display','flex');
    
    $.get('/work/project/'+pid, function(res){
        const p = res.project;
        $('#currentStageBadge').text(p.currentStage + " 단계 진행중").show();
        
        // 각 단계별 렌더링
        ['INITIATION','CONSTRUCTION','COMPLETION'].forEach(st => renderCol(st, res.documents, p.currentStage));
    }).fail(function() { alert("데이터 로드 실패"); });
}

// 컬럼 렌더링 로직
function renderCol(stage, docs, currentProjectStage) {
    const list = docs.filter(d => d.stage === stage);
    let html = '';
    let allApproved = true; 
    
    if(list.length === 0) allApproved = false;

    list.forEach(d => {
        if(d.documentStatus !== 'APPROVED') allApproved = false;

        let btn = '';
        if(d.documentStatus === 'PENDING') {
            btn = `<button class="btn btn-sm btn-success w-100 mt-2 shadow-sm" onclick="openApprove(\${d.documentId}, '\${d.documentName}', \${d.projectId}, '\${stage}')"><i class="fas fa-pen-nib me-1"></i>결재하기</button>`;
        }
        
        let fileInfo = d.filePath ? '<i class="fas fa-paperclip text-primary"></i>' : '';
        let uName = d.userName ? `<span class="text-muted small ms-1">- \${d.userName}</span>` : '';

        html += `
            <div class="doc-item">
                <i class="fas fa-trash-alt btn-del" onclick="delDoc(\${d.documentId})" title="목록에서 삭제"></i>
                <div class="mb-1">
                    \${fileInfo} <strong>\${d.documentName}</strong>
                    \${uName}
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="doc-badge st-\${d.documentStatus}">\${d.documentStatus}</span>
                    <small class="text-muted">\${d.formattedUploadDate ? d.formattedUploadDate.substring(0,10) : ''}</small>
                </div>
                \${btn}
            </div>`;
    });
    
    $('#col-'+stage).html(html);

    // [다음 단계 승인] 버튼 표시 로직
    if(allApproved && stage === currentProjectStage) {
        $('#btn-next-' + stage).show();
    } else {
        $('#btn-next-' + stage).hide();
    }
}

// 문서 추가
function addDoc(stage){
    const tid = $('#addSelect-'+stage).val();
    if(!tid) { alert("추가할 양식을 선택해주세요."); return; }
    $.post('/work/document/add', {projectId:curPid, templateId:tid}, function(res){ 
        alert(res.message); 
        loadProjectData(curPid); 
    });
}

// 문서 삭제
function delDoc(did){
    if(confirm('이 문서를 목록에서 제거하시겠습니까?\n(이미 업로드된 파일도 함께 삭제됩니다.)')) 
        $.post('/work/document/remove', {documentId:did}, function(res){ 
            alert(res.message); 
            loadProjectData(curPid); 
        });
}

// 프로젝트 삭제
function deleteProject() {
    const pid = $('#projectSelect').val();
    if (!pid) { alert('삭제할 프로젝트를 선택해주세요.'); return; }
    if (!confirm('경고: 정말로 이 프로젝트를 삭제하시겠습니까?\n\n- 포함된 모든 문서\n- 모든 승인 이력\n\n위 데이터가 영구적으로 삭제됩니다.')) return;
    
    $.post('/work/project/delete', { projectId: pid }, function(res) {
        alert(res.message);
        location.reload();
    }).fail(function() {
        alert('삭제 중 오류가 발생했습니다.');
    });
}

// 승인 팝업
function openApprove(did, name, pid, stage) {
    $('#curDocId').val(did); 
    $('#modalDocName').text(name);
    $('#modalDownBtn').attr('href', '/work/document/download/'+did);
    $('#approveModal').modal('show');
    
    // 이전 단계 문서 조회
    $.get('/work/api/previous-docs', {projectId:pid, currentStage:stage}, function(res){
        let h = '';
        if(res.documents && res.documents.length > 0) 
            res.documents.forEach(d => h += `<li class="list-group-item py-2 d-flex justify-content-between align-items-center"><span>\${d.documentName}</span> <a href="/work/document/download/\${d.documentId}" class="btn btn-xs btn-outline-secondary">보기</a></li>`);
        else h = '<li class="list-group-item text-muted text-center">조회된 이전 단계 문서가 없습니다.</li>';
        $('#prevDocsList').html(h);
    });
}

// 승인/반려 처리
function processDoc(type) {
    const url = type==='approve'?'/work/document/approve':'/work/document/reject';
    const data = { documentId:$('#curDocId').val() };
    
    if(type==='approve') data.comments=$('#approveComment').val();
    else {
        if(!$('#approveComment').val()) { alert("반려 사유를 입력하세요."); return; }
        data.reason=$('#approveComment').val();
    }
    
    $.post(url, data, function(res){ 
        alert(res.message); 
        $('#approveModal').modal('hide'); 
        loadProjectData(curPid); 
    });
}

// 단계 승인
function approveStage(stage) {
    if(!confirm('해당 단계의 모든 문서가 승인되었습니다.\n다음 단계로 진행하시겠습니까?')) return;
    $.post('/work/stage/approve', {projectId:curPid, stage:stage, comments:'관리자 승인 처리'}, function(res) {
        alert(res.message);
        loadProjectData(curPid);
    });
}

// 템플릿 업로드
function uploadTemplate(){
    var fd = new FormData($('#tplForm')[0]);
    if(!$('input[name=file]').val()) { alert("파일을 선택해주세요."); return; }
    $.ajax({url:'/work/template/upload', type:'POST', data:fd, processData:false, contentType:false, success:function(res){alert(res.message); location.reload();}});
}
</script>