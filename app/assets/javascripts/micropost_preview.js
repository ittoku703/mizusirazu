let previewMicropostBtn = $('#preview_micropost_btn');
let previewMicropost = $('#preview_micropost');
let newMicropostBtn = $('#new_micropost_btn');
let newMicropost = $('#new_micropost');
let editMicropostBtn = $('#edit_micropost_btn');
let editMicropost = $('#edit_micropost');

newMicropostBtn.on('click', () => {
  newMicropostBtn.prop('disabled', true);
  previewMicropostBtn.prop('disabled', false);

  newMicropost.toggleClass('hidden');
  previewMicropost.toggleClass('hidden');
});

editMicropostBtn.on('click', () => {
  editMicropostBtn.prop('disabled', true);
  previewMicropostBtn.prop('disabled', false);

  editMicropost.toggleClass('hidden');
  previewMicropost.toggleClass('hidden');
});

previewMicropostBtn.on('click', () => {
  previewMicropostBtn.prop('disabled', true);
  newMicropostBtn.prop('disabled', false);
  editMicropostBtn.prop('disabled', false);

  previewMicropost.toggleClass('hidden');
  newMicropost.toggleClass('hidden');
  editMicropost.toggleClass('hidden');
});

let previewMicropostTitle = $('#preview_micropost_title');
let previewMicropostContent = $('#preview_micropost_content');
let newMicropostTitle = $('#new_micropost_form #micropost_title');
let newMicropostContent = $('#new_micropost_form #micropost_content');
let editMicropostTitle = $('#edit_micropost_form #micropost_title');
let editMicropostContent = $('#edit_micropost_form #micropost_content');

previewMicropostTitle.html(editMicropostTitle.val());
previewMicropostContent.html(editMicropostContent.val());

newMicropostTitle.on('input', () => {
  previewMicropostTitle.html(newMicropostTitle.val());
})

newMicropostContent.on('input', () => {
  previewMicropostContent.html(newMicropostContent.val());
})

editMicropostTitle.on('input', () => {
  previewMicropostTitle.html(editMicropostTitle.val());
})

editMicropostContent.on('input', () => {
  previewMicropostContent.html(editMicropostContent.val());
})
