<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>


	<!-- For Demo Purpose -->
	<header class="py-5">
		<h1 class="display-4">Sign Up</h1>
	</header>


	<div class="row">
		<div class="col-lg-8 mx-auto">
			<form action='add' method='post' name="form" enctype='multipart/form-data'>
			
			<!--사진-->        
          <div class="mb-4">
           <div class="imgArea">
	           <img id="image_section" onchange="imageInsert();" src="#" style="display: none;"/>
           </div>
	           <input type='file' name='photoFile' id="imgInput">
          <!-- Solid dividder -->
          <hr class="solid">
        </div>
        
			<!--이메일-->
				<div class="mb-4">
					<input type='text' name='email' id="email"
						onkeyup="emailSearch()" placeholder="EMAIL" size=30 maxlength=40>
					<span id="alert_email" style="color: grey;">예)
						bitcamp@naver.com</span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--비밀번호-->
				<div class="mb-4">
					<input type='password' name='password'
						id="password" onkeyup="passwordCheck()" placeholder="PASSWORD"
						size=30 maxlength=20> <span id="alert_password"
						style="color: grey;">영문자와 숫자 조합으로 8자 이상 입력해주세요.</span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--비밀번호확인-->
				<div class="mb-4">
					<input type='password' id="password2"
						onkeyup="password2Check()" placeholder="CONFIRM PASSWORD" size=30
						maxlength=20> <span id="alert_password2"
						style="color: grey;"></span> <br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--이름-->
				<div class="mb-4">
					<input type='text' name='name' id="name"
						onkeyup="nameCheck()" placeholder="NAME" size=30 maxlength=20>
					<span id="alert_name" style="color: grey;"></span> <br>

					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--생년월일-->
				<div class="mb-4">
					<input type='text' name='birth' id="birth"
						onkeyup="birthCheck()" placeholder="BIRTH" size=30 maxlength=20>
					<span id="alert_birth" style="color: grey;">예) 19930613</span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--성별-->
				<div class="mb-4">
				        <input type="text" placeholder="GENDER" readonly  maxlength=2>
					&nbsp; <input type='radio' name='gender' id="gender" value="2" >여자
					&nbsp; <input type='radio' name='gender' id="gender" value="1">남자
					<span id="alert_gender" style="color: grey;"></span><br>

					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--전화번호-->
				<div class="mb-4">
					<input type='text' name='tel' id="tel" onkeyup="telSearch()" placeholder="TEL" size=30 maxlength=20>
					<span id="alert_tel" style="color: grey;">예) 010-1234-1234</span><br>
					<!-- Solid divider -->
					<hr class="solid">
				</div>

				<!--우편번호-->
				<div>
					<input type='text' name='zipCode' class="zipCodes"  id="zipCode" readonly placeholder="우편번호" size=30 maxlength=20>
          <span id="alert_zipCode" style="color:grey;"></span>
          <input type="button" onClick="openDaumZipAddress(this);" value ="주소 찾기"/><br/>
					<!-- Solid divider -->
					<hr class="solid">
				
				<!--기본주소-->
					<input type='text'name='basicAddr' class="basicAddrs" id="basicAddr" readonly placeholder="기본주소" size=30 maxlength=20>
					<span id="alert_basicAddr" style="color: grey;"></span><br>
					<!-- Solid divider -->
					<hr class="solid">
				
				<!--상세주소-->
					 <input  type='text' class="detailAddrs" name='detailAddr' id="detailAddr" placeholder="상세주소" size=30 maxlength=20>
					<!-- Solid divider -->
					<hr class="solid">
				</div>
				
				<!--별명-->
					<div class="mb-4">
					 <input type='text' name='nickName' id="nickName" oninput="nickNameSearchh()"  
					 placeholder="별명" size=30 maxlength=8>  
					 <span id="alert_nickName" style="color: grey;"></span><br> 
					<!-- Solid divider -->
					<hr class="solid">
					<input type="button" class="userformButtons" onclick="checkForm()" value="등록"> 
					<input type="button" class="userformButtons" onclick="reset()" value="초기화">
				</div>

			</form>
		</div>
	</div>


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
  var j = jQuery.noConflict();
