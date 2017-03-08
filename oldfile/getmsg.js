$(document).ready(function(){

    $("#return").click(function(e){  //查看所有留言
       window.open('index.jsp');
    });


    $(document).on('click','.delmbtn',function(){ //動態綁定刪除按鈕

        $.ajax({
          type: "POST",
          url: "deletemsg.jsp",
          dataType: "json",
          data: {"deleteindex": +$(this).attr('msgid')}, //傳入該留言id
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
