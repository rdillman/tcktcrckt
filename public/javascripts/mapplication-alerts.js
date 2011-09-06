var LAST_CNN = "";

function login(cnn,side){
	location.replace("/alert/show");
	return true
}

function makeAlert(cnn,side){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	$.get("/alert/make_new_alert?cnn="+cnn+"&side="+side, function(data){
		debugger
		if(data[0]=='$'){
			var alert = data.split('$');
			var masterString ="<div id='alarm"
			masterString +=alert[4]
			masterString +="'>"
			masterString +=alert[1];
			masterString +="<button class='kill' onclick='killAlert(";
			masterString +=alert[4];
			masterString +=")'>KILL</div>";
			$('#currentAlarms').prepend(masterString);
			$( "#accordion" ).accordion( "option", "active", 1 );
		}else{
			alert(data);
		}
	});
	return false;
}



function showAlerts(){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	$.get("/alert/show_alerts_on_map", function(data){
		if(data[0]=="$"){
			var alerts = data.split('#');
			var len = alerts.length -1;
			for (var i =0; i <len; i++){
				var alert = alerts[i].split('$');
				var masterString ="<div id='alarm";
				masterString +=alert[4];
				masterString +="'>";
				masterString +=alert[1];
				masterString +="<button class='kill' onclick='killAlert(";
				masterString +=alert[4];
				masterString +=")'>KILL</div>";
				$('#currentAlarms').prepend(masterString);
			}
		}else if (data[0]=="!"){
			alert("not signed in");
		}else{
			alert("something went wrong");
		}
	});
	return false;
}

function killAlert(id){
	$('#alarm'+id).attr("onclick","");
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
		$('#alarm'+id).html("<img src='/images/mapLoad.gif' style='postion: abosulte; top: 50%;'/>");
		
	  }
	})
	$.get("/alert/kill?q="+id, function(data){
		if (data == "success"){
			$('#alarm'+id).remove();
			if ($('#currentAlarms').html() == ""){
				$('#currentAlarms').html("You have no alerts");
			}
		}else{
			alert("something went wrong");
		}
	});
	return false;
}

function nextTimeQuery(query){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
		$('#infoBox').html("<img src='/images/mapLoad.gif' style='postion: abosulte; top: 50%;'/>");
	  }
	})
	
	$.get("/alert/timequery?q="+query, function(data){
		if (data[0]=='$')
		{
			$('#infoBox').html("We couldn't find that street.<br/>Please search again");
		}
		else if(data[0]=='@')
		{
			var cnn = data.split('@@');
			cnn = cnn[1];
			if (LAST_CNN != "" && LAST_CNN !== cnn){$("path#"+LAST_CNN).attr("stroke","rgb(0,255,0)");LAST_CNN==""}	
			var newcenter = $('path#'+cnn).attr('lid').split(',');
			var lt = parseFloat(newcenter[1]);
			var ln = parseFloat(newcenter[0]);
			map.center({lat:lt,lon:ln});
			$('#infoBox').html("Please Select Street On Map")
			
		}
		else
		{
			var cnn = data.split('##');
			var search_stuff = cnn[0]
			cnn = cnn[1];
			if (LAST_CNN != "" && LAST_CNN !== cnn){$("path#"+LAST_CNN).attr("stroke","rgb(0,255,0)");LAST_CNN==""}	
			if (LAST_CNN == cnn){}else{$("path#"+cnn).attr("stroke","rgb(255,0,0)");LAST_CNN=cnn;}
			var newcenter = $('path#'+cnn).attr('lid').split(',');
			var lt = parseFloat(newcenter[1]);
			var ln = parseFloat(newcenter[0]);
			map.center({lat:lt,lon:ln});		
			$('#infoBox').html(search_stuff);
			var masterString = '<button id=';
			masterString+=cnn;
			masterString+=' class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false"><span class="ui-button-text">Make Alert</span></button>';
			$('#infoBox').append(masterString);
		}
		$( "#accordion" ).accordion( "option", "active", 0 );
		
	});
}

function getNextCleanTime(cnn){
	
	
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
		$('#infoBox').html("<img src='/images/mapLoad.gif' style='postion: abosulte; top: 50%;'/>");
	  }
	})

	
	
	//Change LAST_CNN's color back to green, set new LAST_CNN
	if (LAST_CNN != "" && LAST_CNN !== cnn){$("path#"+LAST_CNN).attr("stroke","rgb(0,255,0)");}	
	if (LAST_CNN == cnn){
		//do nothing
	}else{
	LAST_CNN = cnn;
		//@st,@sf,@br,@tr,@rside,@rnct,@right_times,@rhol,@bl,@tl,@lside,@lnct,@left_times,@lhol
		$.get("/alert/timecnn?q="+cnn, function(data){
			$('#infoBox').html(data)
			$('#infoBox').append('<button id= class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false"><span class="ui-button-text">Make Alert</span></button>')
			$('#searchBar').attr('value',"");
			
		});	
	}

	$( "#accordion" ).accordion( "option", "active", 0 );
	
	return false;
}

function readData(data){
	alert(data);
}

function showLocation(position) {
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  map.center({lat: latitude, lon: longitude})

}

function errorHandler(err) {
  if(err.code == 1) {
    alert("Error: Access is denied!");
  }else if( err.code == 2) {
    alert("Error: Position is unavailable!");
  }
}


function getGPSCoords(){
	//return map.center({lat: 37.7793+Math.random()/30, lon: -122.4192-Math.random()/30})
// Un Comment for in San Francisco Testing
   if(navigator.geolocation){
      // timeout at 60000 milliseconds (60 seconds)
      var options = {timeout:60000};
      navigator.geolocation.getCurrentPosition(showLocation, 
                                               errorHandler,
                                               {enableHighAccuracy: true});
   }else{
      alert("Sorry, browser does not support geolocation!");
   }
}

