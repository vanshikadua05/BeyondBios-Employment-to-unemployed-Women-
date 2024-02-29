<%-- 
    Document   : emplog
    Created on : Jan 14, 2024, 7:00:00 PM
    Author     : LENOVO
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        <!-- Your CSS styles remain unchanged -->
    </style>
    <script>
        function showAlert(message) {
            alert(message);
        }
        function redirectToEmps() {
            window.location.href = 'emps.html';
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <%
            // JDBC Connection parameters for Apache Derby
            String url = "jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull";
            String user = "root";
            String password = "root@bv1";

            // Retrieve user input from the form
            String email = request.getParameter("email");
            String Password = request.getParameter("password");

            // Database connection and query
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");

                // Query to retrieve user information
                String query = "SELECT * FROM empregistration WHERE email=? AND password=?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                stmt.setString(2, Password);
                rs = stmt.executeQuery();

                // Check if the user exists in the database
                if (rs.next()) {
                    // User found, redirect to home.html
                    response.sendRedirect("homejobporatl.html");
                } else {
                    // User not found, display error message using JavaScript
        %>
                    <script>
                        showAlert("Error Incorrect credentials or Please register first.");
                  function redirectToEmps(){
            window.location.href = 'emps.html';
        };
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
        %>

        <!-- Your HTML form remains unchanged -->
    </div>
</body>
</html>
