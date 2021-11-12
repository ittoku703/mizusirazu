$('#new_comment textarea').on('input',() => {
  check_textarea('#new_comment textarea', '#new_comment button');
});

$('#edit_comment textarea').on('input', () => {
  check_textarea('#edit_comment textarea', '#edit_comment button'); 
});

function check_textarea(textarea, button) {
  console.log(textarea, button)
  if($.trim($(textarea).val()) == '') {
    $(button).prop('disabled', true);
  } else {
    $(button).prop('disabled', false);
  }
}
