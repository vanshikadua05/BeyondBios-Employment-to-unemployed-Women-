<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.RequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@ page import="java.sql.*, java.io.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
// Database connection details
String url = "jdbc:mysql://localhost:3306/beyondbias";
String user = "root";
String password = "root@bv1";

// Directory to store uploaded files
String uploadDirectory = getServletContext().getRealPath("/") + File.separator + "uploads";
File uploadDir = new File(uploadDirectory);
if (!uploadDir.exists()) {
    uploadDir.mkdir();
}

// Process the form data and file upload
try {
    // Create a RequestContext from the current request
    RequestContext ctx = new ServletRequestContext(request);

    // Use ServletFileUpload with RequestContext
    ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
    List<FileItem> items = upload.parseRequest(ctx);

    // Form data
    String name = null;
    String jobid = null;
    String email = null;
    int age = 0;
    String skills = null;
    String qualification = null;
    String experience = null;
    String contact = null;
    String address = null;
    String resume = null;

    // Process form fields and file upload
    for (FileItem item : items) {
        if (item.isFormField()) {
            String fieldName = item.getFieldName();
            String fieldValue = item.getString("UTF-8");

            // Assign form field values to variables
            if ("name".equals(fieldName)) {
                name = fieldValue;
            } else if ("jobid".equals(fieldName)) {
                jobid = fieldValue;
            } else if ("email".equals(fieldName)) {
                email = fieldValue;
            } else if ("age".equals(fieldName)) {
                age = Integer.parseInt(fieldValue);
            } else if ("skills".equals(fieldName)) {
                skills = fieldValue;
            } else if ("qualification".equals(fieldName)) {
                qualification = fieldValue;
            } else if ("experience".equals(fieldName)) {
                experience = fieldValue;
            } else if ("contact".equals(fieldName)) {
                contact = fieldValue;
            } else if ("address".equals(fieldName)) {
                address = fieldValue;
            }
        } else {
            // Process file upload (resume)
            if (item.getSize() > 0) {
                String fileName = new File(item.getName()).getName();
                resume = uploadDirectory + File.separator + fileName;
                File storeFile = new File(resume);
                item.write(storeFile);
            } else {
                resume = ""; // Set resume to an empty string if no file is uploaded
            }
        }
    }

    // Establish the database connection
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");

        connection = DriverManager.getConnection(url, user, password);

        // SQL query to insert data into the database
        String sql = "INSERT INTO application (name, jobid,  email, age, skills, qualification, experience, contact, address, resume) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, jobid);
        preparedStatement.setString(3, email);
        preparedStatement.setInt(4, age);
        preparedStatement.setString(5, skills);
        preparedStatement.setString(6, qualification);
        preparedStatement.setString(7, experience);
        preparedStatement.setString(8, contact);
        preparedStatement.setString(9, address);
        preparedStatement.setString(10, resume);

        // Execute the query
        int rowsAffected = preparedStatement.executeUpdate();

        // Close the resources
        preparedStatement.close();
        connection.close();

        // Display success message if data inserted successfully
        if (rowsAffected > 0) {
%>
            <script>
                alert("Application submitted successfully! We will contact you further.");
                window.location.href = "homejobporatl.html"; // Redirect to home job portal page
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("Error in Application Submission. Please try again later.");
            window.location.href = "applyform.html"; // Redirect to apply form page
        </script>
<%
    } finally {
        // Close the database resources
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>
