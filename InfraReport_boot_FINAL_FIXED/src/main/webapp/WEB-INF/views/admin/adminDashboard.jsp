<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KERIS 인프라팀 - 담당자별 작업 현황 대시보드</title>
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
            background: #f5f7fa;
            padding: 20px;
        }
        
        .header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .header-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .date-selector {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .content-container {
            display: flex;
            gap: 20px;
        }
        
        .section {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .section-title {
            font-size: 1.5em;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 20px;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        
        /* 일일진행 섹션 */
        .daily-section {
            flex: 1;
            min-width: 400px;
        }
        
        .manager-row {
            margin-bottom: 25px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 5px solid #3498db;
        }
        
        .manager-name {
            font-size: 1.3em;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .progress-container {
            position: relative;
            height: 40px;
        }
        
        .progress {
            height: 40px;
            border-radius: 8px;
            background: #e9ecef;
        }
        
        .progress-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.1em;
            color: white;
            border-radius: 8px;
            transition: width 0.6s ease;
        }
        
        .progress-rate-high {
            background: linear-gradient(90deg, #2ecc71 0%, #27ae60 100%);
        }
        
        .progress-rate-medium {
            background: linear-gradient(90deg, #3498db 0%, #2980b9 100%);
        }
        
        .progress-rate-low {
            background: linear-gradient(90deg, #e74c3c 0%, #c0392b 100%);
        }
        
        .task-stats {
            display: flex;
            gap: 15px;
            margin-top: 10px;
            font-size: 0.9em;
        }
        
        .task-stat-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .stat-label {
            color: #7f8c8d;
        }
        
        .stat-value {
            font-weight: bold;
            color: #2c3e50;
        }
        
        /* 비정기 섹션 */
        .irregular-section {
            flex: 2;
            min-width: 600px;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th {
            background: #34495e;
            color: white;
            padding: 12px;
            text-align: center;
            font-weight: bold;
            border: 1px solid #2c3e50;
        }
        
        td {
            padding: 12px;
            text-align: center;
            border: 1px solid #dee2e6;
        }
        
        tr:nth-child(even) {
            background: #f8f9fa;
        }
        
        tr:hover {
            background: #e9ecef;
        }
        
        .manager-cell {
            font-weight: bold;
            color: #2c3e50;
            text-align: left;
            padding-left: 20px;
        }
        
        .count-cell {
            font-weight: bold;
        }
        
        .count-overdue {
            color: #e74c3c;
            font-size: 1.1em;
        }
        
        .count-urgent {
            color: #e67e22;
        }
        
        .count-normal {
            color: #3498db;
        }
        
        .count-total {
            background: #ecf0f1;
            font-weight: bold;
            color: #2c3e50;
        }
        
        /* 자동 새로고침 */
        .refresh-indicator {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: white;
            padding: 10px 20px;
            border-radius: 25px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            font-size: 0.9em;
            color: #3498db;
        }
        
        /* 로딩 */
        .loading {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
        }
        
        /* 반응형 */
        @media (max-width: 1200px) {
            .content-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- 헤더 -->
    <div class="header">
        <div class="d-flex justify-content-between align-items-center">
            <div class="header-title">
                <i class="fas fa-users"></i> 담당자별 작업 현황 대시보드
            </div>
            <div class="date-selector">
                <label for="reportDate" class="me-2"><strong>날짜:</strong></label>
                <input type="date" id="reportDate" class="form-control" style="width: 180px;">
                <button class="btn btn-primary" onclick="loadDashboard()">
                    <i class="fas fa-search"></i> 조회
                </button>
                <button class="btn btn-secondary" onclick="setToday()">
                    <i class="fas fa-calendar-day"></i> 오늘
                </button>
            </div>
        </div>
    </div>

    <!-- 메인 컨텐츠 -->
    <div class="content-container">
        <!-- 일일진행 섹션 -->
        <div class="daily-section section">
            <div class="section-title">
                <i class="fas fa-tasks"></i> 일일진행
            </div>
            <div id="dailyProgressContainer">
                <div class="loading">
                    <i class="fas fa-spinner fa-spin fa-2x"></i>
                    <p class="mt-2">데이터 로딩 중...</p>
                </div>
            </div>
        </div>

        <!-- 비정기 섹션 -->
        <div class="irregular-section section">
            <div class="section-title">
                <i class="fas fa-calendar-alt"></i> 비정기
            </div>
            <div class="table-container">
                <table id="irregularTable">
                    <thead>
                        <tr>
                            <th rowspan="2" style="width: 150px;">담당자</th>
                            <th rowspan="2">전체작업</th>
                            <th rowspan="2">기한초과</th>
                            <th colspan="5">기한 내 작업</th>
                            <th rowspan="2">Over 1M</th>
                        </tr>
                        <tr>
                            <th>1D</th>
                            <th>3D</th>
                            <th>5D</th>
                            <th>2W</th>
                            <th>4W</th>
                        </tr>
                    </thead>
                    <tbody id="irregularTableBody">
                        <tr>
                            <td colspan="10" class="loading">
                                <i class="fas fa-spinner fa-spin"></i> 데이터 로딩 중...
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 자동 새로고침 표시 -->
    <div class="refresh-indicator">
        <i class="fas fa-sync-alt"></i> 
        <span id="nextRefresh">60초 후 갱신</span>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 페이지 로드 시 오늘 날짜로 초기화
        $(document).ready(function() {
            setToday();
            loadDashboard();
            
            // 60초마다 자동 새로고침
            setInterval(loadDashboard, 60000);
            
            // 카운터 업데이트
            setInterval(updateRefreshCounter, 1000);
        });
        
        // 오늘 날짜 설정
        function setToday() {
            const today = new Date().toISOString().split('T')[0];
            $('#reportDate').val(today);
        }
        
        // 대시보드 데이터 로드
        function loadDashboard() {
            const reportDate = $('#reportDate').val();
            
            $.ajax({
                url: '/admin/work-status',
                method: 'GET',
                data: { reportDate: reportDate },
                success: function(data) {
                    if (data.success) {
                        updateDailyProgress(data.dailyProgress);
                        updateIrregularTasks(data.irregularTasks);
                        resetRefreshCounter();
                    } else {
                        alert('데이터 조회 실패: ' + data.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 오류:', error);
                    alert('데이터 로드 중 오류가 발생했습니다.');
                }
            });
        }
        
        // 일일 진행 현황 업데이트
        function updateDailyProgress(data) {
            let html = '';
            
            if (data && data.length > 0) {
                data.forEach(function(item) {
                    const rate = item.completionRate || 0;
                    const progressClass = rate >= 80 ? 'progress-rate-high' : 
                                         rate >= 50 ? 'progress-rate-medium' : 'progress-rate-low';
                    
                    html += `
                        <div class="manager-row">
                            <div class="manager-name">` + item.manager + `</div>
                            <div class="progress-container">
                                <div class="progress">
                                    <div class="progress-bar ` + progressClass + `" 
                                         role="progressbar" 
                                         style="width: ` + rate + `%" 
                                         aria-valuenow="` + rate + `" 
                                         aria-valuemin="0" 
                                         aria-valuemax="100">
                                        ` + Math.round(rate) + `% 완료
                                    </div>
                                </div>
                            </div>
                            <div class="task-stats">
                                <div class="task-stat-item">
                                    <span class="stat-label">전체:</span>
                                    <span class="stat-value">` + item.totalTasks + `건</span>
                                </div>
                                <div class="task-stat-item">
                                    <span class="stat-label">완료:</span>
                                    <span class="stat-value" style="color: #27ae60;">` + item.completedTasks + `건</span>
                                </div>
                                <div class="task-stat-item">
                                    <span class="stat-label">미완료:</span>
                                    <span class="stat-value" style="color: #e74c3c;">` + item.pendingTasks + `건</span>
                                </div>
                            </div>
                        </div>
                    `;
                });
            } else {
                html = '<div class="loading">해당 날짜에 작업 데이터가 없습니다.</div>';
            }
            
            $('#dailyProgressContainer').html(html);
        }
        
        // 비정기 작업 현황 업데이트
        function updateIrregularTasks(data) {
            let html = '';
            
            if (data && data.length > 0) {
                data.forEach(function(item) {
                    html += '<tr>' +
                        '<td class="manager-cell">' + item.manager + '</td>' +
                        '<td class="count-total count-cell">' + item.totalIrregularTasks + '</td>' +
                        '<td class="' + (item.overdueCount > 0 ? 'count-overdue' : '') + ' count-cell">' +
                            item.overdueCount +
                        '</td>' +
                        '<td class="' + (item.within1Day > 0 ? 'count-urgent' : '') + ' count-cell">' +
                            item.within1Day +
                        '</td>' +
                        '<td class="count-cell">' + item.within3Days + '</td>' +
                        '<td class="count-cell">' + item.within5Days + '</td>' +
                        '<td class="count-cell">' + item.within2Weeks + '</td>' +
                        '<td class="count-cell">' + item.within4Weeks + '</td>' +
                        '<td class="count-cell">' + item.over1Month + '</td>' +
                    '</tr>';
                });
            } else {
                html = '<tr>' +
                    '<td colspan="10" class="loading">' +
                        '해당 날짜에 작업 데이터가 없습니다.' +
                    '</td>' +
                '</tr>';
            }
            
            $('#irregularTableBody').html(html);
        }
        
        // 새로고침 카운터
        let refreshCounter = 60;
        function updateRefreshCounter() {
            refreshCounter--;
            $('#nextRefresh').text(refreshCounter + '초 후 갱신');
            if (refreshCounter <= 0) {
                resetRefreshCounter();
            }
        }
        
        function resetRefreshCounter() {
            refreshCounter = 60;
        }
    </script>
</body>
</html>
