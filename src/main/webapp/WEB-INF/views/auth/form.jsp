<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<div class="all">
	<div class="col-lg-7 mt-5 mt-lg-0 d-flex align-items-stretch"
		data-aos="fade-up" data-aos-delay="200">
		<form action='login' method='post' name ="form">
			<div class="total">
				<div class="content">
					<h3>LOGIN</h3>

					<div class="form-group">
						<label for="name"></label> <input type="email"
							class="form-control" name="email" id="subject1"
							data-rule="minlen:4" value='${cookie.email.value}'
							placeholder="email" />
						<div class="validate"></div>
					</div>
					<div class="form-group">
						<label for="name"></label> <input type='password'
							placeholder="password" class="form-control" name="password"
							id="subject2" />
						<div class="validate"></div>
					</div>
				</div>
			</div>
			<input type='checkbox' name='saveEmail' class="context-text"
				style="margin-bottom: 10px; text-algin: center;"> 이메일 저장해두기<br>
			<div class="total">
				<input type ="button" id="btn" value="로그인" onClick="formCheck()">
				<br>
				<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
        </fb:login-button>
			</div>
			<div class="etc">
				<a href="../user/findinfoform"  class="search" >비밀번호 찾기</a>
					<a href='../user/form'>회원가입</a>
			</div>
		</form>
	</div>
	</div>
	<script>
	var epCnt = 0;
	function formCheck() {
		var form = document.form;
		if(form.email.value==""){
			alert("이메일을 적어주세요!");
			form.email.focus();
			return false;
		} else if(form.password.value==""){
			alert("비밀번호를 입력해주세요!");
			form.password.focus();
			return false
		} else if(epCheck() == 0){
			alert("이메일 또는 비밀번호를 확인해주세요!");
			return false;
		}
		form.submit();
	}
	
	function epCheck() {
	    var e = $('#subject1').val();
	    var p = $('#subject2').val();
	    console.log(e);
	    console.log(p);
	    $.ajax({
	         type: 'POST',
	         datatype: "json",
	         async: false,
	         data: { email : e, password:p}, 
	         url: "epSearch",
	         success : function(result){
	        	 epCnt = result;
	        console.log("epCnt" + epCnt);
	        return epCnt;
	          }
	            });
	     }
	
	
// 로그인 버튼
window.fbAsyncInit = function() {
    console.log("window.fbAsyncInit() 호출됨!");
    FB.init({
      appId      : '535183894054195', // 개발자가 등록한 앱 ID
      cookie     : true,  
      xfbml      : true,  
      version    : 'v7.0' 
    });
    FB.AppEvents.logPageView();
  };

  (function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "https://connect.facebook.net/en_US/sdk.js";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
  
function checkLoginState() {
      FB.getLoginStatus(function(response) { 
          if (response.status == 'connected') { // 로그인이 정상적으로 되었을 때,
              requestAutoLogin(response.authResponse.accessToken);
          
          } else { // 로그인이 되지 않았을 때,
              alert("페이스북 로그인을 취소했습니다.");
          }
      });
  }
  
function requestAutoLogin(accessToken) {
    location.href = "facebookLogin?accessToken=" + accessToken;
}
</script>