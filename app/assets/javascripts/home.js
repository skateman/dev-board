$(function () {
  $('table > tbody > tr').click(function () {
    window.open($(this).attr('data-click'), '_blank');
  });

  window.setTimeout(function () {
    window.location.reload();
  }, 120000);
});
