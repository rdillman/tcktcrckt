var LAST_CNN = "";

function makeAlert(query){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	$.get("/alert/make_new_alert?q="+query, function(data){
		if(data[0]=='$'){
			var newalert = data.split('$');
			$('#currentAlerts').prepend("<div id='alarm"+newalert[4]+"'>"+newalert[1]+"<button class='kill' onclick='killAlert("+newalert[4]+")'>KILL</div>");
		}else{
			alert("make alert failed");
		}
	});
	return false;
}

function showAlerts(){
	$.get("/alert/show_alerts_on_map", function(data){
		if(data[0]=="$"){
			var alerts = data.split('#');
			var len = alerts.length -1;
			for (var i =0; i <len; i++){
				var alert = alerts[i].split('$');
				$('#currentAlert').prepend("<div id='alarm"+alert[4]+"'>"+alert[1]+"<button class='kill' onclick='killAlert("+alert[4]+")'>KILL</div>");
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
	$('#alarm'+id).attr("onclick","")
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	$.get("/alert/kill?q="+id, function(data){
			if (data == "success"){
				$('#alarm'+id).remove();
			}else{
				alert("something went wrong");
			}
	});
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
			$('#infoBox').html(search_stuff)
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

