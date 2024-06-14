<%@ page contentType="text/html; charset=US-ASCII" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register | ABC Cars</title>
  <!-- Enable Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!-- Link to register.css -->
  <link href="/css/register.css" rel="stylesheet" />

</head>

<body>
  <%@ include file="header.jsp" %>
    <div class="container my-3">
      <c:if test="${error_string != null}">
        <div class="alert alert-danger">${error_string} Click here to <a href="register">
            Register</a></div>
      </c:if> 
    </div>
    <c:if test="${success_register != null}">
    <div class="alert alert-success">
      ${success_register} Click here to<a href="login">Sign In</a>
    </div>
    </c:if>
      <!-- Ring div starts here -->
      <div class="ring">
        <i style="--clr:#00ff0a;"></i>
        <i style="--clr:#ff0057;"></i>
        <i style="--clr:#fffd44;"></i>
        <div class="register">
          <!-- Form to handle registration -->
          <c:url var="post_url" value="/register" />
          <form action="${post_url}" method="post" class="was-validated">
            <h2>Register</h2>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="inputBx">
              <input type="text" id="email" name="email" placeholder="Email" required>
            </div>
            <div class="inputBx">
              <input type="password" id="password" name="password" placeholder="Password" required>
            </div>
            <div class="inputBx">
              <input type="text" id="name" name="name" placeholder="Name" required>
            </div>
            <div class="inputBx">
              <input type="text" id="userName" name="userName" placeholder="Username" required>
            </div>
            <div class="inputBx">
              <input type="submit" value="Sign up">
            </div>
          </form>
          <div class="links">
            <a href="/login">Login</a>
          </div>
        </div>
      </div>
      <!-- Ring div ends here -->
      <%@ include file="footer.jsp" %>
</body>
</html>
