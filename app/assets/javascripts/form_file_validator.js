function formFileValidator(elem, maxFileLength, fileSizeParams) {
  const files = elem.prop('files');

  // check length
  if (files.length > maxFileLength) {
    alert('Maximum file count is ' + maxFileLength);
    elem.val('');
  }

  // check size
  const maxFileSize = 1024 * 1024 * 5; // 5MB
  let size = 0;

  $.each(files, (index, file) => {
    if (file.size > maxFileSize) {
      alert("Maximum file size is 5MB. Please choose a smaller file");
      size = 0;
      elem.val('');
    } else {
      size += file.size;
    }
  });

  // output size to parameter
  let sizeFormatted = (size / 1024).toFixed(2); // kirobyte
  $(file_size_params).html(`${sizeFormatted}KB/5MB`);
}

// micropost

let micropostFileField = $('#micropost_file_field');
let micropostFileSizeParams = $('#file_size_params');

$(micropostFileField).change(() => {
  formFileValidator(micropostFileField, 10, micropostFileSizeParams);
});

// comment

let commentFileField = $('#new_comment-form #comment_file_field');
let commentFileSizeParams = $('#new_comment-form #file_size_params');

$(commentFileField).change(() => {
  formFileValidator(commentFileField, 3, commentFileSizeParams);
});
