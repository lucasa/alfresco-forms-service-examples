var result = new Array();

var carMake = url.extension;

var dataServiceUrl = "http://localhost:8080/share/components/form/samples/cars.xml";

var connector = remote.connect("http");

var str = new String(connector.call(dataServiceUrl));

//Javascript E4X module has problems with XML header

if ( str.substr(0,5).indexOf("?xml") != -1 ) {
	positionRootElement = str.indexOf("<", 10);//get first real tag
	str = str.substr( positionRootElement, str.length - 1 ); 
}

var cars = new XML(str);

if ( carMake == "list" ) {

	// return list of all available makes
	var make;
	for each ( make in cars.make)	{	
		result.push(make.@name);
	}
	
	
} else {

	// return list of all available models
	var cmodel;
	for each ( cmodel in cars.make.(@name == carMake).*)	{	
		result.push(cmodel.text());
	}

}

model.result = jsonUtils.toJSONString(result);

