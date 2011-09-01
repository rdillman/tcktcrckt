var po = org.polymaps;

var color = pv.Scale.linear()
    .domain(0, 10000,100000000)
    .range("#F00", "#3B0");



var map = po.map()
	.container(document.getElementById("map").appendChild(po.svg("svg")))
	.center({lon:-122.441886,lat:37.753365})
	.zoom(13)
	.zoomRange([12, 19])
	.add(po.interact())
	;

map.add(po.image()
	.url(po.url("http://{S}tile.cloudmade.com/4e1fc9bb9c924338a8c078a01f2ffec5/42585/256/{Z}/{X}/{Y}.png")
	.hosts(["a.", "b.", "c.", ""])));
	
map.add(po.geoJson()
	.on("load",load)
    .url("/json/clean.json")
    .id("clean")
    .zoom(15)
    .tile(false));

map.add(po.compass()
    .pan("none"));



function load(e) {
  for (var i = 0; i < e.features.length; i++) {
    var f = e.features[i];;
    f.element.setAttribute("stroke", color(f.data.properties.CNN).color);
	f.element.setAttribute('lid',f.data.geometry.coordinates[0]);
	f.element.setAttribute('class',"s")
    f.element.id = f.data.properties.CNN;
    f.element.addEventListener("click",function(e){
        clickFeature(this, e);  	
    }, false);

  }
}

function clickFeature(f, evt){
	f.setAttribute("stroke", color(1).color);
	getNextCleanTime(f.id);
}
