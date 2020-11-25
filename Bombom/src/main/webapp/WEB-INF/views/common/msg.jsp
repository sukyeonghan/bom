<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<script>
	swal({
		  title: "${title}",
		  text: "${msg}",
		  icon:"${icon}",
		  button:"확인",
		  closeOnClickOutside: false,
		}).then(function(){
			/* "${opener}";
			"${script}"; */
			location.replace("${pageContext.request.contextPath}${loc}");
		});
		
	</script>
</body>
</html>