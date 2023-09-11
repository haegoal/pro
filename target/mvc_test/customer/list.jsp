<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="modal_list" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="div_cus"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="up_insert">등록</button>
            </div>
        </div>
    </div>
</div>


<script id="temp_cus" type="text/x-handlebars-template">
    <table class="table">
        <th scope="col" class="text-center">성함</th>
        <th scope="col">연락처</th>
        <th colspan="2">주소</th>
        <th colspan="2">추가주소</th>
        {{#each .}}
        <tr height="50px" style="cursor:pointer;" class="tr" cid="{{cid}}" cphone="{{cphone}}">
            <td class="text-center">{{cname}}</td>
            <td colspan="2">{{cphone}}</td>
            <td>{{caddress1}}</td>
            <td>{{caddress2}}</td>
        </tr>
        {{/each}}
    </table>
</script>


<script>

    $("#div_cus").on("click", ".tr", function(){
        $("#modal_list").modal("hide");
        const cid = $(this).attr("cid");
        $.ajax({
            type:"get",
            data:{cid:cid},
            url:"/customer/readCid",
            success:function(data){
                $("#modal_insert").modal("show");
                const obj = JSON.parse(data);
                $(frm4.cid).val(obj.cid);
                $(frm4.inputPhone2).val(obj.cphone);
                $(frm4.cname2).val(obj.cname);
                $(frm4.inputPhone).val(obj.cphone);
                $(frm4.cname).val(obj.cname);
                $(frm4.cphone2).val(obj.cphone2);
                $(frm4.postcode).val(obj.postcode);
                $(frm4.jibun).val(obj.jibun);
                $(frm4.caddress1).val(obj.caddress1);
                $(frm4.caddress2).val(obj.caddress2);
                $("#commit").on("click", function(){
                    const cphone = $(frm4.inputPhone).val();
                    const cphone2 = $(frm4.cphone2).val();
                    const cname = $(frm4.cname).val();
                    const caddress1 = $(frm4.caddress1).val();
                    const caddress2 = $(frm4.caddress2).val();
                    const jibun = $(frm4.jibun).val();
                    const postcode = $(frm4.postcode).val();
                    const cid = $(frm4.cid).val();
                    if(cphone==""){
                        $(frm4.inputPhone).focus();
                    }else if(cname==""){
                        $(frm4.cname).focus();
                    }else if(checkKor(cname)){
                        $(frm4.cname).focus();
                    }else{
                        $.ajax({
                            type:"post",
                            url:"/customer/update",
                            data:{cphone, cname, caddress1, caddress2, cphone2, jibun, postcode, cid:cid},
                            success:function(){
                                $(frm3.cphone).val(cphone);
                                $(frm3.cphone2).val(cphone2);
                                $(frm3.cname).val(cname);
                                $(frm3.caddress1).val(caddress1);
                                $(frm3.caddress2).val(caddress2);
                                $("#modal_insert").modal("hide");
                            }
                        })
                    }
                });
            }
        })
    })



    $("#up_insert").on("click", function(){
        const cphone = $("#div_cus .tr").attr("cphone");
        $("#modal_list").modal("hide");
        $(frm5.inputPhone).val(cphone);
        $("#modal_insert2").modal("show");
    })


    $("#clist").on("click", function(){
        $("#modal_insert").modal("hide");
        $("#modal_list").modal("show");
        const cphone = $(frm4.inputPhone).val();
        $.ajax({
            type:"get",
            dataType:"json",
            url:"/customer/list.json",
            data:{page, cphone:cphone},
            success:function(data){
                console.log(data);
                const temp = Handlebars.compile($("#temp_cus").html());
                $("#div_cus").html(temp(data));
            }
        })
    })
</script>