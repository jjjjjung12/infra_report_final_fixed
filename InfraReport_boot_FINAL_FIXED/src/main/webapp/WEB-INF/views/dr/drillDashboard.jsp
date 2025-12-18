<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모의훈련 상황판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <style>
        :root { --primary: #f7931e; --dark-bg: #0a0a1a; --card-bg: #1a1a2e; --success: #28a745; --info: #17a2b8; }
        body { background: var(--dark-bg); color: #fff; font-family: 'Segoe UI', sans-serif; min-height: 100vh; }
        
        /* Header */
        .header { background: var(--primary); padding: 12px 25px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 1.4rem; font-weight: bold; margin: 0; }
        
        /* [중요] 헤더 셀렉트 박스 스타일 수정 */
        .header select { 
            background-color: #ffffff !important; 
            color: #333333 !important; 
            border: 1px solid rgba(255,255,255,0.3); 
            padding: 8px 15px; 
            border-radius: 5px; 
            margin-right: 10px; 
        }
        .header select option { color: #333 !important; background: #fff !important; }
        
        /* Layout */
        .main-container { display: grid; grid-template-columns: 350px 1fr; gap: 15px; padding: 15px; height: calc(100vh - 60px); }
        .task-panel { background: var(--card-bg); border-radius: 10px; padding: 15px; display: flex; flex-direction: column; overflow: hidden; }
        .panel-title { color: var(--primary); font-weight: bold; padding-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center; }
        .task-list { flex: 1; overflow-y: auto; }
        .task-item { background: rgba(255,255,255,0.05); border-radius: 8px; padding: 12px 15px; margin-bottom: 10px; cursor: pointer; transition: all 0.3s; border-left: 4px solid #6c757d; display: flex; align-items: flex-start; gap: 10px; }
        .task-item:hover { background: rgba(255,255,255,0.1); }
        .task-item.active { border-left-color: var(--primary); background: rgba(247, 147, 30, 0.15); }
        .task-item.completed { border-left-color: var(--success); }
        .task-item.status-progress { border-left-color: var(--info); }
        .task-item.dragging { opacity: 0.5; background: rgba(247, 147, 30, 0.3); }
        .task-drag-handle { cursor: grab; color: #666; padding: 5px; margin-top: 2px; }
        .task-drag-handle:hover { color: var(--primary); }
        .task-drag-handle:active { cursor: grabbing; }
        .task-content { flex: 1; }
        .task-name { font-weight: 500; margin-bottom: 5px; }
        .task-meta { font-size: 0.8rem; color: #888; display: flex; justify-content: space-between; }
        .task-progress { margin-top: 8px; }
        .progress { height: 6px; background: rgba(255,255,255,0.1); border-radius: 3px; }
        .progress-bar { background: var(--success); border-radius: 3px; }

        .subtask-panel { background: var(--card-bg); border-radius: 10px; padding: 15px; display: flex; flex-direction: column; overflow: hidden; }
        .subtask-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .subtask-title { color: var(--primary); font-weight: bold; }
        .subtask-info { display: flex; gap: 20px; align-items: center; }
        .progress-circle { width: 60px; height: 60px; position: relative; }
        .progress-circle svg { transform: rotate(-90deg); }
        .progress-circle circle { fill: none; stroke-width: 6; }
        .progress-circle .bg { stroke: rgba(255,255,255,0.1); }
        .progress-circle .fg { stroke: var(--success); stroke-linecap: round; transition: stroke-dashoffset 0.5s; }
        .progress-text { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 0.9rem; font-weight: bold; }

        .subtask-table-wrapper { flex: 1; overflow-y: auto; }
        table { width: 100%; border-collapse: collapse; }
        thead { position: sticky; top: 0; background: var(--card-bg); z-index: 10; }
        th { background: rgba(247, 147, 30, 0.2); color: var(--primary); padding: 12px 10px; text-align: center; font-size: 0.85rem; border-bottom: 2px solid var(--primary); }
        td { padding: 10px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); font-size: 0.85rem; vertical-align: middle; }
        tr:hover { background: rgba(255,255,255,0.03); }
        
        .drag-handle { cursor: grab; color: #666; font-size: 0.8rem; }
        .drag-handle:hover { color: var(--primary); }
        .btn-action { padding: 4px 8px; font-size: 0.75rem; margin: 0 2px; }
        .btn-start { background: var(--info); border: none; color: white; }
        .btn-end { background: var(--success); border: none; color: white; }
        .status-badge { padding: 3px 8px; border-radius: 10px; font-size: 0.7rem; }
        .subtask-progress-bar { width: 100%; height: 20px; background: rgba(255,255,255,0.1); border-radius: 10px; overflow: hidden; position: relative; }
        .subtask-progress-fill { height: 100%; background: linear-gradient(90deg, var(--info), var(--success)); border-radius: 10px; transition: width 0.3s; }
        .subtask-progress-text { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 0.75rem; font-weight: bold; text-shadow: 1px 1px 2px black; }
        .empty-state { text-align: center; padding: 50px; color: #666; }
        
        /* Modal & Form - 강제 흰색 배경 */
        .modal-content { background: var(--card-bg); color: #fff; }
        .modal-header, .modal-footer { border-color: rgba(255,255,255,0.1); }
        .form-control, .form-select { 
            background-color: #ffffff !important; 
            color: #333333 !important; 
            border: 1px solid #ced4da !important; 
        }
        .form-control:focus, .form-select:focus { 
            background-color: #ffffff !important; 
            color: #333333 !important; 
            border-color: var(--primary) !important; 
            box-shadow: 0 0 0 0.25rem rgba(247, 147, 30, 0.25) !important; 
        }
        .form-label { color: #aaa; font-size: 0.9rem; }
        .btn-primary-custom { background: var(--primary); border: none; color: #fff; }
        .btn-primary-custom:hover { background: #e8850f; color: #fff; }
        .btn-primary-custom:disabled { background: #666; cursor: not-allowed; opacity: 0.6; }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-tasks me-2"></i>모의훈련 상황판</h1>
        <div>
            <select id="drillSelector"><option value="">훈련 선택</option></select>
            <a href="/dr/dashboard" class="btn btn-outline-light me-2"><i class="fas fa-chart-line me-1"></i>DR현황판</a>
            <a href="/dr/manage" class="btn btn-outline-light"><i class="fas fa-cog me-1"></i>관리</a>
        </div>
    </div>
    
    <div class="main-container">
        <div class="task-panel">
            <div class="panel-title">
                <span><i class="fas fa-list-ul me-2"></i>훈련 태스크</span>
                <button class="btn btn-sm btn-outline-warning" onclick="openTaskModal()"><i class="fas fa-plus"></i></button>
            </div>
            <div class="task-list" id="taskList">
                <div class="empty-state"><i class="fas fa-clipboard-list"></i><p>훈련을 선택해주세요.</p></div>
            </div>
        </div>
        
        <div class="subtask-panel">
            <div class="subtask-header">
                <div>
                    <div class="subtask-title" id="selectedTaskName"><i class="fas fa-tasks me-2"></i>세부 작업 목록</div>
                    <small class="text-muted" id="selectedTaskTeam"></small>
                </div>
                <div class="subtask-info">
                    <div class="progress-circle">
                        <svg width="60" height="60" viewBox="0 0 60 60">
                            <circle class="bg" cx="30" cy="30" r="25"/>
                            <circle class="fg" id="taskProgressCircle" cx="30" cy="30" r="25" stroke-dasharray="157" stroke-dashoffset="157"/>
                        </svg>
                        <div class="progress-text" id="taskProgressText">0%</div>
                    </div>
                    <button class="btn btn-primary-custom btn-sm" onclick="openSubtaskModal()" id="btnAddSubtask" disabled>
                        <i class="fas fa-plus me-1"></i>작업 추가
                    </button>
                </div>
            </div>
            
            <div class="subtask-table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th width="30"></th><th width="40">#</th><th>작업내용</th><th width="90">예상시작</th><th width="90">예상종료</th>
                            <th width="90">실제시작</th><th width="90">실제종료</th><th width="80">수행인원</th><th width="120">진척률</th><th width="120">작업</th>
                        </tr>
                    </thead>
                    <tbody id="subtaskTableBody"></tbody>
                </table>
                <div class="empty-state" id="subtaskEmptyState">
                    <i class="fas fa-clipboard-check fa-2x mb-3"></i><p>태스크를 선택하면 세부 작업이 표시됩니다.</p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="taskModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">태스크 추가</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <input type="hidden" id="taskId">
                    <div class="mb-3"><label class="form-label">태스크명 *</label><input type="text" class="form-control" id="taskName"></div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label">태스크유형</label>
                            <select class="form-select" id="taskType">
                                <option value="DISASTER">재해선언</option><option value="RECOVERY">시스템복구</option><option value="CHECK">업무점검</option>
                                <option value="CONFIRM">업무확인</option><option value="COMPLETE">복구완료</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3"><label class="form-label">수행팀</label><input type="text" class="form-control" id="taskAssignTeam"></div>
                    </div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-warning" onclick="saveTask()">저장</button></div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="subtaskModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title" id="subtaskModalTitle">세부작업 추가</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <input type="hidden" id="subtaskId">
                    <div class="mb-3"><label class="form-label">작업내용 *</label><input type="text" class="form-control" id="subtaskName"></div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label">예상시작시간</label><input type="time" class="form-control" id="planStartTime"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">예상종료시간</label><input type="time" class="form-control" id="planEndTime"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label">진척률 (%)</label><input type="number" class="form-control" id="subtaskProgressInput" min="0" max="100" placeholder="0~100"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">수행인원</label><input type="text" class="form-control" id="assignUser"></div>
                    </div>
                    <div class="mb-3"><label class="form-label">비고</label><textarea class="form-control" id="subtaskRemark" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-warning" onclick="saveSubtask()">저장</button></div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    <script>
        var currentDrillId = ${drillId != null ? drillId : 'null'};
        var currentTaskId = null;
        var tasks = [];
        var sortable = null;
        var taskSortable = null;

        $(document).ready(function() {
            loadDrillList();
            $('#drillSelector').on('change', function() {
                currentDrillId = $(this).val(); currentTaskId = null;
                if (currentDrillId) loadTasks();
                else { $('#taskList').html('<div class="empty-state"><i class="fas fa-clipboard-list"></i><p>훈련을 선택해주세요.</p></div>'); clearSubtaskTable(); }
            });
        });

        function loadDrillList() {
            $.get('/dr/api/drills', function(res) {
                if (res.success && res.data && res.data.length > 0) {
                    var opts = '<option value="">훈련 선택</option>';
                    res.data.forEach(function(d) {
                        var sel = (currentDrillId && d.drillId == currentDrillId) ? 'selected' : '';
                        opts += '<option value="'+d.drillId+'" '+sel+'>'+d.drillName+'</option>';
                    });
                    $('#drillSelector').html(opts);
                    if (currentDrillId) loadTasks();
                } else { $('#drillSelector').html('<option value="">등록된 훈련 없음</option>'); }
            });
        }
        
        function loadTasks() {
            $.get('/dr/api/drills/' + currentDrillId + '/tasks', function(res) {
                if (res.success && res.data) { tasks = res.data; renderTaskList(); } 
                else { tasks = []; renderTaskList(); }
            }).fail(function() { tasks = []; renderTaskList(); });
        }
        
        function renderTaskList() {
            if (!tasks || tasks.length === 0) { $('#taskList').html('<div class="empty-state"><i class="fas fa-clipboard-list"></i><p>등록된 태스크가 없습니다.</p></div>'); return; }
            var html = '';
            tasks.forEach(function(t, i) {
                var statusClass = t.status === 'COMPLETED' ? 'completed' : (t.status === 'PROGRESS' ? 'status-progress' : '');
                var activeClass = t.taskId == currentTaskId ? 'active' : '';
                var progress = t.progressRate || 0;
                var subtaskCount = (t.subtasks && t.subtasks.length) || 0;
                var completedCount = t.subtasks ? t.subtasks.filter(function(s){ return s.status === 'COMPLETED'; }).length : 0;
                html += '<div class="task-item '+statusClass+' '+activeClass+'" data-task-id="'+t.taskId+'">' +
                    '<div class="task-drag-handle"><i class="fas fa-grip-vertical"></i></div>' +
                    '<div class="task-content" onclick="selectTask('+t.taskId+')">' +
                        '<div class="task-name">'+(i+1)+'. '+t.taskName+'</div>' +
                        '<div class="task-meta"><span>'+(t.assignTeam||'-')+'</span><span>'+completedCount+'/'+subtaskCount+' 완료</span></div>' +
                        '<div class="task-progress"><div class="progress"><div class="progress-bar" style="width:'+progress+'%"></div></div></div>' +
                    '</div>' +
                '</div>';
            });
            $('#taskList').html(html);
            initTaskSortable();
        }
        
        function selectTask(taskId) {
            currentTaskId = taskId;
            $('.task-item').removeClass('active');
            $('.task-item[data-task-id="'+taskId+'"]').addClass('active');
            $('#btnAddSubtask').prop('disabled', false);
            var task = tasks.find(function(t) { return t.taskId == taskId; });
            if (task) { $('#selectedTaskName').html('<i class="fas fa-tasks me-2"></i>' + task.taskName); $('#selectedTaskTeam').text(task.assignTeam ? '수행팀: ' + task.assignTeam : ''); }
            loadSubtasks(taskId);
        }
        
        function loadSubtasks(taskId) {
            $.get('/dr/api/tasks/' + taskId + '/subtasks', function(res) {
                if (res.success && res.data) { renderSubtaskTable(res.data); updateTaskProgress(res.data); initSortable(); } 
                else { renderSubtaskTable([]); updateTaskProgress([]); }
            }).fail(function() { renderSubtaskTable([]); updateTaskProgress([]); });
        }
        
        function renderSubtaskTable(subtasks) {
            if (!subtasks || subtasks.length === 0) { $('#subtaskTableBody').empty(); $('#subtaskEmptyState').show(); return; }
            $('#subtaskEmptyState').hide();
            var html = '';
            subtasks.forEach(function(s, i) {
                var statusClass = s.status === 'COMPLETED' ? 'completed' : (s.status === 'PROGRESS' ? 'status-progress' : '');
                var progress = s.progressRate || 0;
                html += '<tr class="'+statusClass+'" data-subtask-id="'+s.subtaskId+'"><td><i class="fas fa-sort drag-handle" title="순서변경"></i></td><td>'+(i+1)+'</td><td style="text-align:left;">'+s.subtaskName+'</td><td>'+formatTime(s.planStartTime)+'</td><td>'+formatTime(s.planEndTime)+'</td><td class="actual-start">'+(s.actualStartTime ? formatTime(s.actualStartTime) : '<span class="text-muted">-</span>')+'</td><td class="actual-end">'+(s.actualEndTime ? formatTime(s.actualEndTime) : '<span class="text-muted">-</span>')+'</td><td>'+(s.assignUser||'-')+'</td><td><div class="subtask-progress-bar"><div class="subtask-progress-fill" style="width:'+progress+'%"></div><div class="subtask-progress-text">'+progress+'%</div></div></td><td>' + getActionButtons(s) + '</td></tr>';
            });
            $('#subtaskTableBody').html(html);
        }
        
        function getActionButtons(s) {
            var btns = '';
            if (s.status === 'WAITING') { btns = '<button class="btn btn-start btn-sm btn-action" title="작업시작" onclick="startSubtask('+s.subtaskId+')"><i class="fas fa-play"></i></button>'; } 
            else if (s.status === 'PROGRESS') { btns = '<button class="btn btn-end btn-sm btn-action" title="작업완료" onclick="completeSubtask('+s.subtaskId+')"><i class="fas fa-check"></i></button>'; } 
            else { btns = '<span class="status-badge status-completed"><i class="fas fa-check"></i></span>'; }
            btns += '<button class="btn btn-outline-info btn-sm btn-action" onclick="editSubtask('+s.subtaskId+')"><i class="fas fa-edit"></i></button>';
            btns += '<button class="btn btn-outline-danger btn-sm btn-action" onclick="deleteSubtask('+s.subtaskId+')"><i class="fas fa-trash"></i></button>';
            return btns;
        }
        
        function updateTaskProgress(subtasks) {
            var total = subtasks.length; var sumRate = 0;
            if (total > 0) {
                subtasks.forEach(function(s) { sumRate += (s.progressRate || 0); });
                var avg = Math.round(sumRate / total);
                var circumference = 157; var offset = circumference - (avg / 100 * circumference);
                $('#taskProgressCircle').css('stroke-dashoffset', offset); $('#taskProgressText').text(avg + '%');
            } else { $('#taskProgressCircle').css('stroke-dashoffset', 157); $('#taskProgressText').text('0%'); }
        }
        
        function initTaskSortable() {
            if (taskSortable) taskSortable.destroy();
            var taskList = document.getElementById('taskList');
            if (taskList && taskList.children.length > 0) {
                taskSortable = new Sortable(taskList, {
                    handle: '.task-drag-handle',
                    animation: 150,
                    ghostClass: 'dragging',
                    onEnd: function(evt) {
                        var items = taskList.querySelectorAll('.task-item');
                        var orderList = [];
                        items.forEach(function(item, index) {
                            var id = item.getAttribute('data-task-id');
                            if (id) orderList.push({ taskId: parseInt(id), taskOrder: index + 1 });
                        });
                        $.ajax({
                            url: '/dr/api/tasks/reorder',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify(orderList),
                            success: function(res) {
                                if (res.success) {
                                    loadTasks();
                                }
                            }
                        });
                    }
                });
            }
        }

        function initSortable() {
             if (sortable) sortable.destroy();
             var tbody = document.getElementById('subtaskTableBody');
             if (tbody) {
                 sortable = new Sortable(tbody, { handle: '.drag-handle', animation: 150, ghostClass: 'dragging',
                     onEnd: function(evt) {
                         var rows = tbody.querySelectorAll('tr'); var orderList = [];
                         rows.forEach(function(row, index) { var id = row.getAttribute('data-subtask-id'); if (id) orderList.push({ subtaskId: parseInt(id), subtaskOrder: index + 1 }); });
                         $.ajax({ url: '/dr/api/subtasks/reorder', type: 'POST', contentType: 'application/json', data: JSON.stringify(orderList), success: function(res) { if (res.success) loadSubtasks(currentTaskId); } });
                     }
                 });
             }
        }

        function formatTime(datetime) {
            if (!datetime) return '-';
            try { var d = new Date(datetime); if (isNaN(d.getTime())) return '-'; return String(d.getHours()).padStart(2,'0') + ':' + String(d.getMinutes()).padStart(2,'0'); } catch(e) { return '-'; }
        }

        function openTaskModal() {
            if (!currentDrillId) { Swal.fire('알림', '먼저 상단에서 훈련을 선택해주세요.', 'warning'); return; }
            $('#taskId, #taskName, #taskAssignTeam').val(''); $('#taskType').val('RECOVERY'); new bootstrap.Modal('#taskModal').show();
        }

        function saveTask() {
            var data = { drillId: parseInt(currentDrillId), taskName: $('#taskName').val(), taskType: $('#taskType').val(), assignTeam: $('#taskAssignTeam').val() };
            if (!data.taskName) { Swal.fire('알림', '태스크명을 입력해주세요.', 'warning'); return; }
            $.ajax({ url: '/dr/api/tasks', type: 'POST', contentType: 'application/json', data: JSON.stringify(data),
                success: function(res) { if (res.success) { bootstrap.Modal.getInstance(document.getElementById('taskModal')).hide(); Swal.fire('완료', '저장되었습니다.', 'success'); loadTasks(); } else { Swal.fire('오류', res.message || '저장 실패', 'error'); } }, error: function() { Swal.fire('오류', '서버 오류', 'error'); }
            });
        }
        
        function openSubtaskModal() {
            if (!currentTaskId) { Swal.fire('알림', '태스크를 선택해주세요.', 'warning'); return; }
            $('#subtaskId, #subtaskName, #planStartTime, #planEndTime, #assignUser, #subtaskRemark').val(''); $('#subtaskProgressInput').val(0); $('#subtaskModalTitle').text('세부작업 추가'); new bootstrap.Modal('#subtaskModal').show();
        }
        
        function editSubtask(subtaskId) {
            $.get('/dr/api/subtasks/' + subtaskId, function(res) {
                if (res.success && res.data) {
                    var s = res.data;
                    $('#subtaskId').val(s.subtaskId); $('#subtaskName').val(s.subtaskName);
                    $('#planStartTime').val(s.planStartTime ? formatTime(s.planStartTime) : ''); $('#planEndTime').val(s.planEndTime ? formatTime(s.planEndTime) : '');
                    $('#assignUser').val(s.assignUser); $('#subtaskRemark').val(s.remark); $('#subtaskProgressInput').val(s.progressRate || 0);
                    $('#subtaskModalTitle').text('세부작업 수정'); new bootstrap.Modal('#subtaskModal').show();
                }
            });
        }
        
        function saveSubtask() {
            var id = $('#subtaskId').val(); var today = new Date().toISOString().split('T')[0];
            var pst = $('#planStartTime').val(); var pet = $('#planEndTime').val();
            var planStart = pst ? today + ' ' + pst + ':00' : null; var planEnd = pet ? today + ' ' + pet + ':00' : null;
            var progressVal = parseInt($('#subtaskProgressInput').val()) || 0;
            var data = { taskId: parseInt(currentTaskId), subtaskName: $('#subtaskName').val(), planStartTime: planStart, planEndTime: planEnd, assignUser: $('#assignUser').val(), remark: $('#subtaskRemark').val(), progressRate: progressVal };
            
            if (!data.subtaskName) { Swal.fire('알림', '작업내용을 입력해주세요.', 'warning'); return; }
            if (data.progressRate < 0 || data.progressRate > 100) { Swal.fire('알림', '진척률은 0~100 사이여야 합니다.', 'warning'); return; }

            $.ajax({ url: id ? '/dr/api/subtasks/' + id : '/dr/api/subtasks', type: id ? 'PUT' : 'POST', contentType: 'application/json', data: JSON.stringify(data),
                success: function(res) { if (res.success) { bootstrap.Modal.getInstance(document.getElementById('subtaskModal')).hide(); loadSubtasks(currentTaskId); loadTasks(); } else { Swal.fire('오류', res.message || '저장 실패', 'error'); } }, error: function(xhr) { Swal.fire('오류', '서버 오류', 'error'); }
            });
        }
        
        function deleteSubtask(subtaskId) {
            Swal.fire({ title: '삭제 확인', text: '삭제하시겠습니까?', icon: 'warning', showCancelButton: true, confirmButtonColor: '#dc3545', confirmButtonText: '삭제', cancelButtonText: '취소' }).then(function(result) {
                if (result.isConfirmed) { $.ajax({ url: '/dr/api/subtasks/' + subtaskId, type: 'DELETE', success: function(res) { if (res.success) { Swal.fire('완료', '삭제되었습니다.', 'success'); loadSubtasks(currentTaskId); loadTasks(); } } }); }
            });
        }
        
        function startSubtask(subtaskId) { $.post('/dr/api/subtasks/' + subtaskId + '/start', function(res) { if (res.success) { loadSubtasks(currentTaskId); loadTasks(); } else { Swal.fire('오류', '실패', 'error'); } }); }
        
        function completeSubtask(subtaskId) { $.post('/dr/api/subtasks/' + subtaskId + '/complete', function(res) { if (res.success) { loadSubtasks(currentTaskId); loadTasks(); } else { Swal.fire('오류', '실패', 'error'); } }); }
        
        function clearSubtaskTable() { $('#subtaskTableBody').empty(); $('#subtaskEmptyState').show(); $('#selectedTaskName').html('<i class="fas fa-tasks me-2"></i>세부 작업 목록'); $('#selectedTaskTeam').text(''); $('#taskProgressCircle').css('stroke-dashoffset', 157); $('#taskProgressText').text('0%'); $('#btnAddSubtask').prop('disabled', true); }
    </script>
</body>
</html>