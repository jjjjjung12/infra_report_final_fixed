//빈값 체크
function isNull(value) {
	if(value != null && value != '' && value != undefined && value != "undefined") {
		return false;
	} else {
		return true;
	}
}

//yyyy-mm-dd hh:mm 형식 반환
function formatDate(dateStr) {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    if (isNaN(date)) return dateStr;
    const yyyy = date.getFullYear();
    const mm = String(date.getMonth() + 1).padStart(2, '0');
    const dd = String(date.getDate()).padStart(2, '0');
    const hh = String(date.getHours()).padStart(2, '0');
    const min = String(date.getMinutes()).padStart(2, '0');
    return `${yyyy}-${mm}-${dd} ${hh}:${min}`;
}

// 테이블 정렬 함수
function sortTable(tableId, column) {
    const table = document.getElementById(tableId);
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const th = table.querySelectorAll('th')[column];
    
    // 현재 정렬 상태 확인
    const currentSort = th.classList.contains('sort-asc') ? 'asc' : 
                       th.classList.contains('sort-desc') ? 'desc' : 'none';
    
    // 모든 헤더에서 정렬 클래스 제거
    table.querySelectorAll('th').forEach(header => {
        header.classList.remove('sort-asc', 'sort-desc');
    });
    
    // 새로운 정렬 방향 결정
    let sortDirection;
    if (currentSort === 'none' || currentSort === 'desc') {
        sortDirection = 'asc';
        th.classList.add('sort-asc');
    } else {
        sortDirection = 'desc';
        th.classList.add('sort-desc');
    }
    
    // 행 정렬
    rows.sort((a, b) => {
        const aValue = a.cells[column].textContent.trim();
        const bValue = b.cells[column].textContent.trim();
        
        // 숫자인지 확인
        const aNum = parseFloat(aValue.replace(/[^0-9.-]/g, ''));
        const bNum = parseFloat(bValue.replace(/[^0-9.-]/g, ''));
        
        let comparison;
        if (!isNaN(aNum) && !isNaN(bNum)) {
            comparison = aNum - bNum;
        } else {
            comparison = aValue.localeCompare(bValue, 'ko-KR');
        }
        
        return sortDirection === 'asc' ? comparison : -comparison;
    });
    
    // 정렬된 행을 다시 추가
    rows.forEach(row => tbody.appendChild(row));
}

// 엑셀 업로드 공통 함수
function uploadExcel(input) {
    const file = input.files[0];
    if (file) {
        const type = input.getAttribute('data-type') || 'resource';
        const uploadExcelFormData = new FormData();
        uploadExcelFormData.append('excelFile', file);
        uploadExcelFormData.append('action', 'uploadExcel');
        uploadExcelFormData.append('uploadType', type);
//        uploadExcelFormData.append('date', '${reportDate}');
		
        fetch('/report/uploadExcel', {
            method: 'POST',
            body: uploadExcelFormData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('업로드 완료');
//                location.reload();
				reloadCurrentTab();
            } else {
                alert(data.message || '업로드 실패');
            }
        });
    }
}

//데이터 엑셀 내보내기
function exportAll() {
	
	const exportExcelForm = $('<form>', {
	        method: 'POST',
	        action: '/report/exportExcel'
	    });

	const searchExportExcelData = {
		  "startReportDate" : $("#startReportDate").val()					/* 시작 날짜	*/
		, "endReportDate" : $("#endReportDate").val()                       /* 종료 날짜	*/
		, "searchField" : $('#searchField option:selected').val()   		/* 검색 필드	*/
		, "searchKeyword" : $("#searchKeyword").val()               		/* 검색어		*/
		, "sortField" : $('#sortField option:selected').val()               /* 정렬 기준	*/
		, "sortOrder" : $('#sortOrder option:selected').val()               /* 순서		*/
		, "reportAction" : $("#action").val()								/* 페이지 구분 */
	};

    Object.entries(searchExportExcelData).forEach(([key, value]) => {
        exportExcelForm.append($('<input>', {type: 'hidden', name: key, value: value}));
    });

    $('body').append(exportExcelForm);
    exportExcelForm.submit();
    exportExcelForm.remove();
}

//내보내기 웹
function exportAll_bak() {
	const reportAction = $("#action").val();
// 현재 테이블 가져오기
    const table = document.getElementById(reportAction+"Table");
    if (!table) {
        alert("테이블을 찾을 수 없습니다.");
        return;
    }

    // 테이블 복사본 생성
    const tableClone = table.cloneNode(true);

    // 버튼 컬럼 제거 (상세, 삭제)
    for (let row of tableClone.rows) {
		if(reportAction == 'resource') {
            row.deleteCell(-1);
        } else {
			row.deleteCell(-1);
			row.deleteCell(-1);
		}
    }

    // 테이블 HTML 문자열 생성
    const tableHTML = `
        <html xmlns:x="urn:schemas-microsoft-com:office:excel">
        <head>
            <meta charset="UTF-8">
        </head>
        <body>
            ${tableClone.outerHTML}
        </body>
        </html>
    `;
	
	const exportNow = new Date();
    const datePart = exportNow.toISOString().slice(0, 10); // YYYY-MM-DD
    const timePart = exportNow
        .toTimeString()
        .split(' ')[0]
        .replace(/:/g, ''); // HHMMSS
	
	let exportFileNameKor = '';
	
	if(reportAction == 'daily') {
		exportFileNameKor = '업무목록';
	} else if (reportAction == 'resource') {
		exportFileNameKor = '자원사용현황';
	} else if (reportAction == 'hwsw') {
		exportFileNameKor = 'HW/SW점검결과';
	} else if (reportAction == 'security') {
		exportFileNameKor = '보안관제활동현황';
	} else if (reportAction == 'backup') {
		exportFileNameKor = '백업관리대장';
	}

    const exportFileName = exportFileNameKor+`_${datePart}_${timePart}.xls`;

    // Blob 생성 후 엑셀 파일로 다운로드
    const blob = new Blob([tableHTML], { type: "application/vnd.ms-excel" });
    const url = URL.createObjectURL(blob);

    const a = document.createElement("a");
    a.href = url;
    a.download = exportFileName;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}