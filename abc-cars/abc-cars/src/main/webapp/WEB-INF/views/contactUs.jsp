<%@ page contentType="text/html; charset=US-ASCII" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us | ABC Cars</title>

  <!-- Bootstrap CSS and JS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!-- Custom CSS -->
  <style>
    @import url("https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap");
   
    * {
      font-family: "Quicksand", sans-serif;
    }
    body {
      background-color: #121212;
      color: white;
    }

    /* Container for Contact Us section */
    .contact-container {
      margin: 20px auto;
      max-width: 1000px;
    }

    h1 {
      margin-bottom: 20px;
    }

    form {
      max-width: 500px;
    }

    label {
      margin-bottom: 5px;
    }

    .form-control {
      margin-bottom: 15px;
    }
  </style>
</head>

<body>
  <%@ include file="header.jsp" %>

  <div class="contact-container">
    <h1>Contact Us</h1>
    <p>If you have any questions, comments, or concerns, we'd love to hear from you. Please fill out the form below, and one of our team members will get back to you as soon as possible.</p>

    <form action="contact" method="post">
      <div class="mb-3">
        <label for="name" class="form-label">Name</label>
        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
      </div>
      <div class="mb-3">
        <label for="message" class="form-label">Message</label>
        <textarea class="form-control" id="message" name="message" rows="4" placeholder="Enter your message" required></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Send Message</button>
    </form>

    <h2>Contact Details</h2>
    <p>Address: 123 Main Street, City, State, ZIP</p>
    <p>Phone: (123) 456-7890</p>
    <p>Email: contact@abccars.com</p>
  </div>

  <%@ include file="footer.jsp" %>
</body>

</html>
