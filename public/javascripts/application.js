// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function ($) {
  $("#payment_button").click(function() {
    var confirmation_message = "You'll be redirected to secure page to perform this payment. Do you want to continue?";
    if(confirm(confirmation_message)){

      $.getJSON('/payments/new.json?', function(data) {
        if(data.payment_options != undefined && data.url != undefined){
          var form=$('<form id="pay" action="'+data.url+'" method="post"></form>');
          var fields = "";
          $.each(data.payment_options,function(field,value){
            fields += "<input type='hidden' name='"+field+"' value='"+value+"' />";
          });
          form.html(fields);
          $('body').append(form);
          $('#pay').submit();
        }
      });
    }
  });
});