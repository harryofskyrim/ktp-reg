function sortEvents(index, num) {
	var rows, i, x, y, shouldSwitch, switchcount = 0;
	var table = document.getElementById("table" + num);
	var switching = true;
	var dir = "asc"; 
	while (switching) {
		switching = false;
		rows = table.getElementsByTagName("tr");
		for (i = 0; i < (rows.length - 1); i++) {
			shouldSwitch = false;
			x = rows[i].getElementsByTagName("td")[index];
			y = rows[i + 1].getElementsByTagName("td")[index];
			x = contents(x);
			y = contents(y);
			if (dir == "asc") {
				if (x < y) {
					shouldSwitch = true;
					break;
				}
			} else if (dir == "desc") {
				if (x > y) {
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
	return element.innerHTML.toLowerCase();
}
