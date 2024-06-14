
  <style>
    /* Custom styles for navbar */
    .navbar-nav {
      margin-right: 20px;
      /* Adjust the margin as needed */
    }

    .navbar-nav .nav-item {
      margin-right: 10px;
      /* Adjust the margin as needed */
    }
  </style>

<body>
  <header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
      <div class="container-fluid">
        <!-- Placeholder for logo -->
        <a class="navbar-brand" href="/cars">
          <img src="../images/logo_abccars.png" alt="ABC Cars Logo" style="height: 40px; width: 80px">
        </a>

        <!-- Toggler for mobile view -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
          aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar content -->
        <div class="collapse navbar-collapse" id="navbarNav">
          <!-- Navigation links -->
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link" href="/cars">Home</a>
            </li>
            <sec:authorize access="isAuthenticated()">
              <li class="nav-item">
                <a class="nav-link" href="/profile">Profile</a>
              </li>
              <sec:authorize access="hasRole('ADMIN')">
                <li class="nav-item">
                  <a class="nav-link" href="/users">User Management</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/all_cars">Car Management</a>
                </li>
              </sec:authorize>
            </sec:authorize>
          </ul>

          <!-- Logout link -->
          <sec:authorize access="isAuthenticated()">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" href="/logout">Logout</a>
            </li>
          </ul>
          </sec:authorize>

          <!-- Search form -->
          <sec:authorize access="isAuthenticated()">
          <form class="d-flex" action="search" method="get">
            <input class="form-control me-2" type="search" name="keyword" placeholder="Search" aria-label="Search"
              aria-describedby="search-addon">
            <button class="btn btn-outline-light rounded-pill" type="submit">Search</button>
          </form>
          </sec:authorize>
        </div>
      </div>
    </nav>
  </header>

  <!-- Bootstrap JS -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
