<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    margin: 20px;
    background-color: white;
}

h2 {
    color:#1e5783;
    text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

table th, table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

table th {
    background-color: #3ea5d5;
    color: white;
}

a {
    display: block;
    text-align: center;
    margin-top: 20px;
    text-decoration: none;
    color: #3ea5d5;
}

a:hover {
    color: #1e5783;
}
       
       
    </style>
</head>
<body bgColor="pink" >
    <h2> Feedback </h2>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Email</th>
            <th>Feedback</th>
        </tr>
        <%
            String url = "jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull";
            String user = "root";
            String password = "root@bv1";
             Connection conn = null;
             Statement stmt = null;
             ResultSet rs = null;


            try {
                // Connect to the database
                Class.forName("com.mysql.jdbc.Driver");
                // Open a connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");

                 stmt = conn.createStatement();

                // Retrieve feedback records from the database
                String query = "SELECT * FROM feedback";
                 rs = stmt.executeQuery(query);

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("feedback") %></td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    // Close resources in the reverse order of opening
                    if (rs != null) {
                        rs.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
    <br>
    <a href="homejobporatl.html">Back to home page</a>
</body>
</html>
