	//호버 시 메인 이미지 변경 
	$(function() { 
		
		$(".hover").hover(function(){ 
			// console.log("올림");
			$(this).attr("src", $(this).attr("src").replace($(this).next().val(), $(this).next().next().val())); 
	
		}, function(){ 
			//console.log("내림");
			$(this).attr("src", $(this).attr("src").replace($(this).next().next().val(), $(this).next().val())); 
		}); 
	});