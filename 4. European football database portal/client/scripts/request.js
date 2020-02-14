// all post request for different pages and hanlding of table formulation
var userCountryId = $('hidden').text();
console.log(userCountryId);



function createTable(data,usr){
  var num = Object.keys(data).length;
  for(var i=0;i<num;i++)
  {
    var key = Object.keys(data[i]);
    var num2 = Object.keys(data[i][key]).length;
    for(var j=0;j<1;j++)
    {
      var kh = Object.keys(data[i][key][j]);
      var b = Object.keys(kh).length;
      usr.innerHTML += "<div style='position:absolute'>";
      var myTable= "<table class='stab' border='1' id='example1'><tr>";
      for(var k=0;k<b;k++)
      {
        myTable+= "<td style='color: red;'>"+kh[k]+"</td>";
      }
      myTable+="</tr>"
      }
      for(var j=0;j<num2;j++)
      {
        var kh = Object.keys(data[i][key][j]);
        myTable+="<tr>";
        for(var k=0;k<kh.length;k++)
        {
          var d = data[i][key][j][kh[k]];
          myTable+="<td>"  + d + "</td>";
        }
        myTable+="</tr>";
      }
      myTable+="</table><br><br>"
      usr.innerHTML += myTable;
      usr.innerHTML += "</div>";
  }
}


function createTable1(data,usr){
  var num = Object.keys(data).length;
	for(var i=0;i<num;i++)
	{
		var key = Object.keys(data[i]);
		var num2 = Object.keys(data[i][key]).length;
		for(var j=0;j<1;j++)
		{
			var kh = Object.keys(data[i][key][j]);
			var b = Object.keys(kh).length;
			usr.innerHTML += "<div style='position:absolute'>";
			var myTable= "<table class='stab' border='1' id='example1'><tr>";
			for(var k=0;k<b;k++)
			{
				myTable+= "<td style='color: red;'>"+kh[k]+"</td>";
			}
			myTable+="</tr>"
			}
			for(var j=0;j<num2;j++)
			{
				var kh = Object.keys(data[i][key][j]);
				myTable+="<tr>";
				for(var k=0;k<kh.length;k++)
				{
					var d = data[i][key][j][kh[k]];
					myTable+="<td>"  + d + "</td>";
				}
				myTable+="</tr>";
			}
		  myTable+="</table><br><br>"
		  usr.innerHTML += myTable;
		  usr.innerHTML += "</div>";
	}

  $('#example1').Tabledit({
    url: '/updaterPlayer',
    columns: {
        identifier: [0, 'api_id'],
        editable: [[5,'potential'],[8,'crossing'],[9,'finishing']],
    },
    // [1, 'player_name'], [2, 'year_born'],[3, 'age'],
    onDraw: function() {
        console.log('onDraw()');
    },
    onSuccess: function(data, textStatus, jqXHR) {
        console.log('onSuccess(data, textStatus, jqXHR)');
        console.log(data);
        console.log(textStatus);
        console.log(jqXHR);
    },
    onFail: function(jqXHR, textStatus, errorThrown) {
        console.log('onFail(jqXHR, textStatus, errorThrown)');
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    },
    onAlways: function() {
        console.log('onAlways()');
    },
    onAjax: function(action, serialize) {
        console.log('onAjax(action, serialize)');
        console.log(action);
        console.log(serialize);
    }
  });
}

function createTable2(data,usr){
  var num = Object.keys(data).length;
  for(var i=0;i<num;i++)
  {
    var key = Object.keys(data[i]);
    var num2 = Object.keys(data[i][key]).length;
    for(var j=0;j<1;j++)
    {
      var kh = Object.keys(data[i][key][j]);
      var b = Object.keys(kh).length;
      usr.innerHTML += "<div style='position:absolute'>";
      var myTable= "<table class='stab' border='1' id='example1'><tr>";
      for(var k=0;k<b;k++)
      {
        myTable+= "<td style='color: red;'>"+kh[k]+"</td>";
      }
      myTable+="</tr>"
      }
      for(var j=0;j<num2;j++)
      {
        var kh = Object.keys(data[i][key][j]);
        myTable+="<tr>";
        for(var k=0;k<kh.length;k++)
        {
          var d = data[i][key][j][kh[k]];
          myTable+="<td>"  + d + "</td>";
        }
        myTable+="</tr>";
      }
      myTable+="</table><br><br>"
      usr.innerHTML += myTable;
      usr.innerHTML += "</div>";
  }

  $('#example1').Tabledit({
    url: '/updaterTeam',
    columns: {
        identifier: [0, 'team_id'],
        editable: [[2,'speed'], [4,'drib'],[6,'pass']],
    },
    onDraw: function() {
        console.log('onDraw()');
    },
    onSuccess: function(data, textStatus, jqXHR) {
        console.log('onSuccess(data, textStatus, jqXHR)');
        console.log(data);
        console.log(textStatus);
        console.log(jqXHR);
    },
    onFail: function(jqXHR, textStatus, errorThrown) {
        console.log('onFail(jqXHR, textStatus, errorThrown)');
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    },
    onAlways: function() {
        console.log('onAlways()');
    },
    onAjax: function(action, serialize) {
        console.log('onAjax(action, serialize)');
        console.log(action);
        console.log(serialize);
    }
  });
}

