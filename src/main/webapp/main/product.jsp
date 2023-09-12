<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-6">
  <form name="frm2" class="card p-3">
    <div class="row">
      <div class="col-6 col-sm-6 col-md-6">
        <div class="input-group">
          <span class="input-group-text">모델코드</span>
          <input type="text" class="form-control" list="mlist" id="mcode-enter" name="mcode" maxlength='16' oninput='isEng(this)'/>
          <datalist id ="mlist">
            <option value="ZZZ" />
            <option value="REZ" />
            <option value="3" />
            <option value="4" />
            <option value="5" />
            <option value="6" />
          </datalist>
        </div>
      </div>
      <div class="col-6 col-sm-6 col-md-6">
        <div class="input-group">
          <span class="input-group-text">구매일</span>
          <input class="form-control" type="date" name="pdate">
        </div>
      </div>
    </div>
    <div class="row mt-2">
      <div class="col-6 col-sm-6 col-md-6">
        <div class="input-group">
          <span class="input-group-text">상품분류</span>
          <input class="form-control" name="pcode" id="pcode-enter" maxlength='16' oninput='isKor(this)'/>
        </div>
      </div>
      <div class="col-6 col-sm-6 col-md-6">
        <div class="input-group">
          <span class="input-group-text">보증기간</span>
          <select class="form-select" name="plife">
            <option selected></option>
            <option value="before">보증이내</option>
            <option value="after">보증이후</option>
          </select>
        </div>
      </div>
    </div>
    <div class="row mt-2">
      <div class="col-6 col-sm-6 col-md-6">
        <div class="input-group">
          <span class="input-group-text">상품명</span>
          <input class="form-control" name="pname" id="pname-enter" maxlength='16' autocomplete='off' oninput='isKor(this)'/>
        </div>
      </div>
    </div>
    <div class="row mt-2">
      <div class="col-6 col-sm-6 col-md-6">
        <div class="input-group">
          <span class="input-group-text">제조번호</span>
          <input class="form-control" name="pnumber" maxlength='16' id="test-enter">
        </div>
      </div>
    </div>
    <div class="row mt-2">
      <div class="col-6 col-sm-6 col-md-6">
        <div class="input-group">
          <span class="input-group-text">모델명</span>
          <input class="form-control" name="mname" id="mname-enter" maxlength='16'>
        </div>
      </div>
    </div>
  </form>
</div>
<script>

  document.getElementById('mcode-enter').addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
      const query = $(frm2.mcode).val();
      const key ="mcode";
      $.ajax({
        type:"get",
        data:{query, key},
        url:"/product/read",
        dataType:"json",
        success:function(data){
          console.log(data.mcode);
          $(frm2.mcode).val(data.mcode)
          $(frm2.pname).val(data.pname)
          $(frm2.pcode).val(data.pcode)
        }
      })
    }
  });


  document.getElementById('pcode-enter').addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
      const query = $(frm2.pcode).val();
      const key = "pcode";
      $.ajax({
        type: "get",
        data: {query, key},
        url: "/product/read",
        dataType: "json",
        success: function (data) {
          $(frm2.mcode).val(data.mcode)
          $(frm2.pname).val(data.pname)
          $(frm2.pcode).val(data.pcode)
        }
      })
    }
  });

  document.getElementById('pname-enter').addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
    const query = $(frm2.pname).val();
    const key ="pname";
    $.ajax({
      type:"get",
      data:{query, key},
      url:"/product/read",
      dataType:"json",
      success:function(data){
        $(frm2.mcode).val(data.mcode)
        $(frm2.pcode).val(data.pcode)
        $(frm2.pname).val(data.pname)
      }
    })
    }
  });

  document.getElementById('mname-enter').addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
      const query = $(frm2.mname).val();
      const key = "mname";
      $.ajax({
        type: "get",
        data: {query, key},
        url: "/product/read",
        dataType: "json",
        success: function (data) {
          $(frm2.mcode).val(data.mcode)
          $(frm2.pcode).val(data.pcode)
          $(frm2.pname).val(data.pname)
          $(frm2.mname).val(data.mname)
        }
      })
    }
  })

  function isEng(item)  {
    item.value = item.value.replace(/[^A-Za-z]/ig, '')
  }

  function isKor(item)  {
    item.value = item.value.replace(/[^ㄱ-ㅎ|가-힣]/g, '')
  }

  // ex) A20231011BE
  document.getElementById('test-enter').addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
      let pnumber = $(frm2.pnumber).val();
      if (pnumber.length == 11) {
        let fpnumber = pnumber.slice(0, 5) + '-' + pnumber.slice(5, 7) + '-' + pnumber.slice(7, 11);
        $(frm2.pdate).val(fpnumber.substring(1, 11))
      }
    }
  });
</script>