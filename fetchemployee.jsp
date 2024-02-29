<%-- 
    Document   : fetchJobSeeker
    Created on : Jan 29, 2024, 11:19:58 PM
    Author     : LENOVO
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Details</title>
     <style>
         
         body {
            background-color: #ffffff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 300px;
            margin: 0 auto;
            padding: 20px;
           background-image: linear-gradient(#a0c7da, white);
            box-shadow:20px -19px 8px rgb(0 0 0 / 24%);
            border-radius: 10px;
            
            margin-top: 50px;
        }
        h2 {
            color:#1e5783;
            text-align: center;
        }
        input[type="text"],
        input[type="password"] {
            width: 90%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
     
        
         button[type="submit"] {
            width: 100%;
            background-color:#3ea5d5;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Employee Details</h2>
        <% 
            String email= request.getParameter("email");
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");
                String query = "SELECT * FROM employeedata WHERE email=?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                rs = stmt.executeQuery();
                if (rs.next()) {
        %>
                    <form action="updateemployee.jsp" method="POST">
                        <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                         <label for="id">Id:</label>
                        <input type="text" id="id" name="id" value="<%= rs.getString("id") %>" required><br>
                        
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required><br>
                      
                        <label for="location">Loction:</label>
                        <input type="text" id="location" name="location" value="<%= rs.getString("location") %>" required><br>
                        <label for="info">Info:</label>
                        <input type="text" id="info" name="info" value="<%= rs.getString("info") %>" required><br>
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" value="<%= rs.getString("password") %>" required><br>
                        <label for="contact">Contact:</label>
                        <input type="text" id="contact" name="contact" value="<%= rs.getString("contact") %>" required><br>
                        <button type="submit">Update</button><br>
                    </form>
                    <form action="deleteemployee.jsp" method="POST">
                        <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                        <br> <button type="submit">Delete</button>
                    </form>
        <% 
                } else {
        %>
                    <p>No employee found with the provided ID.</p>
        <% 
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>


















