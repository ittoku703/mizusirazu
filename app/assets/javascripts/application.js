//= require rails-ujs
//= require jquery

$('.header__togglebtn').click(function() {
  $('.header__nav-links')
    .slideToggle()
    .toggleClass('nes-container is-rounded')
});
