var LAST_CNN = "";

function login(cnn,side){
	location.replace("/alert/show");
	return true;
}

function makeAlert(cnn,side){
	cA = $('#currentAlarms')
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
	  }
	})
	$.get("/alert/make_new_alert?cnn="+cnn+"&side="+side, function(data){
		if(data[0]==='$'){
			var alert = data.split('$');
			var numberRegEx = /currently/i;
			var id = alert[1]
			var divStuff = alert[2]
			if (numberRegEx.test(cA.html())){
				cA.html(divStuff);
			}else{
				cA.prepend(divStuff);
			}
			$('#kill'+id).button();
			$('#accordion').accordion("option","active",1);
		}else{
			 $('#infoBox').html("oops something went wrong");
			 $('#accordion').accordion("option","active",0);
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
		if(data[0]=="#"){
			var alerts = data.split('#');
			var len = alerts.length;
			for (var i =1; i <len; i++){
				var alert = alerts[i].split('$');
				var id = alert[0];
				$('#currentAlarms').prepend(alert[1]);
				$('#kill'+id).button();
			}
		}else if (data!=""){
			$('#currentAlarms').html(data);
		}else{
			$('#currentAlarms').html("Oops something went wrong.<br/> We are working on fixing that now");
		}
	});
	return false;
}

function killAlert(id){
	$('#alarm'+id).attr("onclick","");
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
		$('#alarm'+id).html("<img src='/images/mapLoad.gif' style='postion: abosulte; top: 50%;'/><br><span>deleting alert</span>");
		
	  }
	})
	$.get("/alert/kill?q="+id, function(data){
		if (data == "success"){
			$('#alarm'+id).remove();
			var lastAlert = /[\S|oops]/i;
			if (lastAlert.test($('#currentAlarms').html()) == false){
				$('#currentAlarms').html("You currently have no alerts");
			}
		}else{
			 $('#infoBox').html("oops something went wrong");
			 $('#accordion').accordion("option","active",0);
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
	var iB = $('#infoBox');
	
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {
	    xhr.setRequestHeader("Accept", "text/html");
		iB.html("<img src='/images/mapLoad.gif' style='postion: abosulte; top: 50%;'/>");
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
			iB.html(data)			
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

