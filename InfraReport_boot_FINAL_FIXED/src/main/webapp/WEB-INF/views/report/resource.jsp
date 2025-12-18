<!-- ========================================
자원사용 현황
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 자원 사용률 그래프 카드 -->
<div class="card mb-4">
	<div class="card-header d-flex justify-content-between align-items-center">
		<h5 class="mb-0">서버별 자원 사용률 그래프</h5>
		<div class="btn-group" role="group">
			<button class="btn btn-sm btn-outline-primary" onclick="showChart('cpu')">CPU</button>
			<button class="btn btn-sm btn-outline-primary" onclick="showChart('memory')">메모리</button>
			<button class="btn btn-sm btn-outline-primary" onclick="showChart('disk')">디스크</button>
			<button class="btn btn-sm btn-primary" onclick="showChart('all')">전체</button>
		</div>
	</div>
	<div class="card-body">
		<div class="chart-container">
			<canvas id="resourceChart"></canvas>
		</div>
	</div>
</div>

<!-- 엑셀 업로드 영역 -->
<div class="card mb-4">
	<div class="card-body">
		<div class="upload-area" onclick="document.getElementById('excelFile').click()">
			<i class="fas fa-file-excel fa-3x mb-3 text-success"></i>
			<h5>엑셀 파일을 선택하거나 드래그하세요</h5>
			<p class="text-muted">지원 형식: .xlsx, .xls</p>
			<input type="file" id="excelFile" data-type="resource" accept=".xlsx,.xls" style="display: none;" onchange="uploadExcel(this)">
		</div>
	</div>
</div>

<!-- 검색 폼 (자원사용 현황) - 가로 배치 -->
<div class="search-form">
<!-- 	<form action="report" method="get"> -->
		<input type="hidden" name="action" id="action" value="resource">
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
					<option value="RESOURCE_TYPE">자원유형</option>
					<option value="STATUS">상태</option>
					<option value="CREATED_BY">등록자</option>
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
					<option value="SERVER_NAME">서버명</option>
					<option value="USAGE_PERCENT">사용률</option>
					<option value="STATUS">상태</option>
					<option value="MONITORING_TIME">모니터링 시간</option>
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
				<button type="submit" class="btn btn-primary btn-sm w-100" onclick="searchResourceList();">
					<i class="fas fa-search"></i> 검색
				</button>
			</div>
		</div>
<!-- 	</form> -->
</div>

<!-- 서버별 자원 사용 현황 테이블 -->
<div class="card">
	<div class="card-header">
		<h5 class="mb-0">서버별 자원 사용 현황</h5>
	</div>
	<div class="card-body p-0">
		<table class="table mb-0" id="resourceTable">
			<thead>
				<tr>
					<th onclick="sortTable('resourceTable', 0)">서버명 <span class="sort-icon"></span></th>
					<th onclick="sortTable('resourceTable', 1)">자원유형 <span class="sort-icon"></span></th>
					<th onclick="sortTable('resourceTable', 2)">사용률 <span class="sort-icon"></span></th>
					<th onclick="sortTable('resourceTable', 3)">모니터링 시간 <span class="sort-icon"></span></th>
					<th onclick="sortTable('resourceTable', 4)">상태 <span class="sort-icon"></span></th>
					<th onclick="sortTable('resourceTable', 5)">등록일시 <span class="sort-icon"></span></th>
					<th onclick="sortTable('resourceTable', 6)">등록자 <span class="sort-icon"></span></th>
					<th>사용률 그래프</th>
				</tr>
			</thead>
			<tbody id="resourceTableBody">
				<c:forEach var="res" items="${resourceUsage}">
					<tr>
						<td>${res.serverName}</td>
						<td>${res.resourceType}</td>
						<td><strong>${res.usagePercent}%</strong></td>
						<td>${res.monitoringTime != null ? res.monitoringTime : '00:00'}</td>
						<td><span class="badge ${res.resourceStatusClass}">${res.resourceStatus}</span></td>
						<td><fmt:formatDate value="${res.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>${res.createdBy}</td>
						<td>
							<div class="usage-progress progress">
								<div class="progress-bar 
	                                <c:choose>
	                                    <c:when test="${res.usagePercent >= 90}">bg-danger</c:when>
	                                    <c:when test="${res.usagePercent >= 75}">bg-warning</c:when>
	                                    <c:otherwise>bg-success</c:otherwise>
	                                </c:choose>"
									style="width: ${res.usagePercent}%">
								</div>
							</div>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty resourceUsage}">
					<tr>
						<td colspan="8" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>

<script>

// 페이지 로드시 차트 초기화
// document.addEventListener('DOMContentLoaded', function() {
//     initResourceChart();
// });

