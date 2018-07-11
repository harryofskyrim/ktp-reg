window.onload = function() {
	var nodes = $("#table").children;
	console.log(nodes);
	for(node in nodes) {
		var id = node.id;
		console.log("Getting data on " + id);
		var query = "https://codeforces.com/api/user.rating?handle=" + $("#cfhandle"+id).innerHtml;
		$.ajax(url: query).done (cfdata) ->
			if(cfdata.status == "OK") {
				$("#rating"+id).innerHtml = cfdata.result.[cfdata.result.length-1].newRating;
			} else {
				console.log(cfdata.status);
			}
	}
} 
