function filterSearch() {
	var input, filter, table, tr, td, i;
	inputs = new Array();
	inputs.push(document.getElementById("searchName").value.toLowerCase());
	inputs.push(document.getElementById("searchSchool").value.toLowerCase());
	inputs.push(document.getElementById("searchGroup").value.toLowerCase());
	inputs.push(parseInt(document.getElementById("searchMin").value));
	inputs.push(parseInt(document.getElementById("searchMax").value));
	table = document.getElementById("table");
	tr = table.getElementsByTagName("tr");

	for (i = 0; i < tr.length; i++) {
		var tds = tr[i].getElementsByTagName("td");
		var visible = true;
		for(var index = 0; index < 3; index++) {
			td = tds[index];
			if (td) {
				if (td.innerHTML.toLowerCase().indexOf(inputs[index]) <= -1) {
					visible = false;
					break;
				}
			}
		}
		if(visible) {
			var fmin = inputs[3];
			var fmax = inputs[4];
			if(fmin || fmax) {
				td = tds[3];
				span = td.getElementsByTagName("span")[0];
				a = span.getElementsByTagName("a")[0];
				if (a) {
					if(isNaN(a.innerHTML)) {
						visible = false;
					} else {
						var fmn, fmx;
						if(!fmin)
							fmn = 0;
						else
							fmn = fmin;
						if(!fmax)
							fmx = 4000;
						else
							fmx = fmax;
						if (parseInt(a.innerHTML) < fmn || parseInt(a.innerHTML) > fmx) {
							visible = false;
						}
					}
				} else {
					if(fmin || fmax)
						visible = false;
				}
			}
		}
		console.log(tr[i], visible)
		if(visible)
			tr[i].style.display = "";
		else
			tr[i].style.display = "none";
	}
}

/*
function filterRating () {
	var input, filter, table, tr, td, i;
	input = document.getElementById("searchMin");
	fmin = parseInt(input.value);
	input = document.getElementById("searchMax");
	fmax = parseInt(input.value);
	table = document.getElementById("table");
	tr = table.getElementsByTagName("tr");
	for (i = 0; i < tr.length; i++) {
		if(!fmin && !fmax) {
			tr[i].style.display = "";
			continue;
		}
		td = tr[i].getElementsByTagName("td")[3];
		span = td.getElementsByTagName("span")[0];
		a = span.getElementsByTagName("a")[0];
		if (a) {
			var fmn, fmx;
			if(!fmin)
				fmn = 0;
			else
				fmn = fmin;
			if(!fmax)
				fmx = 4000;
			else
				fmx = fmax;
			if (parseInt(a.innerHTML) >= fmn && parseInt(a.innerHTML) <= fmx) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		} else {
			if(!fmin && !fmax)
				tr[i].style.display = "";
			else
				tr[i].style.display = "none";
		}
	}
} */

function sortTable(index) {
	console.log("function call")
	var rows, i, x, y, shouldSwitch, switchcount = 0;
	var table = document.getElementById("table");
	var switching = true;
	var dir = "asc"; 
	while (switching) {
		switching = false;
		rows = table.getElementsByTagName("tr");
		for (i = 0; i < (rows.length - 1); i++) {
			shouldSwitch = false;
			x = rows[i].getElementsByTagName("td")[index];
			y = rows[i + 1].getElementsByTagName("td")[index];
			if(index == 3) {
				x = x.getElementsByTagName("span")[0].getElementsByTagName("a")[0];
				y = y.getElementsByTagName("span")[0].getElementsByTagName("a")[0];
			}
			x = contents(x);
			y = contents(y);
			if (dir == "asc") {
				if (comp(x, y, true)) {
					shouldSwitch = true;
					break;
				}
			} else if (dir == "desc") {
				if (comp(x, y, false)) {
					shouldSwitch = true;
					break;
				}
			}
		}
		if (shouldSwitch) {
			rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
			switching = true;
			switchcount ++; 
		} else {
			if (switchcount == 0 && dir == "asc") {
				dir = "desc";
				switching = true;
			}
		}
	}
}

function contents(element) {
	if(element == undefined)
		return 'z';
	else if(element.getElementsByTagName('a')[0] == undefined)
		return element.innerHTML.toLowerCase();
	return element.getElementsByTagName('a')[0].innerHTML.toLowerCase();
}

function comp(x, y, asc) {
	if(!asc)
		y = [x, x = y][0];
	if(isNaN(x) == isNaN(y)) {
		return x < y;
	} else {
		return isNaN(x);
	}
}
