var ready = function() {
  $('#forgot_email_submit').on('click', function(event) {
    var email = $('input#forgot_email').val();
    $.ajax({
      url: '/emails/forgot',
      type: 'get',
      dataType: 'jsonp',
      data: { email: email },
      complete: function(response) {
        appendResponse(response);
      }
    })
  });

  function appendResponse(response) {
    $('.response').append(response.responseText);
    $('input#forgot_email').val('');
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);