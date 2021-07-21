<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link href="../css/home.css" rel="stylesheet" id="bootstrap-css">
<title>Edit Details</title>
</head>
<body>
	<div>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
			<a class="navbar-brand" href="home.do">BuckIt List</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link"
							href="navi.do?userSelect=explore">Explore</a></li>
					<li class="nav-item">
						<div class="dropdown">
							<c:if test='${not empty loggedInUser}'>
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
									role="button" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false"> My Bucket </a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="navi.do?userSelect=userBucket">My
										Bucket List</a>
									<a class="dropdown-item" href="newbucketitem.do"> Add New
										Bucket List Item </a>
								</div>
							</c:if>
						</div>
					</li>
				</ul>
				<c:if test='${not empty loggedInUser}'>
					<div class=justify-content: flex-end>
						<div class="dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
								role="button" data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								<img src="${sessionScope.loggedInUser.imageUrl}"
									alt="Profile Picture" class="avatar" class="nav-item dropdown">
							</a>

							<div class="dropdown-menu dropdown-menu-right"
								aria-labelledby="navbarDropdown">
								<c:if test='${loggedInUser.role == "admin"}'>
									<a class="dropdown-item" href="adminHome.do">Admin Home</a>
								</c:if>
								<a class="dropdown-item" href="navi.do?userSelect=settings">Settings</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="logout.do">Log out</a>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</nav>
	</div>



	<div class="container-fluid">
		<div class="row">
			<div class="col-8 offset-2">
				<form action="updateUserBucketItem.do" class="form-group"
					id="updateUserItemDetails" method="post">
					<input type="hidden" name="id" value="${userBucketItem.id }">
					<label for="dateCompleted">Date Completed:</label>
					<input class="form-control" type="date" name="dateCompleted"
						id="dateCompleted" value="${userBucketItem.dateCompleted }"
						>
					<label for="targetDate">Target Date:</label>
					<input class="form-control" type="date" name="targetDate"
						id="targetDate" value="${userBucketItem.targetDate }">
					<label for="isCompleted">Complete:</label> &emsp;
					<input class="form-control-sm" type="radio" name="isCompleted"
						id="isCompleted" value="true" required>
					Yes &emsp;
					<input class="form-control-sm" type="radio" name="isCompleted"
						id="isCompleted" value="false">
					No <br>
					<input type="submit" class="btn btn-success" value="Save Changes" />
				</form>
				<div class="col-10 offset-1">
					<div class="col-6">
						<table class="table">
							<thead>
								<tr>
									<th>Note Title</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="note" items="${userBucketItem.notes }">
									<tr>
										<th scope="row">${note.noteTitle }</th>
										<td>
											<form action="deleteNote.do" method="post">
												<input type="hidden" name="bucketItemId"
													value="${userBucketItem.id }" />
												<input type="hidden" name="noteId" value="${note.id }" />
												<input type="submit" value="Delete" />
											</form>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="col-6">
						<table class="table">
							<thead>
								<tr>
									<th>URL</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="resource" items="${userBucketItem.resources }">
									<tr>
										<th scope="row">${resource.url }</th>
										<td>
											<form action="deleteResource.do" method="post">
												<input type="hidden" name="bucketItemId"
													value="${userBucketItem.id }" />
												<input type="hidden" name="resourceId"
													value="${resource.id }" />
												<input type="submit" value="Delete" />
											</form>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- <div class="col-2 offset-5">
			<button type="submit" class="btn btn-sm btn-primary" form="updateUserItemDetails" value="Save Changes">Save Changes</button>
		</div> -->
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