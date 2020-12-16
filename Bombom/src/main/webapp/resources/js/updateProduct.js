//옵션 추가하기 
$("#add-option").click(function(){
    
    var addOption="";
    addOption+='<tr name="trOption">';
    addOption+='<th>&nbsp&nbsp옵션 내용</th>';
    addOption+='<td><input type="text" class="content" id="content" name="pdtOptionContent"></td>';
    addOption+='<th>추가 요금</th>';
    addOption+='<td><input type="text" class="addprice" name="pdtOptionAddprice">';
    addOption+='<button class="btn btn-success btn-sm delBtn2" name="delBtn">삭제</button></td>';
    addOption+='</tr>';

    $("#insert-table").append(addOption);
});

//옵션 삭제 
/*$(document).on("click","button[name=delBtn]",function(){

    var trHtml=$(this).parent().parent();
    trHtml.remove();
});*/

	
	//옵션내용 유효성 검사-따로 밖으로 뺌
	$(document).on("focusout","input[name=pdtOptionContent]",function(e){
	  var check=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_,/ ]*$/;
	  var name=$("input[name=pdtOptionContent]").val();
	
	  if(!check.test(name)){
			swal("옵션명에 특수문자는 입력할 수 없습니다.");
			$(e.target).val('');
	         return false;
	    }
	  if(name==''){
	      swal("옵션 내용을 입력해주세요.");
	      return false;
	  }
	  
	});
	
	//옵션가격 유효성 검사
	$(document).on("focusout","input[name=pdtOptionAddprice]",function(e) {
	    var check=/^[-0-9]*$/;
	    //price=$("input[name=pdtOptionAddprice]").val();
	    if(!check.test($("input[name=pdtOptionAddprice]").val())){
	           swal("옵션 가격에 숫자 외에는 입력하실 수 없습니다.");
	           $(e.target).val('');
	           return false;
	       } 
	    if($("input[name=pdtOptionAddprice]").val()==''){
	        swal("옵션 가격을 입력해주세요.");
	        return false;
	    }
	    
	});

	//상세이미지 파일명 바꾸기
	$(function(){
			$('[name=detailImg]').on("change",function(){
			
				var filename=$(this).prop('files')[0].name;
				$(this).prev(".fileBtn").html(filename);
			});
		});
	
	//상세이미지 파일 업로드
	$("#fileBtn").on("click",e=>{
		$(e.target).next().next().click();
	});

	//이미지 업로드 
	$(function(){
	       //div 클릭시 파일업로드
	       $(".proDiv").on("click",e=>{

	           //input file만 선택
	           var file=$(e.target).children().first();
	           file.click();
	    
	       });
	     
	       //파일 업로드시 이미지 체인지
	       $(".proPic").on("change",e =>{ 
	         
	            let reader=new FileReader();
	              let div=$(e.target).parent();
	              //이전 사진 삭제
	            $(e.target).prev().remove();

	             reader.onload=e=>{
	              let img=$("<img>",{"src":e.target.result,width:"150px",height:"150px",onclick:"fn_upload(this);"});
	              img.addClass("proImg");
	              div.prepend(img); 

	          }
	          reader.readAsDataURL($(e.target)[0].files[0]);
	       }); 
	    
	});

	//사진 눌렀을 떄 다시 파일 업로드
	  function fn_upload(e){
	    $(e).next().click();
	}  

	//이미지 삭제 버튼
	$(function(){
	    $(".close").on("click",e=>{	  
	        //이미지 삭제
	        $(e.target).prev().prev().remove();
	        //input file value삭제
	        console.log($(e.target).prev());
	        $(e.target).prev().val("");
	       });
	});
	
		//제품 수정
	function updatePro(){
		if(confirm("정말 수정하시겠습니까?")==true){ 
		
	  	//제품명 유효성 검사
	  	var val=$("#name").val();
	  	if(val.length>0){
	  		
	  		var name=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_,/ ]*$/;
	        console.log(val);
	        if(!name.test(val)){
	               swal("제품명에 특수문자는 입력하실 수 없습니다.");
	               $("#name").val('');
	               return false;
	          }
	      	//중복검사
	       $.ajax({
	            
	            url:"${path}/admin/updateCheckPdtName",
	            data:{"pdtName":val,"pdtNo":$(product.pdtNo)},
	            type:"get",
	            success:function(data){
	                 console.log(data);  
	            	if(data!=0){
	                	swal("상품명이 중복됩니다.");
	                    $("#name").val('');
	                   	return false;
	                }
	            }
	        }); 
	        
	  	}else{
	        swal("제품명을 입력해주세요.");
	        return false;
	  	}
	   
	  	//가격 유효성 검사
	  	var val2=$("#price").val();
	    if(val2.length>0){
	    	 var price=/^[0-9]*$/;
	        if(!price.test($("#price").val())){
	               swal("제품가격에 숫자 외에는 입력하실 수 없습니다.");
	               $("#price").val('');
	               return false;
	        }
	    }else{
	    	swal("가격을 입력해주세요.");
	        return false;
	    }
	    
	  	//간단한 설명 - 글자 수 제한
	    $(document).ready(function(){
	        $("#intro-text").on('keyup',function(){
	            if($(this).val().length>65){
	                $(this).val($(this).val().substring(0,65));
	                swal("65자를 초과하였습니다.");
	            }
	        });
	    });

	    
	  	//제품 썸네일 사진
	    if($("#input1").val()==""){
	    	swal("대표이미지를 등록해주세요.");
	    	return false;
	    }
	    
	    //상세 사진 파일 검사
	    if($("input[name=detailImg]").val()==""){
	    	swal("상세 사진을 등록해주세요.");
	    	return false;
	    }
	    
		
		//옵션 값 넣기
		var list=[];
	    var items = document.getElementsByName("pdtOptionContent");
	    
	    for(var i=0; i<items.length; i++){
	        list.push({"pdtOptionContent":$("input[name=pdtOptionContent]").eq(i).val(),
	        	"pdtOptionAddprice":$("input[name=pdtOptionAddprice]").eq(i).val()});    
	    }
	    $("#test_list").val(JSON.stringify(list));
	        
		} 
		else{
			return false;
		}   
	}
	
	//제품 삭제
	function deletePro(){
		if(confirm("정말 삭제하시겠습니까?")==true){
	        location.href='${path}/admin/deleteProduct?pdtNo='+encodeURI('${product.pdtNo}');
		}else{
			return false;
		}   
	}