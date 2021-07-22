<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>Bucket Item</title>
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
					<li class="nav-item"><a
						class="nav-link active active-underline"
						href="navi.do?userSelect=explore">Explore</a></li>
					<li class="nav-item">
						<div class="dropdown">
							<c:if test='${not empty loggedInUser}'>
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
									role="button" data-toggle="dropdown" aria-haspopup="true"
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

				<div class="row">
					<div class="col-sm-6">
						<img src="${bucketItem.imageUrl }" class="card-img-top"
							id="detailed-card-img" />
						<!-- How to incorporate Map? -->
					</div>
					<div class="col-sm-6">
						<div id="itemTitle">
							<h1>${bucketItem.name }</h1>
						</div>
						<hr>
						<div id="location-details">
							<h4>
								<c:if test='${bucketItem.location.specificLocation != null }'>
				${bucketItem.location.specificLocation}<br>
								</c:if>
								<c:if test='${bucketItem.location.cityArea != null }'>
				${bucketItem.location.cityArea}<br>
								</c:if>
								<c:if test='${bucketItem.location.countryCode != null }'>
				${bucketItem.location.countryCode.countryName}
				</c:if>
							</h4>
						</div>
						<br> <br>

						<div id="addItemFromDetailedBtn">
							<form action="addUserBucketItem.do" method=POST
								id="addItemToUserBucket${bucketItem.id }" hidden='true'>
								<input type="text" class="form-control" id="bucketItemIdToAdd"
									name="bucketItemIdToAdd" readonly hidden='true'
									value='${bucketItem.id}'>
							</form>
							<c:if test='${loggedInUser != null }'>
								<c:set var="btnDisabled" value="" />
								<c:set var="btnStyle" value="btn-outline-success" />
								<c:set var="message" value="Add to Your Bucket List" />
								<c:if test="${  fn:contains( allUserItems, bucketItem ) }">
									<c:set var="btnDisabled" value="disabled" />
									<c:set var="btnStyle" value="btn-success" />
									<c:set var="message"
										value="This item is already in your bucket" />
								</c:if>
								<button type='submit'
									form='addItemToUserBucket${bucketItem.id }'
									class="btn btn-lg ${btnStyle }" data-toggle="tooltip"
									title="${message}" data-delay='{"show":"0", "hide":"0"}'
									${btnDisabled}>${message}</button>
							</c:if>
						</div>
					</div>
					<!--  -->


					<div class="container tab-panel">
						<div class="col-10 offset-1">
							<ul class="nav nav-tabs" id="myTab" role="tablist">
								<li class="nav-item active"><a class="nav-link active"
									href="#desc" data-toggle="tab" id="description-tab" role="tab"
									aria-controls="description" aria-selected="true">Description</a></li>
								<li class="nav-item"><a class="nav-link" href="#comment"
									data-toggle="tab" id="comment-tab" role="tab"
									aria-controls="comment" aria-selected="false">Comments</a></li>
								<li class="nav-item"><a class="nav-link" href="#rating"
									data-toggle="tab" id="rating-tab" role="tab"
									aria-controls="rating" aria-selected="false">Ratings</a></li>
							</ul>
							<!-- Tab Content Goes Here -->
							<div class="tab-content" id="myTabContent">
								<div class="tab-pane fade show active" id="desc" role="tabpanel"
									aria-labelledby="desc-tab">
									<br>
									<p>${bucketItem.description }</p>
								</div>
								<div class="tab-pane fade" id="comment" role="tabpanel"
									aria-labelledby="comment-tab">
									<br>
									<c:forEach var="comment" items="${bucketItem.comments }">
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
										<form class="form" action="addComment.do" id=addComment>
											<input type="hidden" value="${bucketItem.id }"
												name="bucketItemId" /> 
											<textarea class="form-control" form="addComment" rows="3"
												cols="40" name="commentText"></textarea>
											<input type="submit" class="btn btn-primary form-control"
												value="Add Comment" />
										</form>
									</div>

								</div>

								<div class="tab-pane fade" id="rating" role="tabpanel"
									aria-labelledby="rating-tab">
									<form action="addPole.do">
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
												value="${bucketItem.id }" name="bucketItemId" /><input
												id="vote-btn" type="submit"
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
							</div>
						</div>
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
