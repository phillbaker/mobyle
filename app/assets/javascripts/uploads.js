//= require jquery-fileupload

$(function () {
    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
      dropZone: $('.dropzone'),
      add: function (e, data) {
        // Start immediately
        data.submit();
      }
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
    $.getJSON($('#fileupload').prop('action'), function (files) {
      var fu = $('#fileupload').data('fileupload'),
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

});