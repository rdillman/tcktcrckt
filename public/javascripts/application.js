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
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/javascript");
	  }
	})
	var id = $(".delete").attr("data-id");
	$.getScript("lookup/delete_alert?q="+id, function(data){
		$('.alert[data-id='+id+']').html("<b>"+data+"</b>");  
	});
	return false;
}

function changeAlert(){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/javascript");
	  }
	})
	var id = $(".change").attr("data-id");
	$.getScript("lookup/change_alert?q="+id, function(data){
		$('.sendTime[data-id='+id+']').html(data);  
	});
	return false;
}

function nextClean(){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/javascript");
	  }
	})
	var search = $("#searchinput").attr("value");
	$.getScript("lookup/get_next_time?q="+search, function(data){
		var array_separator = data.indexOf("~")
		var address = data.substring(0,array_separator)
		var cleantime = data.substring(array_separator+1)		
		$('#searchresults').html("<b>"+address+"</b>:"+time);
		$('#fullResultContent').show();
		$('#searchCreateAlert').attr('q', address);
		$('#searchCreateAlert').attr('time', cleantime);
	});
	return false;
}

function makeAlert(){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/javascript");
	  }
	})
	var q = $(".changeAlert").attr("q");
	$.getScript("lookup/make_alert?q="+q, function(data){
		alert(data);
	});
	return false;
}