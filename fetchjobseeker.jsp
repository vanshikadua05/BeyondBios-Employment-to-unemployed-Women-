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
    <title>Job Seeker Details</title>
     <style>
         
    body {
        background-color: #f2f2f2;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        text-align: center;
        background-size: cover;
    }
    
    h2 {
        color: #1e5783;
        text-align: center;
    }
    .form-group {
            max-width: 400px;
            background-image: linear-gradient(#a0c7da, white);
            box-shadow:20px -19px 8px rgb(0 0 0 / 24%);
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    input[type="text"],
    input[type="password"],
    input[type="date"]
    {
         width: 100%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
    }
    button[type="submit"] {
        width: 48%; /* Adjusted width to fit side by side */
        background-color: #3ea5d5;
        color: #fff;
        padding: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
         display: inline-block; /* Added to display buttons inline */
    margin-right: 2%; /* Added margin between buttons */
}


</style>

         
    </style>
</head>
<body>
     <div class="form-group">
        <h2>Job Seeker Details</h2>
        <% 
            String email = request.getParameter("email");
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");
                String query = "SELECT * FROM jobseekerdata WHERE email=?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                rs = stmt.executeQuery();
                if (rs.next()) {
        %>
                    <form action="updateJobSeeker.jsp" method="POST">
                       
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required><br>
                         <label for="age">Age:</label>
                        <input type="text" id="age" name="age" value="<%= rs.getString("age") %>" required><br>
                         <label for="dob">Date of Birth:</label>
                        <input type="date" id="dob" name="dob" value="<%= rs.getString("dob") %>" required><br>
                        <label for="contact">Contact:</label>
                        <input type="text" id="contact" name="contact" value="<%= rs.getString("contact") %>" required><br>
                        <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                        <label for="address">Address:</label>
                        <input type="text" id="address" name="address" value="<%= rs.getString("address") %>" required><br>
                        <label for="skill">Skills:</label>
                        <input type="text" id="skill" name="skill" value="<%= rs.getString("skill") %>" required><br>
                        <label for="experience">Experience:</label>
                        <input type="text" id="info" name="experience" value="<%= rs.getString("experience") %>" required><br>
                        <label for="qualification">Qualification:</label>
                        <input type="text" id="qualification" name="qualification" value="<%= rs.getString("qualification") %>" required><br>
                        <label for="shift">Shift:</label>
                        <input type="text" id="shift" name="shift" value="<%= rs.getString("shift") %>" required><br>
                        
                        <button type="submit">Update</button>
                    </form>
                    <form action="deleteJobSeeker.jsp" method="POST">
                        <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                        <br><button type="submit">Delete</button>
                    </form>
        </div>
        <% 
                } else {
        %>
                    <p>No job seeker found with the provided ID.</p>
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
    
</body>
</html>


















