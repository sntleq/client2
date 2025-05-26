$(document).ready(function() {
    $('#addCourseForm').submit(function(e) {
        e.preventDefault();

        // Validate form
        if (!this.checkValidity()) {
            $(this).addClass('was-validated');
            return;
        }

        // Prepare the data object
        const formData = {
            Crs_Code: $('#courseCategory').val() + $('#courseCode').val(),
            Crs_Title: $('#descriptiveTitle').val(),
            Crs_Units: $('#numberOfUnits').val(),
            Crs_Lec: $('#lecUnits').val(),
            Crs_Lab: $('#labUnits').val(),
            Ctg_Code: $('#courseCategory').val(),
            Preq_Crs_Code: $('#prerequisite').val() ? $('#prerequisite').val().join(',') : null
        };

        // Show loading state
        Swal.fire({
            title: 'Processing',
            html: 'Please wait while we add the course...',
            allowOutsideClick: false,
            didOpen: () => Swal.showLoading()
        });

        $.ajax({
            url: $(this).data('ajax-url'),
            type: 'POST',
            data: formData,
            contentType: 'application/x-www-form-urlencoded',
            success: function(response) {
                Swal.close();
                if (response.success) {
                    showSuccess('Course added successfully!');
                    window.location.href = response.redirectUrl;
                    $('#addCourseForm')[0].reset();
                } else {
                    showError(response.message || 'Error adding course');
                }
            },
            error: function(xhr) {
                Swal.close();
                handleAjaxError(xhr);
            }
        });
    });

    function handleAjaxError(xhr) {
        let errorMessage = 'An error occurred while adding the course';
        const errorFields = {};

        if (xhr.responseJSON) {
            // Handle validation errors
            if (xhr.responseJSON.errors) {
                $.each(xhr.responseJSON.errors, function(field, messages) {
                    errorFields[field] = messages.join(' ');

                    // Highlight problematic fields
                    if (field === 'Crs_Code') {
                        $('#courseCode').addClass('is-invalid');
                        $('#courseCode').next('.invalid-feedback').text(messages[0]);
                    }
                    if (field === 'Crs_Title') {
                        $('#descriptiveTitle').addClass('is-invalid');
                        $('#descriptiveTitle').next('.invalid-feedback').text(messages[0]);
                    }
                });
                errorMessage = "Please correct the highlighted errors.";
            } else if (xhr.responseJSON.message) {
                errorMessage = xhr.responseJSON.message;
            }
        }

        showError(errorMessage);
    }

    function showSuccess(message) {
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: message,
            confirmButtonText: 'OK'
        });
    }

    function showError(message) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: message,
            confirmButtonText: 'OK'
        });
    }

// Clear validation errors when user starts typing
    $('#courseCode, #descriptiveTitle').on('input', function() {
        $(this).removeClass('is-invalid');
    });
});