var lastcall = 1;

function setter(id){
  var usr = document.getElementById("hello");
  usr.innerHTML = "";
  if(id=="player"){
  	usr.innerHTML += '<div class="selector">\
        <div class="input-select" align="center" width="480" heig>\
          <select data-trigger="" name="choices-single-default">\
          <option placeholder="">Category</option>\
          <option onclick="playerPost(1);">PLAYER  By Height</option>\
          <option onclick="playerPost(2);">PLAYER  By Info</option>\
          </select>\
        </div>\
        </div>\
    </div><section id="player"></section>'
  }
  else if(id=="stat"){
    usr.innerHTML += ' <div class="selector">\
        <div class="input-select" align="center" width="480" heig>\
          <select data-trigger="" name="choices-single-default">\
          <option placeholder="">Category</option>\
          <option onclick="statPost(1);">PLAYER  By Birth</option>\
          <option onclick="statPost(2);">PLAYER  By Height</option>\
          <option onclick="statPost(3);">PLAYER  By Year</option>\
          <option onclick="statPost(4);">PLAYER  Info by Birth</option>\
          <option onclick="statPost(5);">PLAYER Rating</option>\
          </select>\
        </div>\
        </div>\
    </div><section id="stat"></section>'
  }else if(id=="top"){
        usr.innerHTML += ' <div class="selector">\
        <div class="input-select" align="center" width="480" heig>\
          <select data-trigger="" name="choices-single-default">\
          <option placeholder="">Category</option>\
          <option onclick="topPost(1);">topPlayersByoverall_rating</option>\
          <option onclick="topPost(2);">topPlayersBypotential</option>\
          <option onclick="topPost(3);">topPlayersBycrossing</option>\
          <option onclick="topPost(4);">topPlayersByfinishing</option>\
          <option onclick="topPost(5);">By Heading accuracy</option>\
          <option onclick="topPost(6);">By Short passing</option>\
          <option onclick="topPost(7);">By short passing</option>\
          <option onclick="topPost(9);">By dribbling</option>\
          <option onclick="topPost(10);">By curve</option>\
          <option onclick="topPost(11);">By free kick accuracy</option>\
          <option onclick="topPost(12);">By  long passing</option>\
          <option onclick="topPost(13);">By ball control</option>\
          <option onclick="topPost(14);">By acceleration</option>\
          <option onclick="topPost(15);">By sprint speed</option>\
          <option onclick="topPost(16);">By agility</option>\
          <option onclick="topPost(17);">By rection</option>\
          </select>\
        </div>\
        </div>\
    </div><section id="top"></section>'
  }
  else if(id=="coun"){
    $.post("/fetchCountries").done((data,status)=>{
      allCountries = data;
      myCountry = "";
      text = "";
      for(i in allCountries){
      text = text + `<option onclick="changeCountry(`+allCountries[i].id+`)">`+allCountries[i].name+`</option>`
      if(allCountries[i].id == userCountryId){
        myCountry = allCountries[i].name;
      }
    }
      usr.innerHTML += `<div style='text-align:center;color:white'>Your current country is :`+myCountry+`</div><br><br>`
    
    usr.innerHTML += `<div style="text-align:center;color:white">Update your country:<br><br><div class="selector">
            <div class="input-select" align="center" width="480" height=auto>
              <select data-trigger="" name="choices-single-default">`+text+`</select>
            </div>
          </div>
          </div>`
    });
    
  }
  else if(id=="cplayer"){
    usr.innerHTML += "<h1 style='text-align:center;color:white;'>Create New Player</h1><br>"
    usr.innerHTML += "<form style='text-align:center;padding:auto;color:white;'>\
                      <label for='pname'>Player Name</label>\
                     <input type='text' id='pname' name='pname' required><br><br>\
                     <label for='dob'>Date of Birth</label>\
                     <input type='text' id='dob' name='dob' required><br><br>\
                     <label for='pname'>Height</label>\
                     <input type='text' id='height' name='height' required><br><br>\
                     <label for='pname'>Weight</label>\
                     <input type='text' id='weight' name='weight' required><br><br>\
                     <button type='submit' style='padding:5px'>Submit</button>\
                     </form>\
                     "
  }
  else if(id=="cteam"){
    $.post("/getLeague").done((data,status)=>{
      allLeagues = data;
      usr.innerHTML += `<h1 style='text-align:center;color:white'>Create New Team</h1><br>
                    <form style='text-align:center;color:white;padding:auto;'>
                        <label for='pname'>Team Name</label>
                      <input type='text' id='pteam' name='pteam' required><br><br>
                      <label for='dob'>Short Name</label>
                      <input type='text' id='sn' name='sn' required><br><br></form>`
      text = "";

      for(i in allLeagues){
      text = text + `<option onclick="updateLeague(`+allLeagues[i].id+`)">`+allLeagues[i].name+`</option>`
    } 
    usr.innerHTML += `<div style="text-align:center;color:white">Select League:<br><br><div class="selector">
            <div class="input-select" align="center" width="480" height=auto>
              <select data-trigger="" name="choices-single-default">`+text+`</select>
            </div>
          </div>
          </div>`
    });
        }
  else if(id =="addCountry"){
    usr.innerHTML += "<h1 style='text-align:center;color:white'>Create New Country</h1><br>"
    usr.innerHTML += "<form style='text-align:center;color:white;padding:auto;' id='counform' action='/country/add' method='POST'>\
                      <label for='name'>Country Name</label>\
                     <input type='text' id='name' name='name' required></input><br><br>\
                      <button type='submit' style='padding:5px'>Submit</button>\
                      </form>\
                     "
  }
  else if(id == "country"){
  	$.post("/country/list").done((data,status)=>{
  	  //console.log(data)
  	  createTable(data,usr);
  	});
  }else if(id == "Leagues"){
    $.post("/country/league").done((data,status)=>{
      //console.log(data)
      createTable(data,usr);
    });    
  }else if(id == "teamAll"){
     usr.innerHTML += `<div align="center"><br><input type="number" step="1" value="10" onchange="teamPost(1,$(this).val());"
     placeholder="limit"></input></div><br><br></div><section id="team"></section>`
    console.log("team post")
    teamPost(1);
  }else if(id=="teamSeason"){
     usr.innerHTML += ` <div class="selector">
        <div class="input-select" align="center" width="480" heig>
          <select data-trigger="" name="choices-single-default">
          <option placeholder="">Category</option>
          <option onclick="teamPost(2);">Best Teams</option>
          <option onclick="teamPost(3);">By Home Matches</option>
          <option onclick="teamPost(4);">By Away Matches</option>
          <option onclick="teamPost(5);">By Home Goals</option>
          <option onclick="teamPost(6);">By Away Goals</option>
          <option onclick="teamPost(7);">Top Losing Team</option>
          <option onclick="teamPost(8);">Top Winning Team</option>
          <option onclick="teamPost(9);">Top Draw Team</option>
          </select>
        </div>
        </div>
    </div><div align="center"><br><input type="number" step="1" value="10" onchange="updateteamPost($(this).val());"
     placeholder="limit"></input></div><br><br><section id="team"></section>`
  }else if(id=="teamAllTime"){
    usr.innerHTML += ' <div class="selector">\
        <div class="input-select" align="center" width="480" heig>\
          <select data-trigger="" name="choices-single-default">\
          <option placeholder="">Category</option>\
          <option onclick="teamPost(12);">Best Teams</option>\
          <option onclick="teamPost(13);">By Home Matches</option>\
          <option onclick="teamPost(14);">By Away Matches</option>\
          <option onclick="teamPost(15);">By Home Goals</option>\
          <option onclick="teamPost(16);">By Away Goals</option>\
          <option onclick="teamPost(17);">Top Losing Team</option>\
          <option onclick="teamPost(18);">Top Winning Team</option>\
          <option onclick="teamPost(19);">Top Draw Team</option>\
          </select>\
        </div>\
        </div>\
    </div><section id="team"></section>'


  }else if(id=="match_season"){
    usr.innerHTML = `<section id="match"></season>`;
    matchPost(1);
  }else if(id=="match_country"){
    usr.innerHTML = `<section id="match"></season>`;
    matchPost(2);
  }else if(id=="match_league"){
    usr.innerHTML = `<section id="match"></season>`;
    matchPost(3);
  }else if(id=="league_season"){
    usr.innerHTML = `<section id="league"></season>`;
    leaguePost(1);
  }else if(id=="league_performance"){
    usr.innerHTML = `<section id="league"></season>`;
    leaguePost(2);
  }else if(id=="uplayer"){
    usr.innerHTML = `<section id="uplayer"></season>`;
    uplayer();
  }else if(id=="uteam"){
    usr.innerHTML = `<section id="uteam"></season>`;
    uteam(usr);
  }
}

