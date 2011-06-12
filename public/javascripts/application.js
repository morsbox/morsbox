$(function() {
  // section filter
  $('#section_filter_form #section_id').change(function(){
    $('#section_filter_form').submit()
  });
  
  // description's form dialogs
  $('.dialog_description').dialog({
    autoOpen: false,
    modal: true,
    height: 700,
    width: 1000
  });
  $('a.dialog_open').click(function(){
    $('#'+$(this).attr('dialog_id')).dialog('open');
    return false;
  });
});
