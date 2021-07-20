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
		<h4>Admin Dashboard - Edit Item</h4>
		<div class="adminTabs">
			<nav>
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<a class="nav-item nav-link active" id="nav-itemDetails-tab"
						data-toggle="tab" href="#nav-itemDetails" role="tab"
						aria-controls="nav-itemDetails" aria-selected="true">User
						Details</a> <a class="nav-item nav-link" id="nav-itemComments-tab"
						data-toggle="tab" href="#nav-itemComments" role="tab"
						aria-controls="nav-itemComments" aria-selected="false">Comments</a>
					<a class="nav-item nav-link" id="nav-itemPolls-tab"
						data-toggle="tab" href="#nav-itemPolls" role="tab"
						aria-controls="nav-itemPolls" aria-selected="false">Polls</a>
				</div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-itemDetails"
					role="tabpanel" aria-labelledby="nav-itemDetails-tab">
					<form action="editItemDetails.do" method=POST id="editItemDetails">
						<label for="id"> ID #: </label> <input type="text"
							class="form-control" id="id" name="id" value="${item.id}"
							readonly> <label for="name"> Title: </label> <input
							type="text" class="form-control" id="name" name="name"
							value="${item.name}"> <label for="description">
							Description: </label> <input type="text" class="form-control"
							id="description" name="description" value="${item.description}">
						<label for="dateCreated"> Date Created: </label> <input
							type="text" class="form-control" id="dateCreated"
							name="dateCreated" value="${item.dateCreated}" readonly>
						<label for="dateUpdated"> Date Updated: </label> <input
							type="text" class="form-control" id="dateUpdated"
							name="dateUpdated" placeholder="${item.dateUpdated}" readonly>
						<label for="isActive"> Active?: </label> <select id="isActive"
							name="isActive">
							<option value="${item.isActive}" selected hidden="true">${item.isActive}</option>
							<option value="true">True</option>
							<option value="false">False</option>
						</select><br> <label for="isPublicAtCreation"> Public?: </label> <select
							id="isPublicAtCreation" name="isPublicAtCreation">
							<option value="${item.isPublicAtCreation}" selected hidden="true">${item.isPublicAtCreation}</option>
							<option value="true">True</option>
							<option value="false">False</option>
						</select><br> <label for="imageUrl"> Image: </label> <input
							type="text" class="form-control" id="imageUrl" name="imageUrl"
							value="${item.imageUrl}"> <label for="entireLocation">
							Location: </label> <input type="text" class="form-control"
							id="entireLocation" name="entireLocation"
							value="${item.location.cityArea},
										${item.location.specificLocation},
										${item.location.countryCode.countryName}"
							readonly> <label for="userCreated"> Created By: </label>
						<input type="text" class="form-control" id="userCreated"
							name="userCreated" value="${item.createdByUser.username}"
							readonly>
						<button type='submit' id="saveChanges"
							class="btn btn-sm btn-success">Save Changes</button>
					</form>
				</div>
				<div class="tab-pane fade" id="nav-itemComments" role="tabpanel"
					aria-labelledby="nav-itemComments-tab">
					ALL COMMENTS FOR ITEM:
					<c:out value='${item.id}' />
					<table class="table">
						<thead>
							<tr>
								<th>ID #</th>
								<th>Comment</th>
								<th>Date Created</th>
								<th>Date Updated</th>
								<th>Image Url</th>
								<th>Created By</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var='comment' items='${item.comments}'
								varStatus='loopComment'>
								<tr>
									<td>${comment.id}</td>
									<td>${comment.commentText }</td>
									<td>${comment.dateCreated }</td>
									<td>${comment.dateUpdated }</td>
									<td>${comment.imageUrl }</td>
									<td>${comment.bucketItem.createdByUser.username}</td>
									<td>
										<form action="adminDeleteCommentFromItem.do" method=POST
											id="adminDeleteComment${loopComment.index}">
											<input type="number" class="form-control" id="idToDelete"
												name="idToDelete" value="${comment.id}" hidden='true'>
											<input type="number" class="form-control" id="itemId"
												name="itemId" value="${item.id}" hidden='true'>
											<button type='submit'
												form="adminDeleteComment${loopComment.index}"
												id="deleteComment" class="btn btn-sm btn-danger">Delete</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					END OF COMMENTS
				</div>

				<div class="tab-pane fade" id="nav-itemPolls" role="tabpanel"
					aria-labelledby="nav-itemPolls-tab">
					ALL POLLS FOR ITEM:
					<c:out value='${item.id}' />
					<table class="table">
						<thead>
							<tr>
								<th>ID #</th>
								<th>Rating</th>
								<th>Cost</th>
								<th>Best Time of Year</th>
								<th>Date Created</th>
								<th>Date Updated</th>
								<th>Created By</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var='poll' items='${item.polls}'
								varStatus='loopPoll'>
								<tr>
									<td>${poll.id}</td>
									<td>${poll.ratingStars }</td>
									<td>${poll.costDollarSigns }</td>
									<td>${poll.bestTimeToDo }</td>
									<td>${poll.dateCreated }</td>
									<td>${poll.dateUpdated }</td>
									<td>${poll.user.username}</td>
									<td>
										<form action="adminDeletePollFromItem.do" method=POST
											id="adminDeletePoll${loopPoll.index}">
											<input type="number" class="form-control" id="idToDelete"
												name="idToDelete" value="${poll.id}" hidden='true'>
											<input type="number" class="form-control" id="itemId"
												name="itemId" value="${item.id}" hidden='true'>
											<button type='submit' form="adminDeletePoll${loopPoll.index}"
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