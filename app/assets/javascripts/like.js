//var $heart = $(".like-button");
console.log("hi!");
$("div.like-button").on("click", function(){
	console.log("clicked to like!");
	var $likeSum = $(this).next("div.like-sum").text();
//  like_function(#{beer.id}, $(this), $heart, $likeSum)
});

function like_function(id, button, heart, sum) {
  if (button.hasClass("decrement")){
      $.ajax({url: "/beeeer/" + id + "/likes/", type: "delete", data: {beeeer_id: id, dataType: "json"}})
      .done(function(data){
      button.removeClass("decrement").addClass("increment");
      heart.attr("src", "unliked.png");
      sum.text(data["count"])
      })
    }else{
      $.ajax({url: "/beeeer/" + id + "/likes/", type: "post", data: {beeeer_id: id, dataType: "json"}})
      .done(function(data){
      button.removeClass("increment").addClass("decrement");
      heart.attr("src", "liked.png");
      sum.text(data["count"]);
      })
    }
}
