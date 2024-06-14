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
  <title>Login | ABC Cars</title>
  <!--  Enable Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!--  Access the Static Resources without using spring URL -->
  <link href="/css/login.css" rel="stylesheet" />

</head>

<body>
  <%@ include file="header.jsp" %>
    <div class="container my-3">
      <c:if test="${error_string != null}">
        <div class="alert alert-danger">${error_string} Click here to <a href="register">
            Register</a></div>
      </c:if>
    </div> 
    <!--ring div starts here-->
    <div class="ring">
      <i style="--clr:#00ff0a;"></i>
      <i style="--clr:#ff0057;"></i>
      <i style="--clr:#fffd44;"></i>
        <div class="login">
          <c:url var="post_url" value="/login" />
          <form action="${post_url}" method="post" class="was-validated">
            <h2>Login</h2>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="inputBx">
              <input type="text" id="userName"  name="username" value="" placeholder="Username" required>
            </div>
            <div class="inputBx">
              <input type="password" id="password" name="password" value="" placeholder="Password" required>
            </div>
            <div class="inputBx">
              <input type="submit" name="Login" value="Sign In">
            </div>
          </form>
          <div class="links">
            <a href="#">Forget Password</a>
            <a href="/register">Register</a>
          </div>
        </div>
    </div>
    <!--ring div ends here-->
    <%@ include file="footer.jsp" %>
</body>
</html>