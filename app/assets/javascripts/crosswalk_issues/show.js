$(function() {
  $('#clear_ipeds_ope').on('click', function() {
    $('#cross').val('');
    $('#ope').val('');
  });
  $('.crosswalk_update').on('click', function() {
    $('#cross').val($(this).attr('cross'));
    $('#ope').val($(this).attr('ope'));
  });
});