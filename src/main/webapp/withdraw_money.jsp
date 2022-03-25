<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.testdelete.DatabaseConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: juzarbharmal
  Date: 24/03/22
  Time: 8:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Deposit Money</title>
</head>
<body>
<%
    String accountno = request.getParameter("accountno");
    String amount = request.getParameter("amount");


    try {
        Connection conn = DatabaseConnection.initializeDatabase();
        conn.setAutoCommit(false);

        PreparedStatement pstmt=conn.prepareStatement("UPDATE BALANCE SET BALANCE=BALANCE-? WHERE ACCNO=?");

        pstmt.setFloat(1, Float.parseFloat(amount));
        pstmt.setString(2,accountno);
        int status = pstmt.executeUpdate();
        pstmt = conn.prepareStatement("Insert into TRANSACTIONS (TRANSACTION_FROM,TRANSACTION_TYPE,TRANSACTION_TO,TRANSACTION_ID,TRANSACTION_AMOUNT) values(?,?,?,?,?)");
        pstmt.setString(1,accountno);
        pstmt.setString(2,"Cash");

        pstmt.setString(3,"self");

        String rand_int1 = UUID.randomUUID().toString();
        pstmt.setString(4, (rand_int1));
        pstmt.setFloat(5,Float.parseFloat(amount));
        pstmt.executeQuery();

        if(status == 1){
            conn.commit();
%>
        <script>
            alert("money deposited successfully");
            window.location.href = "http://localhost:8080/Bank/withdraw.jsp";

        </script>
<%
        }else{
            conn.rollback();
        }


    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

</body>
</html>

