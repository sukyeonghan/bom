	var hostIndex = null;	
	function getContextPath() {
		hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
	
	var sock = null;
	
	$(document).ready( function(){
			connectWS();
			getContextPaht();
	});
	
	function connectWS(){
		
		sock = new SockJS(hostIndex+'/replyEcho');
	
		 sock.onopen = function() {
		     console.log('open');
		     sock.send('test');
		 };
		 
		 sock.onmessage = function(e) {
			 
		     console.log('message', e.data);
		     var data = e.data;
			   	console.log("ReceivMessage : " + data + "\n");
		 
			   	$.ajax({
					url : hostIndex+'/member/countAlarm',
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
	 
		 
		
		