<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DR 현황판</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
    
    <style>
        :root { --primary: #f7931e; --dark-bg: #0a0a1a; --card-bg: #1a1a2e; --success: #28a745; --info: #17a2b8; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: var(--dark-bg); color: #fff; font-family: 'Segoe UI', sans-serif; min-height: 100vh; }
        
        .header { background: var(--primary); padding: 12px 25px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 1.4rem; font-weight: bold; margin: 0; display: flex; align-items: center; gap: 10px; }
        
        /* 셀렉트 박스 스타일 */
        .header-btns select { 
            background-color: #ffffff !important; 
            color: #333333 !important; 
            border: 1px solid rgba(255,255,255,0.3); 
            padding: 8px 15px; 
            border-radius: 5px; 
            margin-right: 10px; 
        }
        .header-btns select option { color: #333 !important; background: #fff !important; }
        .header-btns .btn { margin-left: 8px; }
        
        .main-container { display: grid; grid-template-columns: 1fr 350px; grid-template-rows: 280px 1fr; gap: 15px; padding: 15px; height: calc(100vh - 60px); }
        .map-section { grid-column: 1; grid-row: 1; background: var(--card-bg); border-radius: 10px; overflow: hidden; position: relative; transition: all 0.3s; }
        .map-section.fullscreen { position: fixed; top: 0; left: 0; right: 0; bottom: 0; z-index: 9999; grid-column: auto; grid-row: auto; border-radius: 0; }
        
        #map { width: 100%; height: 100%; }
        .map-title { position: absolute; top: 10px; left: 10px; background: rgba(0,0,0,0.7); padding: 8px 15px; border-radius: 5px; z-index: 1000; font-weight: bold; display: flex; align-items: center; }
        
        .right-panel { grid-column: 2; grid-row: 1 / 3; display: flex; flex-direction: column; gap: 15px; }
        .time-card { background: var(--card-bg); border-radius: 10px; padding: 20px; text-align: center; }
        .time-label { color: #aaa; font-size: 0.9rem; margin-bottom: 8px; }
        .time-value { font-size: 2.5rem; font-weight: bold; font-family: 'Consolas', monospace; }
        
        .rto-card { background: linear-gradient(135deg, #e85d04, #f48c06); border-radius: 10px; padding: 20px; }
        .rto-card.exceeded { background: linear-gradient(135deg, #dc3545, #c82333); }
        .rto-label { text-align: center; margin-bottom: 15px; font-weight: 500; }
        .rto-display { display: flex; justify-content: center; gap: 15px; }
        .rto-unit { text-align: center; }
        .rto-num { font-size: 2rem; font-weight: bold; background: rgba(0,0,0,0.3); padding: 10px 15px; border-radius: 8px; min-width: 60px; }
        .rto-unit-label { font-size: 0.7rem; margin-top: 5px; color: rgba(255,255,255,0.8); }
        
        .drill-info { background: var(--card-bg); border-radius: 10px; padding: 15px; flex: 1; }
        .drill-info h6 { color: var(--primary); margin-bottom: 15px; display: flex; align-items: center; gap: 8px; }
        .drill-info p { margin: 8px 0; font-size: 0.9rem; }
        .drill-info strong { color: #aaa; }
        .badge-status { padding: 4px 12px; border-radius: 15px; font-size: 0.8rem; }
        .badge-planned { background: #6c757d; }
        .badge-progress { background: #0dcaf0; color: #000; }
        .badge-completed { background: #198754; }
        
        .bottom-section { grid-column: 1; grid-row: 2; display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 15px; }
        .status-card { background: var(--card-bg); border-radius: 10px; padding: 15px; display: flex; flex-direction: column; }
        .card-title { color: var(--primary); font-weight: bold; margin-bottom: 15px; display: flex; align-items: center; gap: 8px; padding-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        
        .timeline-container { flex: 1; overflow-y: auto; padding-right: 5px; }
        .timeline-item { display: flex; gap: 15px; margin-bottom: 15px; position: relative; }
        .timeline-item:not(:last-child)::before { content: ''; position: absolute; left: 8px; top: 25px; bottom: -15px; width: 2px; background: rgba(255,255,255,0.2); }
        .timeline-dot { width: 18px; height: 18px; border-radius: 50%; flex-shrink: 0; margin-top: 3px; }
        .timeline-dot.completed { background: var(--success); }
        .timeline-dot.progress { background: var(--info); animation: pulse 1.5s infinite; }
        .timeline-dot.waiting { background: #6c757d; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
        .timeline-content { flex: 1; }
        .timeline-time { font-size: 0.75rem; color: #888; }
        .timeline-title { font-size: 0.9rem; margin: 3px 0; }
        .timeline-empty { text-align: center; color: #666; padding: 30px; }
        
        /* ========================================
           [수정] 도넛 차트 크기 대폭 확대 (400px)
           ======================================== */
        .chart-container { display: flex; flex-direction: column; align-items: center; justify-content: center; flex: 1; }
        .donut-chart { position: relative; width: 400px; height: 400px; }
        .donut-chart svg { transform: rotate(-90deg); }
        .donut-chart circle { fill: none; stroke-width: 25; }
        .donut-bg { stroke: rgba(255,255,255,0.1); }
        .donut-progress { stroke: var(--success); stroke-linecap: round; transition: stroke-dashoffset 0.5s ease; }
        .donut-progress.system { stroke: #17a2b8; }
        .donut-progress.check { stroke: #28a745; }
        .donut-center { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; }
        .donut-percent { font-size: 3.5rem; font-weight: bold; }
        .donut-label { font-size: 1.2rem; color: #888; }
        .chart-legend { margin-top: 20px; text-align: center; font-size: 1.1rem; color: #aaa; }
        
        /* 마커 스타일 */
        .custom-marker { background: transparent; border: none; }
        .marker-pin {
            width: 30px; height: 30px; border-radius: 50% 50% 50% 0; background: #f7931e;
            position: absolute; transform: rotate(-45deg); left: 50%; top: 50%; margin: -15px 0 0 -15px;
            box-shadow: 0 3px 5px rgba(0,0,0,0.3);
        }
        .marker-pin.dr-center { background: #17a2b8; }
        .marker-pin::after {
            content: ''; width: 14px; height: 14px; margin: 8px 0 0 8px; background: #fff;
            position: absolute; border-radius: 50%;
        }
        .marker-label {
            position: absolute; top: -25px; left: 50%; transform: translateX(-50%);
            background: rgba(0,0,0,0.7); color: #fff; padding: 2px 8px; border-radius: 4px;
            font-size: 11px; white-space: nowrap; pointer-events: none;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-shield-alt"></i> 나이스 클라우드센터 재해복구</h1>
        <div class="header-btns">
            <select id="drillSelector"><option value="">훈련 선택</option></select>
            <button class="btn btn-success" id="btnStartDrill" onclick="startDrill()"><i class="fas fa-play me-1"></i>훈련시작</button>
            <button class="btn btn-warning" id="btnPauseDrill" onclick="pauseDrill()" style="display:none;"><i class="fas fa-pause me-1"></i>일시정지</button>
            <button class="btn btn-info" id="btnResumeDrill" onclick="resumeDrill()" style="display:none;"><i class="fas fa-play me-1"></i>재개</button>
            <button class="btn btn-danger" id="btnEndDrill" onclick="endDrill()" style="display:none;"><i class="fas fa-stop me-1"></i>훈련종료</button>
            <button class="btn btn-primary" id="btnRestartDrill" onclick="restartDrill()" style="display:none;"><i class="fas fa-redo me-1"></i>다시시작</button>
            <a href="/dr/drill" class="btn btn-outline-light"><i class="fas fa-tasks me-1"></i>상황판</a>
        </div>
    </div>
    
    <div class="main-container">
        <div class="map-section" id="mapSection">
            <div class="map-title">
                <i class="fas fa-map-marker-alt me-2"></i>센터 위치
                <button class="btn btn-sm btn-outline-light ms-3" onclick="toggleMapFullscreen()" id="btnMapFullscreen">
                    <i class="fas fa-expand"></i>
                </button>
            </div>
            <div id="map"></div>
        </div>
        
        <div class="right-panel">
            <div class="time-card">
                <div class="time-label">현재시간</div>
                <div class="time-value" id="currentTime">00:00:00</div>
            </div>
            <div class="rto-card" id="rtoCard">
                <div class="rto-label">RTO 잔여시간</div>
                <div class="rto-display">
                    <div class="rto-unit"><div class="rto-num" id="rtoHours">00</div><div class="rto-unit-label">HOURS</div></div>
                    <div class="rto-unit"><div class="rto-num" id="rtoMinutes">00</div><div class="rto-unit-label">MINUTES</div></div>
                    <div class="rto-unit"><div class="rto-num" id="rtoSeconds">00</div><div class="rto-unit-label">SECONDS</div></div>
                </div>
            </div>
            <div class="drill-info">
                <h6><i class="fas fa-info-circle"></i> 훈련 정보</h6>
                <p><strong>훈련명:</strong> <span id="drillName">-</span></p>
                <p><strong>훈련일:</strong> <span id="drillDate">-</span></p>
                <p><strong>상태:</strong> <span id="drillStatus" class="badge-status badge-planned">대기</span></p>
                <p><strong>RTO 목표:</strong> <span id="rtoTarget">-</span></p>
            </div>
        </div>
        
        <div class="bottom-section">
            <div class="status-card">
                <div class="card-title"><i class="fas fa-history"></i> 복구 현황</div>
                <div class="timeline-container" id="timeline">
                    <div class="timeline-empty"><i class="fas fa-clock fa-2x mb-2"></i><p>훈련이 시작되지 않았습니다.</p></div>
                </div>
            </div>
            <div class="status-card">
                <div class="card-title"><i class="fas fa-server"></i> 시스템복구(업무기동)</div>
                <div class="chart-container">
                    <!-- [수정] SVG 크기 400x400, 반지름 160, circumference 1005 -->
                    <div class="donut-chart">
                        <svg width="400" height="400" viewBox="0 0 400 400">
                            <circle class="donut-bg" cx="200" cy="200" r="160"/>
                            <circle class="donut-progress system" id="systemProgress" cx="200" cy="200" r="160" stroke-dasharray="1005" stroke-dashoffset="1005"/>
                        </svg>
                        <div class="donut-center">
                            <div class="donut-percent" id="systemPercent">0%</div>
                            <div class="donut-label" id="systemLabel">0/0</div>
                        </div>
                    </div>
                    <div class="chart-legend" id="systemLegend">시스템 복구 대기중</div>
                </div>
            </div>
            <div class="status-card">
                <div class="card-title"><i class="fas fa-clipboard-check"></i> 업무점검/확인</div>
                <div class="chart-container">
                    <!-- [수정] SVG 크기 400x400, 반지름 160, circumference 1005 -->
                    <div class="donut-chart">
                        <svg width="400" height="400" viewBox="0 0 400 400">
                            <circle class="donut-bg" cx="200" cy="200" r="160"/>
                            <circle class="donut-progress check" id="checkProgress" cx="200" cy="200" r="160" stroke-dasharray="1005" stroke-dashoffset="1005"/>
                        </svg>
                        <div class="donut-center">
                            <div class="donut-percent" id="checkPercent">0%</div>
                            <div class="donut-label" id="checkLabel">0/0</div>
                        </div>
                    </div>
                    <div class="chart-legend" id="checkLegend">업무 점검 대기중</div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        var currentDrillId = ${drillId != null ? drillId : 'null'};
        var drillData = null;
        var map = null;
        var markers = [];
        var rtoInterval = null;
        var rtoEndTime = null;
        
        $(document).ready(function() {
            startClock();
            initMap();
            loadDrillList();
            
            // [핵심] 훈련 선택 여부에 따라 전체/개별 센터 로드
            if (currentDrillId) {
                loadDashboardData();
            } else {
                loadAllCenters();
            }
            
            $('#drillSelector').on('change', function() {
                currentDrillId = $(this).val();
                if (currentDrillId) {
                    loadDashboardData();
                } else {
                    clearDashboard();
                    loadAllCenters(); // 훈련 선택 해제 시 전체 센터 표시
                }
            });
            
            setInterval(function() { if (currentDrillId) loadDashboardData(); }, 30000);
        });

        function startClock() {
            function update() {
                var now = new Date();
                $('#currentTime').text(
                    String(now.getHours()).padStart(2,'0') + ':' +
                    String(now.getMinutes()).padStart(2,'0') + ':' +
                    String(now.getSeconds()).padStart(2,'0')
                );
            }
            update();
            setInterval(update, 1000);
        }
        
        // [수정] OpenStreetMap 타일 사용
        function initMap() {
            map = L.map('map').setView([36.35, 127.38], 7); // 대전 중심
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap'
            }).addTo(map);
        }
        
        // [기능 추가] 전체 센터 로드 (훈련과 무관하게)
        function loadAllCenters() {
            $.get('/dr/api/centers', function(res) {
                if (res.success && res.data) {
                    updateMapMarkers(res.data);
                }
            });
        }
        
        function loadDrillList() {
            $.get('/dr/api/drills', function(res) {
                if (res.success && res.data) {
                    var opts = '<option value="">훈련 선택</option>';
                    res.data.forEach(function(d) {
                        var sel = d.drillId == currentDrillId ? 'selected' : '';
                        opts += '<option value="'+d.drillId+'" '+sel+'>'+d.drillName+'</option>';
                    });
                    $('#drillSelector').html(opts);
                }
            });
        }
        
        function loadDashboardData() {
            if (!currentDrillId) return;
            
            // 훈련 정보
            $.get('/dr/api/drills/' + currentDrillId, function(res) {
                if (res.success && res.data) {
                    drillData = res.data;
                    $('#drillName').text(drillData.drillName);
                    $('#drillDate').text((drillData.drillDate||'').substring(0,10));
                    $('#rtoTarget').text((drillData.rtoHours||0) + '시간 ' + (drillData.rtoMinutes||0) + '분');
                    
                    var status = drillData.status || 'PLANNED';
                    var statusText = {PLANNED:'대기', PROGRESS:'진행중', PAUSED:'일시정지', COMPLETED:'완료'}[status] || '대기';
                    var statusClass = {PLANNED:'badge-planned', PROGRESS:'badge-progress', PAUSED:'badge-warning', COMPLETED:'badge-completed'}[status] || 'badge-planned';
                    $('#drillStatus').text(statusText).removeClass('badge-planned badge-progress badge-warning badge-completed').addClass(statusClass);
                    
                    updateDrillButtons(status);

                    if ((status === 'PROGRESS' || status === 'PAUSED') && drillData.startTime) {
                        var start = new Date(drillData.startTime);
                        rtoEndTime = new Date(start.getTime() + ((drillData.rtoHours||0)*60 + (drillData.rtoMinutes||0)) * 60 * 1000);
                        if (status === 'PROGRESS') { startRtoCountdown(); } 
                        else { stopRtoCountdown(); updateRtoDisplay(); }
                    } else { stopRtoCountdown(); }
                }
            });

            // [핵심] 훈련별 센터만 로드
            $.get('/dr/api/drills/' + currentDrillId + '/centers', function(res) {
                if (res.success && res.data) {
                    updateMapMarkers(res.data);
                } else {
                    // 데이터가 없으면 마커 삭제
                    markers.forEach(function(m) { map.removeLayer(m); });
                    markers = [];
                }
            });

            // 타임라인 및 차트 데이터 로드 (기존과 동일)
            $.get('/dr/api/drills/' + currentDrillId + '/timeline', function(res) {
                if (res.success && res.data && res.data.length > 0) { updateTimeline(res.data); } 
                else {
                    $.get('/dr/api/drills/' + currentDrillId + '/tasks', function(taskRes) {
                        if (taskRes.success && taskRes.data) updateTimelineFromTasks(taskRes.data);
                    });
                }
            });
            $.get('/dr/api/drills/' + currentDrillId + '/recovery-systems', function(res) {
                if (res.success) {
                    var data = res.data || [];
                    var total = data.length;
                    var completed = data.filter(function(s) { return s.status === 'COMPLETED'; }).length;
                    updateDonutChart('system', completed, total);
                }
            });
            $.get('/dr/api/drills/' + currentDrillId + '/business-checks', function(res) {
                if (res.success) {
                    var data = res.data || [];
                    var total = data.length;
                    var completed = data.filter(function(c) { return c.status === 'PASS' || c.status === 'COMPLETED'; }).length;
                    updateDonutChart('check', completed, total);
                }
            });
        }
        
        function updateMapMarkers(centers) {
            markers.forEach(function(m) { map.removeLayer(m); });
            markers = [];
            if (!centers || centers.length === 0) return;
            
            var bounds = [];
            centers.forEach(function(c) {
                if (c.latitude && c.longitude) {
                    var isDr = (c.centerType === 'DR' || c.centerType === 'BACKUP');
                    var pinClass = isDr ? 'marker-pin dr-center' : 'marker-pin';
                    
                    var icon = L.divIcon({
                        className: 'custom-marker',
                        html: '<div class="'+pinClass+'"></div><div class="marker-label">'+c.centerName+'</div>',
                        iconSize: [30, 42],
                        iconAnchor: [15, 42]
                    });
                    
                    var marker = L.marker([c.latitude, c.longitude], {icon: icon}).addTo(map);
                    
                    var popupContent = '<b>'+c.centerName+'</b><br>';
                    popupContent += '<span class="badge '+(isDr?'bg-info':'bg-warning')+' text-dark">'+(c.centerType||'센터')+'</span><br>';
                    popupContent += (c.addr || '주소 정보 없음');
                    
                    marker.bindPopup(popupContent);
                    markers.push(marker);
                    bounds.push([c.latitude, c.longitude]);
                }
            });
            
            if (bounds.length > 0) { 
                map.fitBounds(bounds, {padding: [50, 50], maxZoom: 10}); 
            }
        }
        
        function updateTimeline(events) {
            var html = '';
            events.forEach(function(e) {
                var time = e.eventTime ? new Date(e.eventTime).toLocaleTimeString('ko-KR', {hour:'2-digit', minute:'2-digit'}) : '';
                html += '<div class="timeline-item"><div class="timeline-dot completed"></div><div class="timeline-content"><div class="timeline-time">'+time+'</div><div class="timeline-title">'+e.eventTitle+'</div></div></div>';
            });
            $('#timeline').html(html || '<div class="timeline-empty"><i class="fas fa-clock fa-2x mb-2"></i><p>이벤트가 없습니다.</p></div>');
        }
        
        function updateTimelineFromTasks(tasks) {
            var html = '';
            tasks.forEach(function(t) {
                var dotClass = t.status === 'COMPLETED' ? 'completed' : (t.status === 'PROGRESS' ? 'progress' : 'waiting');
                var time = t.actualStartTime ? new Date(t.actualStartTime).toLocaleTimeString('ko-KR', {hour:'2-digit', minute:'2-digit'}) : '--:--';
                html += '<div class="timeline-item"><div class="timeline-dot '+dotClass+'"></div><div class="timeline-content"><div class="timeline-time">'+time+'</div><div class="timeline-title">'+t.taskName+'</div></div></div>';
            });
            $('#timeline').html(html || '<div class="timeline-empty"><i class="fas fa-clock fa-2x mb-2"></i><p>훈련이 시작되지 않았습니다.</p></div>');
        }
        
        /* ========================================
           [수정] circumference = 2 × π × 160 ≈ 1005
           ======================================== */
        function updateDonutChart(type, completed, total) {
            var percent = total > 0 ? Math.round(completed / total * 100) : 0;
            var circumference = 1005;  // 2 * 3.14159 * 160
            var offset = circumference - (percent / 100 * circumference);
            $('#' + type + 'Progress').css('stroke-dashoffset', offset);
            $('#' + type + 'Percent').text(percent + '%');
            $('#' + type + 'Label').text(completed + '/' + total);
            $('#' + type + 'Legend').text(completed + '개 완료 / 총 ' + total + '개');
        }
        
        function startRtoCountdown() { stopRtoCountdown(); updateRtoDisplay(); rtoInterval = setInterval(updateRtoDisplay, 1000); }
        function stopRtoCountdown() { if (rtoInterval) { clearInterval(rtoInterval); rtoInterval = null; } }
        function updateRtoDisplay() {
            if (!rtoEndTime) { $('#rtoHours, #rtoMinutes, #rtoSeconds').text('00'); return; }
            var now = new Date(); var diff = rtoEndTime - now;
            if (diff <= 0) { $('#rtoCard').addClass('exceeded'); diff = Math.abs(diff); } else { $('#rtoCard').removeClass('exceeded'); }
            var hours = Math.floor(diff / 3600000); var minutes = Math.floor((diff % 3600000) / 60000); var seconds = Math.floor((diff % 60000) / 1000);
            $('#rtoHours').text(String(hours).padStart(2, '0')); $('#rtoMinutes').text(String(minutes).padStart(2, '0')); $('#rtoSeconds').text(String(seconds).padStart(2, '0'));
        }
        
        function startDrill() {
            if (!currentDrillId) { Swal.fire('알림', '훈련을 선택해주세요.', 'warning'); return; }
            Swal.fire({ title: '훈련 시작', text: '훈련을 시작하시겠습니까?', icon: 'question', showCancelButton: true, confirmButtonText: '시작', cancelButtonText: '취소' }).then(function(result) {
                if (result.isConfirmed) { $.post('/dr/api/drills/' + currentDrillId + '/start', function(res) { if (res.success) { Swal.fire('완료', '훈련이 시작되었습니다.', 'success'); loadDashboardData(); updateDrillButtons('PROGRESS'); } else { Swal.fire('오류', res.message || '시작에 실패했습니다.', 'error'); } }); }
            });
        }
        function pauseDrill() {
            if (!currentDrillId) return;
            Swal.fire({ title: '훈련 일시정지', text: '훈련을 일시정지 하시겠습니까?', icon: 'question', showCancelButton: true, confirmButtonText: '일시정지', cancelButtonText: '취소' }).then(function(result) {
                if (result.isConfirmed) { $.post('/dr/api/drills/' + currentDrillId + '/pause', function(res) { if (res.success) { Swal.fire('완료', '훈련이 일시정지되었습니다.', 'success'); loadDashboardData(); updateDrillButtons('PAUSED'); } else { Swal.fire('오류', res.message || '일시정지에 실패했습니다.', 'error'); } }); }
            });
        }
        function resumeDrill() { if (!currentDrillId) return; $.post('/dr/api/drills/' + currentDrillId + '/resume', function(res) { if (res.success) { Swal.fire('완료', '훈련이 재개되었습니다.', 'success'); loadDashboardData(); updateDrillButtons('PROGRESS'); } else { Swal.fire('오류', res.message || '재개에 실패했습니다.', 'error'); } }); }
        function endDrill() {
            if (!currentDrillId) return;
            Swal.fire({ title: '훈련 종료', text: '훈련을 종료하시겠습니까?', icon: 'warning', showCancelButton: true, confirmButtonText: '종료', cancelButtonText: '취소' }).then(function(result) {
                if (result.isConfirmed) { $.post('/dr/api/drills/' + currentDrillId + '/end', function(res) { if (res.success) { Swal.fire('완료', '훈련이 종료되었습니다.', 'success'); loadDashboardData(); updateDrillButtons('COMPLETED'); } else { Swal.fire('오류', res.message || '종료에 실패했습니다.', 'error'); } }); }
            });
        }
        function restartDrill() {
            if (!currentDrillId) return;
            Swal.fire({ title: '훈련 다시 시작', text: '이전 훈련 기록을 유지하고 다시 시작하시겠습니까?', icon: 'question', showCancelButton: true, confirmButtonText: '다시 시작', cancelButtonText: '취소' }).then(function(result) {
                if (result.isConfirmed) { $.post('/dr/api/drills/' + currentDrillId + '/restart', function(res) { if (res.success) { Swal.fire('완료', '훈련이 다시 시작되었습니다.', 'success'); loadDashboardData(); updateDrillButtons('PROGRESS'); } else { Swal.fire('오류', res.message || '다시 시작에 실패했습니다.', 'error'); } }); }
            });
        }
        function updateDrillButtons(status) {
            $('#btnStartDrill, #btnPauseDrill, #btnResumeDrill, #btnEndDrill, #btnRestartDrill').hide();
            switch(status) { case 'PLANNED': $('#btnStartDrill').show(); break; case 'PROGRESS': $('#btnPauseDrill, #btnEndDrill').show(); break; case 'PAUSED': $('#btnResumeDrill, #btnEndDrill').show(); break; case 'COMPLETED': $('#btnRestartDrill').show(); break; }
        }
        function toggleMapFullscreen() {
            var mapSection = document.getElementById('mapSection'); var btn = document.getElementById('btnMapFullscreen');
            if (mapSection.classList.contains('fullscreen')) { mapSection.classList.remove('fullscreen'); btn.innerHTML = '<i class="fas fa-expand"></i>'; } else { mapSection.classList.add('fullscreen'); btn.innerHTML = '<i class="fas fa-compress"></i>'; }
            setTimeout(function() { if (map) map.invalidateSize(); }, 300);
        }
        document.addEventListener('keydown', function(e) { if (e.key === 'Escape') { var mapSection = document.getElementById('mapSection'); if (mapSection.classList.contains('fullscreen')) { toggleMapFullscreen(); } } });
        
        function clearDashboard() {
            drillData = null; stopRtoCountdown();
            $('#drillName, #drillDate, #rtoTarget').text('-');
            $('#drillStatus').text('대기').removeClass('badge-progress badge-completed').addClass('badge-planned');
            $('#rtoHours, #rtoMinutes, #rtoSeconds').text('00');
            $('#timeline').html('<div class="timeline-empty"><i class="fas fa-clock fa-2x mb-2"></i><p>훈련을 선택해주세요.</p></div>');
            updateDonutChart('system', 0, 0); updateDonutChart('check', 0, 0);
            
            // [중요] 훈련 선택이 해제되면 전체 센터 다시 표시
            loadAllCenters();
        }
    </script>
</body>
</html>
