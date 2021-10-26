<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/21
  Time: 9:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../CRUDquery/Stubiz.jsp"%>
<%@page import="utils.*" %>
<html>
<head>
  <meta charset="UTF-8">
    <title>Title</title>
  <link rel="stylesheet" href="../css/me.css">
  <link rel="stylesheet" href="../css/semantic.min.css">
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String Sno = request.getParameter("Sno");
        String Sname = request.getParameter("Sname");
        String Sdept = request.getParameter("Sdept");
        List<String[]> rel1 = new ArrayList<>();
        List<String[]> rel2 = new ArrayList<>();
        List<String[]> rel3 = new ArrayList<>();
        if(!Sno.equals("")){
            rel1 = search("1",Sno);
        }
        if(!Sname.equals("")){
            rel2 = search("2",Sname);
        }
        if(!Sdept.equals("")){
            rel3 = search("3",Sdept);
        }
        List<String[]> rel = new ArrayList<>();
        if(!rel1.isEmpty()&&!rel2.isEmpty()&&!rel3.isEmpty()){
            rel = ResultSetProcessing.searchRel(rel1,rel2,rel3);
        }else{
            if(rel1.isEmpty()&&!rel2.isEmpty()&&!rel3.isEmpty()){
                rel = ResultSetProcessing.searchRel(rel2,rel3);
            }else if(!rel1.isEmpty()&&rel2.isEmpty()&&!rel3.isEmpty()){
                rel = ResultSetProcessing.searchRel(rel1,rel3);
            }else if(!rel1.isEmpty() && !rel2.isEmpty()){
                rel = ResultSetProcessing.searchRel(rel1,rel2);
            }else if(!rel1.isEmpty()){
                rel = rel1;
            }else if(!rel2.isEmpty()){
                rel = rel2;
            }else if(!rel3.isEmpty()){
                rel = rel3;
            }
        }
        session.setAttribute("searchResult",rel);
    %>
    <jsp:forward page="searchPlus.jsp?beg=0"></jsp:forward>
</body>
</html>