</script>
<script type="text/JavaScript"
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24cdf736c8b9797f29a0e35af3b6773a&libraries=services,clusterer,drawing"></script>

<script>
var emailcheck = /^([0-9a-zA-Z-_.])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
var passcheck = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
var telcheck = /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/;
var emailCnt =0;
var telCnt =0;
var nickNameCnt =0;

function readURL(input) {
	   if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    
	    reader.onload = function (e) {
	     $('#image_section').attr('src', e.target.result);
	     $('#image_section').css('display', '').css('width', '200px'); 
	    }
	    
	    reader.readAsDataURL(input.files[0]);
	    }
	  }
	  
	  $("#imgInput").change(function(){
	     readURL(this);
	  });
	  
//주소 API 연결
function openDaumZipAddress(btn) { 
  console.log(btn)
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
  if(emailSearch() > 0){
      alert("이메일을 확인해주세요!");
      cnt = 0;
      form.email.focus();
      return false;
    } else if(passwordCheck()==false) {
      alert("비밀번호를 확인해주세요!");
      password.focus();
      return false;
    } else if(password2Check()==false) {
      alert("비밀번호 확인을 확인해주세요!");
      form.password2.focus();
      return false;
    } else if(nameCheck()==false) {
      alert("이름을 확인해주세요!");
      form.name.focus();
      return false;
    } else if(birthCheck()==false) {
      alert("생년월일을 확인해주세요!");
      form.birth.focus();
      return false;
    } else if(form.gender[0].checked==false && form.gender[1].checked==false){
      alert("성별을 체크하세요!");
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
  document.form.submit();
  }

//이메일 유효성
function emailSearch() {
    var e = j('#email').val();
      if(e==""){
        document.getElementById("alert_email").innerHTML=('<span style="color: red;">이메일을 입력해주세요!</span>');
        emailCnt = 5;
        return emailCnt;
      } else if(e!=""){
        if(!emailcheck.test(e)) {
              document.getElementById("alert_email").innerHTML=('<span style="color: red;">이메일 형식을 확인해주세요</span>');
              emailCnt = 3;
              return emailCnt;
        } else {
         j.ajax({
         type: 'POST',
         datatype: "json",
         data: { email : e},
         url: "emailSearch",
         success : function(result){
           emailCnt = result;
         console.log(result);
         if (result == 0){
           j("#alert_email").text("OK!");
           j("#alert_email").css("color", "green");
         } else {
           j("#alert_email").text("사용중인 이메일입니다!");
           j("#alert_email").css("color", "red");
         }
        }
      });
        console.log("email cnt:" + emailCnt);
        return emailCnt;
     }
    }
  }

//password 유효성
function passwordCheck(){
  var form = document.form;
  if(form.password.value==""){
    document.getElementById("alert_password").innerHTML=('<span style="color: red;">비밀번호를 입력해주세요!</span>');
  } else if(form.password.value!=""){
    if(!passcheck.test(form.password.value)) {
      document.getElementById("alert_password").innerHTML=('<span style="color: red;">영문자, 숫자 조합으로 8자 이상 적어주세요!</span>');
      return false;
    } else {
        document.getElementById("alert_password").innerHTML=('<span style="color: green;">OK!</span>');
    }
  }
}

// password2 유효성
function password2Check(){
  var form = document.form;
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

//name 유효성
function nameCheck(){
  var form = document.form;
  if(form.name.value==""){
    document.getElementById("alert_name").innerHTML=('<span style="color: red;">이름을 입력해주세요!</span>');
    return false;
  } else {
    document.getElementById("alert_name").innerHTML=('<span style="color: green;">OK!</span>');
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
  
//별명 유효성
function nickNameSearchh() {
  var nick = j('#nickName').val();
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

