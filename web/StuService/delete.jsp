<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/20
  Time: 18:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../CRUDquery/Stubiz.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String Sno = request.getParameter("id");
        try {
            delete(Sno);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    %>
    <jsp:forward page="successPlus.jsp?beg=0">
        <jsp:param name="insertTag" value="删除成功 !!"/>
    </jsp:forward>
</body>
</html>
