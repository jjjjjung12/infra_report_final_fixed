<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body { background-color: #f4f6f9; font-family: 'Malgun Gothic', sans-serif; }
    .navbar-custom { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); padding: 15px 20px; }
    
    /* 3단 레이아웃 */
    .phase-container { display: flex; gap: 20px; padding: 20px 0; min-height: 600px; }
    .phase-col { flex: 1; min-width: 300px; }
    
    /* 카드 스타일 */
    .phase-card { 
        background: #fff; border: 1px solid #ddd; border-radius: 8px; height: 100%; 
        display: flex; flex-direction: column; position: relative; overflow: hidden; /* 오버레이를 위해 relative */
    }
    
    .phase-header { padding: 15px; text-align: center; font-weight: bold; color: #fff; border-radius: 8px 8px 0 0; }
    .ph-init { background-color: #28a745; } 
    .ph-const { background-color: #007bff; } 
    .ph-comp { background-color: #6c757d; }
    
    .phase-body { padding: 15px; background: #f8f9fa; flex: 1; overflow-y: auto; }
    
    .doc-item { background: white; padding: 10px; margin-bottom: 8px; border: 1px solid #eee; border-radius: 5px; position: relative; }
    .btn-del { position: absolute; top: 10px; right: 10px; color: #ccc; cursor: pointer; transition: 0.2s;}
    .btn-del:hover { color: #dc3545; transform: scale(1.1); }
    
    /* 잠금 오버레이 스타일 (NEW) */
    .locked-overlay {
        position: absolute; top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(240, 242, 245, 0.85); /* 반투명 배경 */
        z-index: 10;
        display: flex; flex-direction: column;
        align-items: center; justify-content: center;
        backdrop-filter: blur(2px); /* 블러 효과 */
        color: #6c757d;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#"><i class="fas fa-briefcase me-2"></i>작업 관리 시스템 (작업자)</a>
        <div class="d-flex align-items-center">
            <span class="text-white me-3 fw-bold"><sec:authentication property="principal.userName"/>님</span>
            <form action="/logout" method="post" class="d-inline">
                <button type="submit" class="btn btn-sm btn-outline-light"><i class="fas fa-sign-out-alt me-1"></i> 로그아웃</button>
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid p-4">
    <div class="card mb-4 border-info shadow-sm">
        <div class="card-header bg-info text-white fw-bold"><i class="fas fa-file-download me-2"></i>표준 양식 자료실</div>
        <div class="card-body">
            <div class="d-flex flex-wrap gap-2">
                <c:forEach var="t" items="${templates}">
                    <a href="/work/template/download/${t.templateId}" class="btn btn-outline-dark btn-sm">
                        <i class="fas fa-file-word text-primary me-1"></i> ${t.documentName}
                    </a>
                </c:forEach>
                <c:if test="${empty templates}"><span class="text-muted">등록된 양식이 없습니다.</span></c:if>
            </div>
        </div>
    </div>

    <div class="d-flex gap-3 mb-3 align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-3">
            <h4 class="mb-0 fw-bold text-secondary">내 프로젝트</h4>
            <select id="prjSelect" class="form-select w-auto border-success fw-bold" onchange="loadPrj(this.value)">
                <option value="">▶ 작업할 프로젝트 선택</option>
                <c:forEach var="p" items="${projects}">
                    <option value="${p.projectId}">${p.projectName} (${p.projectStatus})</option>
                </c:forEach>
            </select>
            <button class="btn btn-outline-danger btn-sm" onclick="deletePrj()">
                <i class="fas fa-trash-alt me-1"></i>삭제
            </button>
        </div>
        <button class="btn btn-success shadow-sm" onclick="$('#newPrjModal').modal('show')">
            <i class="fas fa-plus me-1"></i> 새 프로젝트 생성
        </button>
    </div>

    <div class="phase-container" id="wfView" style="display:none;">
        <c:forEach var="stage" items="${['INITIATION', 'CONSTRUCTION', 'COMPLETION']}">
            <div class="phase-col">
                <div class="phase-card" id="card-${stage}">
                    
                    <div class="phase-header ${stage=='INITIATION'?'ph-init':stage=='CONSTRUCTION'?'ph-const':'ph-comp'}">
                        ${stage=='INITIATION'?'1. 착수':stage=='CONSTRUCTION'?'2. 구축':'3. 완료'} 단계
                    </div>
                    
                    <div class="phase-body" id="u-${stage}"></div>
                    
                    <div class="p-3 border-top bg-white" id="addArea-${stage}">
                        <div class="input-group input-group-sm">
                            <select id="userAdd-${stage}" class="form-select">
                                <option value="">+ 추가할 양식</option>
                                <c:forEach var="t" items="${templates}">
                                    <c:if test="${t.stage == stage}">
                                        <option value="${t.templateId}">${t.documentName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <button class="btn btn-outline-secondary" onclick="addDoc('${stage}')">추가</button>
                        </div>
                    </div>

                    <div id="lock-${stage}" class="locked-overlay" style="display:none;">
                        <i class="fas fa-lock fa-3x mb-3"></i>
                        <h5 class="fw-bold">대기중</h5>
                        <small>이전 단계 승인 후 진행 가능</small>
                    </div>

                </div>
            </div>
        </c:forEach>
    </div>
    
    <div id="emptyMsg" class="text-center py-5 text-muted opacity-50">
        <i class="fas fa-folder-open fa-4x mb-3"></i>
        <h3>작업할 프로젝트를 선택해주세요.</h3>
    </div>
</div>

<div class="modal fade" id="newPrjModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white"><h5>새 프로젝트</h5><button class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <input id="npName" class="form-control mb-2" placeholder="프로젝트명">
                <input id="npContent" class="form-control mb-2" placeholder="내용">
                <div class="row"><div class="col"><input type="date" id="npStart" class="form-control"></div><div class="col"><input type="date" id="npEnd" class="form-control"></div></div>
            </div>
            <div class="modal-footer"><button class="btn btn-primary w-100" onclick="createPrj()">생성하기</button></div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
let curPid = null;
const STAGE_ORDER = ['INITIATION', 'CONSTRUCTION', 'COMPLETION'];

function loadPrj(pid) {
    if(!pid) { $('#wfView').hide(); $('#emptyMsg').show(); return; } 
    curPid = pid;
    $('#emptyMsg').hide(); $('#wfView').css('display','flex');
    
    $.get('/work/project/'+pid, function(res){
        
        // 현재 진행중인 단계 인덱스 찾기
        const currentStageIdx = STAGE_ORDER.indexOf(res.project.currentStage);

        STAGE_ORDER.forEach((st, idx) => {
            // [잠금 로직] 현재 단계보다 뒤에 있는 단계는 잠금
            if(idx > currentStageIdx) {
                $('#lock-'+st).show();      // 오버레이 표시
                $('#addArea-'+st).hide();   // 추가 버튼 숨김
            } else {
                $('#lock-'+st).hide();      // 오버레이 숨김
                $('#addArea-'+st).show();   // 추가 버튼 표시
            }

            // 문서 렌더링
            let h = '';
            const list = res.documents.filter(d => d.stage === st);
            
            list.forEach(d => {
                let actionArea = '';
                let delBtn = '';

                // 삭제 가능 여부: 미제출 상태일 때만
                if(d.documentStatus === 'NOT_UPLOADED') {
                    delBtn = `<i class="fas fa-times btn-del" onclick="delDoc(\${d.documentId})" title="목록에서 삭제"></i>`;
                }

                // 버튼 분기: 미제출/반려 -> 업로드, 제출됨 -> 다운로드
                if(d.documentStatus==='NOT_UPLOADED'||d.documentStatus==='REJECTED') {
                     actionArea = `
                        <input type="file" id="f_\${d.documentId}" style="display:none" onchange="up(\${d.documentId})">
                        <button class="btn btn-sm btn-primary w-100 mt-2" onclick="$('#f_\${d.documentId}').click()">
                            <i class="fas fa-upload me-1"></i>파일 업로드
                        </button>`;
                } else {
                     actionArea = `
                        <a href="/work/document/download/\${d.documentId}" class="btn btn-sm btn-outline-secondary w-100 mt-2">
                            <i class="fas fa-download me-1"></i>내 파일 확인
                        </a>`;
                }
                
                let rejectMsg = (d.documentStatus==='REJECTED' && d.rejectReason) ? 
                    `<div class="alert alert-danger p-2 mt-2 mb-0 small">\${d.rejectReason}</div>` : '';

                h += `<div class="doc-item">
                        \${delBtn}
                        <strong>\${d.documentName}</strong> 
                        <span class="badge bg-light text-dark border float-end">\${d.documentStatus}</span>
                        \${rejectMsg}
                        \${actionArea}
                      </div>`;
            });
            $('#u-'+st).html(h);
        });
    });
}

function addDoc(st){
    const tid = $('#userAdd-'+st).val();
    if(!tid) return;
    $.post('/work/document/add', {projectId:curPid, templateId:tid}, function(res){ alert(res.message); loadPrj(curPid); });
}

function delDoc(did){
    if(confirm('삭제하시겠습니까?')) $.post('/work/document/remove', {documentId:did}, function(res){ alert(res.message); loadPrj(curPid); });
}

function deletePrj() {
    const pid = $('#prjSelect').val();
    if (!pid) { alert('삭제할 프로젝트를 선택해주세요.'); return; }
    if (!confirm('정말 삭제하시겠습니까? 복구할 수 없습니다.')) return;
    $.post('/work/project/delete', { projectId: pid }, function(res) {
        alert(res.message);
        location.reload();
    });
}

function up(did) {
    var fd = new FormData(); fd.append('documentId', did); fd.append('file', document.getElementById('f_'+did).files[0]);
    $.ajax({url:'/work/document/upload', type:'POST', data:fd, processData:false, contentType:false, success:function(res){alert(res.message); loadPrj(curPid);}});
}

function createPrj() {
    var d = {projectName:$('#npName').val(), workContent:$('#npContent').val(), startDate:$('#npStart').val(), endDate:$('#npEnd').val()};
    if(!d.projectName) { alert("프로젝트명을 입력하세요."); return; }
    $.ajax({url:'/work/project/create', type:'POST', contentType:'application/json', data:JSON.stringify(d), success:function(res){alert(res.message); location.reload();}});
}
</script>