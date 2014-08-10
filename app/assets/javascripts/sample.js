function showFollowingLegalPopup(caller) {
  window.scrollTo(0, 0);
  if (caller != undefined) {
    var url = $(caller).data("continue-url");
    $("#legal-popup-action").attr("href", url);
  }
  $("#legal-popup-following").modal('toggle');
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
 
 $('.scrollto').click(function(e) {
	 e.preventDefault();
	 
	 var hash = this.hash;
	 
	 $('html, body').animate({
		 scrollTop: $(hash).offset().top - 70
	 }, 300, function() {
		 window.location.hash = hash;
	 });
 });
 
 $('.follow').click(function(e) {
	 e.preventDefault();
	 
	 var thisbtn = $(this);
	 
	 $.ajax({
		 type:'POST',
		 url:'/investments/follow',
		 data:'deal_id=' + thisbtn.data('dealid'),
		 beforeSend:function() {
	 		 thisbtn.addClass('disabled');	
		 },
		 success:function() {
			thisbtn.html('Following');
		 }
	 });
 });
 
 $('#deal_form .gmaptrigger').change(function() {
	 var address = $('#deal_form input[name="deal[name]"]').val();
	 var city = $('#deal_form input[name="deal[address_attributes][city]"]').val();
	 var state = $('#deal_form select[name="deal[address_attributes][state]"]').val();
	 var zip = $('#deal_form input[name="deal[address_attributes][zipcode]"]').val();
	 if (address && city && state && zip) {
		 // get latitude/longitude for input address
	 	 $.get('https://maps.googleapis.com/maps/api/geocode/json', 'address=' + address + ',' + city + ',' + state + ',' + zip, function(d) {
			 var lat = d.results[0].geometry.location.lat;
			 var lng = d.results[0].geometry.location.lng;
			 $('#gmap').css('height', '500px');
			 gmapInit(lat, lng);
	 	 });
	 }
 });
}

function gmapInit(lat, lng) {
	var myLatlng = new google.maps.LatLng(lat,lng);
	var mapOptions = {
		center: myLatlng,
		zoom: 15
	};
	var map = new google.maps.Map(document.getElementById("gmap"), mapOptions);
	var marker = new google.maps.Marker({
		position: myLatlng, 
		map: map,
		title: 'Test'
	});
}
//google.maps.event.addDomListener(window, 'load', gmapInit);

$(document).ready(coreFunctions);
$(document).on('page:load', coreFunctions);
