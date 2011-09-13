var LAST_CNN = "";

//this is a lazy href, this function redirects to alert/show
function login(cnn,side){
	location.replace("/alert/show");
	return true;
}

//this creates a new alert
function makeAlert(cnn,side){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/javascript");
	  }
	})
	$.get("/alert/make_new_alert?cnn="+cnn+"&side="+side, function(data){
		if(data[0]=='$'){
			var newalert = data.split('$');
			$('#currentAlerts').prepend("<div id='alarm"+newalert[4]+"'>"+newalert[1]+"<button class='kill' onclick='makeAlert("+alert[4]+"')>KILL</div>");
		}else{
			alert("make alert failed");
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
	
	$.get("/mapz/timequery?q="+query, function(data){
		if (data[0]=='$')
		{
			$('#infoBox').html("We couldn't find that street.<br/>Please search again");
		}
		else if(data[0]=='@')
		{
			var temp_cnn = data.split('@@');
			cnn = temp_cnn[1];
			if (LAST_CNN != "" && LAST_CNN !== cnn){$("path#"+LAST_CNN).attr("stroke","rgb(0,255,0)");LAST_CNN==""}	
			var newcenter = $('path#'+cnn).attr('lid').split(',');
			var lt = parseFloat(newcenter[1]);
			var ln = parseFloat(newcenter[0]);
			map.center({lat:lt,lon:ln});
			map.zoom(18);
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
		}
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
		$.get("/mapz/timecnn?q="+cnn, function(data){
			$('#infoBox').html(data)
			$('#searchBar').attr('value',"");
		});	
	}

	
	return false;
}

function showLocation(position) {
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  map.center({lat: latitude, lon: longitude})

}

function gpsErrorHandler(err) {
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
                                               gpsErrorHandler,
                                               {enableHighAccuracy: true});
   }else{
      alert("Sorry, browser does not support geolocation!");
   }
}

