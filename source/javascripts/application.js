$(function() {
  
  if(!$('body').hasClass('page-index')) {
    // Hide Header on on scroll down
    var didScroll;
    var lastScrollTop = 0;
    var delta = 5;
    var footerHeight = $('#footer').outerHeight();

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
        $('#footer').removeClass('footer-up').addClass('footer-down');
      } else {
        if(st + $(window).height() < $(document).height()) {
            $('#footer').removeClass('footer-down').addClass('footer-up');
        }
      }
      lastScrollTop = st;
    }
  }

  // Show navigation on click
  $('.toggle-nav').on('click', function(e){
    e.preventDefault();
    if(!$(this).hasClass('active')) {
      $(this).addClass('active');
      $('body').addClass('nav-on');
      $('.overlay-nav').addClass('on');
    } else {
      $(this).removeClass('active');
      $('body').removeClass('nav-on');
      $('.overlay-nav').removeClass('on');
    }
  });

  $('.close-nav').on('click', function(e){
    e.preventDefault();
    $('.toggle-nav').removeClass('active');
    $('body').removeClass('nav-on');
    $('.overlay-nav').removeClass('on');
  });

});