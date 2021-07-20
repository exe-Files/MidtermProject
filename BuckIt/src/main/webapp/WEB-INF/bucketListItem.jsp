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
<title>Bucket Item</title>
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
					<li class="nav-item active"><a class="nav-link"
						href="navi.do?userSelect=home"> Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="navi.do?userSelect=explore">Explore</a></li>

					<li class="nav-item"><a class="nav-link disabled"
						href="navi.do?userSelect=userBucket">My BuckIt</a></li>
					<li class="nav-item"><a class="nav-link disabled"
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


	<div class="container">
		<div class="row">
			<div class="col-8 offset-2">
				<img src="${bucketItem.imageUrl }" />
				<!-- How to incorporate Map? -->
			</div>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="offset-2">
			<h4>${bucketItem.name }</h4>
		</div>
	</div>
	<br>
	<div class="container">
		<div class="col-10 offset-1">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item active"><a class="nav-link active"
					href="#desc" data-toggle="tab" id="description-tab" role="tab"
					aria-controls="description" aria-selected="true">Description</a></li>
				<li class="nav-item"><a class="nav-link" href="#comment"
					data-toggle="tab" id="comment-tab" role="tab"
					aria-controls="comment" aria-selected="false">Comments</a></li>
				<li class="nav-item"><a class="nav-link" href="#rating"
					data-toggle="tab" id="rating-tab" role="tab" aria-controls="rating"
					aria-selected="false">Ratings</a></li>
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
					<c:forEach var="comment" items="${bucketItem.comments }">
						<div class="media">
							<div class="media-body">
								<h5 class="mt-0">${comment.user.firstName } ${comment.user.lastName }</h5>
								<p>${comment.commentText }</p>
							</div>
						</div>
					</c:forEach>
					<br>
					<!-- Add Comment / Might need work on Controller side -->
					<div class="offset-3">
						<form class="form-inline" action="addComment.do" id=addComment>
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
							<div class="col">
								<h5 class="d-flex justify-content-center">Rating</h5>
								<div class="stars">
									<input class="star star-5" value="5" id="star-5" type="radio"
										name="ratingStars" /> <label class="star star-5" for="star-5"></label>
									<input class="star star-4" value="4" id="star-4" type="radio"
										name="ratingStars" /> <label class="star star-4" for="star-4"></label>
									<input class="star star-3" value="3" id="star-3" type="radio"
										name="ratingStars" /> <label class="star star-3" for="star-3"></label>
									<input class="star star-2" value="2" id="star-2" type="radio"
										name="ratingStars" /> <label class="star star-2" for="star-2"></label>
									<input class="star star-1" value="1" id="star-1" type="radio"
										name="ratingStars" /> <label class="star star-1" for="star-1"></label>
								</div>
							</div>

							<div class="col">
								<h5 class="d-flex justify-content-center">Cost</h5>
								<div class="cost">
									<input class="cost cost-5" value="5" id="cost-5" type="radio"
										name="costDollarSigns" /> <label class="cost cost-5"
										for="cost-5"></label> <input class="cost cost-4" value="4"
										id="cost-4" type="radio" name="costDollarSigns" /> <label
										class="cost cost-4" for="cost-4"></label> <input
										class="cost cost-3" value="3" id="cost-3" type="radio"
										name="costDollarSigns" /> <label class="cost cost-3"
										for="cost-3"></label> <input class="cost cost-2" value="2"
										id="cost-2" type="radio" name="costDollarSigns" /> <label
										class="cost cost-2" for="cost-2"></label> <input
										class="cost cost-1" value="1" id="cost-1" type="radio"
										name="costDollarSigns" /> <label class="cost cost-1"
										for="cost-1"></label>
								</div>
							</div>
							<div class="col">
								<h5 class="d-flex justify-content-center">Best Time To Do</h5>
								<input type="text" name="bestTimeToDo" class="form-control"
									id="besttime" placeholder="ex. Fall">
							</div>
							<div class="col">
								<br> <br> <input type="hidden"
									value="${bucketItem.id }" name="bucketItemId" /> <input
									id="vote-btn" type="submit"
									class="btn btn-success btn-sm form-control" value="Vote" />
							</div>
						</div>
					</form>

					<hr>
					<div class="row">
						<div class="col">
							<h3 class="d-flex justify-content-center">
								<strong>Average Rating</strong>
							</h3>
							<h2 class="avg-rating d-flex justify-content-center">${avgStarRating}<i
									class="fa fa-bitbucket" aria-hidden="true"></i>
							</h2>
						</div>
						<div class="col">
							<h3 class="d-flex justify-content-center">
								<strong>Average Cost</strong>
							</h3>
							<h2 class="avg-rating d-flex justify-content-center">${avgCostRating}<i
									class="fa fa-usd" aria-hidden="true"></i>
							</h2>
						</div>
						<div class="col">
							<h3 class="d-flex justify-content-center">
								<strong>Best Time To Do</strong>
							</h3>
							<h2 class="avg-rating d-flex justify-content-center">${bestTimeToDo}</h2>
						</div>
						<div class="col"></div>
					</div>


					<!-- 				<table class="table"> -->
					<!-- 					<thead class="thead-dark"> -->
					<!-- 						<tr> -->
					<!-- 							<th>Stars</th> -->
					<!-- 							<th>Price</th> -->
					<!-- 							<th>Best Time to Complete</th> -->
					<!-- 						</tr> -->
					<!-- 					</thead> -->
					<!-- 					<tbody> -->
					<%-- 						<c:forEach var="rating" items="${bucketItem.polls }"> --%>
					<!-- 							<tr> -->
					<%-- 								<td>${rating.ratingStars }</td> --%>
					<%-- 								<td>${rating.costDollarSigns }</td> --%>
					<%-- 								<td>${rating.bestTimeToDo }</td> --%>
					<!-- 							</tr> -->
					<%-- 						</c:forEach> --%>
					<!-- 					</tbody> -->
					<!-- 				</table> -->
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