function uplayer(usr){
  $.post("/player/update").done((data,status)=>{
    var stat = document.getElementById("uplayer");
    createTable1(data,stat);
  })
}

function uteam(usr){
  $.post("/team/update").done((data,status)=>{
    var stat = document.getElementById("uteam");
    createTable2(data,stat);
  })
}

function playerPost(id){
  var obj = {code:id};
	$.post("/player/player",obj).done((data,status)=>{
	  createTable(data,usr);
	})
}

function statPost(id){
  console.log(id);
    obj = {code:id};
    $.post("/player/stat",obj).done((data,status)=>{
    var stat = document.getElementById("stat");
      stat.innerHTML = "";
      console.log(data)
    createTable(data,stat);
    parsedData = parseData(data);
    plot(parsedData);

  })
}

function topPost(id){
  console.log(id);
    obj = {code:id};
    $.post("/player/top",obj).done((data,status)=>{
    var stat = document.getElementById("top");
      stat.innerHTML = "";
      console.log(data)
    createTable(data,stat);

  })
}

function teamPost(id,val){
  lastcall = id;
  console.log(id);
    obj = {code:id,value:val};
    $.post("/team/teams",obj).done((data,status)=>{
    var stat = document.getElementById("team");
      stat.innerHTML = "";
      console.log(data)
    createTable(data,stat);
      
  })
}


