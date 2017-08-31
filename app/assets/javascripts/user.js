$("form#sign_up_user").bind("ajax:success", function(e, data, status, xhr) {
    if (data.success) {
        //location.reload();
        window.location.href='/users/edit';
    } else {
        alert(data['error']);
    }
});
$('#new_user').bind('ajax:success', function(evt, data, status, xhr) {
    //function called on status: 200 (for ex.)
    console.log('success');
    location.reload();
}).bind("ajax:error", function(evt, xhr, status, error) {
        //function called on status: 401 or 500 (for ex.)
        //console.log(xhr.responseText);
            $('#login_error').show();
            //return false;
            //alert(xhr.responseText);
    });



