<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/16
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" language="java" import="java.sql.*" %>
<%@include file="../CRUDquery/factorydb.jsp"%>
<html>
<head>
    <title>登录处理</title>
</head>
<body class="bg4">

<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("userName");
    String psw = request.getParameter("userPassword");
    String sqlQuery = "select userId,userPassword from user where userName = ?";
    try(
            Connection conn = getConnection();
            PreparedStatement pst = conn.prepareStatement(sqlQuery);
    ){
        System.out.println("成功进入submit.jsp");
        pst.setString(1,username);
        ResultSet result = pst.executeQuery();
        if(result.next()){
            String password = result.getString(2);
            if(password.equals(psw)){
                session.setAttribute("username",username);
                System.out.println("登陆成功");
                response.sendRedirect("../StuService/successPlus.jsp?beg=0");
    }else{
%>
<jsp:forward page="wrongPsw.jsp"></jsp:forward>
<%
    }
}else{
%>
<jsp:forward page="noUser.jsp"></jsp:forward>
<%
        }
        conn.close();
        pst.close();
    }catch(SQLException e){
        e.printStackTrace();
    }
%>

</body>

</html>
