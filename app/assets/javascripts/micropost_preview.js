let newMicropostBtn = $('#new_micropost-btn')
let editMicropostBtn = $('#edit_micropost-btn')
let previewMicropostBtn = $('#preview_micropost-btn')
let newMicropost = $('#new_micropost')
let editMicropost = $('#edit_micropost')
let previewMicropost = $('#preview_micropost')

newMicropostBtn.on('click', () => {
  newMicropostBtn.prop('disabled', true);
  previewMicropostBtn.prop('disabled', false);

  newMicropost.toggleClass('hidden');
  previewMicropost.toggleClass('hidden');
})

editMicropostBtn.on('click', () => {
  editMicropostBtn.prop('disabled', true);
  previewMicropostBtn.prop('disabled', false);

  editMicropost.toggleClass('hidden');
  previewMicropost.toggleClass('hidden');
})

previewMicropostBtn.on('click', () => {
  previewMicropostBtn.prop('disabled', true);
  newMicropostBtn.prop('disabled', false);
  editMicropostBtn.prop('disabled', false);

  previewMicropost.toggleClass('hidden');
  newMicropost.toggleClass('hidden');
  editMicropost.toggleClass('hidden');
})

let previewMicropostTitle = $('#preview_micropost-title');
let previewMicropostContent = $('#preview_micropost-content');
let newMicropostTitle = $('#new_micropost-form #micropost_title');
let newMicropostContent = $('#new_micropost-form #micropost_content');
let editMicropostTitle = $('#edit_micropost-form #micropost_title');
let editMicropostContent = $('#edit_micropost-form #micropost_content');

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
