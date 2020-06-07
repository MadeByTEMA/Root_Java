<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div style="width: 400px;margin:200px auto;">
	<h3>비밀번호 찾기</h3>
	<form action='findPass' method='post' name="form">
		<div class="form-group">
		  <label for="name"></label>
		  <input name='name' type='text' id="name" placeholder="이름">
		  <div class="validate"></div>
		</div>
    <div class="form-group">
			<label for="name"></label>
			<input name='email' type='text' id="email" placeholder="email">
		  <div class="validate"></div>
			</div>
		<input type ="button" id="btn" value="전송" onClick="formCheck()" style="margin-top: 28px;">
	</form>
</div>
<script>
var enCnt = 0;

function formCheck() {
	var form = document.form;
	if(form.name.value==""){
		alert("이름을 입력해주세요!");
		form.name.focus();
		return false;
	} else if(form.email.value==""){
	    alert("이메일을 입력해주세요!");
	    form.email.focus();
	    return false;
	} else if(enSearch()==0){
	  alert("유효한 회원이 없습니다.");
	  enCnt = 0;
	  return false;
	} else {
	  alert("작성하신 이메일 주소로 메일을 발송하였습니다.");
	}
	form.submit();
}

function enSearch() {
    var e = $('#email').val();
    var n = $('#name').val();
    console.log(e);
    console.log(n);
         $.ajax({
         type: 'POST',
         async: false,
         datatype: "json",
         data: { email : e, name:n},
         url: "enSearch",
         success : function(result){
         console.log(result);
         enCnt = result;
         console.log("enCnt" + enCnt);
         return enCnt;
         }
      });
     }

</script>
