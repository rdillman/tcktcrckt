// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function updateAlerts() {  
  var user_id = $('#alerts').attr('data-user')
  $.getScript('/alertUpdate.js?user_id='+user_id);  
 setTimeout(updateAlerts, 10000);  
}

function createNewAlert() {
  var user_search = $('#search_term').attr('data-search')
  $.getScript('/alertNew.js?user_search='+user_search);
  setTimeout(updateAlerts, 10000);  
}

function killAlert(){
  var alert_id = $('#alert').attr('data-id');  
  $.getScript('/alertKill.js?alert_id='+alert_id)
  setTimeout(updateAlerts, 10000);  
}

function nextClean(){
	var search = $("#searchinput").attr("value");
	
	$.getScript("lookup/get_next_time?q="+search);
}