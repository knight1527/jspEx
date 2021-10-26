<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/20
  Time: 18:05
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
        String flag = request.getParameter("flag");
        String Sno = request.getParameter("Sno");
        String Sname = request.getParameter("Sname");
        String Ssex = request.getParameter("Ssex");
        String Sage = request.getParameter("Sage");
        String Sdept = request.getParameter("Sdept");
        if(flag.equals("1")){
            try {
                update(Sno,Sname,Ssex,Sage,Sdept);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            %>
                <jsp:forward page="successPlus.jsp?beg=0">
                    <jsp:param name="insertTag" value="更新成功 !!"/>
                </jsp:forward>
            <%
        }else{
            try {
                List<String[]> userSno = getStudentBySno(Sno);
                List<String[]> userSname = getStudentBySname(Sname);
                if(userSno.isEmpty() && userSname.isEmpty()) {
                    try {
                        insert(Sno,Sname,Ssex,Sage,Sdept);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    %>
                        <jsp:forward page="successPlus.jsp?beg=0">
                            <jsp:param name="insertTag" value="插入成功 !!"/>
                        </jsp:forward>
                    <%
                }else {
                    if(!userSno.isEmpty() && !userSname.isEmpty()){
                    %>
                        <jsp:forward page="showUpdatePlus.jsp?id=none">
                            <jsp:param name="insertTag" value="学号和姓名已存在!!"/>
                        </jsp:forward>
                    <%
                    }else if(!userSno.isEmpty()){
                    %>
                        <jsp:forward page="showUpdatePlus.jsp?id=none">
                            <jsp:param name="insertTag" value="学号已存在!!"/>
                        </jsp:forward>
                    <%
                    }else{
                    %>
                        <jsp:forward page="showUpdatePlus.jsp?id=none">
                            <jsp:param name="insertTag" value="姓名已存在!!"/>
                        </jsp:forward>
                    <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    %>

</body>
</html>
