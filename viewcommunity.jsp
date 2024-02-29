<%-- 
    Document   : veiwcommunity.jsp
    Created on : Feb 25, 2024, 11:09:51 PM
    Author     : LENOVO
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Jobs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-image: linear-gradient(#a0c7da, white);
            box-shadow:20px -19px 8px rgb(0 0 0 / 24%);
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

       h1 {
        color: #1e5783;
        text-align: center;
    }

        .job-box {
            border: 1px solid #ddd;
            padding: 20px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .job-title {
            font-size: 18px;
            font-weight: bold;
            color: #1e5783;
            margin-bottom: 10px;
        }

        .job-details {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        .apply-link {
            text-decoration: none;
            color: #3ea5d5;
            cursor: pointer;
            display: inline-block;
            padding: 8px 12px;
            background-color: #eee;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .apply-link:hover {
            background-color: #3ea5d5;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>View Community</h1>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias","root","root@bv1");
            Statement statement = connection.createStatement();

            String query = "SELECT * FROM job";
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
    %>
    <div class="job-box">
        <div class="job-title"><%= resultSet.getString("jobtitle") %></div>
        <div class="job-details">
            <strong>Community Name::</strong> <%= resultSet.getString("jobid") %><br>
            <strong>Community ID:</strong> <%= resultSet.getString("description") %><br>
            <strong>Community Purpose:</strong> <%= resultSet.getString("criteria") %><br>
            <strong>TC_Members:</strong> <%= resultSet.getString("vacancy") %><br>
             
        </div>
       
    </div>
    
    <%
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
     <a href="homejobporatl.html"  >Back to Home</a>
</div>


</body>
</html>
