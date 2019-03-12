$(function(){
    $(".val").click(function(e){
         e.preventDefault();
          var a = $(this).attr("data");
          $(".pantalla").append(a);
          $(".fuera").val($(".fuera").val() + a);
          return false;
    });

     $(".equal").click(function(){
          $(".fuera").val(eval($(".fuera").val()));
          $(".pantalla").html(eval($(".fuera").val()));
     });

     $(".clear").click(function(){
          $(".fuera").val("");
          $(".pantalla").html("");
     });

     $(".min").click(function(){
         $(".cal").stop().animate({width: "0px", height: "0px", marginLeft: "700px", marginTop: "1000px"}, 500);
        setTimeout(function(){$(".cal").css("display", "none")}, 600);
     });

     $(".close").click(function(){
          $(".cal").css("display", "none");
     })
})