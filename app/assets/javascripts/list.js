var xhr;
var nodes;
var handles = new Array();

function init() {
	nodes = $("#table").children();
	xhr = new XMLHttpRequest();
	xhr.onreadystatechange = ORSC;
	
	nodes.each( function(i) {
		if($(this)[0].id) {
			id = $(this)[0].id.substring(2);
			var handle = $("#cfhandle"+id).html();
			if(handle)
				handles.push(handle);
		}
	});
	
	
	var query = "https://codeforces.com/api/user.info?handles=" + handles.join(';');
	xhr.open('GET', query);
	xhr.send();
}

function ORSC() {
	if (xhr.readyState != 4) {
		return;
	}
	if (xhr.status != 200) {
		console.log( xhr.status + ': ' + xhr.statusText );
	} else {
		cfdata = JSON.parse(xhr.responseText);
		if(cfdata.status == "OK") {
			var data = cfdata.result;
			var ratings = new Object();
			for(var i in data) {
				var row = data[i];
				if('rating' in row) {
					ratings[row.handle] = row.rating;
				}
			}
			
			nodes.each( function(i) {
				var id = $(this)[0].id.substring(2);
				var handle = $("#cfhandle"+id).html();
				if(handle) {
					var rating = ratings[handle];
					var color = userColor(parseInt(rating));
					if(rating == undefined) {
						rating = 'Не в рейтинге';
						color = 'gray';
					}
					//console.log('loaded ' + handle + '\'s rating as ' + rating);
					$("#rating"+id).html('<a style="font-weight:bold" class="user-' + color + '" href="https://codeforces.com/profile/' + handle + '">' + rating + '</a>');
				} else {
					//console.log(cfdata.status);
				}
			});
		}
	}
}

function userColor(rating) {
	if(rating < 1200)
		return 'gray';
	if(rating < 1400)
		return 'green';
	if(rating < 1600)
		return 'cyan';
	if(rating < 1900)
		return 'blue';
	if(rating < 2200)
		return 'violet';
	if(rating < 2400)
		return 'orange';
	return 'red';
}

//$(".users.index").ready(init);
//$(".teams.edit").ready(init);
//$(".teams.show").ready(init);
$(document).ready(init);
//$(document).on('page:load', init);
//$(document).on('turbolinks:load', init);
