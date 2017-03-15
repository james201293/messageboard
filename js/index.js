$(document).ready(function(){

    $("#allmessage").click(function(e){  //查看所有留言
       window.open('viewmsg.jsp');
    });
    $("#clear").click(function(e){  //清除表單
      $("#txtauthor, #txttitle, #content").val('');
    });

    $("#submit").click(function(e){ //送出表單

       $.ajax({
         type: "POST",
         url: "alert.jsp",
         dataType: "json",
         data: {"txtauthor": $("#txtauthor").val(), "txttitle": $("#txttitle").val(), "content":$("#content").val()},
         cache: false,
         success: function(response){
           location.reload();  //刷新網頁
           alert(response.exe_status);
         },
         error: function(xhr){
           alert(xhr.status);
         }


       });
     });

});

<!--jquery button-->
  $( "#allmessag,#submit,#clear" ).click( function( event ) {
        event.preventDefault();
      } );
