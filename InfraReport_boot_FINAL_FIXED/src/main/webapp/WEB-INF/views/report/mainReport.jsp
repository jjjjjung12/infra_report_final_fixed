<!-- ========================================
메인 페이지 (탭 별 페이지 분할)
- 업무유형별 현황 (workType.jsp)
- 자원사용 현황 (resource.jsp)
- HW/SW 점검 결과 (hwsw.jsp)
- 보안관제 현황 (security.jsp)
- 백업 관리 (backup.jsp)
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container">
	<!-- 탭 메뉴 -->
	<ul class="nav nav-tabs" id="mainTab" role="tablist">
		<li class="nav-item">
			<button class="nav-link active" data-bs-toggle="tab" data-bs-target="#workType">
				<i class="fas fa-tasks"></i>업무유형별 현황
			</button>
		</li>
		<li class="nav-item">
			<button class="nav-link" data-bs-toggle="tab" data-bs-target="#resource">
				<i class="fas fa-chart-area"></i>자원사용 현황
			</button>
		</li>
		<li class="nav-item">
			<button class="nav-link" data-bs-toggle="tab" data-bs-target="#hwsw">
				<i class="fas fa-server"></i>HW/SW 점검 결과
			</button>
		</li>
		<li class="nav-item">
			<button class="nav-link" data-bs-toggle="tab" data-bs-target="#security">
				<i class="fas fa-shield-alt"></i>보안관제 현황
			</button>
		</li>
		<li class="nav-item">
			<button class="nav-link" data-bs-toggle="tab" data-bs-target="#backup">
				<i class="fas fa-database"></i>백업 관리
			</button>
		</li>
	</ul>
	
	<!-- 탭 컨텐츠 -->
    <div class="tab-content">
    	<!-- 업무유형별 현황 탭 -->
        <div class="tab-pane fade show active" id="workType"></div>
        <div class="tab-pane fade" id="resource"></div>
        <div class="tab-pane fade" id="hwsw"></div>
        <div class="tab-pane fade" id="security"></div>
        <div class="tab-pane fade" id="backup"></div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {

    // 초기 로드: 첫 번째 탭
    const firstBtn = document.querySelector('#mainTab button[data-bs-target="#workType"]');
    if (firstBtn) loadTabContent('workType', '/workType/main', firstBtn);

    // 탭 클릭 시 동적 페이지 로딩
    document.querySelectorAll('#mainTab button[data-bs-target]').forEach(btn => {
        btn.addEventListener('click', function() {
            const tabSelector = this.dataset.bsTarget;
            const tabId = tabSelector.replace('#', '');
            loadTabContent(tabId, '/'+tabId+'/main', this);
        });
    });
    
});

//탭 별 페이지 로드
function loadTabContent(tabId, url, clickedBtn) {
    const tab = document.getElementById(tabId);
    
    //클릭한 탭 버튼 활성화
    document.querySelectorAll('#mainTab .nav-link').forEach(btn => {
        btn.classList.remove('active');
    });
    if (clickedBtn) clickedBtn.classList.add('active');
    
 	// 다른 탭 컨텐츠 초기화
    document.querySelectorAll('.tab-pane').forEach(pane => {
        if (pane.id !== tabId) {
            pane.innerHTML = "";           // 내용 제거
            delete pane.dataset.loaded;    // 다시 로드 가능 상태로 초기화
            pane.classList.remove('show', 'active');
        }
    });
 	
    tab.classList.add('show', 'active');
 
    if (!tab.dataset.loaded) {
        fetch(url)
            .then(response => response.text())
            .then(html => {
                tab.innerHTML = html;
                tab.dataset.loaded = "true";

                // 페이지 별 script 실행
                tab.querySelectorAll("script").forEach(oldScript => {
                    const newScript = document.createElement("script");
                    if (oldScript.src) {
                        // 외부 스크립트 파일일 경우
                        newScript.src = oldScript.src;
                    } else {
                        // 인라인 스크립트일 경우
                        newScript.textContent = oldScript.textContent;
                    }
                    document.body.appendChild(newScript);
                    document.body.removeChild(newScript);
                });
                
                //자원사용 현황일때 차트 초기화 수동 실행
                if (tabId === "resource" && typeof initResourceChart === "function") {
                	//자원 사용률 차트 변수
                	let resourceChart;	//resource.jsp에 선언 후 자원 사용 현황 페이지 재 실행 시 전역 변수 재선언으로 충돌
                    initResourceChart();
                }
            })
            .catch(err => {
                tab.innerHTML = '<div class="text-danger p-3">컨텐츠 로드 실패</div>';
                console.error(err);
            });
    }
}

// 등록수정삭제 후 현재 페이지로 초기화
function reloadCurrentTab() {
	
	//현재 포커스 제거
	if (document.activeElement) document.activeElement.blur();
	
	// 모든 모달 닫기
    document.querySelectorAll('.modal.show').forEach(modalEl => {
        const modalInstance = bootstrap.Modal.getInstance(modalEl);
        if (modalInstance) modalInstance.hide();
    });

    // 남아 있는 backdrop 제거
    document.querySelectorAll('.modal-backdrop').forEach(backdrop => backdrop.remove());
    document.body.classList.remove('modal-open'); // 스크롤 잠금 해제
    document.body.style = '';
    
    const activeBtn = document.querySelector('#mainTab .nav-link.active');
    if (!activeBtn) return;
    
    const tabId = activeBtn.dataset.bsTarget.replace('#', '');
    const url = '/' + tabId + '/main';
    const tab = document.getElementById(tabId);
    
    //현재 탭 초기화
    delete tab.dataset.loaded;

    // 해당 탭 내용 다시 불러오기
    loadTabContent(tabId, url, activeBtn);
}
</script>