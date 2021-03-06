<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.testdelete.DatabaseConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: juzarbharmal
  Date: 24/03/22
  Time: 7:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.util.UUID" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String sessionid=(String)session.getAttribute("id");
    if(sessionid==null||sessionid.equals("")){
%>
<jsp:forward page="index.html"/>
<%}%>

<html>
<head>
    <title>Deposit Money</title>
</head>
<body>
<%
    String accountno = request.getParameter("accountno");
    String amount = request.getParameter("amount");
    String transactionType = request.getParameter("transactionType");

    try {
        Connection conn = DatabaseConnection.initializeDatabase();
        conn.setAutoCommit(false);
        PreparedStatement pstm=conn.prepareStatement("Select * from CUSTOMERS where accno=?");
        pstm.setString(1,accountno);
        ResultSet rs = pstm.executeQuery();
        if(rs.next()){
        pstm=conn.prepareStatement("UPDATE BALANCE SET BALANCE=BALANCE+? WHERE ACCNO=?");

        pstm.setFloat(1, Float.parseFloat(amount));
        pstm.setString(2,accountno);
        int status = pstm.executeUpdate();
        pstm = conn.prepareStatement("Insert into TRANSACTIONS (TRANSACTION_FROM,TRANSACTION_TYPE,TRANSACTION_TO,TRANSACTION_ID,TRANSACTION_AMOUNT) values(?,?,?,?,?)");
        pstm.setString(1,"self");
        pstm.setString(2,transactionType);
        pstm.setString(3,accountno);
        String rand_int1 = UUID.randomUUID().toString();
        pstm.setString(4, (rand_int1));
        pstm.setFloat(5,Float.parseFloat(amount));
        pstm.executeUpdate();

        if(status == 1) {
            conn.commit();

%>
        <script>
            alert("Money Deposited Successfully");
            window.location.href = "http://localhost:8080/Bank/deposit.jsp";

        </script>
<%
        }else{
            conn.rollback();

            %>
                <script>alert("An Error Occurred while depositing the amount");
                window.location.href = "http://localhost:8080/Bank/deposit.jsp";</script>
            <%
        }
        }else
        {
            %>
            <script>
                    alert("No Account Found!");
                    window.location.href = "http://localhost:8080/Bank/deposit.jsp";</script>

       <%
        }

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

</body>
</html>
