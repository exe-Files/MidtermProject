<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link href="../css/home.css" rel="stylesheet" id="bootstrap-css">
<title>User Settings</title>
</head>
<body>
	<div>
		<nav class="navbar navbar-expand-lg navbar-light bg-light static-top">
			<a class="navbar-brand" href="home.do">BuckIt List</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="navi.do?userSelect=home">
							Home <span class="sr-only">(current)</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="navi.do?userSelect=explore">Explore</a>
					</li>

					<li class="nav-item">
						<a class="nav-link" href="navi.do?userSelect=userBucket">My
							BuckIt</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="navi.do?userSelect=settings">Settings</a>
					</li>

					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">Action</a>
							<a class="dropdown-item" href="#">Another action</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#">Something else here</a>
						</div>
					</li>
				</ul>
				<!-- <form class="form-inline my-2 my-lg-0">
					<input class="form-control mr-sm-2" type="search"
						placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
				</form> -->
			</div>
		</nav>
	</div>
	<div class="settingsForm">
		<div>
			<div>
				<h3>User Settings</h3>
			</div>
			<%-- <c:if test='${updateResult == "false"}'>
				<div class="alert alert-danger alert-dismissible fade show"
					role="alert">
					No changes made to user settings. Please try again.
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</c:if> --%>

			<form action="updatedSettings.do?id=${user.id}" method="POST">
				<div class="row">
					<div class="mb-auto">
						<div>
							<img src="${user.imageUrl}" alt="Profile Picture" class="avatar">
							<input name="imageUrl" class="form-control input-sm"
								placeholder="Profile Picture URL" value="${user.imageUrl}">
						</div>
						<br>
						<div>
							<label for="username">User Name: </label>
							<input name="username" class="form-control"
								placeholder="User Name" value="${user.username}" required>
						</div>
						<div>
							<label for="firstName">First Name: </label>
							<input name="firstName" class="form-control input-sm"
								placeholder="First Name" value="${user.firstName}">
						</div>
						<div>
							<label for="lastName">Last Name: </label>
							<input name="lastName" class="form-control input-sm"
								placeholder="Last Name" value="${user.lastName}">
						</div>
						<div>
							<label for="email">Email: </label>
							<input name="email" class="form-control input-sm"
								placeholder="Email" value="${user.email}" required>
						</div>
						<div>
							<label for="password">Password: </label>
							<input name="password" type="password"
								class="form-control input-sm" placeholder="Password"
								value="${user.password}" required>
						</div>
						<div class="text-center">
							<button class="btn btn-outline-dark w-75 mt-3" type="submit"
								value="Update">Submit</button>
						</div>
					</div>

				</div>
			</form>
		</div>
	</div>


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
</body>
</body>
</html>