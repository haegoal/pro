<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div class="row justify-content-center">
  <div class="col text-center">
    &nbsp;
    <i class="bi bi-search" style="cursor:pointer"></i>
  </div>
</div>

<div class="modal fade" id="modal-search" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">유저찾기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="text-end">
          <form name="frm1">
            <select name="key">
              <option value="uname" selected>이름</option>
              <option value="ucode">코드</option>
            </select>
            <input name="query" autocomplete='off'>
            <button type="submit" class="btn btn-primary">검색</button>
          </form>
          <div id="div_sea"></div>
          <div id="pagination" class="pagination justify-content-center"></div>
        </div>
      </div>
      <hr>
    </div>
  </div>
</div>
<script id="temp_sea" type="text/x-handlebars-template">
  <table class="table">
    <th>코드</th>
    <th>성함</th>
    <th>번호</th>
    <th>입사일</th>
    <th>직책</th>
    <th>센터</th>
    {{#each .}}
    <tr>
      <td>{{ucode}}</td>
      <td>{{uname}}</td>
      <td>{{uphone}}</td>
      <td>{{rdate}}</td>
      <td>{{fle level}}</td>
      <td>{{center}}</td>
    </tr>
    {{/each}}
  </table>
</script>
<script>
  Handlebars.registerHelper("fle", function(level){
    if(level==1){
      return "상담사"
    }else if(level==2){
      return "상담실장"
    }else if(level==3){
      return "엔지니어"
    }else if(level==4){
      return "수리팀장"
    }
  })
</script>
<script>
  let page=1;
  let query="";
  let key=$(frm1.key).val();
  $("#temp_sea").hide();

  $(".bi-search").on("click",function(){
    $("#modal-search").modal("show")
  })

  $(frm1).on("submit", function(e){
    e.preventDefault();
    key=$(frm1.key).val();
    query=$(frm1.query).val();
    if(query==""){
      alert("검색어를 입력해주세요.")
    }else{
      $("#div_sea").show();
      getTotal();
    }
  });

  function getlist(){
    $.ajax({
      type:"get",
      dataType:"json",
      data:{query, key, page},
      url:"/user/list.json",
      success:function(data){
        console.log(data);
        const temp = Handlebars.compile($("#temp_sea").html());
        $("#div_sea").html(temp(data));
      }
    })
  }

  function getTotal(){
    $.ajax({
      type:"get",
      url:"/user/total",
      data:{query, key},
      success:function(data){
        console.log(data)
      }
    })
  }
  $("#pagination").hide();

  function getTotal(){
    $.ajax({
      type:"get",
      url:"/user/total",
      data:{query, key},
      success:function(data){
        if(data==0){
          $("#div_sea").html("<h3 class='text-center my-5'>결과가 존재하지않습니다..</h3>");
        }else{
          const totalPages=Math.ceil(data/5);
          $("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
        }
        if(data > 5){
          $("#pagination").show();
        }else{
          $("#pagination").hide();
        }
      }
    });
  }


  $('#pagination').twbsPagination({
    totalPages:21,	// 총 페이지 번호 수
    visiblePages: 10,	// 하단에서 한번에 보여지는 페이지 번호 수
    startPage : 1, // 시작시 표시되는 현재 페이지
    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
    onPageClick: function (event, curPage) {
      page=curPage;
      getlist();
    }
  });

</script>