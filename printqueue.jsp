<html>
   <head>
        <meta http-equiv="Refresh" content="5;url=Print"> <!-- Reload Print page every 5 seconds -->
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <script language="javascript" type="text/javascript">
            <!--
            if (${printstring.isEmpty()}) {
                console.log("print queue is empty");
            } else {
                console.log("try creating activeXobject");
                var objDoc;
                try {
                    objDoc = new ActiveXObject("bpac.Document");
                } catch (e) {
                    console.log(e);
                }
                console.log(objDoc);
                console.log("created activeXobject");

                // console.log("${labeltemplatepath}");
                // if (objDoc.Open("C:/Users/Elliot/OneDrive - National University of Singapore/NUS/CAPTISS/Label Printer/label_template.lbx") != false) {

                if (objDoc.Open("${labeltemplatepath}") != false) {
                    console.log("process print string elements");
                    <c:set var = "splitprintstring" value = "${fn:split(printstring, ';')}" />
                    <c:forEach var="record" items="${splitprintstring}" varStatus="status">
                        <c:set var="splitrecord" value="${fn:split(record, ',')}" />
                        // 0:id, 1:name, 2:p1, 3:p2, 4:p3, 5:p4

                        if (${fn:length(splitrecord)} >= 6) {
                            objDoc.GetObject("name").Text = "${splitrecord[1]}";
                            objDoc.GetObject("qrcode").Text = "${splitrecord[0]}";
                            objDoc.GetObject("p1").Text = "${splitrecord[2]}";
                            objDoc.GetObject("p2").Text = "${splitrecord[3]}";
                            objDoc.GetObject("p3").Text = "${splitrecord[4]}";
                            objDoc.GetObject("p4").Text = "${splitrecord[5]}";
                            // console.log("cat 1 or 2");
                        } else {
                            objDoc.GetObject("name").Text = "${splitrecord[1]}";
                            objDoc.GetObject("qrcode").Text = "${splitrecord[0]}";
                            objDoc.GetObject("p1").Text = "${splitrecord[2]}";
                            // console.log("${splitrecord[2]}");
                        }

                        objDoc.StartPrint("",0);
                        objDoc.PrintOut(1,0);
                        objDoc.EndPrint();
                    </c:forEach>
                    objDoc.Close();
                } else {
                    console.log("failed to open template");
                }
            }
            -->
        </script>
      <title>Print Queue</title>
      <link rel="stylesheet" type="text/css" href="css/custom.css" >
      <link rel="stylesheet" type="text/css" href="css/button.css" >
      <link rel="stylesheet" type="text/css" href="css/admin.css" >
      <link rel="stylesheet" href="css/bootstrap.css">
      <link rel="stylesheet" href="css/w3.css">
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
      <script src="js/w3.js"></script>
      <script src="js/tableFilter.js"></script>
      <link rel="shortcut icon" href="https://captlife.com/wp-content/uploads/2017/12/cropped-CAPT_Logo_Vertical-32x32.png">
   </head>
   <body class="maincontent">
      <jsp:include page="header_navbar.jsp" />
      <div class="container">
         <div class="row">
            <div class="col-md-12">
               <h1>CAPTISS Print Page</h1>
               <form action = "Admin" method = "POST">
                  <input type="hidden" name="jsppage" value="/admin.jsp">
                  <a href="#" class="btn btn-sm animated-button victoria-one ">
                  <!-- <input type = "submit" value = "Refresh and backup" class="submitbutton" /></a> -->
                  <input type="button" value="Print" class="submitbutton" /></a>
               </form>

               <!-- Filter by names -->
               <input class="w3-input w3-border w3-padding" type="text" placeholder="Search for name..." id="nameFilterInput" onkeyup="sortTableByName()">
               <br />

               <table border="3" class="admintable" id="myTable">
                  <tr>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(1)')" style="cursor:pointer">No</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(2)')" style="cursor:pointer">Name</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(3)')" style="cursor:pointer">Organization</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(4)')" style="cursor:pointer">Category</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(5)')" style="cursor:pointer">P1</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(6)')" style="cursor:pointer">P2</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(7)')" style="cursor:pointer">P3</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(8)')" style="cursor:pointer">P4</th>
                     <th onclick="w3.sortHTML('#myTable','.item', 'td:nth-child(9)')" style="cursor:pointer">Time-In</th>
                  </tr>
                  <c:forEach items="${printqueue}" var="record" varStatus="status">
                     <tr class="item">
                        <td>${record}</td>
                        <td>${registrationrecords.get(record).get("name")}</td>
                        <td>${registrationrecords.get(record).get("org")}</td>
                        <td>${registrationrecords.get(record).get("cat")}</td>
                        <td>${registrationrecords.get(record).get("p1")}</td>
                        <td>${registrationrecords.get(record).get("p2")}</td>
                        <td>${registrationrecords.get(record).get("p3")}</td>
                        <td>${registrationrecords.get(record).get("p4")}</td>
                        <td>${registrationtime.get(record)}</td>
                     </tr>
                  </c:forEach>
               </table>
            </div>
         </div>
      </div>
   </body>
   <div class="footer">
      <p class="copyright">&copy Copyright 2018 College of Alice & Peter Tan. All Rights Reserved.</p>
   </div>
</html>