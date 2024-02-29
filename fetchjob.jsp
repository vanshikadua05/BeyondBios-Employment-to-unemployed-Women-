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
    .form-group {
            max-width: 400px;
            background-image: linear-gradient(#a0c7da, white);
            box-shadow:20px -19px 8px rgb(0 0 0 / 24%);
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    h2 {
        color:#1e5783;
        text-align: center;
    }
    input[type="text"],
    input[type="date"] {
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

         
   
</head>
<body>
    <div class="form-group">
        <h2>Job Seeker Details</h2>
        <% 
            String jobid= request.getParameter("jobid");
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");
                String query = "SELECT * FROM job WHERE jobid=?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, jobid);
                rs = stmt.executeQuery();
                if (rs.next()) {
        %>
                    <form action="updateJob.jsp" method="POST">
                        
                        <label for="jobtitle">Job Title:</label>
                        <input type="text" id="jobtitle" name="jobtitle" value="<%= rs.getString("jobtitle") %>" required><br>
                         <label for="jobid">Job Id:</label>
                        <input type="text" id="jobid" name="jobid" value="<%= rs.getString("jobid") %>" required><br>
                         <label for="description">Description:</label>
                        <input type="text" id="description" name="description" value="<%= rs.getString("description") %>" required><br>
                        <label for="criteria">Criteria:</label>
                        <input type="text" id="criteria" name="criteria" value="<%= rs.getString("criteria") %>" required><br>
                        
                        <label for="vacancy">Vacancy:</label>
                        <input type="text" id="vacancy" name="vacancy" value="<%= rs.getString("vacancy") %>" required><br>
                        <label for="deadline">Deadline:</label>
                        <input type="date" id="deadline" name="deadline" value="<%= rs.getString("deadline") %>" required><br>
                       
                        
                        <button type="submit">Update</button>
                    </form>
                    <form action="deleteJob.jsp" method="POST">
                        <input type="hidden" name="jobid" value="<%= rs.getString("jobid") %>">
                        <br><button type="submit">Delete</button>
                    </form>
        <% 
                } else {
        %>
                    <p>No job found with the provided ID.</p>
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


















