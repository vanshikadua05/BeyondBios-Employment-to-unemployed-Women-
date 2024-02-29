<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    // Connect to the database and fetch employee profile data based on the provided ID
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String profileData = "{}"; // Default empty JSON object
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beyondbias?zeroDateTimeBehavior=convertToNull", "root", "root@bv1");

        String query = "SELECT * FROM jobseekerdata WHERE id=?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, id);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            // Construct JSON object manually
            profileData = "{\"name\": \"" + rs.getString("name") + "\","
                    + "\"email\": \"" + rs.getString("email") + "\","
                    + "\"location\": \"" + rs.getString("location") + "\","
                    + "\"info\": \"" + rs.getString("info") + "\","
                    + "\"password\": \"" + rs.getString("password") + "\","
                    + "\"contact\": \"" + rs.getString("contact") + "\"}";
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Send the profile data as JSON response
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(profileData);
%>
