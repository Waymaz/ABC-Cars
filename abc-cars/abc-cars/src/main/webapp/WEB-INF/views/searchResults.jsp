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
  <title>View Cars | ABC Cars</title>

  <!-- Bootstrap CSS and JS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!-- Custom CSS for dark mode -->
  <link href="../css/custom-dark.css" rel="stylesheet"> <!-- Adjust the path as needed -->

  <!-- Custom CSS for additional styling -->
  <style>
    @import url("https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap");

    * {
      font-family: "Quicksand", sans-serif;
    }

    body {
      background-color: #121212;
      color: white;
    }

    .card {
      background-color: #1e1e1e; /* Dark background color */
      color: #ffffff; /* Light text color */
      border: 1px solid #343a40; /* Dark border */
    }

    .card-title {
      color: #ffffff; /* Light title color */
    }

    .card-text {
      color: #b8b8b8; /* Light text color */
    }

    .btn-primary {
      background-color: #007bff; /* Primary button color */
    }

    .btn-primary:hover {
      background-color: #0056b3; /* Darker hover color */
    }
  </style>
</head>

<body>

  <%@ include file="header.jsp"%>

  <div class="container mt-4 mb-4" style="min-height: 70vh;">
    <c:if test="${empty searchCar}">
      <div class="alert alert-danger">No search results found for ${keyword}</div>
    </c:if>

    <!-- List of all cars posted -->
    <div class="row" style="gap: 60px;">
      <c:forEach items="${searchCar}" var="c">
        <div class="card" style="width: 400px">
          <img class="card-img-top" src="${c.photoImagePath}" alt="${c.photos}" style="width: 100%">
          <div class="card-body">
            <h4 class="card-title">${c.name}</h4>
            <p class="card-text">
              <i class="fas fa-tags"></i>&nbsp;PHP ${c.price}
            </p>
            <a href="/car_detail?cid=${c.id}" class="btn btn-primary">View Car Details</a>
          </div>
        </div>
      </c:forEach>
    </div>
    <!-- List of all cars posted -->
  </div>

  <%@ include file="footer.jsp"%>

</body>
</html>
