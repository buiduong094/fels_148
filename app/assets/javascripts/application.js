// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("div.answers").append(content.replace(regexp, new_id));
}

$(document).ready(function(){
  $('.answers').on('change', 'input[type=checkbox]',function(){
    $('.answers').find('input[type=checkbox]').not(this).attr('checked', false);
  })
});

$(document).on('ready page:load',function(){
  var index = 1;
  $(window).scroll(function() {
    if($(window).scrollTop() + $(window).height() == $(document).height()) {
      var page = $('.page-scroll').val();
      if(page == 'home'){
        page = '?page=';
      }else if(page == 'users'){
        page = '?page_activities=';
      }else{
        page = 'nil';
      }
      if(page != 'nil'){
        index++;
        $.ajax({
          url: page+index,
          dataType: 'JSON',
          type: 'GET',
          success: function(response){
            if(response.content != ''){
              $('.end_result').css('display', 'none');
              $('.table_activities tbody').append(response.content);
            }else{
              $('.end_result').css('display', 'block');
            }
          }
        });
      }
    }
  });
})
