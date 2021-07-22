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
<link href="css/home.css" rel="stylesheet" id="bootstrap-css">

<title>BuckIt, The #1 Bucket-List</title>
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

	<div class="container">
		<div class="card-deck">
			<div class="card" id="explore-item-card">
				<img
					src='https://media.istockphoto.com/vectors/filter-icon-vector-icon-simple-element-illustration-filter-symbol-vector-id1007786246?k=6&m=1007786246&s=170667a&w=0&h=THvnIMFDqpJBquWZ3XHTGIxbwcdS03AJCjkI2trPQ-M='
					class="card-img-top" alt="...">
				<div class="card-body">
					<h4 class="card-title">Filter By Category</h4>
					<h6 class="card-subtitle"></h6>
					<hr>
					<form action="filterByCategoryUserBucket.do" method=POST
						id="filterByCategory">
						<select id="categoryId" name="categoryId">
							<option value="-1">View All</option>
							<c:forEach var="category" items="${allCategories}">
								<option value="${category.id}">${category.categoryName }</option>
							</c:forEach>
						</select>
					</form>
				</div>
				<div class="card-footer">
					<button type='submit' form='filterByCategory'
						class='btn btn-sm btn-outline'>Search</button>
				</div>
			</div>

			<c:set var="cardsInRow" value="1" />
			<c:forEach var="item" items="${allUserBucketItems }">
				<c:if test="${cardsInRow == 3}">
		</div>
		<div class="card-deck">
			<c:set var="cardsInRow" value="0" />
			</c:if>
			<div class="card" id="explore-item-card">
				<img src='${item.bucketItem.imageUrl}' class="card-img-top"
					alt="...">
				<div class="card-body">
					<h4 class="card-title">${item.bucketItem.name}</h4>
					<c:if test='${item.bucketItem.location != null}'>
						<h6 class="card-subtitle">${item.bucketItem.location.cityArea }
							<c:if test='${item.bucketItem.location.countryCode != null}'>, ${item.bucketItem.location.countryCode.countryName }</c:if>
						</h6>
					</c:if>
					<hr>
					<p class="card-text">${item.bucketItem.description }</p>
				</div>
				<div class="card-footer">
					<p>Target Date: ${item.targetDate }</p>



					<div class="row">
						<div class="col">
							<c:if test="${item.isCompleted == true}">
								<button class="btn btn-sm btn-success btn-round"
									data-toggle="tooltip" title="Congratulations - You are living!"
									data-delay='{"show":"0", "hide":"0"}' disabled>&#10003</button>
							</c:if>

						</div>
						<div class="col">



							<form action="viewUserBucketItem.do" method=GET
								id="viewUserItemDetailed${item.id }">
								<input type="number" class="form-control" id="itemId"
									name="itemId" hidden='true' value='${item.id}'>
								<button type='submit' form='viewUserItemDetailed${item.id }'
									id="detailedViewBtn" class="btn btn-sm btn-primary">
									Detailed View</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<c:set var="cardsInRow" value="${cardsInRow +1 }" />
			</c:forEach>
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