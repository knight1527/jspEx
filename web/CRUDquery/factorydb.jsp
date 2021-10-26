<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/19
  Time: 22:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
    <%!
        /*
        * 数据连接方法
        * */
       public static Connection getConnection(){
           String url = "jdbc:mysql://localhost:3306/homework?useUnicode=true&characterEncoding=utf-8&useSSL=true";
           String user = "root";
           String password = "******";
           try{
               Class.forName("com.mysql.jdbc.Driver");
           }catch (ClassNotFoundException e){
               System.out.println("驱动出错");
               System.out.println(e);
           }
           Connection conn = null;
           try{
               conn = DriverManager.getConnection(url,user,password);
           }catch(SQLException e){
               e.printStackTrace();
           }
           return conn;
       }
       /*
       *连接关闭
       * */
       public static void close(Connection conn,Statement stat){
           try{
               conn.close();
               stat.close();
           }catch (SQLException e){
               e.printStackTrace();
           }
       }
       public static void close(Connection conn,PreparedStatement ps) {
            try{
                conn.close();
                ps.close();
            }catch(SQLException e){
                e.printStackTrace();
            }
       }
    %>
</body>
</html>
