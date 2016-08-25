//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.MultiFile
//= require fancybox
//= require_tree .

function check_form(){
    if ($('#name').val() != "" && $('#email').val() != "" && $('#company_name').val() != "" && $('#phone_number').val() != "" && $('#description').val() != ""){
        $("#send_form").prop("disabled", true);
        $("#send_form").val("Sending...");
        $("#send_form").addClass("sub-regis-contact");
        $("#send_form").submit();
    }
}

$(function(){
    $(document).on('click','.fancybox-close',function(){
      $('body').removeClass('no-scroll');
    })
});

var isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};
$(function() {
    var dateToday = new Date();
    $("#datepicker").datepicker({ dateFormat: 'yy-mm-dd', minDate: dateToday });
    $("#datepicker1").datepicker({ dateFormat: 'yy-mm-dd',minDate: dateToday });
});
$(function(){
    $('.multi').MultiFile({
        accept:'gif|jpg',
        max:4,
        STRING: {
            remove:'Remover',
            selected:'Selecionado: $file',
            denied:'Invalid image $ext!',
            duplicate:'Arquivo ja selecionado:\n$file!'
        }
    });
});
$(function(argument) {
    $('[type="checkbox"]').bootstrapSwitch();
});

$('.timepicker').timepicker({
    timeFormat: 'h:mm p',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});
$('.timepicker1').timepicker({
    timeFormat: 'h:mm p',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});


