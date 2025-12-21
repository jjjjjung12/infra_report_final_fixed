<!-- ========================================
자산관리 자원이력, 담당자 팝업
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 자원이력 팝업 -->
<div class="modal fade" id="historyModal"  tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-history me-2"></i>자원이력정보
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">내용</label>
                    <textarea id="historyContent" name="historyContent" class="form-control" rows="4" placeholder="내용을 입력하세요"></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">비고</label>
                    <input type="text" id="historyNote" name="historyNote" class="form-control" placeholder="비고" maxlength="255">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="addHistoryRow()">저장</button>
            </div>
        </div>
    </div>
</div>

<!-- 담당자 팝업 -->
<div class="modal fade" id="managerModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-user me-2"></i>담당자관리
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="modal-body">
	                <div class="row g-2">
	                    <div class="col-md-6">
	                        <label class="form-label">이름</label>
	                        <input id="managerName" name="managerName" type="text" class="form-control" maxlength="50">
	                    </div>
	                    <div class="col-md-6">
	                        <label class="form-label">전화번호</label>
	                        <input id="managerPhone" name="managerPhone" type="text" class="form-control" maxlength="50">
	                    </div>
	                    <div class="col-md-6">
	                        <label class="form-label">핸드폰번호</label>
	                        <input id="managerMobile" name="managerMobile" type="text" class="form-control" maxlength="50">
	                    </div>
	                    <div class="col-md-6">
	                        <label class="form-label">이메일</label>
	                        <input id="managerEmail" name="managerEmail" type="email" class="form-control" maxlength="50">
	                    </div>
	                </div>
	            </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="addManagerRow()">저장</button>
            </div>
        </div>
    </div>
</div>

<script>

let histories = [];
let managers = [];

//자원이력 초기화
const historyModalEl = document.getElementById('historyModal');
historyModalEl.addEventListener('show.bs.modal', function (event) {
    // 모든 input, textarea 초기화
    const inputs = historyModalEl.querySelectorAll('input, textarea, select');
    inputs.forEach(input => {
        if(input.type === 'checkbox' || input.type === 'radio') {
            input.checked = false;
        } else {
            input.value = '';
        }
    });
});

//담당자관리 초기화
const managerModalEl = document.getElementById('managerModal');
managerModalEl.addEventListener('show.bs.modal', function (event) {
    const inputs = managerModalEl.querySelectorAll('input, textarea, select');
    inputs.forEach(input => {
        if(input.type === 'checkbox' || input.type === 'radio') {
            input.checked = false;
        } else {
            input.value = '';
        }
    });
});

//자원이력정보 테이블 등록
function addHistoryRow() {

    const content = document.getElementById('historyContent').value.trim();
    const remark  = document.getElementById('historyNote').value.trim();

    if (!content) return alert('내용을 입력하세요');
    
    histories.push({
    	"content":content,
    	"remark":remark
    });

    const tableBody = document.querySelector('#historyTable tbody');

    const noDataRow = tableBody.querySelector('.no-data');
    if (noDataRow) noDataRow.remove();

    const tr = document.createElement('tr');
    tr.dataset.index = histories.length - 1;
	
    //내용
    const tdContent = document.createElement('td');
    tdContent.textContent = content;

    //비고
    const tdRemark = document.createElement('td');
    tdRemark.textContent = remark;

    //삭제 버튼
    const tdDel = document.createElement('td');
    const btnDel = document.createElement('button');
    btnDel.type = 'button';
    btnDel.className = 'btn btn-sm btn-danger';
    btnDel.textContent = '삭제';
    btnDel.onclick = function() {
        const tr = this.closest('tr');
        const index = parseInt(tr.dataset.index, 10);

        // 배열에서 삭제
        histories.splice(index, 1);

        // tr 삭제
        tr.remove();

        // index 재정렬
        document.querySelectorAll('#historyTable tbody tr').forEach((row, i) => {
            row.dataset.index = i;
        });

        // 데이터 없으면 no-data 표시
        if(histories.length === 0){
            const tbody = document.querySelector('#historyTable tbody');
            tbody.innerHTML = `<tr class="no-data"><td colspan="3" class="text-center text-muted">데이터가 없습니다</td></tr>`;
            
            histories = [];
        }
    };
    tdDel.appendChild(btnDel);

    tr.appendChild(tdContent);
    tr.appendChild(tdRemark);
    tr.appendChild(tdDel);

    tableBody.appendChild(tr);

    // 모달 닫기
    bootstrap.Modal.getInstance(
        document.getElementById('historyModal')
    ).hide();

    // 입력 초기화
    document.getElementById('historyContent').value = '';
    document.getElementById('historyNote').value = '';
}

//담당자 정보 테이블 등록
function addManagerRow() {

    const name   = document.getElementById('managerName').value.trim();
    const phone  = document.getElementById('managerPhone').value.trim();
    const mobile = document.getElementById('managerMobile').value.trim();
    const email  = document.getElementById('managerEmail').value.trim();

    if (!name) return alert('이름을 입력하세요');
    if (!mobile) return alert('휴대폰번호를 입력하세요');
    if (!email) return alert('이메일을 입력하세요');

    managers.push({
        "name":name,
        "phone":phone,
        "mobile":mobile,
        "email":email
    });

    const tableBody = document.querySelector('#managerTable tbody');
    const noDataRow = tableBody.querySelector('.no-data');
    if (noDataRow) noDataRow.remove();

    const tr = document.createElement('tr');
    tr.dataset.index = managers.length - 1;
    
    // 이름
    const tdName = document.createElement('td');
    tdName.textContent = name;

    // 전화번호
    const tdPhone = document.createElement('td');
    tdPhone.textContent = phone;

    // 핸드폰번호
    const tdMobile = document.createElement('td');
    tdMobile.textContent = mobile;

    // 이메일
    const tdEmail = document.createElement('td');
    tdEmail.textContent = email;

    // 삭제 버튼
    const tdDel = document.createElement('td');
    const btnDel = document.createElement('button');
    btnDel.type = 'button';
    btnDel.className = 'btn btn-sm btn-danger';
    btnDel.textContent = '삭제';
    btnDel.onclick = function() {
        const tr = this.closest('tr');
        const index = parseInt(tr.dataset.index, 10);

        managers.splice(index, 1);
        tr.remove();

        document.querySelectorAll('#managerTable tbody tr').forEach((row, i) => {
            row.dataset.index = i;
        });

        if(managers.length === 0){
            document.querySelector('#managerTable tbody').innerHTML = `<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>`;
            
            managers = [];
        }
    };
    tdDel.appendChild(btnDel);

    // tr에 td 추가
    tr.appendChild(tdName);
    tr.appendChild(tdPhone);
    tr.appendChild(tdMobile);
    tr.appendChild(tdEmail);
    tr.appendChild(tdDel);

    tableBody.appendChild(tr);

 	// 모달 닫기
    bootstrap.Modal.getInstance(
        document.getElementById('managerModal')
    ).hide();

 	// 입력 초기화
    document.getElementById('managerName').value = '';
    document.getElementById('managerPhone').value = '';
    document.getElementById('managerMobile').value = '';
    document.getElementById('managerEmail').value = '';
    
}

</script>