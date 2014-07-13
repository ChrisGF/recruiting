// Scrolls down to a given an id name. "See http://api.jquery.com/animate/"
// for implementation details.
//
function gotoAnchor(anchor_name) {
  $("body").animate({scrollTop:$("[anchor=" + anchor_name + "]").offset().top}, 250);
};