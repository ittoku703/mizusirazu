function formFileValidator(elem, maxFileLength, fileSizeParams) {
  let fileInput = $(elem);
  let files = fileInput.prop('files');
  let fiveMegabytes = 1024 * 1024 * 5;
  let size = 0;

  // check length
  if (files.length > maxFileLength) {
    alert('Maximum file count is ' + maxFileLength);
    fileInput.val('');
  }

  // check size
  $.each(files, (index, file) => {
    if (file.size > fiveMegabytes) {
      alert("Maximum file size is 5MB. Please choose a smaller file");
      size = 0;
      fileInput.val('');
    } else {
      size += file.size;
    }
  });

  // output size to parameter
  let sizeOfKirobyte = (size / 1024).toFixed(2);
  $(file_size_params).html(`${sizeOfKirobyte}KB/5MB`);
}

// micropost

let micropostFileField = '#micropost_file_field'
let micropostFileSizeParams = '#file_size_params';

$(micropostFileField).change(() => {
  formFileValidator(micropostFileField, 10, micropostFileSizeParams);
});

// comment

let commentFileField = '#new_comment-form #comment_file_field'
let commentFileSizeParams = '#new_comment-form #file_size_params';

$(commentFileField).change(() => {
  formFileValidator(commentFileField, 3, commentFileSizeParams);
});
