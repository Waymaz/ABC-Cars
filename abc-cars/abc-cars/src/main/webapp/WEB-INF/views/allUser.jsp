<%@ page contentType="text/html; charset=US-ASCII" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<!DOCTYPE html>
<html>

<head>
  <!--  Enable Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!--  Access the Static Resources without using spring URL -->
  <link href="/ccs/allUser.css" rel="stylesheet" /> <!-- Adjust the CSS file path -->

  <style>
    @import url("https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap");

    * {
      font-family: "Quicksand", sans-serif;
    }

    body {
      background-color: #121212;
      color: #fff;
    }

    .table {
      background-color: #1e1e1e;
      color: #fff;
    }

    .table th,
    .table td {
      border-color: #343a40;
    }

    .modal-content {
      background-color: #2e2e2e;
      color: #fff;
    }

    .modal-header {
      border-bottom: none;
    }

    .btn {
      border-radius: 25px;
    }

    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    .btn-danger {
      background-color: #dc3545;
      border-color: #dc3545;
    }

    .btn-danger:hover {
      background-color: #c82333;
    }

    .modal-footer {
      border-top: none;
    }

    .form-control {
      background-color: #2e2e2e;
      color: #fff;
      border-color: #495057;
    }

    .form-control:focus {
      border-color: #66afe9;
    }

    .modal-dialog {
      background-color: transparent;
    }

    .modal-body {
      padding: 2rem;
    }

    .fas.fa-edit {
      color: #fff;
    }
  </style>
</head>

<body>

  <%@ include file="header.jsp" %>

    <section>
      <div class="container" style="min-height: 70vh; margin-top: 40px;">
        <h3 style="margin-bottom: 20px;">User Management</h3>

        <div class="row">
          <div class="col-12">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th scope="col">No.</th>
                  <th scope="col">Name</th>
                  <th scope="col">Username</th>
                  <th scope="col">Email</th>
                  <th scope="col">Role</th>
                  <th scope="col">Action</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${user}" var="u" varStatus="status">
                  <tr>
                    <th scope="row">${status.count}</th>
                    <td>${u.name}</td>
                    <td>${u.userName}</td>
                    <td>${u.email}</td>
                    <td>
                      <c:forEach items="${u.roles}" var="r">
                        ${r.name}
                        <!-- Button trigger modal -->
                        <button type="button" class="btn" data-bs-toggle="modal"
                          data-bs-target="#exampleModal1${status.index}">
                          <i class="fas fa-edit fa-sm"></i>
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal1${status.index}" tabindex="-1"
                          aria-labelledby="exampleModalLabel" aria-hidden="true" role="dialog">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Assign Role</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                  aria-label="Close"></button>
                              </div>
                              <div class="modal-body">

                                <!-- Assign Role Form -->
                                <form action="/assign_role" method="post" class="was-validated" modelAttribute="user">
                                  <input type="hidden" name="userId" value="${u.id}"> <!-- Change 'uid' to 'userId' -->
                                  <div class="mb-3 mt-3">
                                      <label for="roleName" class="form-label">Role:</label>
                                      <div class="form-check">
                                          <input class="form-check-input" type="radio" name="roleName" id="userRole${status.index}" value="USER" <c:if test="${r.name == 'USER'}">checked</c:if>>
                                          <label class="form-check-label" for="userRole${status.index}">User</label>
                                      </div>
                                      <div class="form-check">
                                          <input class="form-check-input" type="radio" name="roleName" id="adminRole${status.index}" value="ADMIN" <c:if test="${r.name == 'ADMIN'}">checked</c:if>>
                                          <label class="form-check-label" for="adminRole${status.index}">Admin</label>
                                      </div>
                                  </div>
                                  <button type="submit" class="btn btn-primary">Assign Role</button>
                                </form>
                              </div>
                            </div>
                          </div>
                        </div>
                      </c:forEach>
                    </td>
                    <td>
                      <a type="button" class="btn btn-primary" href="/view?uid=${u.id}">
                        <i class="far fa-eye"></i>
                      </a>
                      <button type="button" class="btn btn-success" data-bs-toggle="modal"
                        data-bs-target="#exampleModal${status.index}">
                        <i class="fas fa-edit"></i>
                      </button>
                      <div class="modal fade" id="exampleModal${status.index}" tabindex="-1"
                        aria-labelledby="exampleModalLabel" aria-hidden="true" role="dialog">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title" id="exampleModalLabel">Edit User</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                              <!-- User Update Form -->
                              <sf:form action="/edit?uid=${u.id}" method="post" class="was-validated"
                                modelAttribute="user">
                                <div class="mb-3 mt-3">
                                  <label for="name" class="form-label">Name:</label> <input type="text"
                                    class="form-control" placeholder="Enter name" name="name" value="${u.name}"
                                    required="true" />
                                  <div class="valid-feedback">Valid.</div>
                                  <div class="invalid-feedback">Please fill out this
                                    field.</div>
                                </div>
                                <div class="mb-3">
                                  <label for="userName" class="form-label">Username:</label>
                                  <input type="text" class="form-control" id="userName" placeholder="Enter username"
                                    name="userName" value="${u.userName}" required="true" />
                                  <div class="valid-feedback">Valid.</div>
                                  <div class="invalid-feedback">Please fill out this
                                    field.</div>
                                </div>

                                <div class="mb-3">
                                  <label for="email" class="form-label">Email:</label> <input type="email"
                                    class="form-control" placeholder="Enter username" name="email" value="${u.email}"
                                    required="true" />
                                  <div class="valid-feedback">Valid.</div>
                                  <div class="invalid-feedback">Please fill out this
                                    field.</div>
                                </div>
                                <div class="mb-3">
                                  <label for="mobile" class="form-label">Mobile:</label> <input type="text"
                                    class="form-control" id="mobile" placeholder="Enter mobile" name="mobile"
                                    value="${u.mobile}" required="true" />
                                  <div class="valid-feedback">Valid.</div>
                                  <div class="invalid-feedback">Please fill out this
                                    field.</div>
                                </div>
                                <div class="mb-3">
                                  <label for="address" class="form-label">Address:</label>
                                  <input type="text" class="form-control" id="address" placeholder="Enter address"
                                    name="address" value="${u.address}" required="true" />
                                  <div class="valid-feedback">Valid.</div>
                                  <div class="invalid-feedback">Please fill out this
                                    field.</div>
                                </div>

                                <button type="submit" class="btn btn-primary">Edit</button>
                              </sf:form>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                          </div>
                        </div>
                      </div>
                      <a type="button" class="btn btn-danger" href="/delete?uid=${u.id}">
                        <i class="far fa-trash-alt"></i>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </section>

    <%@ include file="footer.jsp" %>
</body>

</html>