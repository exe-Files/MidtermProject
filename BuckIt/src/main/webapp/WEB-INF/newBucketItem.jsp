<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
	
<link rel="stylesheet" href="css/utility.css">
<link href="css/home.css" rel="stylesheet" id="bootstrap-css">

<title>Create new bucket item</title>
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
<div class="container" id="addBucketItemContent">

		<h1>Please fill up your new bucket below:</h1>
		<!-- Photo upload and map functions -->
		<div class="row">
			<!-- The left column where the photo upload buttons go -->
			<div class="column">
				<img src="media/emptyBucket.png" alt="An empty bucket"
					width="20%"> <br> <br>
					
				<!-- Upload image input-->
				<div
					class="input-group mb-3 px-2 py-2 rounded-pill bg-white shadow-sm">
					<input id="upload" type="file" onchange="readURL(this);"
						class="form-control border-0"> <label id="upload-label"
						for="upload" class="font-weight-light text-muted">Upload
						your photo</label>
					<div class="input-group-append">
						<label for="upload" class="btn btn-light m-0 rounded-pill px-4">
							<i class="fa fa-cloud-upload mr-2 text-muted"></i><small
							class="text-uppercase font-weight-bold text-muted">Choose
								file</small>
						</label>
					</div>
				</div>

				<!-- Uploaded image area-->
				<p class="font-italic text-black text-center">Your image will
					appear here.</p>
				<div class="image-area mt-4">
					<img id="imageResult" src="#" alt=""
						class="img-fluid rounded shadow-sm mx-auto d-block">
<!-- 						<input hidden type="text" name="imageURL" value="#"></input>
 -->				</div>
			</div>

			<!-- Right column where the google maps functionality goes -->
			<div class="column">


				<!-- <div class="card-container">
					<div class="panel">
						<div>
							<img class="sb-title-icon"
								src="https://fonts.gstatic.com/s/i/googlematerialicons/location_pin/v5/24px.svg"
								alt=""> 
							<span class="sb-title">Address Selection</span>
						</div>
						<input type="text" placeholder="Address" id="location" /> 
						<input type="text" placeholder="Apt, Suite, etc (optional)" /> 
						<input type="text" placeholder="City" id="locality" />
						<div class="half-input-container">
							<input type="text" class="half-input" placeholder="State/Province" id="administrative_area_level_1" />
							<input type="text" class="half-input" placeholder="Zip/Postal code" id="postal_code" />
						</div>
						<input type="text" placeholder="Country" id="country" />
						<button class="button-cta">Confirm location</button>
					</div>
					<div class="map" id="map"></div>
				</div> -->
			</div>
		</div>

		<!-- The rest of the info for the form -->
		<form class="needs-validation" action="newbucketinfo.do" method="POST"
			id="newbucketitem" novalidate>
			<!-- Any hidden attributes to be passed to controller go here -->
			<input type="hidden" name="isActive" value="true">
			<!-- TODO add hidden url for default photo -->
						<input hidden="true" type="text" name="imageUrl" id="imageResultURL" value="#"></input>


			<!-- First row -->
			<div class="form-row">
				<div class="col-md-4 mb-3">
				
				<!-- TODO Turn this into a dropdown with all categories available in Category -->
					<div class="form-group">
    				<label for="addCat">Category</label>
  				
  				<select class="selectpicker" data-live-search="true" name="categoryId">
					<option selected value="-1" style="display:none"> -- select a category -- </option>
						<c:forEach var="category" items="${categories}">
						<option value="${ category.id }"> ${category.categoryName }</option>
						</c:forEach>	
					</select>
  				</div>	
					<br>
				
					<label for="place">Place</label> <input type="text"
						class="form-control" id="place" name="cityArea"
						placeholder="Where the magic happens" >
					<div class="valid-feedback">Looks good!</div>
					
					<select class="selectpicker" data-live-search="true" name="countryId">
					<option selected value="blank" style="display:none"> -- select a country -- </option>
						<c:forEach var="country" items="${countries}">
						<option value="${ country.countryCode }"> ${country.countryName }</option>
						</c:forEach>	
					</select>
					<br>
					<br>
					<label for="validationCustom01">Title</label> <input type="text"
						class="form-control" id="validationCustom01" name="name"
						placeholder="My bucket item" required>
					<div class="valid-feedback">Looks good!</div>

					<div class="btn-group btn-group-toggle" data-toggle="buttons">
  						<label class="btn btn-outline-primary active">
   						 <input type="radio" value="true" name="isPublicAtCreation" id="option1" checked> Public
  						</label>
  						<label class="btn btn-outline-primary">
    					 <input type="radio" value="false" name="isPublicAtCreation" id="option2"> Private
  						</label>
					</div>
					
				</div>

				<div class="col-md-12">
					<!-- <div class="stars">
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
					</div> -->
				</div>
			</div>


			<!-- Second row -->
			<div class="form-row">
				<div class="col-md-4 mb-3">
					<label for="validationCustom02">Description</label>
					<textarea class="form-control" id="validationCustom02" rows="4"
						cols="50" name="description" form="newbucketitem"
						placeholder="Skydiving over the Grand Canyon..." required></textarea>
					<div class="valid-feedback">Looks good!</div>
				</div>

				<div class="col-md-6 mb-3">
					<!-- Add public comments code here -->
				</div>
			</div>
			<br>
			<br>
			<button class="btn btn-primary" type="submit">Submit form</button>
		</form>
		<br>
</div>


		<script>
			// Example starter JavaScript for disabling form submissions if there are invalid fields
			(function() {
				'use strict';
				window
						.addEventListener(
								'load',
								function() {
									// Fetch all the forms we want to apply custom Bootstrap validation styles to
									var forms = document
											.getElementsByClassName('needs-validation');
									// Loop over them and prevent submission
									var validation = Array.prototype.filter
											.call(
													forms,
													function(form) {
														form
																.addEventListener(
																		'submit',
																		function(
																				event) {
																			if (form
																					.checkValidity() === false) {
																				event
																						.preventDefault();
																				event
																						.stopPropagation();
																			}
																			form.classList
																					.add('was-validated');
																		},
																		false);
													});
								}, false);
			})();
		</script>

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
	<!-- <script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U&libraries=places&callback=initMap&channel=GMPSB_addressselection_v1_cABC"
		async defer></script> -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
		
	<script src="javascript/picpicker.js"></script>
	<script src="javascript/googlemaps.js"></script>


</body>

</html>
