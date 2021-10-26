<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/21
  Time: 9:57
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
<div class="ui segment">
  <br>
  <div class="ui container">
    <div class="ui menu m-padded">
      <div class="ui mini item m-color header" style="margin: 0">登录用户信息：</div>
      <span class="item"><%= (String)session.getAttribute("username")%></span>
      <div class="right menu">
        <a href="../LogInOrOutServer/logout.jsp" class="ui item button m-color">退出</a>
      </div>
    </div>
    <div class="ui segment">
      <div class="ui container" style="height: auto;border: none;">
        <div class="ui form">
          <form action="search.jsp" method="post" name="searchForm">
            <div class="m-padded">
              <p>Tips：三个条件可选择性输入，全空为显示全表</p>
            </div>
            <div class="inline fields">
              <div class="field" style="width: 35%">
                <div class="fluid">
                  <input type="text" placeholder="学号" name="Sno">
                </div>
              </div>
              <div class="field" style="width: 35%">
                <div class="fluid">
                  <input type="text" placeholder="姓名" name="Sname">
                </div>
              </div>
              <div class="field" style="width: 30%">
                <div class="fluid">
                  <input type="text" placeholder="专业" name="Sdept">
                </div>
              </div>
              <div class="field" style="width: 15%">
                <button onclick="submitSearch()"  type="button" id="search-btn" class="ui mini blue button"><i
                        class="search icon"></i>Search</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="ui success message" id="message" style="display: none;">
      <i onclick="closeMessage('message')" class="close icon"></i>
      <div class="header">提示:</div>
      <p id="tipsMessage"></p>
    </div>
    <div class="ui attached segment">
      <div class="ui mini center aligned header m-color m-padded">学生信息管理</div>
      <div class="ui container" style="height: auto;border: none;">
        <div id="table-container" style="border: none;">
          <table class="ui celled table">
            <thead class="m-text-thin">
            <tr>
              <th class="center aligned">学号</th>
              <th class="center aligned">姓名</th>
              <th class="center aligned">性别</th>
              <th class="center aligned">年龄</th>
              <th class="center aligned">专业</th>
              <th class="center aligned">操作</th>
            </tr>
            </thead>
            <tbody>
            <%
              List<String[]> rel = (List<String[]>)session.getAttribute("searchResult");
              if(rel == null||rel.size() == 0){
                %>
            <tr>
              <td  class="center aligned">null</td>
              <td  class="center aligned">null</td>
              <td  class="center aligned">null</td>
              <td class="center aligned">null</td>
              <td class="center aligned">null</td>
              <td class="center aligned">
                <a href="#"
                   class="ui mini blue button m-text-thin">编辑</a>
                <a href="#"
                   class="ui mini orange button m-text-thin">删除</a>
              </td>
            </tr>
            <%
              }else{
                int index = Integer.parseInt(request.getParameter("beg"));
                int endIndex = Math.min(index + 5, rel.size());
                for(int j=index;j<endIndex;j++){
                  String[] i = rel.get(j);
                %>
                <tr>
                  <td  class="center aligned"><%=i[0]%></td>
                  <td  class="center aligned"><%=i[1]%></td>
                  <td  class="center aligned"><%=i[2]%></td>
                  <td class="center aligned"><%=i[3]%></td>
                  <td class="center aligned"><%=i[4]%></td>
                  <td class="center aligned">
                    <a href="showUpdatePlus.jsp?id=<%=i[0]%>&flag=1"
                       class="ui mini blue button m-text-thin">编辑</a>
                    <a href="delete.jsp?id=<%=i[0]%>"
                       class="ui mini orange button m-text-thin">删除</a>
                  </td>
                </tr>
                <%
                }
              }
            %>
            </tbody>
            <tfoot>
            <tr>
              <th colspan="4" class="center aligned">
                <div>
                  <%
                    int total = rel==null||rel.size()==0?0:rel.size();
                    int i = (int)Math.ceil(total/5.0);
                    for(int j=0;j<i;j++){
                  %>
                  <a class="ui mini button" href="searchPlus.jsp?beg=<%=j*5%>"><%=j+1%></a>
                  <%
                    }
                  %>
                </div>
              </th>
              <th class="center aligned">
                  <p class="m-color">共&nbsp;<span><%=total%></span>&nbsp;条数据</p>
              </th>
              <th class="center aligned">
                <a href="showUpdatePlus.jsp?id=none" class="ui m-text-thin mini blue button">新增</a>
              </th>
            </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<input type="hidden" id="insertTag" value="<%= request.getParameter("insertTag")%>">
<script>
  let exp = document.getElementById("insertTag");
  if(exp.value === "null"){

  }else{
    document.getElementById("tipsMessage").textContent=exp.value;
    document.getElementById("message").style.display='block';
  }
  /*提示消息关闭*/
  function closeMessage(value) {
    let message = document.getElementById(value);
    if(message.style.display === 'block'){
        message.style.display='none';
    }else{
      message.style.display='block';
    }
  }
  /*搜索表单提交*/
  function submitSearch() {
    let v1 = document.getElementsByName("Sno")[0];
    let v2 = document.getElementsByName("Sname")[0];
    let v3 = document.getElementsByName("Sdept")[0];
    if(v1.value === ''&&v2.value === ''&&v3.value === ''){
      window.location.href = 'successPlus.jsp?beg=0';
    }else{
      document.searchForm.submit();
    }
  }
</script>
</body>
</html>
