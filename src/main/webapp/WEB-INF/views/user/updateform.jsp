	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<!-- For Demo Purpose -->
	<header class="py-5">
		<h3>정보수정</h3>
	</header>
	<div class="row">
		<div class="col-lg-8 mx-auto">
			<form action='update' method='post' enctype='multipart/form-data' name="form">
			
				<img
					src='${pageContext.servletContext.contextPath}/upload/user/${loginUser.photo}'
					height='100' width='100' vspace=30 hspace=20>

				<!--사진파일-->
				<div class="mb-4">
					<input name='photoFile' type='file'><br>
				</div>
				
				<input name='no' hidden value='${loginUser.no}'>
				
				<!--닉네임-->
				<label>닉네임</label>
				<div class="mb-4">
					<input name='nickName' type="text" value='${loginUser.nickName}' id="nickName" oninput="nickNameSearchh()">
					<span id="alert_nickName" style="color:grey;"></span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--이메일-->
				<label>이메일</label>
				<div class="mb-4">
					<input name='email' type="text" readonly 
					value='${loginUser.email}' placeholder="EMAIL" size=30 maxlength=40>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--새비밀번호-->
				<label>새비밀번호</label>
				<div class="mb-4">
					<input type='password' name='password' id="password" onkeyup="passwordCheck()">
					<span id="alert_password" style="color: grey;">
					영문자와 숫자 조합으로 8자 이상 입력해주세요.</span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--새비밀번호확인-->
        <label>새비밀번호확인</label>
        <div class="mb-4">
          <input type='password' id="password2" onkeyup="password2Check()">
          <span id="alert_password2" style="color: grey;"></span><br>
          <!-- Solid divider -->
          <hr class="solid">
        </div>
				
				<!--이름-->
				<label>이름</label>
				<div class="mb-4">
					<input name='name' type="text" value='${loginUser.name}' readonly />
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--생일-->
				<label>생년월일</label>
				<div class="mb-4">
					<input type='text' name="birth" id="birth" value='${loginUser.birth}'
					       onkeyup="birthCheck()" placeholder="예) 19930613">
					<span id="alert_birth" style="color: grey;"></span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--성별-->
				<div class="mb-4">
				<label>성별</label><br>
					<c:choose>
						<c:when test="${loginUser.gender == 1}">
					남 <input name='gender' type='radio' value=1 checked> 여 <input
								name='gender' type='radio' value=2>
							<br>
						</c:when>
						<c:when test="${loginUser.gender == 2}">
					남 <input name='gender' type='radio' value=1> 여 <input
								name='gender' type='radio' value=2 checked>
							<br>
						</c:when>
					</c:choose>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--전화번호-->
				<label>전화번호</label>
				<div class="mb-4">
					<input name='tel' type="tel" value='${loginUser.tel}' id="tel" onkeyup="telSearch()" 
					placeholder="예) 010-1234-1234" size=30 maxlength=50/>
					<span id="alert_tel" style="color: grey;"></span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>

				<!--우편번호-->
				<label>우편번호</label>
				<div class="mb-4">
					<input name='zipCode' type="text" value='${loginUser.zipCode}' 
					       class="zipCodes"  id="zipCode" onkeyup="zipCodeCheck()" readonly/>
					<input type="button" onClick="openDaumZipAddress(this);" value ="주소 찾기"/><br/>
					<!-- Solid divider -->
					<hr class="solid">
				</div>


				<!--기본주소-->
				<label>기본주소</label>
				<div class="mb-4">
					<input name='basicAddr' type="text" value='${loginUser.basicAddr}'
					       class="basicAddrs" id="basicAddr" onkeyup="basicAddrCheck()" readonly>
					<!-- Solid divider -->
					<hr class="solid">
				</div>


				<!--상세주소-->
				<label>상세주소</label>
				<div class="mb-4">
					<input type="text" name='detailAddr' class="detailAddrs"  
					       id="detailAddr" value='${loginUser.detailAddr}'/>
					<!-- Solid divider -->
					<hr class="solid">
				</div>

			</form>
<button id="btn2" onclick="checkForm()">등록</button>
<script> 

</script>

		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
  var j = jQuery.noConflict();
</script>
<script>
var passcheck = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
var telcheck = /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/;
var emailCnt =0;
var telCnt =0;
var nickNameCnt =0;

//주소 API 연결
function openDaumZipAddress(btn) { 
    new daum.Postcode({
      oncomplete:function(data) {
        $(btn.parentNode).find('.zipCodes').val(data.zonecode);
        $(btn.parentNode).find('.basicAddrs').val(data.address);
        $(btn.parentNode).find('.detailAddrs').focus(); 
      }
    }).open();
    console.log("지도 여기까지!");
  }    
  