function updateteamPost(val){
  var id = lastcall;
  console.log(id);
    obj = {code:id,value:val};
    $.post("/team/teams",obj).done((data,status)=>{
    var stat = document.getElementById("team");
      stat.innerHTML = "";
      console.log(data)
    createTable(data,stat);
      
  })
}

function matchPost(id){
  console.log(id);
    obj = {code:id};
    $.post("/match/stat",obj).done((data,status)=>{
    var stat = document.getElementById("match");
      stat.innerHTML = "";
      console.log(data)
    createTable(data,stat);
      
  })
}

function leaguePost(id){
  console.log(id);
    obj = {code:id};
    $.post("/league/stat",obj).done((data,status)=>{
    var stat = document.getElementById("league");
      stat.innerHTML = "";
      console.log(data)
    createTable(data,stat);
      
  })
}

function fetchCountries(){
  $.post("/fetchCountries").done((data,status)=>{
    return data;
  });
}

function changeCountry(id){
  $.post("/fetchCountries").done((data,status)=>{
    allCountries = data;
    myCountry = "";
    for(i in allCountries){
      if(allCountries[i].id == id){
        myCountry = allCountries[i].name;
      }
    }
    var obj ={id:id}
    $.post("/updateCountry",obj).done((data,status)=>{
      userCountryId = id;
      setter("coun");
    });
  });
}

function updateLeague(id){
  teamName = $('#hello form input#pteam').val();
  shortName = $('#hello form input#sn').val();
  obj = {
    teamName:teamName,
    shortName:shortName
  }
  console.log(obj);
  if(teamName===null){
    alert("Please enter Team Name ");
  }else if(shortName===null){
    alert("Please enter Team Name ");
  }else{
    $.post("/addTeam",obj).done((data,status)=>{
      alert(data.message);
    });
  }
}


