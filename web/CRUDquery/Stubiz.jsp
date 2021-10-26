<%--
  Created by IntelliJ IDEA.
  User: knight1527
  Date: 2021/10/19
  Time: 22:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*"%>
<%@ include file="factorydb.jsp"%>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%!
        /*
        *代码优化
        *@Param:目标结果集
        * */
        private List<String[]> resultSetProcessor(ResultSet st) throws SQLException {
            List<String[]> rel = new ArrayList<>();
            while(st.next()){
                String[] str = new String[5];
                str[0] = st.getString(1);
                str[1] = st.getString(2);
                str[2] = st.getString(3);
                str[3] = st.getInt(4)+"";
                str[4] = st.getString(5);
                rel.add(str);
            }
            return rel;
        }
        /*
         * 查询方法
         * @Param judge=1表示按照ID查询 judge=0全表查询 id在judge等于1时不能为空！
         * */
        public List<String[]> getAllStudent(int judge,String id) throws Exception{
            Connection conn = getConnection();
            String sqlQuery = judge == 0?"select * from student":"select * from student where Sno="+id;
            Statement stat = conn.createStatement();
            ResultSet st = stat.executeQuery(sqlQuery);
            List<String[]> rel = resultSetProcessor(st);
            close(conn,stat);
            return rel;
        }
        /*
         * 条件查询方法
         * @Param 学号
         * */
        public List<String[]> getStudentBySno(String Sno) throws SQLException{
            Connection conn = getConnection();
            String sql = "select * from student where Sno=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1,Sno);
            ResultSet st = pst.executeQuery();
            List<String[]> rel = resultSetProcessor(st);
            close(conn,pst);
            return rel;
        }
        /*
         * 条件查询方法
         * @Param 学生姓名
         * */
        public List<String[]> getStudentBySname(String Sname) throws SQLException{
            Connection conn = getConnection();
            String sql = "select * from student where Sname=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1,Sname);
            ResultSet st = pst.executeQuery();
            List<String[]> rel = resultSetProcessor(st);
            close(conn,pst);
            return rel;
        }
        /*
         * 插入方法
         * */
        public void insert(String no,String name,String sex,String age,String dept) throws SQLException {
            if(age.equals("")){
                System.out.println("age cannot be empty");
                return;
            }
            Connection conn = getConnection();
            String sql = "insert into student(`Sno`,`Sname`,`Ssex`,`Sage`,`Sdept`) values(?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1,no);
            pst.setString(2,name);
            pst.setString(3,sex);
            pst.setInt(4,Integer.parseInt(age));
            pst.setString(5,dept);
            pst.executeUpdate();
            close(conn,pst);
        }
        /*
         * 更新方法
         * */
        public void update(String no,String name,String sex,String age,String dept) throws SQLException {
            if(age.equals("")){
                System.out.println("age cannot be empty");
                return;
            }
            Connection conn = getConnection();
            String sql = "update student set Sname=?,Ssex=?,Sage=?,Sdept=? where Sno = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(5,no);
            pst.setString(1,name);
            pst.setString(2,sex);
            pst.setInt(3,Integer.parseInt(age));
            pst.setString(4,dept);
            pst.executeUpdate();

            close(conn,pst);
        }
        /*
         * 删除方法
         * */
        public void delete(String Sno) throws SQLException {
            Connection conn = getConnection();
            String sql = "delete from student where Sno = ?";
            PreparedStatement stat = conn.prepareStatement(sql);
            stat.setString(1,Sno);
            stat.executeUpdate();

            close(conn,stat);
        }
        /*
        * 分页功能查询方法
        * */
        public List<String[]> page(int beg,int end) throws SQLException {
            Connection conn = getConnection();
            String sql = "select * from student limit ?,?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1,beg);
            pst.setInt(2,end);
            ResultSet rs = pst.executeQuery();
            List<String[]> rel = resultSetProcessor(rs);
            close(conn,pst);
            return rel;
        }
        /*
        * 搜索功能查询
        * */
        public List<String[]> search(String flag,String field) throws Exception {
            String newField = "%"+field+"%";
            String sql = "";
            switch (flag) {
                case "1":
                    sql = "select * from student where Sno like ?";
                    break;
                case "2":
                    sql = "select * from student where Sname like ?";
                    break;
                case "3":
                    sql = "select * from student where Sdept like ?";
                    break;
                default:
                    throw new Exception("internal method error!!");
            }
            Connection conn = getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1,newField);
            ResultSet rs = pst.executeQuery();
            List<String[]> rel = resultSetProcessor(rs);
            close(conn,pst);
            return rel;
        }
    %>
</body>
</html>
