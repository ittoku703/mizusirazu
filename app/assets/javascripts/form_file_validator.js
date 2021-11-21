let micropostFileField = $('#micropost_file_field');
let fileSizeParams = $('#file_size_params');

micropostFileField.change(() => {
  let micropostFiles = micropostFileField.prop('files');
  let fiveMegabytes = 1024 * 1024 * 5;
  let size = 0;

  $.each(micropostFiles, (index, element) => {
    if (element.size > fiveMegabytes) {
      alert("Maximum file size is 5MB. Please choose a smaller file");
      size = 0
      micropostFileField.val('')
    } else {
      size += element.size;
    }
  });

  let sizeOfKirobyte = (size / 1024).toFixed(2);
  fileSizeParams.html(`${sizeOfKirobyte}KB/5MB`);
});
