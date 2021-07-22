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
<link href="../css/home.css" rel="stylesheet" id="bootstrap-css">
<title>User Settings</title>
</head>
<body>
	<!-- NavBar Start -->
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
	<!-- NavBar End -->
<div id="content-settings">
	<div class="container-fluid">
		<h4>User Settings - Edit User</h4>
		<div class="userTabs">
			<nav>
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<a class="nav-item nav-link active" id="nav-userDetails-tab"
						data-toggle="tab" href="#nav-userDetails" role="tab"
						aria-controls="nav-userDetails" aria-selected="true">User
						Details</a>
					<a class="nav-item nav-link" id="nav-userComments-tab"
						data-toggle="tab" href="#nav-userComments" role="tab"
						aria-controls="nav-userComments" aria-selected="false">Comments</a>
					<a class="nav-item nav-link" id="nav-userPolls-tab"
						data-toggle="tab" href="#nav-userPolls" role="tab"
						aria-controls="nav-userPolls" aria-selected="false">Polls</a>
				</div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
				
				<div class="tab-pane fade show active" id="nav-userDetails"
					role="tabpanel" aria-labelledby="nav-userDetails-tab">
					<div class="settingsForm">
						<div class="container">
							<div class="row">
								<div class="col"></div>
								<div class="col-8">
									<h3>User Settings</h3>
									<c:if test='${updateResult}'>
										<div class="alert alert-success" role="alert">Settings Updated Successfully!</div>
									</c:if>
									<form action="updatedSettings.do?id=${user.id}" method="POST">
										<div class="mb-auto">
											<div>
												<label for="imageUrl">Profile Image: </label> <img
													src="${user.imageUrl}" alt="Profile Picture" class="avatar">
												<input name="imageUrl" class="form-control"
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
												<button type='submit' id="saveChanges"
													class="btn btn-sm btn-success btn-outline-dark w-75 mt-3"
													value="Update">Save Changes</button>
											</div>
										</div>

									</form>
								</div>
								<div class="col"></div>
							</div>
						</div>
					</div>

				</div>
				<div class="tab-pane fade" id="nav-userComments" role="tabpanel"
					aria-labelledby="nav-userComments-tab">
					ALL COMMENTS FROM USER:
					<c:out value='${user.username}' />
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
									<td>
										<form action="userDeleteCommentFromUser.do" method=POST
											id="userDeleteComment${loopComment.index}">
											<input type="number" class="form-control" id="idToDelete"
												name="idToDelete" value="${comment.id}" hidden='true'>
											<input type="number" class="form-control" id="userId"
												name="userId" value="${user.id}" hidden='true'>
											<button type='submit'
												form="userDeleteComment${loopComment.index}"
												id="deleteComment" class="btn btn-sm btn-danger">Delete</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					END OF COMMENTS
				</div>

				<div class="tab-pane fade" id="nav-userPolls" role="tabpanel"
					aria-labelledby="nav-userPolls-tab">
					ALL POLLS FROM USER:
					<c:out value='${user.username}' />
					<table class="table">
						<thead>
							<tr>
								<th>ID #</th>
								<th>Rating</th>
								<th>Cost</th>
								<th>Best Time of Year</th>
								<th>Date Created</th>
								<th>Date Updated</th>
								<th>Bucket List Item</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var='poll' items='${user.userPolls}'
								varStatus='loopPoll'>
								<tr>
									<td>${poll.id}</td>
									<td>${poll.ratingStars }</td>
									<td>${poll.costDollarSigns }</td>
									<td>${poll.bestTimeToDo }</td>
									<td>${poll.dateCreated }</td>
									<td>${poll.dateUpdated }</td>
									<td>${poll.bucketItem.name}</td>
									<td>
										<form action="userDeletePollFromUser.do" method=POST
											id="userDeletePoll${loopPoll.index}">
											<input type="number" class="form-control" id="idToDelete"
												name="idToDelete" value="${poll.id}" hidden='true'>
											<input type="number" class="form-control" id="userId"
												name="userId" value="${user.id}" hidden='true'>
											<button type='submit' form="userDeletePoll${loopPoll.index}"
												id="deletePoll" class="btn btn-sm btn-danger">Delete</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					END OF POLLS
				</div>

			</div>
		</div>
	</div>

	<div>
		<div>
			<!-- <c:if test='${updateResult == "false"}'>
				<div class="alert alert-danger alert-dismissible fade show"
					role="alert">
					No changes made to user settings. Please try again.
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</c:if> -->

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
</body>
</html>
