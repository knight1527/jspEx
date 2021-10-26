<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/16
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../CRUDquery/factorydb.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("userName");
        String psw = request.getParameter("userPassword");
        String sqlQuery = "insert into user(`userName`,`userPassword`) values(?,?)";
        String sql = "select * from user where userName = ?";
        try {
            Connection conn = getConnection();
            PreparedStatement pst = conn.prepareStatement(sqlQuery);
            PreparedStatement pst2 = conn.prepareStatement(sql);
            pst2.setString(1,username);
            ResultSet rs = pst2.executeQuery();
            if(rs.next()){
                conn.close();
                pst.close();
                pst2.close();
                request.getRequestDispatcher("userIn.jsp").forward(request,response);
            }else {
                pst.setString(1, username);
                pst.setString(2, psw);
                pst.executeUpdate();
                session.setAttribute("username", username);
                conn.close();
                pst.close();
                pst2.close();
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
    %>
    <jsp:forward page="../StuService/successPlus.jsp?beg=0"></jsp:forward>
</body>
</html>
