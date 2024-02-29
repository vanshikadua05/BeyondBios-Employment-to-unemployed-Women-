<%-- 
    Document   : securityq
    Created on : Jan 17, 2024, 2:47:04 PM
    Author     : LENOVO
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Security Question</title>
    <style>
        body {
            background-image: url('Women-Empowerment1.jpg');
            background-size: cover;
        }
        .container {
            width: 300px;
            margin: 0 auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
        h2 {
            text-align: center;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #0074D9;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
    <script>
        function showErrorMessage(message) {
            alert(message);
            redirectToLogin();
        }
        function redirectToReset() {
            window.location.href = 'resetj.html';
        }
        function redirectToLogin() {
            window.location.href = 'login.html';
        }
    </script>
</head>
<body>


<%
    String email = request.getParameter("email");
    String securityquestion = request.getParameter("securityquestion");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String correctsecurityquestion= "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");

        // Query to retrieve the correct security answer
        String query = "SELECT securityquestion FROM jobseekerregistration WHERE email=?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        rs = stmt.executeQuery();

        if (rs.next()) {
            correctsecurityquestion= rs.getString("securityquestion");
        } else {
    %>
            <script>
                showErrorMessage("Invalid username. Please try again.");
            </script>
    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close database resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    if (correctsecurityquestion.equals(securityquestion)) {
    %>
        <script>
            redirectToReset();
        </script>
    <%
    } else {
    %>
        <script>
            showErrorMessage("Answer does not match. Please try again.");
        </script>
    <%
    }
%>

</body>
</html>
