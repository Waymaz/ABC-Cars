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
  <title>About Us | ABC Cars</title>

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

    /* Container for About Us section */
    .about-container {
      margin: 20px auto;
      max-width: 1000px;
    }

    h1,
    h2 {
      margin-bottom: 20px;
    }

    p {
      font-size: 16px;
      line-height: 1.6;
    }
  </style>
</head>

<body>
  <%@ include file="header.jsp" %>

  <div class="about-container" style="min-height: 60vh;">
    <h1>About Us</h1>
    <p>Welcome to ABC Cars! We are dedicated to providing quality vehicles and exceptional service to our customers. Our journey began over a decade ago, and we have been growing ever since. Here's what we're all about:</p>
    <h2>Our Mission</h2>
    <p>Our mission is to provide top-notch automotive solutions, offering a wide range of cars that cater to different needs and preferences. We strive to deliver exceptional customer service and ensure every customer leaves with a smile.</p>
    <h2>Our Team</h2>
    <p>Our team consists of passionate and experienced professionals who are dedicated to helping you find the perfect vehicle. Whether you need assistance with a purchase, maintenance, or any other aspect of automotive ownership, we're here to help.</p>
    <h2>Why Choose Us?</h2>
    <p>We believe in transparency, honesty, and reliability. When you choose ABC Cars, you can expect:</p>
    <ul>
      <li>Wide selection of quality vehicles</li>
      <li>Knowledgeable and friendly staff</li>
      <li>Competitive pricing</li>
      <li>Excellent customer service</li>
    </ul>
  </div>

  <%@ include file="footer.jsp" %>
</body>

</html>
