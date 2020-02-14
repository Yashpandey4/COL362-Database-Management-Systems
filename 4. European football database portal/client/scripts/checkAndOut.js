function logout(){
	localStorage.removeItem('fifa');
    window.location.reload();
}
// function pronite_logout(){
// 	localStorage.removeItem('Pronite');
// 	localStorage.removeItem('UserPronite');
//     window.location.reload();
// }

function check(){
	var el = document.getElementById("thug");
	console.log(el)
	var token = getToken();
	if(token==null){
		console.log("token was null")
	if(window.location.pathname=="/" || window.location.pathname==""){
		var el = document.getElementById("btnlogreg");
		el.style.display = "block";
		el = document.getElementById("btnlogregafter");
		el.style.display = "none";
	}
	}else{
		console.log("in checker")
		$.post("/api/login",{"token":token})
		.done(function(data,status) {
			console.log("in done checker")
			// localStorage.setItem('USER',JSON.stringify(data.user));
			// localStorage.setItem('ifa', data.token);
			if(window.location.pathname == "/login"){
				window.location.href = "/";
			}
			if(window.location.pathname=="/" || window.location.pathname==""){
				 var el = document.getElementById("btnlogreg");
				console.log(el)
				el.style.display = "none";
				el = document.getElementById("btnlogregafter");
				el.style.display = "block";
				el = document.getElementById("username");
				el.innerHTML = data.user.first_name+" "+data.user.last_name;
				el = document.getElementById("rdvid");
				el.innerHTML = data.user.rdv_number;
				el = document.getElementById("points");
				el.innerHTML = data.user.rdv_points;
			}
		}).fail(function(a,b,c){
			console.log(a);
			localStorage.removeItem('RDV');
			if(window.location.pathname=="/" || window.location.pathname==""){
				var el = document.getElementById("btnlogreg");
				el.style.display = "block";
				el = document.getElementById("btnlogregafter");
				el.style.display = "none";
			}
		})
	}
}

function getToken() {
  const token = localStorage.getItem('fifa');
  if (typeof(token) === "undefined" || !token || token === '')
    return null;
  return token;
}