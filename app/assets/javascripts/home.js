$(function () {
  $('body').on('click', 'table > tbody > tr', function () {
    window.open($(this).attr('data-click'), '_blank');
  });

  window.setInterval(function () {
    $.get('/', function (data) {
      $('body').html(data.match(/<body>(.*)<\/body>/)[1])
    });
  }, 60000);
});
