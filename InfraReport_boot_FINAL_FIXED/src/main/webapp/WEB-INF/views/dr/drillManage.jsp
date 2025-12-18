<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DR 훈련 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <style>
        :root { --primary-color: #f7931e; --card-bg: #16213e; --dark-bg: #1a1a2e; }
        body { background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); min-height: 100vh; color: #fff; }
        
        /* 헤더 */
        .page-header { background: var(--primary-color); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .page-title { font-size: 1.5rem; font-weight: bold; color: #fff; margin: 0; }
        
        /* 탭 스타일 */
        .nav-tabs { border-bottom: 2px solid var(--primary-color); margin-bottom: 20px; }
        .nav-tabs .nav-link { color: #aaa; border: none; padding: 12px 25px; font-weight: 500; }
        .nav-tabs .nav-link.active { color: var(--primary-color); background: transparent; border-bottom: 3px solid var(--primary-color); }
        .nav-tabs .nav-link:hover { color: var(--primary-color); border-color: transparent; }
        
        /* 카드 및 테이블 */
        .content-card { background: var(--card-bg); border-radius: 10px; padding: 20px; margin-bottom: 20px; }
        .card-header-custom { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .card-header-custom h5 { margin: 0; color: var(--primary-color); }
        
        .table-dark-custom { background: transparent; color: #fff; }
        .table-dark-custom thead th { background: rgba(247, 147, 30, 0.2); border-color: rgba(255,255,255,0.1); color: var(--primary-color); font-weight: 600; text-align: center; }
        .table-dark-custom tbody td { border-color: rgba(255,255,255,0.1); vertical-align: middle; text-align: center; }
        .table-dark-custom tbody tr:hover { background: rgba(255,255,255,0.05); }
        
        /* 버튼 및 뱃지 */
        .btn-primary-custom { background: var(--primary-color); border: none; color: #fff; }
        .btn-primary-custom:hover { background: #e8850f; color: #fff; }
        .btn-primary-custom:disabled { background: #666; opacity: 0.6; cursor: not-allowed; }
        .btn-action { padding: 5px 10px; font-size: 0.85rem; margin: 0 2px; }
        
        .status-badge { padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 500; }
        .status-planned, .status-waiting { background: #6c757d; color: #fff; }
        .status-progress { background: #0dcaf0; color: #000; }
        .status-completed, .status-pass { background: #198754; color: #fff; }
        .status-canceled, .status-failed, .status-fail { background: #dc3545; color: #fff; }
        
        /* 모달 및 입력창 스타일 (가독성 개선) */
        .modal-content { background: var(--card-bg); color: #fff; }
        .modal-header { border-bottom: 1px solid rgba(255,255,255,0.1); }
        .modal-footer { border-top: 1px solid rgba(255,255,255,0.1); }
        
        /* [중요] 입력창/셀렉트박스 흰색 배경 + 검은 글씨 강제 적용 */
        .form-control, .form-select { 
            background-color: #ffffff !important; 
            color: #333333 !important; 
            border: 1px solid #ced4da !important; 
        }
        .form-control:focus, .form-select:focus { 
            background-color: #ffffff !important; 
            color: #333333 !important; 
            border-color: var(--primary-color) !important; 
            box-shadow: 0 0 0 0.2rem rgba(247, 147, 30, 0.25) !important; 
        }
        .form-control::placeholder { color: #999; }
        option { color: #333 !important; background: #fff !important; }
        
        .form-label { color: #ccc; font-weight: 500; }
        .empty-state { text-align: center; padding: 40px; color: #888; }
    </style>
</head>
<body>
    <div class="page-header">
        <h1 class="page-title"><i class="fas fa-cog me-2"></i>DR 훈련 관리</h1>
        <div>
            <a href="/dr/dashboard" class="btn btn-outline-light me-2"><i class="fas fa-chart-line me-1"></i>DR 현황판</a>
            <a href="/dr/drill" class="btn btn-outline-light"><i class="fas fa-tasks me-1"></i>상황판</a>
        </div>
    </div>
    
    <div class="container-fluid p-4">
        <ul class="nav nav-tabs" id="manageTabs">
            <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#drillPanel"><i class="fas fa-clipboard-list me-1"></i>훈련 관리</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#centerPanel"><i class="fas fa-building me-1"></i>센터 관리</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#systemPanel"><i class="fas fa-server me-1"></i>시스템복구 항목</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#checkPanel"><i class="fas fa-check-square me-1"></i>업무점검 항목</a></li>
        </ul>
        
        <div class="tab-content">
            <div class="tab-pane fade show active" id="drillPanel">
                <div class="content-card">
                    <div class="card-header-custom">
                        <h5><i class="fas fa-list me-2"></i>훈련 목록</h5>
                        <button class="btn btn-primary-custom" onclick="openDrillModal()"><i class="fas fa-plus me-1"></i>훈련 추가</button>
                    </div>
                    <table class="table table-dark-custom">
                        <thead><tr><th>No</th><th>훈련명</th><th>훈련유형</th><th>훈련일자</th><th>RTO</th><th>상태</th><th>등록일</th><th>작업</th></tr></thead>
                        <tbody id="drillTableBody"></tbody>
                    </table>
                    <div id="drillEmptyState" class="empty-state" style="display:none;"><i class="fas fa-inbox fa-3x mb-3"></i><p>등록된 훈련이 없습니다.</p></div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="centerPanel">
                <div class="content-card">
                    <div class="card-header-custom">
                        <h5><i class="fas fa-building me-2"></i>센터 목록</h5>
                        <button class="btn btn-primary-custom" onclick="openCenterModal()"><i class="fas fa-plus me-1"></i>센터 추가</button>
                    </div>
                    <table class="table table-dark-custom">
                        <thead><tr><th>No</th><th>센터명</th><th>센터코드</th><th>센터유형</th><th>주소</th><th>작업</th></tr></thead>
                        <tbody id="centerTableBody"></tbody>
                    </table>
                    <div id="centerEmptyState" class="empty-state" style="display:none;"><i class="fas fa-building fa-3x mb-3"></i><p>등록된 센터가 없습니다.</p></div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="systemPanel">
                <div class="content-card">
                    <div class="card-header-custom">
                        <h5><i class="fas fa-server me-2"></i>시스템복구 항목</h5>
                        <div>
                            <select class="form-select d-inline-block me-2" id="systemDrillSelect" style="width:250px;"><option value="">훈련 선택</option></select>
                            <button class="btn btn-primary-custom" id="btnAddSystem" onclick="openSystemModal()" disabled><i class="fas fa-plus me-1"></i>항목 추가</button>
                        </div>
                    </div>
                    <table class="table table-dark-custom">
                        <thead><tr><th>순서</th><th>시스템명</th><th>시스템그룹</th><th>담당자</th><th>상태</th><th>작업</th></tr></thead>
                        <tbody id="systemTableBody"></tbody>
                    </table>
                    <div id="systemEmptyState" class="empty-state"><i class="fas fa-server fa-3x mb-3"></i><p>훈련을 선택해주세요.</p></div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="checkPanel">
                <div class="content-card">
                    <div class="card-header-custom">
                        <h5><i class="fas fa-check-square me-2"></i>업무점검 항목</h5>
                        <div>
                            <select class="form-select d-inline-block me-2" id="checkDrillSelect" style="width:250px;"><option value="">훈련 선택</option></select>
                            <button class="btn btn-primary-custom" id="btnAddCheck" onclick="openCheckModal()" disabled><i class="fas fa-plus me-1"></i>항목 추가</button>
                        </div>
                    </div>
                    <table class="table table-dark-custom">
                        <thead><tr><th>순서</th><th>점검항목</th><th>점검그룹</th><th>유형</th><th>담당자</th><th>상태</th><th>작업</th></tr></thead>
                        <tbody id="checkTableBody"></tbody>
                    </table>
                    <div id="checkEmptyState" class="empty-state"><i class="fas fa-check-square fa-3x mb-3"></i><p>훈련을 선택해주세요.</p></div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="drillModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title" id="drillModalTitle">훈련 추가</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <input type="hidden" id="drillId">
                    <div class="row g-3">
                        <div class="col-md-8"><label class="form-label">훈련명 *</label><input type="text" class="form-control" id="drillName"></div>
                        <div class="col-md-4"><label class="form-label">훈련유형</label><select class="form-select" id="drillType"><option value="DR">재해복구훈련</option><option value="MOCK">모의훈련</option></select></div>
                        <div class="col-md-4"><label class="form-label">훈련일자 *</label><input type="date" class="form-control" id="drillDate"></div>
                        <div class="col-md-4"><label class="form-label">시작시간</label><input type="time" class="form-control" id="drillStartTime"></div>
                        <div class="col-md-4"><label class="form-label">종료시간</label><input type="time" class="form-control" id="drillEndTime"></div>
                        <div class="col-md-6"><label class="form-label">목표 RTO (시간)</label><input type="number" class="form-control" id="rtoHours" value="4" min="0"></div>
                        <div class="col-md-6"><label class="form-label">목표 RTO (분)</label><input type="number" class="form-control" id="rtoMinutes" value="0" min="0" max="59"></div>
                    </div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary-custom" onclick="saveDrill()">저장</button></div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="centerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title" id="centerModalTitle">센터 추가</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <input type="hidden" id="centerId">
                    <div class="row g-3">
                        <div class="col-md-8"><label class="form-label">센터명 *</label><input type="text" class="form-control" id="centerName"></div>
                        <div class="col-md-4"><label class="form-label">센터코드</label><input type="text" class="form-control" id="centerCode"></div>
                        <div class="col-md-6"><label class="form-label">위도</label><input type="number" class="form-control" id="latitude" step="0.000001"></div>
                        <div class="col-md-6"><label class="form-label">경도</label><input type="number" class="form-control" id="longitude" step="0.000001"></div>
                        <div class="col-md-6"><label class="form-label">센터유형</label><select class="form-select" id="centerType"><option value="MAIN">주센터</option><option value="DR">DR센터</option><option value="BACKUP">백업센터</option></select></div>
                        <div class="col-12"><label class="form-label">주소</label><input type="text" class="form-control" id="centerAddr"></div>
                    </div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary-custom" onclick="saveCenter()">저장</button></div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="systemModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">시스템복구 항목</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <input type="hidden" id="systemId">
                    <div class="row g-3">
                        <div class="col-12"><label class="form-label">시스템명 *</label><input type="text" class="form-control" id="systemName"></div>
                        <div class="col-md-6"><label class="form-label">시스템그룹</label><input type="text" class="form-control" id="systemGroup"></div>
                        <div class="col-md-6"><label class="form-label">복구순서</label><input type="number" class="form-control" id="recoveryOrder" value="1" min="1"></div>
                        <div class="col-md-6"><label class="form-label">담당자</label><input type="text" class="form-control" id="systemAssignUser"></div>
                    </div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary-custom" onclick="saveSystem()">저장</button></div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="checkModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">업무점검 항목</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <input type="hidden" id="checkId">
                    <div class="row g-3">
                        <div class="col-12"><label class="form-label">점검항목 *</label><input type="text" class="form-control" id="checkName"></div>
                        <div class="col-md-6"><label class="form-label">점검그룹</label><input type="text" class="form-control" id="checkGroup"></div>
                        <div class="col-md-6"><label class="form-label">점검유형</label><select class="form-select" id="checkType"><option value="CHECK">점검</option><option value="CONFIRM">확인</option></select></div>
                        <div class="col-md-6"><label class="form-label">순서</label><input type="number" class="form-control" id="checkOrder" value="1" min="1"></div>
                        <div class="col-md-6"><label class="form-label">담당자</label><input type="text" class="form-control" id="checkAssignUser"></div>
                    </div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary-custom" onclick="saveCheck()">저장</button></div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function() {
            loadDrills();
            loadCenters();
            $('#systemDrillSelect, #checkDrillSelect').on('change', function() {
                var drillId = $(this).val();
                var target = $(this).attr('id') === 'systemDrillSelect' ? 'system' : 'check';
                $('#btnAdd' + (target === 'system' ? 'System' : 'Check')).prop('disabled', !drillId);
                if (drillId) { target === 'system' ? loadSystems(drillId) : loadChecks(drillId); }
                else { $('#' + target + 'TableBody').empty(); $('#' + target + 'EmptyState').show(); }
            });
        });
        
        function loadDrills() {
            $.get('/dr/api/drills', function(res) {
                if (res.success && res.data) {
                    var tbody = $('#drillTableBody').empty();
                    $('#drillEmptyState').toggle(res.data.length === 0);
                    res.data.forEach(function(d, i) {
                        tbody.append('<tr><td>'+(i+1)+'</td><td>'+d.drillName+'</td><td>'+getTypeText(d.drillType)+'</td><td>'+(d.drillDate||'').substring(0,10)+'</td><td>'+(d.rtoHours||0)+'시간 '+(d.rtoMinutes||0)+'분</td><td><span class="status-badge status-'+(d.status||'planned').toLowerCase()+'">'+getStatusText(d.status)+'</span></td><td>'+(d.createDate||'').substring(0,10)+'</td><td><button class="btn btn-sm btn-outline-info btn-action" onclick="editDrill('+d.drillId+')"><i class="fas fa-edit"></i></button><button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteDrill('+d.drillId+')"><i class="fas fa-trash"></i></button></td></tr>');
                    });
                    
                    var opts = '<option value="">훈련 선택</option>';
                    if (res.data.length > 0) { res.data.forEach(function(d) { opts += '<option value="'+d.drillId+'">'+d.drillName+'</option>'; }); }
                    $('#systemDrillSelect, #checkDrillSelect').html(opts);
                }
            });
        }
        
        function openDrillModal() {
            $('#drillId').val(''); $('#drillName').val(''); $('#drillType').val('DR');
            $('#drillDate').val(new Date().toISOString().split('T')[0]);
            $('#drillStartTime, #drillEndTime').val(''); $('#rtoHours').val(4); $('#rtoMinutes').val(0);
            $('#drillModalTitle').text('훈련 추가');
            new bootstrap.Modal('#drillModal').show();
        }
        
        function editDrill(id) {
            $.get('/dr/api/drills/'+id, function(res) {
                if (res.success && res.data) {
                    var d = res.data;
                    $('#drillId').val(d.drillId); $('#drillName').val(d.drillName); $('#drillType').val(d.drillType||'DR');
                    $('#drillDate').val((d.drillDate||'').substring(0,10));
                    $('#drillStartTime').val(d.startTime ? d.startTime.substring(11,16) : '');
                    $('#drillEndTime').val(d.endTime ? d.endTime.substring(11,16) : '');
                    $('#rtoHours').val(d.rtoHours||4); $('#rtoMinutes').val(d.rtoMinutes||0);
                    $('#drillModalTitle').text('훈련 수정');
                    new bootstrap.Modal('#drillModal').show();
                }
            });
        }
        
        function saveDrill() {
            var id = $('#drillId').val(), date = $('#drillDate').val(), st = $('#drillStartTime').val(), et = $('#drillEndTime').val();
            var data = { drillName: $('#drillName').val(), drillType: $('#drillType').val(), drillDate: date,
                startTime: st ? date+'T'+st+':00' : null, endTime: et ? date+'T'+et+':00' : null,
                rtoHours: parseInt($('#rtoHours').val())||0, rtoMinutes: parseInt($('#rtoMinutes').val())||0 };
            if (!data.drillName || !data.drillDate) { Swal.fire('알림','훈련명과 훈련일자를 입력해주세요.','warning'); return; }
            $.ajax({ url: id ? '/dr/api/drills/'+id : '/dr/api/drills', type: id ? 'PUT' : 'POST', contentType: 'application/json', data: JSON.stringify(data),
                success: function(res) { if(res.success) { bootstrap.Modal.getInstance(document.getElementById('drillModal')).hide(); Swal.fire('완료','저장되었습니다.','success'); loadDrills(); } else { Swal.fire('오류',res.message||'저장 실패','error'); } },
                error: function(xhr) { console.error(xhr.responseText); Swal.fire('오류','서버 오류가 발생했습니다.','error'); }
            });
        }
        
        function deleteDrill(id) {
            Swal.fire({ title:'훈련 삭제', text:'삭제하시겠습니까?', icon:'warning', showCancelButton:true, confirmButtonColor:'#dc3545', confirmButtonText:'삭제', cancelButtonText:'취소' }).then(function(r) {
                if(r.isConfirmed) { $.ajax({ url:'/dr/api/drills/'+id, type:'DELETE', success:function(res){ if(res.success){ Swal.fire('완료','삭제되었습니다.','success'); loadDrills(); } } }); }
            });
        }
        
        function loadCenters() {
            $.get('/dr/api/centers', function(res) {
                if (res.success && res.data) {
                    var tbody = $('#centerTableBody').empty();
                    $('#centerEmptyState').toggle(res.data.length === 0);
                    res.data.forEach(function(c, i) {
                        tbody.append('<tr><td>'+(i+1)+'</td><td>'+c.centerName+'</td><td>'+(c.centerCode||'-')+'</td><td>'+getCenterTypeText(c.centerType)+'</td><td>'+(c.addr||'-')+'</td><td><button class="btn btn-sm btn-outline-info btn-action" onclick="editCenter('+c.centerId+')"><i class="fas fa-edit"></i></button><button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteCenter('+c.centerId+')"><i class="fas fa-trash"></i></button></td></tr>');
                    });
                }
            });
        }
        
        function openCenterModal() {
            $('#centerId, #centerName, #centerCode, #latitude, #longitude, #centerAddr').val('');
            $('#centerType').val('MAIN'); $('#centerModalTitle').text('센터 추가');
            new bootstrap.Modal('#centerModal').show();
        }
        
        function editCenter(id) {
            $.get('/dr/api/centers/'+id, function(res) {
                if (res.success && res.data) {
                    var c = res.data;
                    $('#centerId').val(c.centerId); $('#centerName').val(c.centerName); $('#centerCode').val(c.centerCode);
                    $('#latitude').val(c.latitude); $('#longitude').val(c.longitude); $('#centerType').val(c.centerType||'MAIN'); $('#centerAddr').val(c.addr);
                    $('#centerModalTitle').text('센터 수정');
                    new bootstrap.Modal('#centerModal').show();
                }
            });
        }
        
        function saveCenter() {
            var id = $('#centerId').val();
            var data = { centerName: $('#centerName').val(), centerCode: $('#centerCode').val(), latitude: parseFloat($('#latitude').val())||null, longitude: parseFloat($('#longitude').val())||null, centerType: $('#centerType').val(), addr: $('#centerAddr').val() };
            if (!data.centerName) { Swal.fire('알림','센터명을 입력해주세요.','warning'); return; }
            $.ajax({ url: id ? '/dr/api/centers/'+id : '/dr/api/centers', type: id ? 'PUT' : 'POST', contentType: 'application/json', data: JSON.stringify(data),
                success: function(res) { if(res.success) { bootstrap.Modal.getInstance(document.getElementById('centerModal')).hide(); Swal.fire('완료','저장되었습니다.','success'); loadCenters(); } else { Swal.fire('오류',res.message||'저장 실패','error'); } },
                error: function() { Swal.fire('오류','서버 오류','error'); }
            });
        }
        
        function deleteCenter(id) {
            Swal.fire({ title:'센터 삭제', text:'삭제하시겠습니까?', icon:'warning', showCancelButton:true, confirmButtonColor:'#dc3545', confirmButtonText:'삭제', cancelButtonText:'취소' }).then(function(r) {
                if(r.isConfirmed) { $.ajax({ url:'/dr/api/centers/'+id, type:'DELETE', success:function(res){ if(res.success){ Swal.fire('완료','삭제되었습니다.','success'); loadCenters(); } } }); }
            });
        }
        
        // [수정] 시스템 복구 항목 목록 (상태 변경 버튼 추가)
        function loadSystems(drillId) {
            $.get('/dr/api/drills/'+drillId+'/recovery-systems', function(res) {
                var tbody = $('#systemTableBody').empty();
                $('#systemEmptyState').toggle(!res.data || res.data.length === 0);
                if (res.success && res.data) {
                    res.data.forEach(function(s) {
                        var actionBtns = '';
                        if(s.status === 'WAITING') {
                            actionBtns += '<button class="btn btn-sm btn-outline-info btn-action" onclick="updateSystemStatus('+s.systemId+', \'start\')"><i class="fas fa-play"></i> 시작</button>';
                        } else if(s.status === 'PROGRESS') {
                            actionBtns += '<button class="btn btn-sm btn-outline-success btn-action" onclick="updateSystemStatus('+s.systemId+', \'complete\')"><i class="fas fa-check"></i> 완료</button>';
                        } else {
                            actionBtns += '<span class="text-success"><i class="fas fa-check-circle"></i> 완료됨</span>';
                        }
                        actionBtns += ' <button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteSystem('+s.systemId+')"><i class="fas fa-trash"></i></button>';

                        tbody.append('<tr>'+
                            '<td>'+(s.recoveryOrder||'-')+'</td>'+
                            '<td>'+s.systemName+'</td>'+
                            '<td>'+(s.systemGroup||'-')+'</td>'+
                            '<td>'+(s.assignUser||'-')+'</td>'+
                            '<td><span class="status-badge status-'+(s.status||'waiting').toLowerCase()+'">'+getSysStatusText(s.status)+'</span></td>'+
                            '<td>'+actionBtns+'</td>'+
                            '</tr>');
                    });
                }
            });
        }

        // [추가] 시스템 상태 변경
        function updateSystemStatus(systemId, action) {
            $.post('/dr/api/recovery-systems/' + systemId + '/' + action, function(res) {
                if (res.success) { loadSystems($('#systemDrillSelect').val()); }
                else { Swal.fire('오류', '상태 변경 실패', 'error'); }
            });
        }
        
        function openSystemModal() { if(!$('#systemDrillSelect').val()){ Swal.fire('알림','훈련을 선택해주세요.','warning'); return; } $('#systemId, #systemName, #systemGroup, #systemAssignUser').val(''); $('#recoveryOrder').val(1); new bootstrap.Modal('#systemModal').show(); }
        
        function saveSystem() {
            var data = { drillId: parseInt($('#systemDrillSelect').val()), systemName: $('#systemName').val(), systemGroup: $('#systemGroup').val(), recoveryOrder: parseInt($('#recoveryOrder').val())||1, assignUser: $('#systemAssignUser').val() };
            if (!data.systemName) { Swal.fire('알림','시스템명을 입력해주세요.','warning'); return; }
            $.ajax({ url:'/dr/api/recovery-systems', type:'POST', contentType:'application/json', data:JSON.stringify(data),
                success: function(res) { if(res.success) { bootstrap.Modal.getInstance(document.getElementById('systemModal')).hide(); Swal.fire('완료','저장되었습니다.','success'); loadSystems($('#systemDrillSelect').val()); } else { Swal.fire('오류',res.message||'저장 실패','error'); } },
                error: function() { Swal.fire('오류','서버 오류','error'); }
            });
        }
        
        function deleteSystem(id) { Swal.fire({ title:'삭제', text:'삭제하시겠습니까?', icon:'warning', showCancelButton:true, confirmButtonColor:'#dc3545', confirmButtonText:'삭제', cancelButtonText:'취소' }).then(function(r) { if(r.isConfirmed) { $.ajax({ url:'/dr/api/recovery-systems/'+id, type:'DELETE', success:function(res){ if(res.success){ Swal.fire('완료','삭제되었습니다.','success'); loadSystems($('#systemDrillSelect').val()); } } }); } }); }
        
        // [수정] 업무 점검 항목 목록 (상태 변경 버튼 추가)
        function loadChecks(drillId) {
            $.get('/dr/api/drills/'+drillId+'/business-checks', function(res) {
                var tbody = $('#checkTableBody').empty();
                $('#checkEmptyState').toggle(!res.data || res.data.length === 0);
                if (res.success && res.data) {
                    res.data.forEach(function(c) {
                        var actionBtns = '';
                        if(c.status === 'PASS' || c.status === 'FAIL') {
                             actionBtns += '<span class="text-'+(c.status==='PASS'?'success':'danger')+' me-2"><i class="fas fa-check-circle"></i> 처리됨</span>';
                        } else {
                            actionBtns += '<button class="btn btn-sm btn-outline-success btn-action" onclick="updateCheckStatus('+c.checkId+', \'PASS\')">정상</button>';
                            actionBtns += '<button class="btn btn-sm btn-outline-danger btn-action" onclick="updateCheckStatus('+c.checkId+', \'FAIL\')">실패</button>';
                        }
                        actionBtns += ' <button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteCheck('+c.checkId+')"><i class="fas fa-trash"></i></button>';

                        tbody.append('<tr>'+
                            '<td>'+(c.checkOrder||'-')+'</td>'+
                            '<td>'+c.checkName+'</td>'+
                            '<td>'+(c.checkGroup||'-')+'</td>'+
                            '<td>'+(c.checkType==='CHECK'?'점검':'확인')+'</td>'+
                            '<td>'+(c.assignUser||'-')+'</td>'+
                            '<td><span class="status-badge status-'+(c.status||'waiting').toLowerCase()+'">'+getChkStatusText(c.status)+'</span></td>'+
                            '<td>'+actionBtns+'</td>'+
                            '</tr>');
                    });
                }
            });
        }

        // [추가] 업무 점검 상태 변경
        function updateCheckStatus(checkId, status) {
            $.post('/dr/api/business-checks/' + checkId + '/status', { status: status }, function(res) {
                if (res.success) { loadChecks($('#checkDrillSelect').val()); }
                else { Swal.fire('오류', '상태 변경 실패', 'error'); }
            });
        }
        
        function openCheckModal() { if(!$('#checkDrillSelect').val()){ Swal.fire('알림','훈련을 선택해주세요.','warning'); return; } $('#checkId, #checkName, #checkGroup, #checkAssignUser').val(''); $('#checkType').val('CHECK'); $('#checkOrder').val(1); new bootstrap.Modal('#checkModal').show(); }
        
        function saveCheck() {
            var data = { drillId: parseInt($('#checkDrillSelect').val()), checkName: $('#checkName').val(), checkGroup: $('#checkGroup').val(), checkType: $('#checkType').val(), checkOrder: parseInt($('#checkOrder').val())||1, assignUser: $('#checkAssignUser').val() };
            if (!data.checkName) { Swal.fire('알림','점검항목을 입력해주세요.','warning'); return; }
            $.ajax({ url:'/dr/api/business-checks', type:'POST', contentType:'application/json', data:JSON.stringify(data),
                success: function(res) { if(res.success) { bootstrap.Modal.getInstance(document.getElementById('checkModal')).hide(); Swal.fire('완료','저장되었습니다.','success'); loadChecks($('#checkDrillSelect').val()); } else { Swal.fire('오류',res.message||'저장 실패','error'); } },
                error: function() { Swal.fire('오류','서버 오류','error'); }
            });
        }
        
        function deleteCheck(id) { Swal.fire({ title:'삭제', text:'삭제하시겠습니까?', icon:'warning', showCancelButton:true, confirmButtonColor:'#dc3545', confirmButtonText:'삭제', cancelButtonText:'취소' }).then(function(r) { if(r.isConfirmed) { $.ajax({ url:'/dr/api/business-checks/'+id, type:'DELETE', success:function(res){ if(res.success){ Swal.fire('완료','삭제되었습니다.','success'); loadChecks($('#checkDrillSelect').val()); } } }); } }); }
        
        function getStatusText(s) { return {PLANNED:'대기',PROGRESS:'진행중',COMPLETED:'완료',CANCELED:'취소'}[s]||'대기'; }
        function getTypeText(t) { return {DR:'재해복구',MOCK:'모의훈련'}[t]||'-'; }
        function getCenterTypeText(t) { return {MAIN:'주센터',DR:'DR센터',BACKUP:'백업센터'}[t]||'-'; }
        function getSysStatusText(s) { return {WAITING:'대기',PROGRESS:'진행중',COMPLETED:'완료',FAILED:'실패'}[s]||'대기'; }
        function getChkStatusText(s) { return {WAITING:'대기',PASS:'정상',FAIL:'비정상',SKIP:'스킵'}[s]||'대기'; }
    </script>
</body>
</html>