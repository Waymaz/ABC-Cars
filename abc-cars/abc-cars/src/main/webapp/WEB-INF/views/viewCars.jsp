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
  <link href="/css/viewCars.css" rel="stylesheet" />
</head>

<body>
  <%@ include file="header.jsp" %>
  <div class="container">
    <!-- Home screen with image and welcoming text -->
    <div class="home-screen-container">
      <img src="../images/cars-home.jpg" alt="Welcome Image" class="home-screen-image" />
      <div class="home-screen-text">
        <h1><b>Welcome to ABC Cars!</b></h1>
        <p><b>Your one-stop destination for all things cars!</b></p>
      </div>
    </div>

    <!-- Row for "Sell Your Car" section -->
    <sec:authorize access="hasAnyRole('USER', 'ADMIN')">
      <div class="row p-3 mb-5 bg-dark text-white">
        <div class="col-md-5">
          <p class="font-weight-bold" style="margin-bottom: 0px;">Sell Your Car Today!</p>
          <p style="margin-bottom: 0px;">Sell your car in a click with us.</p>
        </div>
        <div class="col-md-4"></div>
        <div class="col-md-3 text-end" style="margin: auto;">
          <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#sellCarModal">
            Sell Now
          </button>

          <!-- Sell Car Modal -->
          <div class="modal fade" id="sellCarModal" tabindex="-1" aria-labelledby="sellCarModalLabel"
            aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content bg-dark text-white">
                <div class="modal-header">
                  <h5 class="modal-title" id="sellCarModalLabel">Sell Your Car Today!</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <!-- Car Post Form -->
                  <sf:form id="carPostForm" action="car_post" method="post" class="was-validated form-left-aligned"
                    modelAttribute="car" enctype="multipart/form-data">
                    <div class="mb-3">
                      <label for="name" class="form-label">Name:</label>
                      <sf:input type="text" class="form-control bg-dark text-white" placeholder="Enter car name"
                        name="name" path="name" required="true" />
                      <div class="valid-feedback">Valid.</div>
                      <div class="invalid-feedback">Please fill out this field.</div>
                    </div>
                    <div class="mb-3">
                      <label for="model" class="form-label">Model:</label>
                      <sf:input type="text" class="form-control bg-dark text-white" placeholder="Enter model"
                        name="model" path="model" required="true" />
                      <div class="valid-feedback">Valid.</div>
                      <div class="invalid-feedback">Please fill out this field.</div>
                    </div>
                    <div class="mb-3">
                      <label for="price" class="form-label">Price (PHP):</label>
                      <sf:input type="text" class="form-control bg-dark text-white" placeholder="Enter car price"
                        name="price" path="price" required="true" />
                      <div class="valid-feedback">Valid.</div>
                      <div class="invalid-feedback">Please fill out this field.</div>
                    </div>
                    <div class="mb-3">
                      <label for="make" class="form-label">Make Year:</label>
                      <sf:input type="text" class="form-control bg-dark text-white" placeholder="Enter make year"
                        name="make" path="make" required="true" />
                      <div class="valid-feedback">Valid.</div>
                      <div class="invalid-feedback">Please fill out this field.</div>
                    </div>
                    <div class="mb-3">
                      <label for="registration" class="form-label">Registration Date:</label>
                      <sf:input type="text" class="form-control bg-dark text-white"
                        placeholder="Enter registration date" name="registration" path="registration"
                        required="true" />
                      <div class="valid-feedback">Valid.</div>
                      <div class="invalid-feedback">Please fill out this field.</div>
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Photo:</label>
                      <input type="file" class="form-control bg-dark text-white" name="fileImage" id="photo"
                        accept="image/png, image/jpeg" required="true" />
                      <div class="valid-feedback">Valid.</div>
                      <div class="invalid-feedback">Please fill out this field.</div>
                    </div>

                    <div class="holder" style="height: 300px; width: 300px; margin: auto;">
                      <img id="imgPreview" src="#" alt="image preview" style="width: inherit;" />
                    </div>

                    <button type="submit" class="btn btn-dark">Post</button>
                  </sf:form>
                  <!-- Script for image preview -->
                  <script>
                    $(document).ready(() => {
                      $("#photo").change(function () {
                        const file = this.files[0];
                        if (file) {
                          const reader = new FileReader();
                          reader.onload = function (event) {
                            $("#imgPreview").attr("src", event.target.result);
                          };
                          reader.readAsDataURL(file);
                        }
                      });
                    });
                  </script>
                  <!-- End of Car Post Form -->
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </sec:authorize>

    <!-- Section for cars being sold -->
    <div class="text-center mb-4">
      <h2><b>Cars for Sale</b></h2>
      <p><b>Check out the cars our users are selling:</b></p>
    </div>  

    <!-- Row for list of all cars posted -->
    <div class="row mb-4" style="gap: 60px;" id="carsContainer">
      <c:forEach items="${cars}" var="car">
        <c:if test="${car.sellStatus != 'sold'}">
          <div class="card bg-dark text-white" style="width: 400px;">
            <img class="card-img-top" src="${car.photoImagePath}" alt="${car.photos}" style="width: 100%; height: 278px;">
            <div class="card-body">
              <h4 class="card-title">${car.name}</h4>
              <p class="card-text">
                <i class="fas fa-tags"></i>&nbsp;PHP ${car.price}
              </p>
              <a href="/car_detail?cid=${car.id}" class="btn btn-dark">View Car Details</a>
            </div>
          </div>
        </c:if>
      </c:forEach>
    </div>
    <!-- End of list of all cars posted -->
  </div>

  <%@ include file="footer.jsp" %>

</body>
</html>
