function parseData(data) {
   var x=[];
   var y = [];


   for (var i in data[0].stat) {
   	var obj = data[0].stat[i];
   	var keys = Object.keys(obj);
	x.push(obj[keys[1]]);
    y.push(parseInt(obj[keys[0]]));
   }
   var obj = {
   	x:x.sort(),
   	y:y.sort(),
   	type:'scatter',
   	mode: 'lines+markers'
   }
   return obj;
}



function plot(data){
	console.log(data);
	Plotly.newPlot('myDiv', [data]);
}

