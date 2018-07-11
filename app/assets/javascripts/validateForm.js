var cf = true;

function validate() {
	
	var submit = document.getElementById('submit');
	submit.setAttribute('disabled', 'true');
	
	//school
	if(!(document.getElementById('school').checked || document.getElementById('higher').checked)) {
		no(document.getElementById('schoolError'), 'Нужно выбрать один из пунктов')
		return;
	}
	else
		yes(document.getElementById('schoolError'));
	
	var input, error;
	
	//lastName
	input = document.getElementById('lastName');
	error = document.getElementById('lastNameError');
	if(!field(input, error))
		return;
	
	//firstName
	input = document.getElementById('firstName');
	error = document.getElementById('firstNameError');
	if(!field(input, error))
		return;
	
	//fathersName
	input = document.getElementById('fathersName');
	error = document.getElementById('fathersNameError');
	if(input.value) {
		if(input.value.length > 50) {
			no(error, 'Слишком длинное');
			return;
		} else {
			yes(error);
		}
	}
	
	//cfhandle
	error = document.getElementById('cfhandleError');
	if(cf) {
		yes(error);
	} else {
		no(error, 'Такого хэндла не существует');
		return;
	}
	
	//email
	input = document.getElementById('email');
	if(input != undefined) {
		error = document.getElementById('emailError');
		if(input.value) {
			if(validateEmail(input.value)) {
				yes(error);
			} else {
				no(error, 'Введите корректный e-mail');
				return;
			}
		} else {
			no(error, 'Должно быть заполнено');
			return;
		}
		
		//password
		input = document.getElementById('password');
		error = document.getElementById('passwordError');
		if(input.value) {
			yes(error);
		} else {
			no(error, 'Должно быть заполнено');
			return;
		}
	
		//password
		input_conf = document.getElementById('password_confirmation');
		error = document.getElementById('passwordConfError');
		if(input_conf.value) {
			if(input.value == input_conf.value) {
				error.style.display = 'none';
			} else {
				error.style.display = '';
				error.innerHTML = "Пароли не совпадают";
				return;
			}
		} else {
			error.style.display = '';
			error.innerHTML = "Должно быть заполнено";
			return;
		}
	}
	
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

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}

function field(input, error) {
	if(input.value) {
		if(input.value.length > 50) {
			no(error, 'Слишком длинное');
			return false;
		} else {
			yes(error);
			return true;
		}
	} else {
		no(error, 'Должно быть заполнено');
		return false;
	}
}

function cfLookUp() {
	input = document.getElementById('cfhandle').value;
	if(!input) {
		cf = true;
		return;
	}
	
	xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (xhr.readyState != 4) {
			return;
		}	
		if (xhr.status != 200) {
			console.log( xhr.status + ': ' + xhr.statusText );
			cf = false;
		} else {
			cfdata = JSON.parse(xhr.responseText);
			cf = (cfdata.status == "OK");
		}
	};
	var query = "https://codeforces.com/api/user.info?handles=" + input;
	xhr.open('GET', query);
	xhr.send();
	console.log('load');
}