// 자원 사용률 차트 초기화
function initResourceChart() {
    const ctx = document.getElementById('resourceChart').getContext('2d');
    
    // 서버별 데이터 준비
    const resourceData = [
        <c:forEach var="res" items="${resourceSummary}">
        {
            server: '${res.serverName}',
            cpu: ${res.cpuUsage},
            memory: ${res.memoryUsage}, 
            disk: ${res.diskUsage}
        },
        </c:forEach>
    ];

    const labels = resourceData.map(item => item.server);
    
    resourceChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'CPU (%)',
                data: resourceData.map(item => item.cpu),
                backgroundColor: 'rgba(54, 162, 235, 0.8)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }, {
                label: 'Memory (%)',
                data: resourceData.map(item => item.memory),
                backgroundColor: 'rgba(255, 99, 132, 0.8)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1
            }, {
                label: 'Disk (%)',
                data: resourceData.map(item => item.disk),
                backgroundColor: 'rgba(255, 205, 86, 0.8)',
                borderColor: 'rgba(255, 205, 86, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '서버별 자원 사용률'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    ticks: {
                        callback: function(value) {
                            return value + '%';
                        }
                    }
                }
            }
        }
    });
}

// 차트 유형 변경 함수
function showChart(type) {
    if (!resourceChart) return;
    
    const resourceData = [
        <c:forEach var="res" items="${resourceSummary}">
        {
            server: '${res.serverName}',
            cpu: ${res.cpuUsage},
            memory: ${res.memoryUsage}, 
            disk: ${res.diskUsage}
        },
        </c:forEach>
    ];
    
    // 버튼 상태 업데이트
    document.querySelectorAll('.btn-group .btn').forEach(btn => {
        btn.classList.remove('btn-primary');
        btn.classList.add('btn-outline-primary');
    });
    event.target.classList.remove('btn-outline-primary');
    event.target.classList.add('btn-primary');
    
    // 데이터셋 업데이트
    if (type === 'all') {
        resourceChart.data.datasets = [{
            label: 'CPU (%)',
            data: resourceData.map(item => item.cpu),
            backgroundColor: 'rgba(54, 162, 235, 0.8)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }, {
            label: 'Memory (%)',
            data: resourceData.map(item => item.memory),
            backgroundColor: 'rgba(255, 99, 132, 0.8)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1
        }, {
            label: 'Disk (%)',
            data: resourceData.map(item => item.disk),
            backgroundColor: 'rgba(255, 205, 86, 0.8)',
            borderColor: 'rgba(255, 205, 86, 1)',
            borderWidth: 1
        }];
    } else {
        const configs = {
            cpu: { label: 'CPU (%)', color: 'rgba(54, 162, 235, 0.8)', data: resourceData.map(item => item.cpu) },
            memory: { label: 'Memory (%)', color: 'rgba(255, 99, 132, 0.8)', data: resourceData.map(item => item.memory) },
            disk: { label: 'Disk (%)', color: 'rgba(255, 205, 86, 0.8)', data: resourceData.map(item => item.disk) }
        };
        
        const config = configs[type];
        resourceChart.data.datasets = [{
            label: config.label,
            data: config.data,
            backgroundColor: config.color,
            borderColor: config.color.replace('0.8', '1'),
            borderWidth: 1
        }];
    }
    
    resourceChart.update();
}

//조건 별 검색
function searchResourceList() {
	
	const searchResourceListData = {
		  "startReportDate" : $("#startReportDate").val()					/* 시작 날짜	*/
		, "endReportDate" : $("#endReportDate").val()                       /* 종료 날짜	*/
		, "searchField" : $('#searchField option:selected').val()   		/* 검색 필드	*/
		, "searchKeyword" : $("#searchKeyword").val()               		/* 검색어		*/
		, "sortField" : $('#sortField option:selected').val()               /* 정렬 기준	*/
		, "sortOrder" : $('#sortOrder option:selected').val()               /* 순서		*/
	};
	
	$.ajax({
		type: "POST",
		url: "/resource/searchResourceList",
		data:searchResourceListData,
		success: function(result) {
			const resourceListResult = result;
			let resourceListHtml = "";
			
			$('#resourceTableBody').empty();
			
			if(!isNull(resourceListResult) && resourceListResult.length > 0) {
				
				resourceListResult.forEach(res => {
					resourceListHtml += `
						<tr>
							<td>\${res.serverName}</td>
							<td>\${res.resourceType}</td>
							<td><strong>\${res.usagePercent}%</strong></td>
							<td>\${res.monitoringTime != null ? res.monitoringTime : '00:00'}</td>
							<td><span class="badge \${res.resourceStatusClass}">\${res.resourceStatus}</span></td>
							<td>\${formatDate(res.createdDate)}</td>
							<td>\${res.createdBy}</td>
							<td>
								<div class="usage-progress progress">
									<div class="progress-bar 
		                                <c:choose>
		                                    <c:when test="\${res.usagePercent >= 90}">bg-danger</c:when>
		                                    <c:when test="${res.usagePercent >= 75}">bg-warning</c:when>
		                                    <c:otherwise>bg-success</c:otherwise>
		                                </c:choose>"
										style="width: \${res.usagePercent}%">
									</div>
								</div>
							</td>
						</tr>
					`;
				});
				
			} else {
				resourceListHtml += `
					<tr>
						<td colspan="8" class="text-center">조회된 데이터가 없습니다.</td>
					</tr>
				`;
			}
			
			$('#resourceTableBody').html(resourceListHtml);
		},
		error: function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

</script>