<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/15
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <link rel="stylesheet" type="text/css" href="css/me.css">
</head>
<body class="bg4">
<div class="chose-img">
  <img onclick="chose_bg(1)" src="static/img/bg1.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(2)" src="static/img/bg2.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(3)" src="static/img/bg3.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(4)" src="static/img/bg4.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(5)" src="static/img/bg5.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(6)" src="static/img/bg6.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(7)" src="static/img/bg7.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(8)" src="static/img/bg8.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(9)" src="static/img/bg9.jpg" alt="">
  <p></p>
  <img onclick="chose_bg(10)" src="static/img/bg10.jpg" alt="">
</div>
<div class="container">
  <div class="login-box">
    <h2>Login</h2>
    <form method="post" name="login">
      <div class="user-box">
        <input type="text" id="InputName" name="userName" required="required">
        <label>Username</label>
      </div>
      <div class="user-box">
        <input type="password" id="InputPsw" name="userPassword" required="required">
        <label>Password</label>
      </div>
      <div id="tips" style="width: 100%;height: auto;color: white;opacity: 0.6;"
           class="m-text-spaced m-text-lined m-text-style">
        <p>Tips:如果没有此用户，请输入用户名和密码点击REGISTER注册即可(管理员账户:qihang密码:admin)</p>
      </div>
      <div>
        <a href="#" onclick="formCheck('UserService/submit.jsp')" id="submitButton">
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          Submit
        </a>
        <a href=""></a>
        <a href="#" onclick="formCheck('UserService/register.jsp')" id="registerButton">
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          Register
        </a>
      </div>
    </form>
  </div>
</div>
<script>
  /*表单校验*/
  function formCheck(value){
    let name = document.getElementById('InputName');
    let psw = document.getElementById('InputPsw');
    if(name.value === "" || psw.value === ""){
      alert("Tips :  username or password cannot be empty!!!!");
    }else{
      document.login.action=value;
      document.login.submit();
    }
  }
  /*更改背景图片*/
  function chose_bg(index) {
    let string = 'bg' + index;
    let body = document.getElementsByTagName("body")[0];
    body.className = string;
  }
</script>
</body>
</html>
