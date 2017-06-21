//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $(".button-collapse").sideNav();

  $('.modal').modal();

  $('select').material_select();

  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15 // Creates a dropdown of 15 years to control year
  });
})
