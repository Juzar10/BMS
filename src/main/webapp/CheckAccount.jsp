<%--
  Created by IntelliJ IDEA.
  User: Dhruv
  Date: 24-03-2022
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>

<%@page import="java.sql.*" %>
<%@ page import="com.example.testdelete.DatabaseConnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Account Details</title>
    <link rel="stylesheet" href="dashboard.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>


    <script>
        var ck_fname = /^[a-zA-Z]{3,128}$/;
        var ck_lname = /^[a-zA-Z]{3,128}$/;
        var ck_aadhar = /^[0-9]{12,12}$/;
        var ck_mobile = /^[0-9]{10,10}$/;
        var ck_password = /^[a-zA-Z0-9!@#$%^&*()_]{8,}$/;
        var ck_conpassword = /^[a-zA-Z0-9!@#$%^&*()_]{8,}$/;
        var ck_address = /^[a-zA-Z0-9\s,.'-]{3,}$/;

        function validateform(form) {

            var fname = form.fname.value;
            var lname = form.lname.value;
            var aadhar = form.aadhar.value;
            var mobile = form.mobile.value;
            var address = form.address.value;
            var errors = [];
            if (!ck_fname.test(fname)) {
                errors[errors.length] = "First Name should only contain alphabets and atleast of size 3!";
            }

            if (!ck_lname.test(lname)) {
                errors[errors.length] = "Last Name should only contain alphabets and atleast of size 3!";
            }

            if (!ck_aadhar.test(aadhar)) {
                errors[errors.length] = "Aadhar Number should be of 12 Digits!";
            }
            if (!ck_mobile.test(mobile)) {

                errors[errors.length] = "Mobile number must be of 10 digits!";
            }
            if (!ck_address.test(address)) {
                errors[errors.length] = "Address should be of atleast size 3 and may contain special symbols out of (\s,.'-)";
            }

            var userinput = form.dob.value;
            var dob = new Date(userinput);
            if (userinput == null || userinput == '') {
                errors[errors.length] = "Select your Birth Date";

            } else {

                //calculate month difference from current date in time
                var month_diff = Date.now() - dob.getTime();

                //convert the calculated difference in date format
                var age_dt = new Date(month_diff);

                //extract year from date
                var year = age_dt.getUTCFullYear();

                //now calculate the age of the user
                var age = Math.abs(year - 1970);

                //display the calculated age
                if (age < 18) {
                    errors[errors.length] = "Customer must be 18 years above in order to create bank account";
                }
            }

            if (errors.length > 0) {
                reportErrors(errors);
                return false;
            }
            return true;
        }

        function reportErrors(errors) {
            var msg = "Following Conditions should be Satisfied!\nKindly resolve them...";
            for (var i = 0; i < errors.length; i++) {
                var numError = i + 1;
                msg += "\n" + numError + ". " + errors[i];
            }
            alert(msg);
        }
    </script>
</head>
<body>

<%

    String sessionid = (String) session.getAttribute("id");

    if (sessionid == null || sessionid.equals("")) {
%>
<jsp:forward page="index.html"/>
<%
    }
    String get_accno = request.getParameter("accinput");
    try {

        //Step 1. Register the Driver
        Connection conn = DatabaseConnection.initializeDatabase();

        //Step 3. Create Statement
        PreparedStatement pstmt = conn.prepareStatement("Select * from CUSTOMERS where accno=?");
        pstmt.setString(1, get_accno);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
%>

<jsp:include page="navbar.jsp" />

<section class=" gradient-custom">
    <div class="container py-5 h-100">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-12 col-lg-9 col-xl-7">
                <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                    <div class="card-body p-4 p-md-5">
                        <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Edit Account Details</h3>
                        <form name="form" action="UpdateAccountDetails.jsp" onsubmit="return validateform(this)">

                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <label class="form-label" for="fname">First Name</label>
                                        <input type="text" name="fname" id="fname"
                                               value=<%=rs.getString(2)%> class="form-control form-control-lg" />

                                    </div>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <label class="form-label" for="lname">Last Name</label>
                                        <input type="text" name="lname" id="lname"
                                               value=<%=rs.getString(3)%> class="form-control form-control-lg" />

                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <label class="form-label" for="aadhar">Aadhar Number</label>
                                        <input type="text" class="form-control form-control-lg" id="aadhar"
                                               name="aadhar" value=<%=rs.getString(4)%> required autocomplete="off"/>


                                    </div>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <label class="form-label" for="contact">Contact Number</label>
                                        <input type="text" class="form-control form-control-lg" id="contact"
                                               name="mobile" value=<%=rs.getString(5)%> required autocomplete="off"/>

                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 mb-4">
                                    <div class="form-outline">
                                        <label class="form-label" for="address">Address</label>
                                        <textarea class="form-control form-control-lg address-textarea" id="address"
                                                  name="address" required autocomplete="off"
                                                  maxlength="200"><%=rs.getString(9)%></textarea>
                                    </div>
                                </div>


                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-4 d-flex align-items-center">

                                    <div class="form-outline datepicker w-100">
                                        <label for="birthdayDate" class="form-label">Birthday</label>
                                        <input
                                                onfocus="(this.type = 'date')" required autocomplete="off"
                                                type="text"
                                                class="form-control form-control-lg"
                                                id="birthdayDate"
                                                name="dob"
                                                value=<%=rs.getDate(6)%>
                                        />

                                    </div>

                                </div>
                                <div class="col-md-6 mb-4">

                                    <h6 class="mb-2 pb-1">Gender: </h6>

                                    <div class="form-check form-check-inline">
                                        <input
                                                class="form-check-input"
                                                type="radio"
                                                name="inlineRadioOptions"
                                                id="femaleGender"
                                                value="Female"
                                                <% if (rs.getString(9).equals("Female")) {%> checked <%}%>
                                        />
                                        <label class="form-check-label" for="femaleGender">Female</label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input
                                                class="form-check-input"
                                                type="radio"
                                                name="inlineRadioOptions"
                                                id="maleGender"
                                                value="Male"
                                                <% if (rs.getString(9).equals("Male")) {%> checked <%}%>

                                        />
                                        <label class="form-check-label" for="maleGender">Male</label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input
                                                class="form-check-input"
                                                type="radio"
                                                name="inlineRadioOptions"
                                                id="otherGender"
                                                value="Other"
                                                <% if (rs.getString(9).equals("Other")) {%> checked <%}%>

                                        />
                                        <label class="form-check-label" for="otherGender">Other</label>
                                    </div>

                                </div>
                            </div>



                            <input type="hidden" id="accno" name="accno" value=<%=get_accno%>>
                            <div class="mt-4 pt-2">
                                <input class="btn btn-primary btn-lg" type="submit" value="Edit"/>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('No Account Found');");
            out.println("location='EditAccountDetails.jsp';");
            out.println("</script>");
        }
    } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
