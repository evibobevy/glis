$("form#sign_up_user").bind("ajax:success", function(e, data, status, xhr) {
    if (data.success) {
        location.reload();
    } else {
        alert(data['error']);
    }
});