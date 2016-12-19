$(document).ready(function() {
  $('a').click(function(e) {
    var $a = $(e.currentTarget),
        href = $a.attr('href'),
        dataToggle = $a.data('toggle');

    console.log($a, href, dataToggle);

    if (href.length > 1 && href[0] === '#' && dataToggle !== 'collapse') {
      e.preventDefault();

      $('html, body').animate({
        scrollTop: $(href).offset().top
      }, 500);
    }
  });
});
