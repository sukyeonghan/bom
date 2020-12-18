	var sock = null;
	$(document).ready( function(){
			connectWS();
			
	});
	
	function connectWS(){
		
		/*sock = new SockJS( "/bom/replyEcho");*/
		sock = new SockJS( "<c:url value='/replyEcho'/>");

		
		
		 sock.onopen = function() {
		     console.log('open');
		     sock.send('test');
		 };
		 sock.onmessage = function(e) {
			 
		     console.log('message', e.data);
		     var data = e.data;
			   	console.log("ReceivMessage : " + data + "\n");
		 
			   	$.ajax({
					url : '/bom/member/countAlarm',
					type : 'POST',
					dataType: 'json',
					success : function(data) {
						if(data >0){
							$('#alarm-countbox').show();
							$('#alarm-countbox').html(data);
							
						}else{
							$('#alarm-countbox').hide();
						}
					},
					error : function(err){
						alert('err');
					}
			   	});
		 };
		 
		 
		 sock.onclose = function() {
		     console.log('close');
		 };
		 
	
	}
		
		
		