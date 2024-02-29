<%-- 
    Document   : createcommunity
    Created on : Feb 26, 2024, 7:17:48 AM
    Author     : LENOVO
--%>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Community</title>
    <style>
        /* Your CSS styles here */
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Community</h2>

        <%
            String ID = request.getParameter("jobseekeremail");
            String name = request.getParameter("jobseekername");
            String email = request.getParameter("communityname");
            String contact = request.getParameter("communityid");
            String location = request.getParameter("communitypurpose");
            String info = request.getParameter("communitymembers");

            try {
                if ( email != null && email.endsWith("@banasthali.in")) {
                    // Check if contact is a positive long
                    if (Long.parseLong(contact) > 0) {
                        // Rest of the code...

                        // Example: Inserting data into the database
                        Connection conn = null;
                        PreparedStatement insertStmt = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");

                            String insertQuery = "INSERT INTO communitydata (ID, name, email, location, info, contact) VALUES ( ?, ?, ?, ?, ?, ?)";
                            insertStmt = conn.prepareStatement(insertQuery);
                            insertStmt.setString(1, ID);
                            insertStmt.setString(2, name);
                            insertStmt.setString(3, email);
                            insertStmt.setString(4, location);
                            insertStmt.setString(5, info);
                            
                            insertStmt.setString(7, contact); // Set as string

                            int rowsAffected = insertStmt.executeUpdate();

                            if (rowsAffected > 0) {
        %>
                                <script>
                                    alert("Community created successfully!");
                                    window.location.href = "homejobporatl.html"; // Redirect to the home page
                                </script>
        <%
                            } else {
        %>
                                <script>
                                    alert("Error creating community. Please try again.");
                                    window.history.back(); // Go back to the previous page
                                </script>
        <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
        %>
                            <script>
                                alert("Invalid email. Please try again.");
                                window.history.back(); // Go back to the previous page
                            </script>
        <%
                        } finally {
                            // Close resources in the reverse order of their creation
                            try {
                                if (insertStmt != null) {
                                    insertStmt.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    } else {
        %>
                        <script>
                            alert("Contact number should be a positive long.");
                            window.history.back(); // Go back to the previous page
                        </script>
        <%
                    }
                } else {
        %>
                    <script>
                        alert("Invalid email format or email should end with '@banasthali.in'. Please try again.");
                        window.history.back(); // Go back to the previous page
                    </script>
        <%
                }
            } catch (NumberFormatException e) {
        %>
                <script>
                    alert("Error parsing contact number. Please enter a valid number.");
                    window.history.back(); // Go back to the previous page
                </script>
        <%
            }
        %>
    </div>
</body>
</html>


