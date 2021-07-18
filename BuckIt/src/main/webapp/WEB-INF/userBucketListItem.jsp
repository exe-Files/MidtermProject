<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<title>Bucket Item Details</title>
</head>
<body>
	<div>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="home.do">Bucket List</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a class="nav-link" href="#">Home
							<span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Explore</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">Action</a> <a
								class="dropdown-item" href="#">Another action</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#">Something else here</a>
						</div></li>
					<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a>
					</li>
				</ul>
				<form class="form-inline my-2 my-lg-0">
					<input class="form-control mr-sm-2" type="search"
						placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
				</form>
			</div>
		</nav>
	</div>
	
	
	
	<div class="container">
		<div class="row">
			<div class="col-6 offset-3">
				<!-- Needs Fixing -->
				<img src="#"/>
				<!-- How to incorporate Map? -->
			</div>
			<br>
			<div class="row">
				<div class="col-12">
					<ul class="nav nav-tabs">
						<li class="nav-item active"><a class="nav-link active" aira-current="page" href="#">Description</a></li>
						<li class="nav-item"><a class="nav-link" href="#">Comments</a></li>
						<li class="nav-item"><a class="nav-link" href="#">Ratings</a></li>
						<li class="nav-item"><a class="nav-link" href="#">Notes</a></li>
						<li class="nav-item"><a class="nav-link" href="#">Resources</a></li>
					</ul>
				</div>
				<div class="tab-content">
					<!-- Tab Content Goes Here -->
				</div>
				<div class="col-4 offset-8">
					<form action="editUserBucketItem.do" id="editUserItem">
						<input type="hidden" value="${userBucketItem.id }">
					</form>
					<form action="deleteUserBucketItem.do" id="deleteUserItem">
						<input type="hidden" value="${userBucketItem.id }">
					</form>
					<div class="btn-group">
						<button type="submit" class="btn btn-sm btn-warning" form="editUserItem" value="Edit">Edit</button>
						<button type="submit" class="btn btn-sm btn-danger" form="deleteUserItem" value="Delete">Delete</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Optional JS -->
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
</html>