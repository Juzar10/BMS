<%--
  Created by IntelliJ IDEA.
  User: juzarbharmal
  Date: 24/03/22
  Time: 7:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String sessionid=(String)session.getAttribute("id");
    if(sessionid==null||sessionid.equals("")){
%>
<jsp:forward page="index.html"/>
<%}%>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>Transfer Amount</title>
    <link rel="stylesheet" href="dashboard.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

</head>

<body>
<jsp:include page="navbar.jsp"/>

<section class=" gradient-custom">
    <div class="container py-5 h-120">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-12 col-lg-9 col-xl-7">
                <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                    <div class="card-body p-4 p-md-5">
                        <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Transfer Amount</h3>

                        <form name="transfer_form" action="transfer_money.jsp">

                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <label  class="form-label" for="fromaccountno">From</label>
                                        <input type="text" pattern="[0-9]{14,14}" title="14-Digit Account Number" class="form-control form-control-lg"  id="fromaccountno" name="fromaccountno" required autocomplete="off" />

                                    </div>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <label  class="form-label" for="toaccountno">To</label>
                                        <input type="text" pattern="[0-9]{14,14}" title="14-Digit Account Number" class="form-control form-control-lg"  id="toaccountno" name="toaccountno" required autocomplete="off" />

                                    </div>
                                </div>

                            </div>
                            <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="form-outline">
                                    <label  class="form-label" for="amount">Amount</label>
                                    <input type="text" pattern="^[0-9]+(\.[0-9]{1,2})?$" title="Amount should be in range of 0-9 and followed by zero or more digit upto 2 decimal places" class="form-control form-control-lg"  id="amount" name="amount" required autocomplete="off" />

                                </div>
                            </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 mb-4">
                                    <div class="form-outline">
                                        <label class="form-label" for="transactionType">Choose a Transaction Type:</label>

                                        <select class="form-control form-control-lg address-textarea" name="transactionType" id="transactionType">
                                            <option value="Check">Check</option>
                                            <option value="Cash">Cash</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-4 pt-2">
                                <input class="btn btn-primary btn-lg" type="submit" value="Submit" />
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script id="rendered-js" >
    var fromaccno = document.getElementById("fromaccountno"),
        toaccno = document.getElementById("toaccountno");

    function validateAccountNo() {
        if (fromaccno.value == toaccno.value) {
            toaccno.setCustomValidity("Same Account Numbers not allowed!");
        } else {
           toaccno.setCustomValidity('');
        }
    }

    fromaccno.onchange = validateAccountNo;
    toaccno.onkeyup = validateAccountNo;
    //# sourceURL=pen.js
</script>

</body>
</html>
