<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
    
<h3 style="text-align:center;">비밀번호 확인</h3>
<div class="pC" style="margin-left:450px;">
비밀번호&nbsp; <input type="password" name="passCheck" id="passCheck"><br>
<input name="email" id="email" hidden value="${loginUser.email}"><br>
</div>
<input type="button" value="확인" onclick="epCheck()" style="margin-left:570px;">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
  var j = jQuery.noConflict();
</script>
<script>
function  epCheck() {
    var e = j('#email').val();
    var p = j('#passCheck').val();
    console.log(e);
    console.log(p);
    if(p==""){
    	alert("비밀번호를 입력하세요!");
    	return false;
    } else {
    j.ajax({
         type: 'POST',
         datatype: "json",
         data: { email : e, password : p }, 
         url: "epSearch",
         success : function(result){
        	 console.log("result: " + result);
           if(result== 0){
        	   alert("비밀번호를 확인해주세요!");
        	   return false;
        	   } else {
        		   self.close();
        		   opener.location.href="../user/updateform"
        		   return true;
        	   }
         }
            });
    }
    
    }
</script>
