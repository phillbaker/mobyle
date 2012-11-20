//= require jquery
//= require jquery_ujs
//= require mobile/mobile.init
//= require jquery.mobile
//= require mobile/add2home
//= require_self

$(document).ready(function() {
  //For manually testing/forcing add2home: addToHome.show(true);
  
  // http://stackoverflow.com/a/8000626
  var stickFooter = function() {
    $('[data-role=content]').each(function() {
      var containerHeight = parseInt($(this).css('height'));
      var windowHeight = parseInt(window.innerHeight);
      var footerAndHeaderHeight = 115;//this assumes both header and footer are turned on
      if(containerHeight+footerAndHeaderHeight < windowHeight) {
          var newHeight = windowHeight-footerAndHeaderHeight;
          $(this).css('min-height', newHeight+'px');
      }
    });
  };
  
  // Run the stick footer once on page load and once on orientation change
  stickFooter();
  $(document).bind('orientationchange', function(event) {
      stickFooter();
  });
  
});