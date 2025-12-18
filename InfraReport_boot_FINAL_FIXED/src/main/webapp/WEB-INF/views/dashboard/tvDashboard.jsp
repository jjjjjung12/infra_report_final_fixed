<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KERIS 인프라 모니터링 대시보드</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow: hidden;
            padding: 20px;
        }
        
        .dashboard-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-template-rows: repeat(2, 1fr);
            gap: 20px;
            height: calc(100vh - 80px);
            margin-top: 60px;
            transition: all 0.3s ease; /* 부드러운 전환 효과 */
        }
        
        /* 전체 화면 모드일 때 컨테이너 숨김 처리용 */
        .dashboard-container.has-fullscreen .dashboard-card:not(.fullscreen-mode) {
            display: none;
        }
        
        .dashboard-container.has-fullscreen {
            grid-template-columns: 1fr;
            grid-template-rows: 1fr;
            height: calc(100vh - 80px);
        }

        .dashboard-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            overflow: hidden;
            cursor: pointer; /* 클릭 가능 표시 */
            position: relative;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
        }
        
        /* 전체 화면 스타일 */
        .dashboard-card.fullscreen-mode {
            position: fixed;
            top: 60px; /* 헤더 높이만큼 띄움 */
            left: 20px;
            right: 20px;
            bottom: 20px;
            z-index: 1000;
            transform: none !important;
            grid-column: 1 / -1;
            grid-row: 1 / -1;
            height: calc(100vh - 80px);
        }

        /* 전체 화면 닫기 버튼 */
        .close-fullscreen-btn {
            display: none;
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 1.5rem;
            color: #666;
            cursor: pointer;
            z-index: 1001;
        }

        .dashboard-card.fullscreen-mode .close-fullscreen-btn {
            display: block;
        }
        
        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
            justify-content: space-between; /* 아이콘 우측 정렬 */
        }
        
        .header-left {
            display: flex;
            align-items: center;
        }

        .card-icon {
            font-size: 2em;
            margin-right: 15px;
        }
        
        .card-title {
            font-size: 1.3em;
            font-weight: bold;
            color: #333;
        }
        
        .expand-icon {
            color: #ccc;
            transition: color 0.3s;
        }

        .dashboard-card:hover .expand-icon {
            color: #667eea;
        }

        .card-body {
            height: calc(100% - 60px);
            overflow-y: auto;
        }
        
        /* 상태 뱃지 */
        .status-badge {
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9em;
        }
        
        .status-success { background: #28a745; color: white; }
        .status-warning { background: #ffc107; color: #333; }
        .status-danger { background: #dc3545; color: white; }
        
        /* 신호등 표시 */
        .traffic-light {
            display: inline-block;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .light-green { background: #28a745; }
        .light-yellow { background: #ffc107; }
        .light-red { background: #dc3545; }
        
        /* 통계 카드 */
        .stat-box {
            text-align: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
        }
        
        .stat-label {
            font-size: 0.9em;
            color: #666;
            margin-top: 5px;
        }
        
        /* 작업 목록 */
        .task-item {
            padding: 10px;
            margin-bottom: 8px;
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            border-radius: 5px;
        }
        
        .task-item:hover {
            background: #e9ecef;
        }
        
        /* 상단 헤더 */
        .top-header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #667eea;
        }
        
        .header-time {
            font-size: 1.2em;
            color: #666;
        }
        
        /* 자동 새로고침 표시 */
        .refresh-indicator {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.9);
            padding: 10px 20px;
            border-radius: 25px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            font-size: 0.9em;
            color: #667eea;
            z-index: 1002; /* 전체화면보다 위에 */
        }
        
        /* 스크롤바 스타일 */
        .card-body::-webkit-scrollbar { width: 8px; }
        .card-body::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
        .card-body::-webkit-scrollbar-thumb { background: #667eea; border-radius: 10px; }
        
        /* 프로그레스 바 */
        .progress-wrapper { margin: 10px 0; }
        .progress-label { display: flex; justify-content: space-between; margin-bottom: 5px; font-size: 0.9em; }
        .custom-progress { height: 20px; border-radius: 10px; }
    </style>
</head>
<body>
    <div class="top-header">
        <div class="header-title">
            <i class="fas fa-server"></i> KERIS 인프라 모니터링 대시보드
        </div>
        <div class="header-time">
            <i class="fas fa-clock"></i> <span id="currentTime"></span>
        </div>
    </div>

    <div class="dashboard-container" id="dashboardContainer">
        
        <div class="dashboard-card" onclick="toggleFullscreen(this)">
            <div class="close-fullscreen-btn" onclick="event.stopPropagation(); toggleFullscreen(this.parentElement)"><i class="fas fa-times"></i></div>
            <div class="card-header">
                <div class="header-left">
                    <span class="card-icon" style="color: #dc3545;">🚨</span>
                    <span class="card-title">실시간 장애 대응</span>
                </div>
                <i class="fas fa-expand expand-icon"></i>
            </div>
            <div class="card-body">
                <div class="stat-box">
                    <div class="stat-number" id="criticalCount">0</div>
                    <div class="stat-label">미확인 Critical 알림</div>
                </div>
                <h6 class="mt-3 mb-2"><strong>핵심 서비스 상태</strong></h6>
                <div id="serviceStatusList"></div>
                <h6 class="mt-3 mb-2"><strong>진행 중인 장애 복구</strong></h6>
                <div id="ongoingIssuesList"></div>
            </div>
        </div>

        <div class="dashboard-card" onclick="toggleFullscreen(this)">
            <div class="close-fullscreen-btn" onclick="event.stopPropagation(); toggleFullscreen(this.parentElement)"><i class="fas fa-times"></i></div>
            <div class="card-header">
                <div class="header-left">
                    <span class="card-icon" style="color: #007bff;">📋</span>
                    <span class="card-title">금일 업무 (To-Do)</span>
                </div>
                <i class="fas fa-expand expand-icon"></i>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-4">
                        <div class="stat-box">
                            <div class="stat-number" style="font-size: 2em;" id="totalTasks">0</div>
                            <div class="stat-label">전체</div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat-box">
                            <div class="stat-number" style="font-size: 2em; color: #28a745;" id="completedTasks">0</div>
                            <div class="stat-label">완료</div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat-box">
                            <div class="stat-number" style="font-size: 2em; color: #ffc107;" id="pendingTasks">0</div>
                            <div class="stat-label">미완료</div>
                        </div>
                    </div>
                </div>
                <h6 class="mb-2"><strong>금일 예정 작업</strong></h6>
                <div id="todayTasksList"></div>
            </div>
        </div>

        <div class="dashboard-card" onclick="toggleFullscreen(this)">
            <div class="close-fullscreen-btn" onclick="event.stopPropagation(); toggleFullscreen(this.parentElement)"><i class="fas fa-times"></i></div>
            <div class="card-header">
                <div class="header-left">
                    <span class="card-icon" style="color: #ffc107;">🎫</span>
                    <span class="card-title">티켓 현황</span>
                </div>
                <i class="fas fa-expand expand-icon"></i>
            </div>
            <div class="card-body">
                <div class="stat-box">
                    <div class="stat-number" style="color: #dc3545;" id="newTickets">0</div>
                    <div class="stat-label">신규 접수 (미배정)</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number" style="color: #ffc107;" id="processingTickets">0</div>
                    <div class="stat-label">처리 중</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number" style="color: #28a745;" id="closedTickets">0</div>
                    <div class="stat-label">금일 처리 완료</div>
                </div>
            </div>
        </div>

        <div class="dashboard-card" onclick="toggleFullscreen(this)">
            <div class="close-fullscreen-btn" onclick="event.stopPropagation(); toggleFullscreen(this.parentElement)"><i class="fas fa-times"></i></div>
            <div class="card-header">
                <div class="header-left">
                    <span class="card-icon" style="color: #17a2b8;">👨‍💼</span>
                    <span class="card-title">팀/커뮤니케이션</span>
                </div>
                <i class="fas fa-expand expand-icon"></i>
            </div>
            <div class="card-body">
                <h6 class="mb-2"><strong>오늘의 당직자</strong></h6>
                <div class="stat-box" id="managerInfo">
                    <div style="font-size: 1.5em;">담당자 정보 로딩 중...</div>
                </div>
                <h6 class="mt-3 mb-2"><strong>주요 공지사항</strong></h6>
                <div id="announcementsList"></div>
            </div>
        </div>

        <div class="dashboard-card" onclick="toggleFullscreen(this)">
            <div class="close-fullscreen-btn" onclick="event.stopPropagation(); toggleFullscreen(this.parentElement)"><i class="fas fa-times"></i></div>
            <div class="card-header">
                <div class="header-left">
                    <span class="card-icon" style="color: #6c757d;">📅</span>
                    <span class="card-title">예정된 작업</span>
                </div>
                <i class="fas fa-expand expand-icon"></i>
            </div>
            <div class="card-body">
                <h6 class="mb-2"><strong>주간 예정 작업</strong></h6>
                <div id="weeklyScheduleList"></div>
            </div>
        </div>

        <div class="dashboard-card" onclick="toggleFullscreen(this)">
            <div class="close-fullscreen-btn" onclick="event.stopPropagation(); toggleFullscreen(this.parentElement)"><i class="fas fa-times"></i></div>
            <div class="card-header">
                <div class="header-left">
                    <span class="card-icon" style="color: #28a745;">📊</span>
                    <span class="card-title">예방 및 점검</span>
                </div>
                <i class="fas fa-expand expand-icon"></i>
            </div>
            <div class="card-body">
                <h6 class="mb-2"><strong>자원 임계치 근접 항목</strong></h6>
                <div id="criticalResourcesList"></div>
                <h6 class="mt-3 mb-2"><strong>일일 백업 상태</strong></h6>
                <div id="backupStatus"></div>
                <h6 class="mt-3 mb-2"><strong>보안 활동</strong></h6>
                <div id="securityActivityStatus"></div>
            </div>
        </div>
    </div>

    <div class="refresh-indicator">
        <i class="fas fa-sync-alt"></i> 
        <span id="nextRefresh">30초 후 갱신</span>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 전체 화면 토글 함수
        function toggleFullscreen(cardElement) {
            const container = document.getElementById('dashboardContainer');
            
            // 이미 전체화면인지 확인
            if (cardElement.classList.contains('fullscreen-mode')) {
                // 전체화면 해제 (닫기)
                cardElement.classList.remove('fullscreen-mode');
                container.classList.remove('has-fullscreen');
            } else {
                // 전체화면 활성화
                // 다른 카드가 이미 전체화면이면 무시 (하나만 전체화면 가능)
                if (document.querySelector('.fullscreen-mode')) return;

                cardElement.classList.add('fullscreen-mode');
                container.classList.add('has-fullscreen');
            }
        }

        // 현재 시간 표시
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
            $('#currentTime').text(timeString);
        }
        
        // 초기 시간 표시 및 1초마다 업데이트
        updateTime();
        setInterval(updateTime, 1000);
        
        // 데이터 로드 함수
        function loadDashboardData() {
            $.ajax({
                url: '/dashboard/data',
                method: 'GET',
                success: function(data) {
                    if (data.success) {
                        updateRealtimeStatus(data.realtime);
                        updateTodayTasks(data.todayTasks);
                        updateTickets(data.tickets);
                        updateTeamInfo(data.team);
                        updateScheduledTasks(data.scheduled);
                        updatePrevention(data.prevention);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 오류:', error);
                }
            });
        }
        
        // 실시간 장애 대응 업데이트
        function updateRealtimeStatus(data) {
            $('#criticalCount').text(data.criticalCount || 0);
            
            let serviceHtml = '';
            if (data.serviceStatus && data.serviceStatus.length > 0) {
                data.serviceStatus.forEach(function(service) {
                    const lightClass = service.serviceStatus === '정상' ? 'light-green' : 
                                     service.serviceStatus === '주의' ? 'light-yellow' : 'light-red';
                    
                    const badgeClass = service.serviceStatus === '정상' ? 'status-success' : 
                                      service.serviceStatus === '주의' ? 'status-warning' : 'status-danger';
                    
                    serviceHtml += '<div class="task-item">' +
                        '<span class="traffic-light ' + lightClass + '"></span>' +
                        '<strong>' + service.serviceName + '</strong>' +
                        '<span class="float-end status-badge ' + badgeClass + '">' +
                            service.serviceStatus +
                        '</span>' +
                    '</div>';
                });
            } else {
                serviceHtml = '<div class="task-item">모든 서비스 정상 운영 중</div>';
            }
            $('#serviceStatusList').html(serviceHtml);
            
            const ongoingCount = data.ongoingIssues || 0;
            $('#ongoingIssuesList').html(
                ongoingCount > 0 ? 
                '<div class="alert alert-warning">진행 중인 장애: ' + ongoingCount + '건</div>' :
                '<div class="alert alert-success">진행 중인 장애 없음</div>'
            );
        }
        
        // 금일 업무 업데이트
        function updateTodayTasks(data) {
            if (data.taskStats) {
                $('#totalTasks').text(data.taskStats.totalTasks || 0);
                $('#completedTasks').text(data.taskStats.completedTasks || 0);
                $('#pendingTasks').text(data.taskStats.pendingTasks || 0);
            }
            
            let tasksHtml = '';
            if (data.taskList && data.taskList.length > 0) {
                data.taskList.forEach(function(task) {
                    const statusClass = task.status === '정상' ? 'status-success' : 
                                      task.status === '주의' ? 'status-warning' : 'status-danger';
                    
                    tasksHtml += '<div class="task-item">' +
                        '<div><strong>' + task.taskDescription + '</strong></div>' +
                        '<div class="mt-1">' +
                            '<small>' + task.taskType + ' | ' + (task.manager || '미지정') + '</small>' +
                            '<span class="float-end status-badge ' + statusClass + '">' + task.status + '</span>' +
                        '</div>' +
                    '</div>';
                });
            } else {
                tasksHtml = '<div class="task-item">금일 예정된 작업이 없습니다.</div>';
            }
            $('#todayTasksList').html(tasksHtml);
        }
        
        // 티켓 현황 업데이트
        function updateTickets(data) {
            $('#newTickets').text(data.newTickets || 0);
            $('#processingTickets').text(data.processingTickets || 0);
            $('#closedTickets').text(data.closedTickets || 0);
        }
        
        // 팀 정보 업데이트
        function updateTeamInfo(data) {
            if (data.manager && data.manager.managerName) {
                $('#managerInfo').html(
                    '<div style="font-size: 1.5em; font-weight: bold;">' + data.manager.managerName + '</div>' +
                    '<div style="color: #666;">' + (data.manager.managerType || '주간') + ' 당직</div>'
                );
            }
            
            let announcementsHtml = '';
            if (data.announcements && data.announcements.length > 0) {
                data.announcements.forEach(function(item) {
                    announcementsHtml += '<div class="task-item">' +
                        '<strong>' + item.title + '</strong>' +
                        '<div class="mt-1"><small>' + item.date + '</small></div>' +
                    '</div>';
                });
            } else {
                announcementsHtml = '<div class="task-item">공지사항이 없습니다.</div>';
            }
            $('#announcementsList').html(announcementsHtml);
        }
        
        // 예정 작업 업데이트
        function updateScheduledTasks(data) {
            let scheduleHtml = '';
            if (data.weeklySchedule && data.weeklySchedule.length > 0) {
                data.weeklySchedule.forEach(function(task) {
                    scheduleHtml += '<div class="task-item">' +
                        '<div><strong>' + task.taskDescription + '</strong></div>' +
                        '<div class="mt-1">' +
                            '<small>' + task.taskType + ' | ' + new Date(task.reportDate).toLocaleDateString('ko-KR') + '</small>' +
                        '</div>' +
                    '</div>';
                });
            } else {
                scheduleHtml = '<div class="task-item">예정된 작업이 없습니다.</div>';
            }
            $('#weeklyScheduleList').html(scheduleHtml);
        }
        
        // 예방 및 점검 업데이트
        function updatePrevention(data) {
            // 자원 임계치
            let resourceHtml = '';
            if (data.criticalResources && data.criticalResources.length > 0) {
                data.criticalResources.forEach(function(resource) {
                    const statusClass = resource.usagePercent >= 90 ? 'status-danger' : 'status-warning';
                    resourceHtml += '<div class="task-item">' +
                        '<div><strong>' + resource.serviceName + ' - ' + resource.resourceType + '</strong></div>' +
                        '<div class="mt-1">' +
                            '<span class="status-badge ' + statusClass + '">' + resource.usagePercent + '% 사용</span>' +
                        '</div>' +
                    '</div>';
                });
            } else {
                resourceHtml = '<div class="task-item">임계치 근접 자원 없음</div>';
            }
            $('#criticalResourcesList').html(resourceHtml);
            
            // 백업 상태
            if (data.backupStatus) {
                const backupRate = data.backupStatus.totalBackups > 0 ?
                    Math.round((data.backupStatus.successBackups / data.backupStatus.totalBackups) * 100) : 0;
                $('#backupStatus').html(
                    '<div class="progress-wrapper">' +
                        '<div class="progress-label">' +
                            '<span>성공: ' + data.backupStatus.successBackups + '건</span>' +
                            '<span>실패: ' + data.backupStatus.failedBackups + '건</span>' +
                        '</div>' +
                        '<div class="progress custom-progress">' +
                            '<div class="progress-bar bg-success" style="width: ' + backupRate + '%">' + backupRate + '%</div>' +
                        '</div>' +
                    '</div>'
                );
            }
            
            // 보안 활동
            if (data.securityActivity) {
                $('#securityActivityStatus').html(
                    '<div class="stat-box">' +
                        '<div>탐지: <strong>' + (data.securityActivity.detectionCount || 0) + '건</strong></div>' +
                        '<div>차단: <strong>' + (data.securityActivity.blockedCount || 0) + '건</strong></div>' +
                    '</div>'
                );
            }
        }
        
        // 자동 새로고침 카운터
        let refreshCounter = 30;
        function updateRefreshCounter() {
            refreshCounter--;
            $('#nextRefresh').text(refreshCounter + '초 후 갱신');
            if (refreshCounter <= 0) {
                loadDashboardData();
                refreshCounter = 30;
            }
        }
        
        // 초기 데이터 로드
        loadDashboardData();
        // 1초마다 카운터 업데이트
        setInterval(updateRefreshCounter, 1000);
        // 30초마다 자동 새로고침
        setInterval(loadDashboardData, 30000);
        
        $(document).ready(function() {
            console.log('TV 대시보드 로드 완료. 카드 클릭시 확대됩니다.');
        });
    </script>
</body>
</html>