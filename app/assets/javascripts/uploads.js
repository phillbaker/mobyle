//= require jquery-fileupload

$(function () {
    // Initialize the jQuery File Upload widget:
    var fu_elem = $('#fileupload');
    if(fu_elem.length > 0) {
      fu_elem.fileupload({
        //, autoUpload: true
        //TODO Start immediately if we drag and drop, if we add manually, wait until we hit go
        dropZone: $('.dropzone')
      });

      $(document).bind('dragover', function (e) {
          var dropZone = $('.dropzone'),
              timeout = window.dropZoneTimeout;
          if (!timeout) {
              dropZone.addClass('in');
          } else {
              clearTimeout(timeout);
          }
          if (e.target === dropZone[0]) {
              dropZone.addClass('hover');
          } else {
              dropZone.removeClass('hover');
          }
          window.dropZoneTimeout = setTimeout(function () {
              window.dropZoneTimeout = null;
              dropZone.removeClass('in hover');
          }, 500);
      });

      // Load existing files:
      $.getJSON(fu_elem.prop('action'), function (files) {
        var fu = fu_elem.data('fileupload'),
          template;
        fu._adjustMaxNumberOfFiles(-files.length);
        console.log(files);
        template = fu._renderDownload(files)
          .appendTo($('#fileupload .files'));
        // Force reflow:
        fu._reflow = fu._transition && template.length &&
          template[0].offsetWidth;
        template.addClass('in');
        $('#loading').remove();
      });
    }
});