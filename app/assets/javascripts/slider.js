/*******

  *** Anchor Slider by Cedric Dugas   ***
  *** Http://www.position-absolute.com ***

  Never have an anchor jumping your content, slide it.

  Don't forget to put an id to your anchor !
  You can use and modify this script for any project you want, but please leave this comment as credit.

*****/

var scrollElement = 'html, body';
$('html, body').each(function () {
  var initScrollTop = $(this).attr('scrollTop');
  $(this).attr('scrollTop', initScrollTop + 1);
  if ($(this).attr('scrollTop') == initScrollTop + 1) {
    scrollElement = this.nodeName.toLowerCase();
    $(this).attr('scrollTop', initScrollTop);
    return false;
  }
})

jQuery.fn.anchorAnimate = function(settings) {
  settings = jQuery.extend({speed: 300, center: false}, settings);
  return this.each(function() {
    var caller = $(this);
    caller.click(function(event) {
      event.preventDefault();
      caller.smoothScroll(settings['speed'], settings['center']);
      return false;
    });
  })
}

jQuery.fn.smoothScroll = function(speed, center) {
  var locationHref = window.location.href;
  var elementClick = $(this).attr("href");
  var left = $(elementClick).offset().left;
  if (center) {
    left -= $(window).width() / 2 - $(elementClick).width() / 2;
  }
  var options = {scrollLeft: left, scrollTop: $(elementClick).offset().top};
  $(scrollElement + ":not(:animated)").animate(options, speed, function() {
    window.location.hash = elementClick;
  });
}