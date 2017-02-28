$(function () {
  $('table > tbody > tr').click(function () {
    window.open($(this).attr('data-click'), '_blank');
  });

  window.setInterval(function () {
    $.get('/', function (data) {
      $('body').html(data.match(/<body>(.*)<\/body>/)[1])
    });
  }, 60000);
});
