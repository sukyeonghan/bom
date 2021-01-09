
   
   function getContextPath() {
      var hostIndex = location.href.indexOf( location.host ) + location.host.length;
      var result=location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
      return result;
   };
   
   
   var sock = null;
   
   $(document).ready(function(){
         connectWS();
         
   });
   
   function connectWS(){
      
      sock = new SockJS(window.location.origin+getContextPath()+'/replyEcho');
   
       sock.onopen = function() {
           console.log('open');
           sock.send('test');
           console.log(typeof fnAlarm);
           if(typeof fnAlarm=='function'){
           		fnAlarm();
           }
       };
       
       sock.onmessage = function(e) {
          
           console.log('message', e.data);
 
           var data = e.data;
               console.log("ReceivMessage : " + data + "\n");
       
               $.ajax({
               url : getContextPath()+'/member/countAlarm',
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
    
