function showFollowingLegalPopup(caller) {
  window.scrollTo(0, 0);
  if (caller != undefined) {
    var url = $(caller).data("continue-url");
    $("#legal-popup-action").attr("href", url);
  }
  $("#legal-popup-following").modal('toggle');
}

function gotoAnchor(tag){
	var position = $(tag).offset().top;
	$('html,body').animate({scrollTop: position}, 'slow');
}

function coreFunctions() {
 //----------------------------------------------------------------
 //  Apply text counters
 if ($("[data-counter]").length > 0) {
   $("[data-counter]").keyup(function(e) {
     max = 250;
     if ($(this).data("counter-max") != undefined) {
       max = $(this).data("counter-max");
     }
     $("#" + $(this).attr("data-counter")).html((max - ($(this).val().length)));
   });
 }

 $("[rel='tooltip']").tooltip();
 $("[rel='popover']").popover();
 
 
}

$(document).ready(coreFunctions);
$(document).on('page:load', coreFunctions);