// 폼 유효성 체크
function checkForm(){
  var form = document.form;
  if(passwordCheck()==false) {
      alert("새비밀번호를 확인해주세요!");
      password.focus();
      return false;
    } else if(password2Check()==false) {
      alert("새비밀번호확인을 확인해주세요!");
      form.password2.focus();
      return false;
    } else if(birthCheck()==false) {
      alert("생년월일을 확인해주세요!");
      form.birth.focus();
      return false;
    } else if(telSearch() > 0){
        alert("전화번호를 확인해주세요!");
        cnt = 0;
        form.tel.focus();
        return false;
    }  else if(form.zipCode.value==""){
       alert("주소를 입력해주세요!");
       form.zipCode.focus();
       return false;
    } else if(form.basicAddr.value==""){
       alert("주소를 입력해주세요!");
       form.basicAddr.focus();
       return false;
    } else if(nickNameSearchh() > 0){
       alert("별명을 확인해주세요!");
       cnt = 0;
       form.nickName.focus();
       return false;
    }
  alert("수정되었습니다!");
  document.form.submit();
  }


//password 유효성
function passwordCheck(){
  var form = document.form;
  if(form.password.value=="") {
	  return true;
  } else if(form.password.value!=""){
    if(!passcheck.test(form.password.value)) {
      document.getElementById("alert_password").innerHTML=('<span style="color: red;">영문자, 숫자 조합으로 8자 이상 적어주세요!</span>');
      return false;
    } else {
        document.getElementById("alert_password").innerHTML=('<span style="color: green;">OK!</span>');
    }
  }
}

//password2 유효성
function password2Check(){
  var form = document.form;
  if(form.password.value!="") { 
    if(form.password2.value==""){
      document.getElementById("alert_password2").innerHTML=('<span style="color: red;">비밀번호 입력해주세요!</span>');
      return false;
    } else if(form.password2.value!=""){
      if(form.password.value!=form.password2.value){
        document.getElementById("alert_password2").innerHTML=('<span style="color: red;">비밀번호가 다릅니다!</span>');
        return false;
      } else {
        document.getElementById("alert_password2").innerHTML=('<span style="color: green;">OK!</span>');
    }
  }
  }
}

//birth 유효성
function birthCheck(){
  var form = document.form;
  var yyyy = form.birth.value.substr(0,4); 
  var mm = form.birth.value.substr(4,2); 
  var dd = form.birth.value.substr(6,2);
  if(form.birth.value==""){
    document.getElementById("alert_birth").innerHTML=('<span style="color: grey;">생년월일을 입력해주세요!</span>');
    return false;
   } else if(form.birth.value!=""){
      if(form.birth.value.length != 8 ){
         document.getElementById("alert_birth").innerHTML=('<span style="color: red;">생년월일을 잘못 입력했습니다!</span>');
         return false;
      } else if (yyyy < "1900" || yyyy > "2020" || mm < "01" || mm > "12" || dd < "01" || dd > "31") {
         document.getElementById("alert_birth").innerHTML=('<span style="color: red;">생년월일을 잘못 입력했습니다!</span>');
         return false;
      } else {
         document.getElementById("alert_birth").innerHTML=('<span style="color: green;">OK!</span>');
     }
   }
}

//전화번호 유효성
function telSearch() {
    var t = j('#tel').val();
    console.log(t);
    console.log("telCnt"+ telCnt);
      if(t==""){
        console.log("tel 없음!");
        document.getElementById("alert_tel").innerHTML=('<span style="color: red;">전화번호를 입력해주세요!</span>');
        telCnt = 5;
        return telCnt;
      } else if(t!=""){
        if(!telcheck.test(t)) {
          document.getElementById("alert_tel").innerHTML=('<span style="color: red;">전화번호 형식을 확인해주세요</span>');
          telCnt = 3;
          return telCnt;
        }else {
         j.ajax({
         type: 'POST',
         datatype: "json",
         data: { tel : t },
         url: "telSearch",
         success : function(result){
         telCnt = result;
         console.log(result);
         if (result == 0){
           j("#alert_tel").text("OK!");
           j("#alert_tel").css("color", "green");
         } else {
           j("#alert_tel").text("사용중인 전화번호입니다!");
           j("#alert_tel").css("color", "red");
         }
        }
      });
        console.log("tel cnt:" + telCnt);
        return telCnt;
     }
    }
  }
  
//별병 유효성
function nickNameSearchh() {
  var nick = j('#nickName').val();
  console.log(nick);
    if(nick==""){
      document.getElementById("alert_nickName").innerHTML=('<span style="color: red;">별명을 입력해주세요!</span>');
      nickNameCnt = 5;
      return nickNameCnt;
    } else if(nick!=""){
      j.ajax({
      type: 'POST',
      datatype: "json",
      data: { nickName : nick},
      url: "nickNameSearch",
      success : function(result){
      nickNameCnt = result;
      console.log(result);
      if (result == 0){
        j("#alert_nickName").text("OK!");
        j("#alert_nickName").css("color", "green");
      } else {
        j("#alert_nickName").text("사용중인 별명입니다!");
        j("#alert_nickName").css("color", "red");
      }
      }
    });
      console.log("nickName cnt:" + nickNameCnt);
      return nickNameCnt;
  }
}
</script>





