window.onload = validateEvent;

function validateEvent() {
	
	var submit = document.getElementById('submit');
	submit.setAttribute('disabled', 'true');
	
	//eventTitle
	if(!field(document.getElementById('eventTitle'), document.getElementById('eventTitleError')))
		return;
	
	//eventType
	if(!(document.getElementById('contest').checked || document.getElementById('camp').checked)) {
		no(document.getElementById('eventTypeError'), 'Нужно выбрать один из пунктов')
		return;
	}
	else
		yes(document.getElementById('eventTypeError'));
	
	//schoolType
	if(!(document.getElementById('school').checked
		|| document.getElementById('higher').checked
		|| document.getElementById('mixed'))) {
		no(document.getElementById('schoolTypeError'), 'Нужно выбрать один из пунктов')
		return;
	}
	else
		yes(document.getElementById('schoolTypeError'));
	
	//teamMinSize
	input = document.getElementById('teamMinSize');
	error = document.getElementById('teamMinSizeError');
	if(!input.value) {
		no(error, "Должно быть заполнено");
		return;
	}
	input = parseInt(input.value);
	if(isNaN(input)) {
		no(error, "Должно быть целым числом");
		return;
	} else if(input < 1 || input > 15) {
		no(error, "Должно лежать в пределах [1, 15]")
		return;
	} else
		yes(error);
	
	//teamMaxSize
	input = document.getElementById('teamMinSize');
	error = document.getElementById('teamMinSizeError');
	if(!input.value) {
		yes(error);
	} else {
		input = parseInt(input.value);
		if(isNaN(input)) {
			no(error, "Должно быть целым числом");
			return;
		} else if(input < 1 || input > 15) {
			no(error, "Должно лежать в пределах [1, 15]")
			return;
		} else if (input < parseInt(document.getElementById('teamMinSize').value)) {
			no(error, "Должно быть больше или равным минимальному количеству человек в команде");
			return;
		} else
			yes(error);
	}
	
	//dateStart
	dateStart = Date.parse(document.getElementById('dateStart').value);
	error = document.getElementById('dateStartError');
	if(isNaN(dateStart)) {
		no(error, "Введите дату");
		return;
	}
	console.log(dateStart);
	dateStart = new Date(dateStart);
	today = new Date();
	today.setHours(0,0,0,0);
	if(dateStart < today) {
		no(error, "Дата начала должна быть не ранее, чем сегодня");
		return;
	} else {
		yes(error);
	}
	
	//dateEnd
	dateEnd = document.getElementById('dateEnd');
	error = document.getElementById('dateEndError');
	if(!dateEnd.value)
		yes(error);
	else {
		dateEnd = Date.parse(dateEnd.value);
		if(isNaN(dateEnd)) {
			no(error, "Введите дату");
			return;
		}
		dateEnd = new Date(dateEnd);
		if(dateEnd < dateStart) {
			no(error, "Дата окончания не должна быть раньше даты начала");
			return;
		}
	}
	
	//eventPlace
	input = document.getElementById('eventPlace');
	error = document.getElementById('eventPlaceError');
	if(!field(input, error))
		return;

	submit.removeAttribute('disabled');
}

function no(error, message) {
	error.style.display = '';
	error.innerHTML = message;
	error.parentElement.setAttribute('class', 'error');
}

function yes(error) {
	error.style.display = 'none';
	error.parentElement.removeAttribute('class');
}

function field(input, error) {
	if(input.value) {
		yes(error);
		return true;
	} else {
		no(error, 'Должно быть заполнено');
		return false;
	}
}
