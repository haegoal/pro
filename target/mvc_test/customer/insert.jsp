<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>
    #memo.btn-warning, #memo2.btn-warning {
        color:red;
        border-style:solid;
        border-width: 1px;
        border-color: red;
    }
</style>
<div class="col">
    <div class="modal fade" id="modal_insert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">고객정보</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form class="row g-3" name="frm4">
                        <div class="col-md-6">
                            <label for="inputPhone" class="form-label">전화번호</label>
                            <input type="hidden" class="form-control" name="inputPhone2" id="inputPhone2"/>
                            <input class="form-control" name="inputPhone" oninput='isNumber(this); handleOnInput(this, 15);' autocomplete='off' id="inputPhone"/>
                        </div>
                        <div class="col-md-3">
                            <label for="inputName" class="form-label">성함</label>
                            <input type="hidden" class="form-control" name="cid"id="cid"/>
                            <input class="form-control" name="cname" oninput='handleOnInput(this, 15);' autocomplete='off' id="inputName" />
                        </div>
                        <div class="col-md-3">
                            <br>
                            <button class="btn btn-primary" id="uc">고객정보미확인</button>
                        </div>
                        <div class="col-md-6">
                            <label for="inputPhone2" class="form-label">연락처</label>
                            <input class="form-control" name="cphone2" oninput='isNumber(this); handleOnInput(this, 15);' autocomplete='off' id="inputPhone2"/>
                        </div>
                        &nbsp;
                        <div class="col-md-6">
                            <label for="inputAddress" class="form-label">도로명주소</label>
                            <input class="form-control" name="caddress1" oninput='isKor(this); handleOnInput(this, 15);' autocomplete='off' id="caddress1"/>

                        </div>
                        <div class="col">
                            <br>
                            <input class="btn btn-secondary" type="button" onclick="sample4_execDaumPostcode()" value="주소찾기"><br>
                        </div>
                        &nbsp;
                        <div class="col-md-6">
                            <label for="inputAddress" class="form-label">지번주소</label>
                            <input class="form-control" name="jibun" autocomplete='off' id="jibunAddress" readonly/>
                            <span id="guide" style="color:#999;display:none"></span>
                        </div>
                        &nbsp;
                        <div class="col-md-6">
                            <label for="inputAddress2" class="form-label">추가주소</label>
                            <input class="form-control" name="caddress2" oninput='handleOnInput(this, 15);' autocomplete='off' id="inputAddress2"/>
                        </div>
                        <div class="col-md-3">
                            <label for="inputAddress2" class="form-label">우편번호</label>
                            <input class="form-control" name="postcode" autocomplete='off' id="postcode" readonly/>
                        </div>
                        &nbsp;
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="commit">확인</button>
                    <button type="button" class="btn btn-secondary" id="clist">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div>
</div>
<script>

    $("#uc").on("click", function(e){
        e.preventDefault();
        const cphone = $(frm4.inputPhone).val();
        $("#modal_insert2").modal("show");
        $("#modal_insert").modal("hide");
        $(frm5.inputPhone).val(cphone);
        $(frm5.cname).val("고객정보미확인");
        $(frm5.cphone2).val("");
        $(frm5.caddress1).val("");
        $(frm5.caddress2).val("");
        $(frm5.jibun).val("");
        $(frm5.postcode).val("");
    })





    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("caddress1").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("caddress1").value = roadAddr + extraRoadAddr;
                } else {
                    document.getElementById("caddress1").value = roadAddr + '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }



</script>