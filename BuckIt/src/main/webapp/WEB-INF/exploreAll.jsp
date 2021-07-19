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
					<li class="nav-item active"><a class="nav-link"
						href="navi.do?userSelect=explore">Explore<span class="sr-only">(current)</span></a></li>

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
		<div class="card-deck">
			<c:forEach var="item" items="${allPublicBucketItems }">
				<div class="card" id="explore-item-card">
					<img src='${item.imageUrl}' class="card-img-top" alt="...">
					<div class="card-body">
						<h4 class="card-title">${item.name }</h4>
						<c:if test='${item.location != null}'>
							<h6 class="card-subtitle">${item.location.cityArea }
								<c:if test='${item.location.countryCode != null}'>, ${item.location.countryCode.countryName }</c:if>
							</h6>
						</c:if>
						<hr>
						<p class="card-text">${item.description }</p>
					</div>
					<div class="card-footer">
						<form action="addUserBucketItem.do" method=POST
							id="addItemToUserBucket${item.id }" hidden='true'>
							<input type="text" class="form-control" id="bucketItemIdToAdd"
								name="bucketItemIdToAdd" readonly hidden='true'
								value='${item.id}'>
						</form>
						<c:if test='${loggedInUser != null }'>
							<button type='submit' form='addItemToUserBucket${item.id }'
								class="btn btn-sm btn-outline-success btn-round"
								data-toggle="tooltip" title="Add to Your Bucket List"
								data-delay='{"show":"0", "hide":"0"}'>&#10003</button>
						</c:if>
						<form action="viewDetailed.do" method=GET id="viewItemDetailed"
							hidden='true'>
							<input type="text" class="form-control" id="bucketItemIdToView${item.id }"
								name="bucketItemIdToView" readonly hidden='true'
								value='${item.id}'>
						</form>
						<button type='submit' form='viewItemDetailed${item.id }' id="detailedViewBtn"
							class="btn btn-sm btn-primary" data-toggle="tooltip"
							title="View Details" data-delay='{"show":"0", "hide":"0"}'>
							Detailed View</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script>
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
		})
	</script>

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