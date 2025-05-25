$(document).ready(function () {
    var $form = $('#addCourseForm');
    var actionUrl = $form.data('ajax-url');

    $form.on('submit', function (e) {
        e.preventDefault();

        const formData = $form.serialize(); // Includes anti-forgery token
        $('#formMessage').empty(); // Clear previous message

        $.ajax({
            url: actionUrl,
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    $('#formMessage').html('<div class="alert alert-success">' + response.message + '</div>');
                    $form[0].reset(); // Reset form fields
                } else {
                    $('#formMessage').html('<div class="alert alert-danger">' + response.message + '</div>');
                }
            },
            error: function () {
                $('#formMessage').html('<div class="alert alert-danger">An unexpected error occurred.</div>');
            }
        });
    });
});