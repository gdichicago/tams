var ready = function() {
  $('#balances').toggle();
  $('#schedule').toggle();
  $('#sign_up').toggle();
  $('#history').toggle();
  $('#active').toggle();

  function initClick(id) {
    $(id + '_header').click(function(event) {
      console.log("hello");
      event.preventDefault();
      $(id + '_icon i').toggleClass('fa-angle-right');
      $(id + '_icon i').toggleClass('fa-angle-down');
      $(id).toggle();
    });
  }

  initClick('#balances');
  initClick('#schedule');
  initClick('#sign_up');
  initClick('#history');
  initClick('#active');
}


$(document).ready(ready);
$(document).on('page:load', ready);