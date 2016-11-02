$(document).on('turbolinks:load', function() {
  $('.repo').on('click', function() {
    $status = $(this).find('.repo-status');

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {
      $status.text('ON!');
    } else {
      $status.text('TURN CI ON?');
    }
  });
});
