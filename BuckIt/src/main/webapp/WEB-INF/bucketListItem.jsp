<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
						<a class="nav-link disabled" href="navi.do?userSelect=userBucket">My BuckIt</a>
					</li>
					<li class="nav-item">
						<a class="nav-link disabled" href="navi.do?userSelect=settings">Settings</a>
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
	</div>	<div>
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
						<a class="nav-link disabled" href="navi.do?userSelect=userBucket">My BuckIt</a>
					</li>
					<li class="nav-item">
						<a class="nav-link disabled" href="navi.do?userSelect=settings">Settings</a>
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



	<div class="container">
		<div class="row">
			<div class="col-8 offset-2">
				<img src="${bucketItem.imageUrl }" />
				<!-- How to incorporate Map? -->
			</div>
		</div>
	</div>
	<br>
	<h4>${bucketItem.name }</h4>
	<br>
	<div class="container">
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
				<p>${bucketItem.description }</p>
			</div>
			<div class="tab-pane fade" id="comment" role="tabpanel"
				aria-labelledby="comment-tab">
				<c:forEach var="comment" items="${bucketItem.comments }">
					<div class="media">
						<div class="media-body">${comment.commentText }</div>
					</div>
				</c:forEach>
			</div>
			<div class="tab-pane fade" id="rating" role="tabpanel"
				aria-labelledby="rating-tab">
				<table class="table">
					<thead class="thead-dark">
						<tr>
							<th>Stars</th>
							<th>Price</th>
							<th>Best Time to Complete</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rating" items="${bucketItem.polls }">
							<tr>
								<td>${rating.ratingStars }</td>
								<td>${rating.costDollarSigns }</td>
								<td>${rating.bestTimeToDo }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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