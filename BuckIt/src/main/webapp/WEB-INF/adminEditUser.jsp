<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="../css/admin.css" rel="stylesheet" id="bootstrap-css">

<title>Admin Dashboard</title>
</head>
<body class="homebg">
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
					<li class="nav-item active"><a class="nav-link"
						href="navi.do?userSelect=home"> Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="navi.do?userSelect=explore">Explore</a></li>

					<li class="nav-item"><a class="nav-link"
						href="navi.do?userSelect=userBucket">My BuckIt</a></li>
					<li class="nav-item"><a class="nav-link"
						href="navi.do?userSelect=settings">Settings</a></li>

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
				</ul>
				<!-- <form class="form-inline my-2 my-lg-0">
					<input class="form-control mr-sm-2" type="search"
						placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
				</form> -->
			</div>
		</nav>
	</div>
	<div class="container-fluid">
		<h4>Admin Dashboard - Edit User</h4>
		<div class="adminTabs">
			<nav>
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<a class="nav-item nav-link active" id="nav-userDetails-tab"
						data-toggle="tab" href="#nav-userDetails" role="tab"
						aria-controls="nav-userDetails" aria-selected="true">User Details</a> <a
						class="nav-item nav-link" id="nav-userComments-tab"
						data-toggle="tab" href="#nav-userComments" role="tab"
						aria-controls="nav-userComments" aria-selected="false">Comments</a>
				</div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-userDetails"
					role="tabpanel" aria-labelledby="nav-userDetails-tab">
					<form action="editUserDetails.do" method=POST id="editUserDetails">
						<label for="id"> ID #: </label>
						<input type="text" class="form-control" id="id" name="id" value="${user.id}" readonly>
						<label for="username"> Username: </label>
						<input type="text" class="form-control" id="username" name="username" value="${user.username}">
						<label for="password"> Password: </label>
						<input type="text" class="form-control" id="password" name="password" value="${user.password}">
						<label for="email"> Email: </label>
						<input type="text" class="form-control" id="email" name="email" value="${user.email}">
						<label for="firstName"> First Name: </label>
						<input type="text" class="form-control" id="firstName" name="firstName" value="${user.firstName}">
						<label for="lastName"> Last Name: </label>
						<input type="text" class="form-control" id="lastName" name="lastName" value="${user.lastName}">
						<label for="role"> Role: </label>
						<select id="role" name="role">
						 <option value="${user.role}" selected hidden='true'>${user.role}</option>
 						 <option value="admin">admin</option>
 						 <option value="user">user</option>
 						</select><br>
						<label for="isActive"> Active?: </label>
						<select id="isActive" name="isActive">
						 <option value="${user.isActive}" selected hidden="true">${user.isActive}</option>
 						 <option value="true">True</option>
 						 <option value="false">False</option>
 						</select><br>
						<label for="imageUrl"> Avatar Image: </label>
						<input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${user.imageUrl}">
						<button type='submit' id="saveChanges" class="btn btn-sm btn-success">Save Changes</button>
					</form>
				</div>
				<div class="tab-pane fade" id="nav-userComments" role="tabpanel"
					aria-labelledby="nav-userComments-tab">
					ALL COMMENTS FROM USER: <c:out value='${user.username}'/>
					<table class="table">
						<thead>
							<tr>
								<th>ID #</th>
								<th>Comment</th>
								<th>Date Created</th>
								<th>Date Updated</th>
								<th>Image Url</th>
								<th>Bucket List Item</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var='comment' items='${user.userComments}'
								varStatus='loopComment'>
								<tr>
									<td>${comment.id}</td>
									<td>${comment.commentText }</td>
									<td>${comment.dateCreated }</td>
									<td>${comment.dateUpdated }</td>
									<td>${comment.imageUrl }</td>
									<td>${comment.bucketItem.name}</td>
									<td>${comment.bucketItem.location.cityArea},
										${comment.bucketItem.location.specificLocation},
										${comment.bucketItem.location.countryCode.countryName}</td>
									<td>
										<form action="adminDeleteComment.do" method=POST id="adminDeleteComment${loopComment.index}">
											<input type="number" class="form-control" id="idToDelete" name="idToDelete" value="${comment.id}" hidden='true'>
											<input type="number" class="form-control" id="userId" name="userId" value="${user.id}" hidden='true'>
											<button type='submit' form="adminDeleteComment${loopComment.index}" id="deleteComment" class="btn btn-sm btn-danger">Delete</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					END OF COMMENTS
				</div>
			</div>

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
</html>