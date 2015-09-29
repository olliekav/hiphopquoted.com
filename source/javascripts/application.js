//= require jquery-1.10.2.min
//= require magnific-popup

$(function() {
  
  if($('#footer').hasClass('sticky')) {
    // Hide Header on on scroll down
    var didScroll,
        lastScrollTop = 0,
        delta = 5,
        footer = $('#footer'),
        footerHeight = footer.outerHeight();

    $(window).scroll(function(event){
      didScroll = true;
    });

    setInterval(function() {
      if (didScroll) {
        hasScrolled();
        didScroll = false;
      }
    }, 250);

    function hasScrolled() {
      var st = $(this).scrollTop();
      if(Math.abs(lastScrollTop - st) <= delta)
          return;
      if (st > lastScrollTop && st > footerHeight -40){
        footer.removeClass('footer-up').addClass('footer-down');
      } else {
        if(st + $(window).height() < $(document).height()) {
          footer.removeClass('footer-down').addClass('footer-up');
        }
      }
      lastScrollTop = st;
    }
  }

});