<%@ page contentType="text/html; charset=US-ASCII" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<!DOCTYPE html>
<html>

<head>
  <!-- Enable Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!-- Dark Theme CSS -->
  <link href="/css/carDetail.css" rel="stylesheet" />
</head>

<body>

  <%@ include file="header.jsp" %>

    <c:forEach items="${car}" var="c">
      <c:set var="id" value="${c.id}"></c:set>
      <c:set var="name" value="${c.name}"></c:set>
      <c:set var="image" value="${c.photoImagePath}"></c:set>
      <c:set var="make" value="${c.make}"></c:set>
      <c:set var="model" value="${c.model}"></c:set>
      <c:set var="registration" value="${c.registration}"></c:set>
      <c:set var="price" value="${c.price}"></c:set>
      <c:set var="sellStatus" value="${c.sellStatus}"></c:set>
    </c:forEach>

    <div class="center-container">
      <div class="card mb-5">
        <div class="row g-0 main-row">
          <div class="col-md-6 border-end">
            <div class="d-flex flex-column justify-content-center">
              <div class="main_image">
                <img src="${image}" id="main_product_image" width="100%" class="img-fluid" alt="Car Image">
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="p-3 right-side">
              <div class="d-flex justify-content-between align-items-center">
                <h3>${name}</h3>
              </div>
              <div class="my-3 mx-5 content">
                <div class="d-flex">
                  <div style="width: 300px;">
                    <span class="fw-bold">Condition</span>
                    <p style="font-size: 16px;">
                      <i class="fas fa-car"></i> Used Car
                    </p>
                  </div>
                  <div>
                    <span class="fw-bold">Manufacture Year</span>
                    <p style="font-size: 16px;">
                      <i class="fas fa-calendar"></i> ${make}
                    </p>
                  </div>
                </div>
                <div class="d-flex">
                  <div style="width: 300px;">
                    <span class="fw-bold">Model</span>
                    <p style="font-size: 16px;">
                      <i class="fas fa-tag"></i> ${model}
                    </p>
                  </div>
                  <div>
                    <span class="fw-bold">Registration Date</span>
                    <p style="font-size: 16px;">
                      <i class="fas fa-calendar"></i> ${registration}
                    </p>
                  </div>
                </div>
              </div>
              <c:if test="${sellStatus == 'sold'}">
                <h3>Car Sold!</h3>
              </c:if>
              <c:if test="${sellStatus != 'sold'}">
                <div>
                  <span class="fw-bold">Current Price</span>
                  <h3>PHP ${price}</h3>
                </div>
                <div class="mt-4">
                  <span class="fw-bold">Current Bid</span>
                  <c:if test="${empty highest}">
                    <h3>PHP 0</h3>
                  </c:if>
                  <c:if test="${not empty highest}">
                    <h3>PHP ${highest}</h3>
                  </c:if>
                </div>
                <div class="buttons d-flex flex-row mt-5 gap-3 justify-content-center">
                  <!-- Button trigger modal for booking -->
                  <button type="button" class="btn btn-outline-dark" data-bs-toggle="modal"
                    data-bs-target="#exampleModal1" style="width: 500px;">Book for Test
                    Drive</button>
                  <!-- Modal for booking -->
                  <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModal1Label"
                    aria-hidden="true">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h5 class="modal-title" id="exampleModal1Label">Book for Test Drive
                          </h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                          <!-- Book Form -->
                          <sf:form action="book" method="post" class="was-validated" modelAttribute="booking">
                            <div class="mb-3 mt-3">
                              <label for="bookDate" class="form-label">Booking
                                Date:</label>
                              <input type="date" class="form-control" name="bookDate" required="true" />
                              <div class="valid-feedback">Valid.</div>
                              <div class="invalid-feedback">Please fill out this field.
                              </div>
                            </div>

                            <input type="hidden" name="cid" value="${id}">

                            <button type="submit" class="btn btn-primary">Book on this
                              Date</button>
                          </sf:form>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- Button trigger modal for bidding -->
                  <button type="button" class="btn btn-dark" data-bs-toggle="modal"
                    data-bs-target="#exampleModal">Bid</button>
                  <!-- Modal for bidding -->
                  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h5 class="modal-title" id="exampleModalLabel">Car Bidding</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                          <!-- Bid Form -->
                          <sf:form action="bid" method="post" class="was-validated" modelAttribute="bidding">
                              <div class="mb-3 mt-3">
                                  <label for="name" class="form-label">Bid Price (PHP):</label>
                                  <input type="number" class="form-control" placeholder="Enter bidding price" name="bidderPrice" required="true" step="0.01" />
                                  <div class="valid-feedback">Valid.</div>
                                  <div class="invalid-feedback">Please fill out this field.</div>
                              </div>

                              <input type="hidden" name="cid" value="${id}">

                              <button type="submit" class="btn btn-primary">Bid at this price</button>
                          </sf:form>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </c:if>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- List of car bidders -->
    <c:if test="${not empty bid}">
      <div class="container mt-5">
        <div class="row justify-content-center">
          <div class="col-12">
            <h3 class="text-center mb-4">Bidding & Booking Status</h3>
            <table class="table table-bordered">
              <thead class="table-dark">
                <tr>
                  <th scope="col">Name</th>
                  <th scope="col">Bidding Date</th>
                  <th scope="col">Bidding Price (PHP)</th>
                  <th scope="col">Test Drive Book Date</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${bid}" var="b">
                  <tr>
                    <td>${b.bidderName}</td>
                    <td>${b.bidDate}</td>
                    <td>${b.bidderPrice}</td>
                    <td>${b.bookDate}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </c:if>

    <%@ include file="footer.jsp" %>

</body>

</html>