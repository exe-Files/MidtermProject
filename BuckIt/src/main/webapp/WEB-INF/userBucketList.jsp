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

<title>BuckIt, The #1 Bucket-List</title>
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
					<li class="nav-item"><a class="nav-link"
						href="navi.do?userSelect=home"> Home </a></li>
					<li class="nav-item"><a class="nav-link"
						href="navi.do?userSelect=explore">Explore<span class="sr-only">(current)</span></a></li>

					<li class="nav-item active"><a class="nav-link disabled"
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
		<div class="card-deck">
			<c:forEach var="item" items="${allUserBucketItems }">
				<div class="card" id="explore-item-card">
					<img src='${item.bucketItem.imageUrl}' class="card-img-top" alt="...">
					<div class="card-body">
						<h4 class="card-title">${item.bucketItem.name }</h4>
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
						<form action="viewUserBucketItem.do" method=GET id="viewUserItemDetailed${item.id }">
							<input type="number" class="form-control" id="itemId"
								name="itemId" hidden='true'
								value='${item.id}'>
						<button type='submit' form='viewUserItemDetailed${item.id }' id="detailedViewBtn"
							class="btn btn-sm btn-primary">
							Detailed View</button>
						</form>
					</div>
				</div>
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