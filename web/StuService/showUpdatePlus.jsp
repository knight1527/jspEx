<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/21
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../CRUDquery/Stubiz.jsp"%>
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
%>
<div class="ui container">
    <div class="ui menu m-padded">
        <div class="ui mini item m-color header" style="margin: 0">登录用户信息：</div>
        <span class="item"><%= (String)session.getAttribute("username")%></span>
        <div class="right menu">
            <a href="../LogInOrOutServer/logout.jsp" class="ui item button m-color">退出</a>
        </div>
    </div>
    <div class="ui attached segment" style="opacity: 0.9;">
        <div class="ui mini center aligned header m-color m-padded">学生信息更新与插入</div>
        <div class="ui container" style="height: auto;border: none;">
            <div class="ui segment" style="width: 90%;margin: auto;">
                <%
                    String id = request.getParameter("id");
                    String flag = "0";
                    String[] rel = new String[5];
                    if(!id.equals("none")) {
                        flag = "1";//flag用于判断是插入还是更新
                        try {
                            rel = getAllStudent(1, id).get(0);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }else{
                        rel = new String[]{"", "", "", "", ""};
                    }
                %>
                <form action="update.jsp" name="update" class="ui form" method="post">
                    <div class="field">
                        <label>学号</label>
                        <input type="text" id="Sno" name="Sno" placeholder="Sno" value="<%=rel[0]%>">
                    </div>
                    <div class="field">
                        <label>姓名</label>
                        <input type="text" id="Sname" name="Sname" placeholder="Sname" value="<%=rel[1]%>">
                    </div>
                    <div class="field">
                        <label>性别</label>
                        <input type="text" id="Ssex" name="Ssex" placeholder="Ssex" value="<%=rel[2]%>">
                    </div>
                    <div class="field">
                        <label>年龄</label>
                        <input type="number" id="Sage" name="Sage" placeholder="Sage" value="<%=rel[3]%>">
                    </div>
                    <div class="field">
                        <label>专业</label>
                        <input type="text" id="Sdept" name="Sdept" placeholder="Sdept" value="<%=rel[4]%>">
                    </div>
                    <div class="field">
                        <div>
                            Tips:
                            <label>表单非空校验已做请放心提交</label>
                        </div>
                    </div>
                    <input type="hidden" name="flag" value="<%=flag%>">
                    <div class="ui field grid">
                        <div class="eight wide column">
                            <a href="successPlus.jsp?beg=0"><button class="ui fluid blue button" type="button">返回
                            </button></a>
                        </div>
                        <div class="eight wide column">
                            <a href="#"
                               onclick="submit()"><button class="ui fluid blue button" type="button">提交</button></a>
                        </div>
                    </div>
                    <%--<a href="#" onclick="submit()"><button class="ui fluid blue button" type="button">提交</button></a>--%>
                </form>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="insertTag" value="<%= request.getParameter("insertTag")%>">
<script>
    let exp = document.getElementById("insertTag");
    if(exp.value === "null"){

    }else{
        alert("Tips:"+exp.value);
    }
</script>
<script type="text/javascript">
    function submit() {
        let Sno = document.getElementById("Sno");
        let Sname = document.getElementById("Sname");
        let Ssex = document.getElementById("Ssex");
        let Sage = document.getElementById("Sage");
        let Sdept = document.getElementById("Sdept");
        if(Sno.value === "" || Sname.value === "" || Ssex.value === "" || Sage.value === "" || Sdept.value === ""){
            alert("Tips :  The form cannot have empty values");
        }else{
            document.update.submit();
        }
    }
</script>
</body>
</html>
