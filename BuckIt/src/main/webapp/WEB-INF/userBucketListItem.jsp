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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../css/utility.css" rel="stylesheet" id="bootstrap-css">
<link href="../css/home.css" rel="stylesheet" id="bootstrap-css">
<title>User Bucket Item</title>
</head>
<body class="homebg">
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
								<a class="nav-link dropdown-toggle active active-underline"
									href="#" id="navbarDropdown" role="button"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false"> My Bucket </a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="navi.do?userSelect=userBucket">My
										Bucket List</a> <a class="dropdown-item" href="newbucketitem.do">
										Add New Bucket List Item </a>
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
								aria-expanded="false"> <img
								src="${sessionScope.loggedInUser.imageUrl}"
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


	<div id="content">
		<div class="container">
			<div class="card" id="detailed-item-card">
				<c:if
					test='${addSuccessful == "Successfully added new item to your bucket!"}'>
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						Successfully added new item to your bucket!
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<c:if
					test='${editSuccessful == "Successfully updated item in your bucket!"}'>
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						Successfully updated an item in your bucket!
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>


				<div class="row">
					<div class="col-sm-6">
						<img src="${userBucketItem.bucketItem.imageUrl }"
							class="card-img-top" id="detailed-card-img" />
						<!-- How to incorporate Map? -->
					</div>
					<div class="col-sm-6">
						<div id="itemTitle">
							<h1>${userBucketItem.bucketItem.name }</h1>
						</div>
						<hr>
						<div id="location-details">
							<h4>
								<c:if
									test='${userBucketItem.bucketItem.location.specificLocation != null }'>
				${userBucketItem.bucketItem.location.specificLocation}<br>
								</c:if>
								<c:if
									test='${userBucketItem.bucketItem.location.cityArea != null }'>
				${userBucketItem.bucketItem.location.cityArea}<br>
								</c:if>
								<c:if
									test='${userBucketItem.bucketItem.location.countryCode != null }'>
				${userBucketItem.bucketItem.location.countryCode.countryName}
				</c:if>
							</h4>
						</div>
						<hr>
						<h5 id="itemDates">
							<br> <strong>Target Date:</strong>
							<c:choose>
								<c:when test='${userBucketItem.targetDate == null}'>No Target Date Set</c:when>
								<c:otherwise>${userBucketItem.targetDate}</c:otherwise>
							</c:choose>
							<br> <br> <strong>Date Completed:</strong>
							<c:choose>
								<c:when test='${userBucketItem.dateCompleted == null}'> Whats taking so long?</c:when>
								<c:otherwise>${userBucketItem.dateCompleted}</c:otherwise>
							</c:choose>
						</h5>
						<br> <br>


						<div class="btn-group edit-delete-group">
							<button type="submit" class="btn btn-sm btn-warning"
								form="editUserItem" value="Edit">Edit My Bucket Item</button>
							<button type="submit" class="btn btn-sm btn-danger"
								form="deleteUserItem" value="Delete">Delete My Bucket
								Item</button>
						</div>
						<br>

					</div>
				</div>
				<!--  -->
				
				<c:if test="${returnToTab == 'noteAdded' }">
					<c:set var="navDescClass" value=""/>
					<c:set var="descTabClass" value=""/>
					<c:set var="navCommentClass" value=""/>
					<c:set var="commentTabClass" value=""/>
					<c:set var="navRatingClass" value=""/>
					<c:set var="ratingTabClass" value=""/>
					<c:set var="navNotesClass" value="active"/>
					<c:set var="notesTabClass" value="show active"/>
					<c:set var="navResourcesClass" value=""/>
					<c:set var="resourcesTabClass" value=""/>
				</c:if>
				<c:if test="${returnToTab == 'resourceAdded' }">
					<c:set var="navDescClass" value=""/>
					<c:set var="descTabClass" value=""/>
					<c:set var="navCommentClass" value=""/>
					<c:set var="commentTabClass" value=""/>
					<c:set var="navRatingClass" value=""/>
					<c:set var="ratingTabClass" value=""/>
					<c:set var="navNotesClass" value=""/>
					<c:set var="notesTabClass" value=""/>
					<c:set var="navResourcesClass" value="active"/>
					<c:set var="resourcesTabClass" value="show active"/>
				</c:if>
				<c:if test="${returnToTab == null }">
					<c:set var="navDescClass" value="active"/>
					<c:set var="descTabClass" value="show active"/>
					<c:set var="navCommentClass" value=""/>
					<c:set var="commentTabClass" value=""/>
					<c:set var="navRatingClass" value=""/>
					<c:set var="ratingTabClass" value=""/>
					<c:set var="navNotesClass" value=""/>
					<c:set var="notesTabClass" value=""/>
					<c:set var="navResourcesClass" value=""/>
					<c:set var="resourcesTabClass" value=""/>
				</c:if>


				<div class="container">
					<div class="col-10 offset-1">
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item active"><a class="nav-link ${navDescClass }"
								href="#desc" data-toggle="tab" id="description-tab" role="tab"
								aria-controls="description" aria-selected="true">Description</a></li>
							<li class="nav-item"><a class="nav-link ${navCommentClass }" href="#comment"
								data-toggle="tab" id="comment-tab" role="tab"
								aria-controls="comment" aria-selected="false">Comments</a></li>
							<li class="nav-item"><a class="nav-link ${navRatingClass }" href="#rating"
								data-toggle="tab" id="rating-tab" role="tab"
								aria-controls="rating" aria-selected="false">Ratings</a></li>
							<li class="nav-item"><a class="nav-link ${navNotesClass }" href="#notes"
								data-toggle="tab" id="note-tab" role="tab" aria-controls="note"
								aria-selected="false">Notes</a></li>
							<li class="nav-item"><a class="nav-link ${navResourcesClass }" href="#resources"
								data-toggle="tab" id="resource-tab" role="tab"
								aria-controls="resource" aria-selected="false">Resources</a></li>
						</ul>
						<!-- Tab Content Goes Here -->
						<div class="tab-content" id="myTabContent">
							<div class="tab-pane fade ${descTabClass }" id="desc" role="tabpanel"
								aria-labelledby="desc-tab">
								<br>
								<p>${userBucketItem.bucketItem.description }</p>
							</div>
							<div class="tab-pane fade ${commentTabClass }" id="comment" role="tabpanel"
								aria-labelledby="comment-tab">
								<c:forEach var="comment"
									items="${userBucketItem.bucketItem.comments }">
									<div class="media">
										<!-- Profile Image here if we have time -->
										<div class="media-body">
											<p class="mt-0 left-by-user">${comment.user.firstName }
												${comment.user.lastName } &emsp; <em>${comment.dateCreated }</em>
											</p>

											<p class="mt-0">${comment.commentText }</p>
										</div>
									</div>
									<hr>
								</c:forEach>

								<div>
									<br>
									<form class="form" action="addCommentFromUserItem.do" id=addComment>
										<input type="hidden" value="${userBucketItem.bucketItem.id }"
											name="bucketItemId" /> <input type="hidden" value="${userBucketItem.id}"
											name="userBucketItemId" />
										<textarea class="form-control" form="addComment" rows="3"
											cols="40" name="commentText"></textarea>
										<input type="submit" class="btn btn-primary form-control"
											value="Add Comment" />
									</form>
								</div>
							</div>

							<div class="tab-pane fade ${ratingTabClass }" id="rating" role="tabpanel"
								aria-labelledby="rating-tab">
								<form action="addPoleFromUserItem.do">
									<div class="form-row">
										<div class="col rating-col">
											<h5 class="d-flex justify-content-center">Rating</h5>
											<div class="stars">
												<input class="star star-5" value="5" id="star-5"
													type="radio" name="ratingStars" /> <label
													class="star star-5" for="star-5"></label> <input
													class="star star-4" value="4" id="star-4" type="radio"
													name="ratingStars" /> <label class="star star-4"
													for="star-4"></label> <input class="star star-3" value="3"
													id="star-3" type="radio" name="ratingStars" /> <label
													class="star star-3" for="star-3"></label> <input
													class="star star-2" value="2" id="star-2" type="radio"
													name="ratingStars" /> <label class="star star-2"
													for="star-2"></label> <input class="star star-1" value="1"
													id="star-1" type="radio" name="ratingStars" /> <label
													class="star star-1" for="star-1"></label>
											</div>
										</div>

										<div class="col rating-col">
											<h5 class="d-flex justify-content-center">Cost</h5>
											<div class="cost">
												<input class="cost cost-5" value="5" id="cost-5"
													type="radio" name="costDollarSigns" /> <label
													class="cost cost-5" for="cost-5"></label> <input
													class="cost cost-4" value="4" id="cost-4" type="radio"
													name="costDollarSigns" /> <label class="cost cost-4"
													for="cost-4"></label> <input class="cost cost-3" value="3"
													id="cost-3" type="radio" name="costDollarSigns" /> <label
													class="cost cost-3" for="cost-3"></label> <input
													class="cost cost-2" value="2" id="cost-2" type="radio"
													name="costDollarSigns" /> <label class="cost cost-2"
													for="cost-2"></label> <input class="cost cost-1" value="1"
													id="cost-1" type="radio" name="costDollarSigns" /> <label
													class="cost cost-1" for="cost-1"></label>
											</div>
										</div>
										<div class="col rating-col">
											<h5 class="d-flex justify-content-center">Best Time To
												Do</h5>
											<input type="text" name="bestTimeToDo" class="form-control"
												id="besttime" placeholder="ex. Fall">
										</div>
									</div>
									<div class="form-row">
										<br> <br> <input type="hidden"
											value="${userBucketItem.bucketItem.id }" name="bucketItemId" />
										<input type="hidden" value="${userBucketItem.id}"
											name="userBucketItemId" />
										<input id="vote-btn" type="submit"
											class="btn btn-success btn-sm form-control" value="Vote" />
									</div>
								</form>


								<hr>
								<div class="row">
									<div class="col-4">
										<h3 class="d-flex justify-content-center">
											<strong>Average Rating</strong>
										</h3>
										<h2 class="avg-rating d-flex justify-content-center">${avgStarRating}<i
												class="fa fa-bitbucket" aria-hidden="true"></i>
										</h2>
									</div>
									<div class="col-4">
										<h3 class="d-flex justify-content-center">
											<strong>Average Cost</strong>
										</h3>
										<h2 class="avg-rating d-flex justify-content-center">${avgCostRating}<i
												class="fa fa-usd" aria-hidden="true"></i>
										</h2>
									</div>
									<div class="col-4">
										<h3 class="d-flex justify-content-center">
											<strong>Best Time To Do</strong>
										</h3>
										<h2 class="avg-rating d-flex justify-content-center">${bestTimeToDo}</h2>
									</div>
									<div class="col"></div>
								</div>
							</div>

							<div class="tab-pane fade ${notesTabClass }" id="notes" role="tabpanel"
								aria-labelledby="notes-tab">
								<div class="col-12">
									<table class="table">
										<thead class="thead-secondary">
											<tr>
												<th colspan="4">Title</th>
												<th colspan="8">Note</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="note" items="${userBucketItem.notes }">
												<tr>
													<th colspan="4">${note.noteTitle }</th>
													<td colspan="8">${note.noteText }</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<form action="addNote.do" method="post" id="addNote">
										<div class="form-group">
											<input type="hidden" name="bucketItemId"
												value="${userBucketItem.id }" /> <label for="noteTitle">Title:</label>
											<input type="text" class="form-control" id="noteTitle"
												name="noteTitle" value="${note.noteTitle }" /> <label
												for="text">Note:</label>
											<textarea class="form-control" form="addNote" name="noteText"
												rows="4" cols="50"></textarea>
											<input type="submit" class="btn btn-success form-control"
												value="Add Note" />
										</div>
									</form>
								</div>
							</div>
							<div class="tab-pane fade ${resourcesTabClass }" id="resources" role="tabpanel"
								aria-labelledby="resource-tab">
								<ul>
									<c:forEach var="resource" items="${userBucketItem.resources }">
										<li><a href='${resource.url }'>${resource.url }</a></li>
									</c:forEach>
								</ul>
								<form action="addResource.do" method="post" id="addResource">
									<div class="form-group">
										<input type="hidden" name="bucketItemId"
											value="${userBucketItem.id }" /> <label for="url">Full URL (must include http://www.):</label>
										<input type="url" class="form-control" id="url" name="url" /> 
										<input type="submit" class="btn btn-success form-control" value="Add Resource" />
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="container">
					<div class="col-4 offset-8">
						<form action="editUserBucketItem.do" id="editUserItem">
							<input type="hidden" name="id" value="${userBucketItem.id }">
						</form>
						<form action="deleteUserBucketItem.do" id="deleteUserItem"
							method="post">
							<input type="hidden" value="${userBucketItem.id }" name="id">
						</form>
					</div>
				</div>

				<div class="container">
					<div class="col-8 offset-2"></div>
				</div>
			</div>
		</div>
	</div>

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