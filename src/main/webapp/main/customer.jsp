<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<div class="col-6">
    <form name="frm3" class="card p-3">
        <div class="row">
            <div class="col-6 col-sm-6 col-md-6">
                <div class="input-group">
                    <button class="input-group-text" id="tlist">전화번호</button>
                    <input class="form-control" name="cphone" oninput='isNumber(this); handleOnInput(this, 20);' autocomplete='off'/>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <button><i class="bi bi-telephone-outbound-fill"></i></button>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-6 col-sm-6 col-md-6">
                <div class="input-group">
                    <span class="input-group-text">연락처</span>
                    <input class="form-control" name="cphone2" oninput='isNumber(this); handleOnInput(this, 20);' autocomplete='off'/>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-6 col-sm-6 col-md-6">
                <div class="input-group">
                    <span class="input-group-text">성함</span>
                    <input class="form-control" name="cname" readonly>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-9">
                <div class="input-group">
                    <span class="input-group-text">주소</span>
                    <input class="form-control" name="caddress1" readonly>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mt-1">
            <div class="col-10">
                <div class="input-group">
                    <input class="form-control" name="caddress2" readonly>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="modal fade" id="modal_customer" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">고객정보등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                없는 고객입니다. 등록하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="cus_insert">등록</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
<div>
    <jsp:include page="/customer/insert.jsp"/>
</div>
<div>
    <jsp:include page="/customer/insert2.jsp"/>
</div>
<div>
    <jsp:include page="/customer/list.jsp"/>
</div>

<script>

    $("#cus_insert").on("click", function(){
        $(frm3.cname).val("");
        $(frm3.caddress1).val("");
        $(frm3.caddress2).val("");
        $("#modal_customer").modal("hide");
        $("#modal_insert2").modal("show");
    })

    $(frm3).on("submit", function(e){
        e.preventDefault();
        const cphone = $(frm3.cphone).val();
        const cphone2 = $(frm3.cphone2).val();
        if(cphone==""){
            alert("숫자입력바람>");
        }else{
            $.ajax({
                type:"get",
                data:{cphone},
                url:"/customer/read",
                success:function(data){
                    console.log(data)
                        $.ajax({
                            type:"get",
                            dataType:"json",
                            url:"/customer/list.json",
                            data:{page, cphone:cphone},
                            success:function(data){
                                $("#modal_list").modal("show");
                                const temp = Handlebars.compile($("#temp_cus").html());
                                $("#div_cus").html(temp(data));
                            }
                        })
                },error:function (){
                    $("#modal_customer").modal("show");
                    $(frm5.inputPhone).val(cphone)
                    $(frm5.cphone2).val(cphone2)
                }
            })
        }
    })

    function isNumber(item){
        item.value=item.value.replace(/[^0-9]/g,'');
    }

    function handleOnInput(el, maxlength) {
        if(el.value.length > maxlength)  {
            el.value
                = el.value.substr(0, maxlength);
        }
    }

    function checkKor(str) {
        const regExp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
        if(regExp.test(str)){
            return true;
        }else{
            return false;
        }
    }
</script>