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
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
<link href="css/admin.css" rel="stylesheet" id="bootstrap-css">

<title>Admin Dashboard</title>
</head>
<body class="homebg">
	<div>
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
	</div>
<!-- NavBar End -->
<div id="content">
	<div class="container-fluid">
		<h4>Admin Dashboard</h4>
		
		<div class="adminTabs">
			<nav>
			
			<c:if test="${returnToTab == null}">
				<c:set var="navUsersClass" value="active"/>
				<c:set var="usersTabClass" value="show active"/>
				<c:set var="navItemClass" value=""/>
				<c:set var="itemTabClass" value=""/>
				<c:set var="navSiteClass" value=""/>
				<c:set var="SitewideTabClass" value=""/>
			</c:if>
			<c:if test="${returnToTab == 'item'}">
				<c:set var="navUsersClass" value=""/>
				<c:set var="usersTabClass" value=""/>
				<c:set var="navItemClass" value="active"/>
				<c:set var="itemTabClass" value="show active"/>
				<c:set var="navSiteClass" value=""/>
				<c:set var="SitewideTabClass" value=""/>
			</c:if>
			<c:if test="${returnToTab == 'sitewide'}">
				<c:set var="navUsersClass" value=""/>
				<c:set var="usersTabClass" value=""/>
				<c:set var="navItemClass" value=""/>
				<c:set var="itemTabClass" value=""/>
				<c:set var="navSiteClass" value="active"/>
				<c:set var="SitewideTabClass" value="show active"/>
			</c:if>
			
			
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<a class="nav-item nav-link ${navUsersClass}" id="nav-users-tab"
						data-toggle="tab" href="#nav-users" role="tab"
						aria-controls="nav-users" aria-selected="true">Users</a> 

					<a class="nav-item nav-link ${navItemClass}" id="nav-bucketitem-tab"
						data-toggle="tab" href="#nav-bucketitem" role="tab"
						aria-controls="nav-bucketitem" aria-selected="false">All
						Bucket Items</a>
						
					<a class="nav-item nav-link ${navSiteClass}" id="nav-sitewide-tab"
						data-toggle="tab" href="#nav-sitewide" role="tab"
						aria-controls="nav-sitewide" aria-selected="false">Sitewide</a>
				</div>
			</nav>
			
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade ${usersTabClass}" id="nav-users" role="tabpanel" aria-labelledby="nav-users-tab">
					<table class="table">
						<thead>
							<tr>
								<th>ID #</th>
								<th>Username</th>
								<th>Password</th>
								<th>Email</th>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Date Created</th>
								<th>Role</th>
								<th>Active</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var='user' items='${allUsers}' varStatus='loopUser'>
								<tr>
									<td><form action="adminEditUser.do" method=GET
											id="adminEditUser${loopUser.index }" hidden='true'>
											<input type="text" class="form-control"
												id="adminEditUser${loopUser.index }" name="adminUserToEdit"
												readonly hidden='true' value='${user.id}'>
										</form>
										<button type='submit' form='adminEditUser${loopUser.index }'
											id="adminEditBtn" class="btn btn-sm btn-secondary">${user.id }</button></td>
									<td>${user.username }</td>
									<td>**********</td>
									<td>${user.email }</td>
									<td>${user.firstName }</td>
									<td>${user.lastName }</td>
									<td>${user.dateCreated }</td>
									<td>${user.role }</td>
									<td>${user.isActive }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="tab-pane fade ${itemTabClass}" id="nav-bucketitem" role="tabpanel"
					aria-labelledby="nav-bucketitem-tab">
					<div class="row">
						<form action="adminFilterItemsByCreatedByUser" method=GET
							id="adminFilterItems">
							<select class="selectpicker" data-live-search="true"
								name="userId">
								<option selected value="-1" style="display: none">--
									Filter by User Created By --</option>
								<c:forEach var="user" items="${allUsers}">
									<option value="${ user.id }">${user.username }</option>
								</c:forEach>
							</select> <input type="submit" class="btn btn-sm btn-secondary"
								id="filterSubmitBtn">
						</form>
					</div>
					<table class="table">
						<thead>
							<tr>
								<th>ID #</th>
								<th>Title</th>
								<th>Description</th>
								<th>Date Created</th>
								<th>Date Updated</th>
								<th>Created By</th>
								<th>Location</th>
								<th>Public?</th>
								<th>Active?</th>
								<th>Image URL</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var='item' items='${allBucketItems}'
								varStatus='loopItem'>
								<tr>
									<td><form action="adminEditItem.do" method=GET
											id="adminEditItem${loopItem.index }" hidden='true'>
											<input type="text" class="form-control"
												id="adminEditItem${loopItem.index }" name="adminItemToEdit"
												readonly hidden='true' value='${item.id}'>
										</form>
										<button type='submit' form='adminEditItem${loopItem.index }'
											id="adminEditBtn" class="btn btn-sm btn-secondary">${item.id }</button></td>
									<td>${item.name }</td>
									<td>${item.description }</td>
									<td>${item.dateCreated }</td>
									<td>${item.dateUpdated }</td>
									<td>${item.createdByUser.username }</td>
									<td>${item.location.cityArea},
										${item.location.specificLocation},
										${item.location.countryCode.countryName}</td>
									<td>${item.isPublicAtCreation }</td>
									<td>${item.isActive }</td>
									<td><a href='${item.imageUrl }'>Image Link</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="tab-pane fade ${SitewideTabClass}" id="nav-sitewide" role="tabpanel" aria-labelledby="nav-sitewide-tab">
								<div class="row">
		<div class="column">
			
			<label>Categories</label>
			<form action="addCategory">
				<div class="form-group">
    				<label for="newCat">New Category Name</label>
    				<input type="text" class="form-control" id="newCat" name="categoryName" placeholder="category">
  				</div>	
			  <button type="submit" class="btn btn-primary">Add Category</button>
			</form>
		</div>
		<div class="column">
			<form action="deleteCategory">
		
				<div class="form-group">
    				<label for="delCat">Category to Remove</label>
  				</div>	
  				
  				<select class="selectpicker" data-live-search="true" name="id">
					<option selected value="blank" style="display:none"> -- select a category -- </option>
						<c:forEach var="category" items="${allCategories}">
						<option value="${ category.id }"> ${category.categoryName }</option>
						</c:forEach>	
					</select>
  					
			  <button type="submit" class="btn btn-warning">Delete Category</button>
			</form>
		</div>
		</div>
				</div>
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

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
</body>
</html>