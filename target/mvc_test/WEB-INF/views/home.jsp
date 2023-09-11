<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>일보전자</title>
<c:if test="${user==null}">
    <link rel="stylesheet" href="/resources/css/style.css"/>
</c:if>
<c:if test="${user!=null}">
    <link rel="stylesheet" href="/resources/css/style2.css"/>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
</c:if>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<c:if test="${user==null}">
<body id="particles-js"></body>
<div class="animated bounceInDown">
    <div class="container">
        <span class="error animated tada" id="msg"></span>
        <form name="frm" class="box">
            <h4>일보<span>전자</span></h4>
            <h5 class="mt-2">로그인해주세요.</h5>
            <input type="text" name="uid" placeholder="id" autocomplete="off">
            <i class="typcn typcn-eye" id="eye"></i>
            <input type="password" name="upw" placeholder="Passsword" id="pw" autocomplete="off">
            <small class="rmb">계정정보저장</small>
            <input type="checkbox" name="keep">
            <a href="#" class="forgetpass">Forget Password?</a>
            <input type="submit" value="로그인" class="btn1">
        </form>
    </div>
</div>
</c:if>
<c:if test="${user!=null}">
<div class="container">
    <div class="row">
        <div class="col">
            &nbsp;
            <button id="wait">대기</button>
            <button id="ing">작업</button>
            <button id="eat">식사</button>
            <button id="rest">휴식</button>
        </div>
        <div class="col text-center">
            <h2>일보전자</h2>
        </div>
        <div class="col">
            <div class="text-end">
                <jsp:include page="/main/search.jsp"/>
                <h5>${user}님 <a href="/user/logout">로그아웃</a></h5>
            </div>
        </div>
        <div class="row">
            <div class="col text-end">
                <button id="save">저장</button>
                <button id="cancel">취소</button>
            </div>

        </div>
    </div>
    <div class="row">
        <jsp:include page="/main/product.jsp"/>
        <jsp:include page="/main/customer.jsp"/>
    </div>
</div>
</c:if>
</body>
<script>

    $(frm).on("submit", function(e){
        e.preventDefault();
        const uid= $(frm.uid).val();
        const upw= $(frm.upw).val();
        const keep=$(frm.keep).is(":checked");
        if(uid ==""){
            alert("아이디입력바람");
            $(frm.uid).focus();
        }else if(upw==""){
            alert("비밀번호입력바람");
            $(frm.upw).focus();
        }else{
            $.ajax({
                type:"post",
                data:{uid, upw, keep},
                url:"/user/login",
                success:function(data){
                    if(data==0){
                        alert("없는 아이디입니다.")
                        $(frm.uid).focus();
                    }else if(data==2){
                        alert("비밀번호가 일치하지않습니다.")
                        $(frm.upw).focus();
                    }else{
                        alert(uid + "님 환영합니다.");
                        location.href="/";
                    }
                }
            })
        }
    })

</script>
</html>
