// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults





function htmlMakeAlert() {
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	var search = $('.htmlSearchBox').attr("value");
	var alertSendOptions = $('#alarmOptions').attr('value');
	alert(search+" : "+alertSendOptions);
	return false;
}


function htmlGetNextCleanTime() {

	var nextTime = null;
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	var search = $('.htmlSearchBox').attr("value");
	$.get("lookup/get_next_time?q="+search, function(data){
		$('.info').html(data);
	});
	
	return false;
}

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
	$.get("lookup/get_next_time?q="+search, function(data){
		var separator = data.indexOf(':');
		var address = data.substring(0,separator-1);
		var time = data.substring(separator+2);
		alert(data);
		$('#searchResults').html(data);
	});
	return false;
}

function makeAlert(){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/javascript");
	  }
	})
	var q = $("button#searchCreateAlert").attr("q");
	$.getScript("lookup/make_alert?q="+q, function(data){
		$.mobile.changePage( "#alertShow", { transition: "pop"} );	
		$('#alertList').prepend(data);
	});
	return false;
}

function makeRecentAlert(){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/javascript");
	  }
	})
	var q = $("button#recentCreateAlert").attr("q");
	$.getScript("lookup/make_alert?q="+q, function(data){
		$.mobile.changePage( "#alertShow", { transition: "pop"} );	
		$('#alertList').prepend(data);
	});
	return false;
}