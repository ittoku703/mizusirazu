// edit comment toggler btn
$('#comments > [id^=comment_]').each((index, element) => {
  $(element).find('#edit_comment_btn').on('click', () => {
    $(element).find('#edit_comment_form').toggleClass('hidden');
  })
})
