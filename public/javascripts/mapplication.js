var LAST_CNN = "";

function nextTimeQuery(query){
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	
	$.get("/mapz/timequery?q="+query, function(data){
		if (data[0]=='$')
		{
			$('#infoElements').html("We couldn't find that street.<br/>Please search again");
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
			$('#infoElements').html("Please Select Street On Map")
			
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
			$('#infoElements').html(search_stuff)
		}
	});
}

function getNextCleanTime(cnn){
	
	
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
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
			$('#infoElements').html(data)
			$('#searchBar').attr('value',"");
		});	
	}

	
	return false;
}

function readData(data){
	alert(data);
}

function getGPSCoords(){


	return map.center({lat: 37.7793+Math.random()/30, lon: -122.4192-Math.random()/30})
// Un Comment for in San Francisco Testing
	// if(navigator.geolocation){
	//       // timeout at 60000 milliseconds (60 seconds)
	//       var options = {timeout:60000};
	//       navigator.geolocation.getCurrentPosition(showLocation, 
	//                                                errorHandler,
	//                                                {enableHighAccuracy: true});
	// 	  return map.center({lat: position.coords.latitude,lon: position.coords.longitude});
	//    }else{
	//       alert("Sorry, browser does not support geolocation!");
	// 	  return false;
	//    }

}
