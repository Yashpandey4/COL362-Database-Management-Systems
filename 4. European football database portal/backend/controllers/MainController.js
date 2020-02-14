/**
 * Created by Sunil
 */
var connection = require('../Models/db_connect');
// var connection = require('../../config');
// var nodemailer = require('nodemailer');


module.exports = {
    home:home,
    search:search,
    update:update,
    insert:insert,
    database:database,
    database1:database1,
    report:report,
    login:login,
    signuppost:signuppost,
    loginpost:loginpost,
    signup:signup,
    logout:logout,
    loginpost:loginpost,
    team:team,
    league:league,
    manager:manager,
    player:player,
    match:match,
    country:country,
    playerList:playerList,
    playerStat:playerStat,
    playerTop:playerTop,
    countryList:countryList,
    countryAdd:countryAdd,
    countryLeague:leagueByCountry,
    sql:sql,
    teams:teamList,
    matchStat:matchStat,
    leagueStat:leagueStat,
    getAllCountries:getAllCountries,
    updateCountry:updateCountry,
    getAllLeague:getAllLeague,
    addTeam:addTeam,
    updater1:updater1,
    updater2:updater2,
    playerget:playerget,
    teamget:teamget
}

//==========================================================
//========== get request handling==========================
//==========================================================
function home(req,res){
    console.log(req.session.user);
    res.render('home.ejs', {
        user:req.session.user
    });
}
function search(req,res){
    res.render('search/search.ejs', {
        user:req.session.user
    });
}

function update(req,res){
    res.render('update/update.ejs', {
        user:req.session.user
    });
}
function insert(req,res){
    res.render('insert/insert.ejs', {
        user:req.session.user
    });
}

function manager(req,res){
    console.log(req.session.user);
    res.render('manager/manager.ejs',{
        user:req.session.user
    })
}

function match(req,res){
    console.log(req.session.user);
    res.render('match/match.ejs',{
        user:req.session.user
    })
}

function player(req,res){
    console.log(req.session.user);
    res.render('player/player.ejs',{
        user:req.session.user
    })
}

function country(req,res){
    console.log(req.session.user);
    res.render('country/country.ejs',{
        user:req.session.user
    })
}

function login(req,res){
    res.render(
        'login/login.ejs',
        {
            user:req.session.user,
            message: 'loginMessage'
        }
    );
}
function signup(req, res) {
res.render(
    'signup/signup.ejs',
     {message: 'signupMessage'}
     );

};

// function admin(req,res,next){
//     // requireRole(req,res,next,'admin');
//     if(sessionChecker(req,res,next,'admin'))
//     res.render('other/admin.ejs',{
//         user: req.session.user
//     });
// }
// function company(req,res,next){
//     // requireRole(req,res,next,'company');
//     if(sessionChecker(req,res,next,'company'))
//     res.render('company/company.ejs',{
//         user:req.session.user
//     });
// }
// function member(req,res,next){
//     // requireRole(req,res,next,'member');
//     if(sessionChecker(req,res,next,'member'))
//     res.render('user/intern_listing.ejs',{
//         user:req.session.user
//     });
// }
// function companyinternform(req,res,next){
//     // requireRole(req,res,next,'company');
//     if(sessionChecker(req,res,next,'company'))
//     res.render('company/postIntern.ejs',{
//         user:req.session.user
//     })
// }


//========= Logout ==================================
function logout(req,res){
    if (req.session.user || req.cookies.user_sid) {
        req.logout();
        req.session.user = null;
        console.log(req.session.user);
        console.log("yo")
        res.clearCookie('user_sid');
        res.redirect('/');
    } else {
        console.log(req.session.user);
        res.redirect('/login');
    }
    // res.redirect('/');
}

//==========================================================
//============ SPECIAL GET REQUEST =========================
//==========================================================
// function verify(req,res){
//     var email = req.query.id.split(",")[0];
//     connection.query('UPDATE users SET verify="1" where email = ?',email,function(err,results,fields){
//         console.log('hey there');
//         console.log('results');
//         var result;
//         if(err) throw err;
//         result = parseIt(results);

//         console.log(results);
//         return res.redirect('/admin');
//     });
// }

function updater1(req,res){
    console.log(req.body)
    var val = req.body;
    if(val.action=="edit"){
        var query = "UPDATE player_attributes set potential =  $1 ,finishing = $2 , crossing = $3 where player_api_id = $4";
        connection.query(query,[val.potential, val.finishing,val.crossing,val.api_id] ,(err,result)=>{
            if(err){
                console.log(err)
            }else{
                console.log(result)
                res.send({error:false,message:"updated"});
            }            
        })

    }
}
function updater2(req,res){
    console.log(req.body)
    var val = req.body;
    if(val.action=="edit"){
        var query = "UPDATE team_attributes set buildupplayspeed =  $1 ,buildupplaydribbling   = $2 , buildupplaypassing = $3 where team_api_id= $4";
        connection.query(query,[val.speed, val.drib,val.pass,val.team_id] ,(err,result)=>{
            if(err){
                console.log(err)
            }else{
                console.log(result)
                res.send({error:false,message:"updated"});
            }            
        })

    }
}
function playerget(req,res){
    var query = `SELECT 
    DISTINCT on (p.player_api_id) p.player_api_id,
    p.player_name,
    --*,
    EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS "year_born",
    -- 2019-(CAST(coalesce(year_born, '0') AS integer)) AS \"player_age\"
    2019::int-(select EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int) AS age,
    pa.overall_rating,pa.potential,pa.attacking_work_rate,pa.defensive_work_rate,pa.crossing,pa.finishing,pa.heading_accuracy,pa.short_passing,pa.gk_kicking,pa.gk_positioning,pa.gk_reflexes
    FROM Player AS p
    INNER JOIN Player_Attributes AS pa 
    ON p.player_api_id = pa.player_api_id
    --WHERE (Insert Sorting Attribute here > Insert threshhold value)
    ORDER BY p.player_api_id,p.player_name
    LIMIT 10
    ;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            console.log(result)
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}
function teamget(req,res){
// function teamInfo(req,res){
    var query = `SELECT 
    DISTINCT on (Team.team_api_id) Team.team_api_id,
    Team.team_long_name,
    Team_Attributes.buildupplayspeed, 
    Team_Attributes.buildupplayspeedclass,
        Team_Attributes.buildupplaydribbling, 
    Team_Attributes.buildupplaydribblingclass,
    Team_Attributes.buildupplaypassing, 
    Team_Attributes.buildupplaypassingclass
    FROM Team, Team_Attributes
WHERE Team.team_api_id = Team_Attributes.team_api_id
ORDER BY Team.team_api_id,Team.team_long_name Limit 20;`
var obj =[];
    connection.query(query,(err,result)=>{
        if(err)
            console.log(err)
        else{
            obj.push({stat:result.rows})
            res.json(obj);
            }       
    }) 
// }
}
//===========================================================
//========= checks role of user =============================
//===========================================================
function requireRole(req,res,next,role) {    
    console.log(req.user);
    if(typeof req.user != "undefined")
    { 
        if ( req.user.local.role === role) {
            // do nothing
        } else {
            res.redirect('/'+req.user.local.role);
        }
    }else
    {
        res.redirect('/login');
    }
}

var sessionChecker = (req, res, next,role) => {
    if (req.session.user && req.cookies.user_sid) {
        if(req.session.user.Role === role)
        {
            if(req.session.user.verify=== 0){
                req.session.user = null;
                res.redirect('/login');
                // res.clearCookie('user_sid');
                return false;
            }
            else
            {
                return true;
            }
            
        }
        else
        {
            res.redirect(req.session.user.Role);
            return false;
        }
    } else {
        res.redirect('/login');
        return false;
        // next();
    }    
};


//==========================================================
//================ POST REQUEST ============================
//==========================================================

function loginpost(req,res,next){
    console.log(req.body);
    // SELECT * FROM users WHERE email = 'sunilssaharan@gmail.com' 
    var query = "SELECT * FROM manager WHERE email = "+"'"+req.body.email+"'";
    console.log(query); 
    connection.query(query,function(err,results,fields){
    // connection.query("SELECT * FROM manager WHERE email = $1",['"'+req.body.email+'"'],function(err,results,fields){
    // console.log('hey there');
    console.log(results);
    var result;
    if(err) {
        console.log(err);
        res.send({error:true,message:"either email or password is not correct"});
    } 
    else if(!results.rowCount==0)
    {
            if(results.rows[0].password == req.body.password){
                result = parseIt(results);
                var user = results.rows[0];
                console.log(results.rows[0]);
                req.session.user = results.rows[0];
                // req.logIn(user,function(err)
                // {
                //     if(err){
                //         // return next(err);
                //     }
                    
                // });
                // res.redirect('/manager');
                res.send({error:false});
            }else{
                res.send({error:true,message:"Password is not correct"});
            }

    }
    else
    {
         res.send({error:true,message:"Email don't exits in records"});
        // res.redirect('/login');
    }

    });   
}

function signuppost(req,res,next){
    console.log(req.body);
    // SELECT * FROM users WHERE email = 'sunilssaharan@gmail.com' 
    var input = req.body;
    if(input.name == "")
        res.send({error:true,message:"name is left blank"})
    else if(input.Lname == "")
        res.send({error:true,message:"last name is left blank"})
    else if(input.password == "")
        res.send({error:true,message:"password is left blank"})

    connection.query("Insert into manager (first_name,last_name,email,password) VALUES($1,$2,$3,$4)", [req.body.name,req.body.Lname,req.body.email,req.body.password],function(err,results,fields){
    // console.log('hey there');



    if(err) {
        // throw err;
        res.send({error:true,message:"email already used"})
    }
    else if(!results.rowCount==0)
    {
            console.log(results);
            var result;
            result = parseIt(results);
            var user = results.rows[0];
            console.log(results.rows[0]+'\n\n');
            req.session.user = results.rows[0];

            // req.logIn(user,function(err)
            // {
            //     if(err){
            //         // return next(err);
            //     }
                
            // });
            res.redirect('/manager');

    }
    else
    {
        res.redirect('/login');
    }

    });   
}

function updateCountry(req,res){
    var usr = req.session.user.id;
    var query = "UPDATE manager set country_id = $1 where id = $2";
    connection.query(query,[req.body.id,usr],(err,result)=>{
        if(err){
            console.log(err);
        }else{
            // connection.query("")
            req.session.user.country_id = req.body.id;//result.rows[0]
            res.send({error:false,message:"updated"});
        }
    })
}

// function postform(req,res,next){
//     console.log(req.body);
//     var query = 'Insert INTO form (name , email , phone , message) VALUES(' +'\''+req.body.name+'\''+','+'\''+req.body.email+'\''+','+'\''+req.body.phone+'\''+','+'\''+req.body.message+'\''+')';
//     console.log(query);
//     var out = database.getDataFromTable(query,function(err,result){
//         if(err){
//          console.log(err);
//         }
//         else
//         {
//             console.log("form submitted");
//             res.redirect('/');
//         }
//     });
// }

function database(req,res){
   //getAllDbImage(req,res);
    res.render('database/database.ejs', {
      user:req.session.user
    });
}
function database1(req,res){
    getAllDbImage(req,res);
    // res.render('database/database.ejs', {
    //     user:req.session.user
    // });
}
// get all db image
function getAllDbImage(req,res){
    var query1 = "select * from country limit 5";
    var query2 = "select * from league limit 5";
    var query3 = "select * from match  where home_player_x1 is not NULL limit 5";
    var query4 = "select * from player limit 5";
    var query5 = "select * from player_attributes limit 5";
    var query6 = "select * from team limit 5";
    var query7 = "select * from team_attributes limit 5";

    obj = []
    connection.query(query1,(err,result)=>{
        obj.push({country:result.rows});
        connection.query(query2,(err,result)=>{
            obj.push({league:result.rows});
            connection.query(query3,(err,result)=>{
                obj.push({match:result.rows});
                connection.query(query4,(err,result)=>{
                    obj.push({player:result.rows});
                    connection.query(query5,(err,result)=>{
                        obj.push({playerAttr:result.rows});
                        connection.query(query6,(err,result)=>{
                            obj.push({team:result.rows});
                            connection.query(query7,(err,result)=>{
                                obj.push({teamAttr:result.rows});
                                res.json(obj);
                            })
                        })
                    })
                })
            })
        })
    })

}


function report(req,res){
    res.render('report/report.ejs', {
        user:req.session.user
    });
}

function team(req,res){
    res.render('team/team.ejs', {
        user:req.session.user
    });
}

function league(req,res){
    res.render('league/league.ejs', {
        user:req.session.user
    });
}



function sql(req,res){
    var query = 'SELECT * from country;' ;
    connection.query(query,[],(err,result)=>{
    
    res.json(result.rows);        
    })
}

function getAllLeague(req,res){
    var query = "select id,name from league;"
    connection.query(query,(err,result)=>{
        res.json(result.rows);
    })
}

function addTeam(req,res){
    var query = "Insert into team (team_long_name,team_short_name) VALUES($1,$2)"
    connection.query(query,[req.body.teamName,req.body.shortName],(err,result)=>{
        if(err){
            console.log(err);
            res.send({error:true,message:err});
        }else{
            console.log("team added")
            res.send({error:false,message:"New Team added"});
        }
    })
}

//=====================================================================
//========================    Country            ======================
//=====================================================================


function countryList(req,res){
    var obj = [];
    var query = 'SELECT name from country;' ;
    connection.query(query,(err,result)=>{
    obj.push({country:result.rows})
    res.json(obj);        
    })
}

function countryAdd(req,res){
    console.log(req.body);
    var query = 'Insert into country (name) VALUES('+'\''+req.body.name+'\''+')';
    connection.query(query,(err,result)=>{
    if(err) {
        // throw err;
        res.send({error:true,message:"Counrty already present"})
    }
    else if(!result.rowCount==0)
    {
            console.log(result);
            res.send({error:false,message:"country : "+req.body.name+" added"});
    }
    else
    {
        res.redirect({error:true,message:"Counrty already present"});
    }
    })
}

function leagueByCountry(req,res){
    var query = "SELECT League.name AS League_name, Country.name AS Country_name\
    FROM League, Country\
    WHERE Country.id=League.country_id;"
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}


function getAllCountries(req,res){
    var query = 'SELECT * from country;' ;
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }else{
            res.json(result.rows);   
        }
         
    })
}

//=====================================================================
//========================    Player  Stats      ======================
//=====================================================================


function playerStat(req,res){
    var code = req.body.code;
    console.log(code)
    if(code==1){
        playersByBirthYear(req,res);
    }else if(code == 2){
        playeysByHeight(req,res);
    }
    else if(code == 3){
        playersByYearNumber(req,res);
    }else if(code == 4){
        playerInfoByBirthYear(req,res);
    }else if(code ==5){
        RatingsByYearNumber(req,res)
    }

}



function playersByBirthYear(req,res){
    var query = `SELECT COUNT(p.player_name) AS number_of_players, 
--strftime('%Y',p.birthday) AS "year_born"
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss')) AS "year_born"
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
GROUP BY year_born;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}

function playeysByHeight(req,res){
    var query = `SELECT CASE
    WHEN ROUND(height)<165 then 165
    WHEN ROUND(height)>195 then 195
    ELSE ROUND(height)
    END AS calc_height, 
    COUNT(height) AS distribution, 
    (avg(PA_Grouped.avg_overall_rating)) AS avg_overall_rating,
    (avg(PA_Grouped.avg_potential)) AS avg_potential,
    AVG(weight) AS avg_weight 
FROM PLAYER
LEFT JOIN (SELECT Player_Attributes.player_api_id, 
    avg(Player_Attributes.overall_rating) AS avg_overall_rating,
    avg(Player_Attributes.potential) AS avg_potential  
    FROM Player_Attributes
    GROUP BY Player_Attributes.player_api_id) 
    AS PA_Grouped ON PLAYER.player_api_id = PA_Grouped.player_api_id
GROUP BY calc_height
ORDER BY calc_height
; `
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
            console.log(result.rows)
            res.json(obj);  
        }      
    }) 
}

function playersByYearNumber(req,res){
    var query = `SELECT 
COUNT(p.player_name) AS number_of_players, 
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS "year_born"
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
GROUP BY year_born
HAVING EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int > '1990';`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}

function playerInfoByBirthYear(req,res){
    var query = `SELECT COUNT(p.player_name) AS number_of_players, 
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS "year_born",
MIN(pa.overall_rating) AS min_overall_rating,
MAX(pa.overall_rating) AS max_overall_rating, 
AVG(pa.overall_rating) AS average_overall_rating
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
GROUP BY year_born;`
var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}

function RatingsByYearNumber(req,res){
    var val = req.body.value;
    if(!val){
        val = 90
    }
    var query = `SELECT 
COUNT(p.player_name) AS number_of_players, 
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS "year_born"
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
WHERE pa.overall_rating > $1
GROUP BY year_born;`
var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}

//==============================================================
//=====================Player List==============================
//==============================================================

function playerList(req,res){
    var code = req.body.code;
    console.log(code)
    if(code==1){
        playerByHeight(req,res);
    }else if(code == 2){
        sortByPlayerInfo(req,res);
    }
    else{

    }
}

function playerByHeight(req,res){
    var query = `SELECT player_name, height,    CASE
        WHEN height < 170.00 THEN 'Short'
        WHEN height BETWEEN 170.00 AND 185.00 THEN 'Medium'
        WHEN height > 185.00 THEN 'Tall'    
        END AS height_class
        FROM Player order by height;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}

function sortByPlayerInfo(req,res){
    var query = `SELECT 
p.player_name,
--*,
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS \"year_born\",
-- 2019-(CAST(coalesce(year_born, '0') AS integer)) AS \"player_age\"
2019::int-(select EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int) AS age,
pa.overall_rating,pa.potential,pa.preferred_foot,pa.attacking_work_rate,pa.defensive_work_rate,pa.crossing,pa.finishing,pa.heading_accuracy,pa.short_passing,pa.volleys,pa.dribbling,pa.curve,pa.free_kick_accuracy,pa.long_passing,pa.ball_control,pa.acceleration,pa.sprint_speed,pa.agility,pa.reactions,pa.balance,pa.shot_power,pa.jumping,pa.stamina,pa.strength,pa.long_shots,pa.aggression,pa.interceptions,pa.positioning,pa.vision,pa.penalties,pa.marking,pa.standing_tackle,pa.sliding_tackle,pa.gk_diving,pa.gk_handling,pa.gk_kicking,pa.gk_positioning,pa.gk_reflexes
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
--WHERE (Insert Sorting Attribute here > Insert threshhold value)
ORDER BY p.player_name
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }      
    }) 
}

//===========================================================
//=============== league               ======================
//===========================================================
function leagueStat(req,res){
    var code = req.body.code;
    console.log(code)
    if(code==1){
        leagueBySeason(req,res);
    }else if(code == 2){
        performanceCountryLeagueSeason(req,res);
    }

}


function leagueBySeason(req,res){
    var query = `SELECT Country.name AS country_name,League.name AS league_name, season,
        count(distinct stage) AS number_of_stages,
        count(distinct HT.team_long_name) AS number_of_teams,
        avg(home_team_goal) AS avg_home_team_scors, 
        avg(away_team_goal) AS avg_away_team_goals, 
        avg(home_team_goal-away_team_goal) AS avg_goal_dif,
        avg(home_team_goal+away_team_goal) AS avg_goals, 
        sum(home_team_goal+away_team_goal) AS total_goals                                      
        FROM Match
        JOIN Country on Country.id = Match.country_id
        JOIN League on League.id = Match.league_id
        LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
        LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
        WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
        GROUP BY Country.name, League.name, season
        HAVING count(distinct stage) > 10
        ORDER BY Country.name, League.name, season DESC
        ;`
        var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }        
    }) 
}

function performanceCountryLeagueSeason(req,res){
    var query = `SELECT Country.name AS country_name, 
        League.name AS league_name, 
        season,
        count(distinct stage) AS number_of_stages,
        count(distinct HT.team_long_name) AS number_of_teams,
        avg(home_team_goal) AS avg_home_team_goals, 
        avg(away_team_goal) AS avg_away_team_goals, 
        avg(home_team_goal-away_team_goal) AS avg_goal_dif, 
        avg(home_team_goal+away_team_goal) AS avg_goals, 
        sum(home_team_goal+away_team_goal) AS total_goals                                       
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Country.name, League.name, season
HAVING count(distinct stage) > 10
ORDER BY Country.name, League.name, season DESC
;`
var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }        
    }) 
}




//===========================================================
//===============    Match           ======================
//===========================================================


function matchStat(req,res){
    var code = req.body.code;
    console.log(code)
    if(code==1){
        matchesBySeason(req,res);
    }else if(code == 2){
        matchesInfoCountryWise(req,res);
    }
    else if(code == 3){
        matchesPlayedInEachLeagueBySeason(req,res);
    }

}

function matchesBySeason(req,res){
    var query = `SELECT Match.id, 
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        stage, 
        date,
        HT.team_long_name AS home_team,
        AT.team_long_name AS away_team,
        CASE WHEN home_team_goal > away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Winning_team,
        home_team_goal, 
        away_team_goal                     
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
ORDER by date
LIMIT 10
;`
    var obj = [];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }       
    }) 
}

function matchesInfoCountryWise(req,res){
    var query = `SELECT  Match.id, 
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        stage, 
        date,
        HT.team_long_name AS  home_team,
        AT.team_long_name AS away_team,
        home_team_goal, 
        away_team_goal   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
ORDER by date
LIMIT 10;`
    var obj = [];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }       
    }) 
}




function matchesPlayedInEachLeagueBySeason(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        COUNT(distinct Match.id) AS Matches_Played              
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Country.name, League.name, season
ORDER by Country.name, League.name, season
LIMIT 20
;`
        var obj = [];
       connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({stat:result.rows})
        res.json(obj);  
        }         
    }) 
}




//===========================================================
//===============    Teams            ======================
//===========================================================

function teamList(req,res){
    var code = req.body.code;
    console.log(code)
    if(code==1){
        listAllTeams(req,res)
    }else if(code == 2){
        bestTeamsSeasonWise(req,res);
    }
    else if(code == 3){
        teamsOrderedByNumberOfHomeMatchesPlayedBySeason(req,res);
    }else if(code == 4){
        teamsOrderedByNumberOfAwayMatchesPlayedBySeason(req,res);
    }else if(code ==5){
        topTeamsByHomeGoalsSeasonWise(req,res)
    }else if(code ==6){
        topTeamsByAwayGoalsSeasonWise(req,res)
    }else if(code ==7){
        topLosingTeamsPerSeason(req,res)
    }else if(code ==8){
        topWinningTeamsPerSeason(req,res)
    }else if(code ==9){
        topDrawTeamsPerSeason(req,res)
    }
    else if(code == 12){
        bestTeamsOfAllTimes(req,res);
    }
    else if(code == 13){
        teamsOrderedByNumberOfHomeMatchesPlayedOfAllTimes(req,res);
    }else if(code == 14){
        teamsOrderedByNumberOfAwayMatchesPlayedOfAllTimes(req,res);
    }else if(code ==15){
        topTeamsByHomeGoalsOfAllTimes(req,res)
    }else if(code ==16){
        topTeamsByAwayGoalsOfAllTimes(req,res)
    }else if(code ==17){
        topLosingTeamsOfAllTimes(req,res)
    }else if(code ==18){
        topWinningTeamsOfAllTimes(req,res)
    }else if(code ==19){
        topDrawTeamsOfAllTimes(req,res)
    }
}


function listAllTeams(req,res){
    var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = "SELECT * FROM Team ORDER BY team_long_name LIMIT $1;"
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}

// ==========  Season wise =================

function bestTeamsSeasonWise(req,res){
    var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT Country.name AS country_name, 
        League.name AS league_name,
        HT.team_long_name,
        season,
        count(distinct stage) AS number_of_stages,
        -- count(distinct HT.team_long_name) AS number_of_teams,
        avg(home_team_goal) AS avg_home_team_goals, 
        avg(away_team_goal) AS avg_away_team_goals, 
        avg(home_team_goal-away_team_goal) AS avg_goal_dif, 
        avg(home_team_goal+away_team_goal) AS avg_goals, 
        sum(home_team_goal+away_team_goal) AS total_goals                                       
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
--WHERE league.name in () --best teams in a given league
--WHERE season in () --best teams in a given season
GROUP BY HT.team_long_name, Country.name, League.name, season
--HAVING count(distinct stage) > 10
ORDER BY total_goals DESC, Country.name, League.name, season DESC
LIMIT $1
;`
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}

function teamsOrderedByNumberOfHomeMatchesPlayedBySeason(req,res){
    var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        HT.team_long_name AS home_team,
        season,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name, season
ORDER by Matches_Played DESC, Country.name, League.name, season, HT.team_long_name
LIMIT $1
;`
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}

function teamsOrderedByNumberOfAwayMatchesPlayedBySeason(req,res){
       var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        AT.team_long_name AS away_team,
        season,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name, season
ORDER by Matches_Played DESC, Country.name, League.name, season, AT.team_long_name
LIMIT $1
;`
    var obj =[]
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}

function topTeamsByHomeGoalsSeasonWise(req,res){
    var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        HT.team_long_name AS home_team,
        SUM(home_team_goal) AS "home_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name, season
ORDER BY home_goals_total DESC, Country.name, League.name, season DESC
LIMIT $1
;`
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })  
}

function topTeamsByAwayGoalsSeasonWise(req,res){
    var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        AT.team_long_name AS away_team,
        SUM(away_team_goal) AS "away_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name, season
ORDER BY away_goals_total DESC, Country.name, League.name, season DESC
LIMIT $1
;`
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}


function topLosingTeamsPerSeason(req,res){
        var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        season,
        CASE WHEN home_team_goal < away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Losing_team, 
        COUNT(*) as num_loss            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Losing_team, Country.name, League.name, season
ORDER BY num_loss DESC, Country.name, League.name, season DESC
LIMIT $1
;`
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}

function topWinningTeamsPerSeason(req,res){
        var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        season,
        CASE WHEN home_team_goal > away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Winning_team, 
        COUNT(*) as num_wins            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Winning_team, Country.name, League.name, season
ORDER BY num_wins DESC, Country.name, League.name, season DESC
LIMIT $1
;`
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}

function topDrawTeamsPerSeason(req,res){
        var val = req.body.value;
    if(!val){
        val = 10;
    }
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        season,
        CASE WHEN home_team_goal = away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Draw_team, 
        COUNT(*) as num_draw          
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY draw_team, Country.name, League.name, season
ORDER BY num_draw DESC, Country.name, League.name, season DESC
LIMIT $1`
    var obj =[];
    connection.query(query,[val],(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    }) 
}
// ==========  All Time =================

function bestTeamsOfAllTimes(req,res){
    var query = `SELECT Country.name AS country_name, 
        League.name AS league_name,
        HT.team_long_name,
        --season,
        count(distinct stage) AS number_of_stages,
        -- count(distinct HT.team_long_name) AS number_of_teams,
        avg(home_team_goal) AS avg_home_team_goals, 
        avg(away_team_goal) AS avg_away_team_goals, 
        avg(home_team_goal-away_team_goal) AS avg_goal_dif, 
        avg(home_team_goal+away_team_goal) AS avg_goals, 
        sum(home_team_goal+away_team_goal) AS total_goals                                       
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
--WHERE league.name in () --best teams in a given league
GROUP BY HT.team_long_name, Country.name, League.name
--HAVING count(distinct stage) > 10
ORDER BY total_goals DESC, Country.name, League.name
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}



function teamsOrderedByNumberOfHomeMatchesPlayedOfAllTimes(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        HT.team_long_name AS home_team,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name
ORDER by Matches_Played DESC, Country.name, League.name, HT.team_long_name
LIMIT 20
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}


function teamsOrderedByNumberOfAwayMatchesPlayedOfAllTimes(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        AT.team_long_name AS away_team,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name
ORDER by Matches_Played DESC, Country.name, League.name, AT.team_long_name
LIMIT 20
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}


function topTeamsByHomeGoalsOfAllTimes(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        HT.team_long_name AS home_team,
        SUM(home_team_goal) AS "home_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name
ORDER BY home_goals_total DESC, Country.name, League.name
LIMIT 20
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}


function topTeamsByAwayGoalsOfAllTimes(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        AT.team_long_name AS away_team,
        SUM(away_team_goal) AS "away_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name
ORDER BY away_goals_total DESC, Country.name, League.name
LIMIT 20
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}


function topWinningTeamsOfAllTimes(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        CASE WHEN home_team_goal > away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Winning_team, 
        COUNT(*) as num_wins            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Winning_team, Country.name, League.name
ORDER BY num_wins DESC, Country.name, League.name
LIMIT 20
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}



function topLosingTeamsOfAllTimes(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        CASE WHEN home_team_goal < away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Losing_team, 
        COUNT(*) as num_loss            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Losing_team, Country.name, League.name
ORDER BY num_loss DESC, Country.name, League.name
LIMIT 20
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}



function topDrawTeamsOfAllTimes(req,res){
    var query = `SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        CASE WHEN home_team_goal = away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Draw_team, 
        COUNT(*) as num_draw          
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY draw_team, Country.name, League.name
ORDER BY num_draw DESC, Country.name, League.name
LIMIT 20
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({team:result.rows})
        res.json(obj);  
        }      
    })
}









































//================================================================
//========================== Top Players =========================
//================================================================

function playerTop(req,res){
    var code = req.body.code;
    console.log(code)
    if(code==1){
        topPlayersByoverall_rating(req,res);
    }else if(code == 2){
        topPlayersBypotential(req,res);
    }
    else if(code == 3){
        topPlayersBycrossing(req,res);
    }else if(code == 4){
        topPlayersByfinishing(req,res);
    }else if(code ==5){
        topPlayersByheading_accuracy(req,res)
    }else if(code ==7){
        topPlayersByshort_passing(req,res)
    }else if(code ==8){
        topPlayersByshort_passing(req,res)
    }else if(code ==9){
        topPlayersBydribbling(req,res)
    }else if(code ==10){
        topPlayersBycurve(req,res)
    }else if(code ==11){
        topPlayersByfree_kick_accuracy(req,res)
    }else if(code ==12){
        topPlayersBylong_passing(req,res)
    }else if(code ==13){
        topPlayersByball_control(req,res)
    }else if(code ==14){
        topPlayersByacceleration(req,res)
    }else if(code ==15){
        topPlayersBysprint_speed(req,res)
    }else if(code ==16){
        topPlayersByagility(req,res)
    }else if(code ==17){
        topPlayersByreactions(req,res)
    }
}

function topPlayersByoverall_rating(req,res){
    var query = `SELECT player_name, AVG(overall_rating) AS ratings
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND overall_rating > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBypotential(req,res){
    var query = `SELECT player_name, AVG(potential) AS potential_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND potential > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBycrossing(req,res){
    var query = `SELECT player_name, AVG(crossing) AS crossing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND crossing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersByfinishing(req,res){
    var query = `SELECT player_name, AVG(finishing) AS finishing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND finishing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByheading_accuracy(req,res){
    var query = `SELECT player_name, AVG(heading_accuracy) AS heading_accuracy_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND heading_accuracy > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByshort_passing(req,res){
    var query = `SELECT player_name, AVG(short_passing) AS short_passing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND short_passing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersByvolleys(req,res){
    var query = `
SELECT player_name, AVG(volleys) AS volleys_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND volleys > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersBydribbling(req,res){
    var query = `
SELECT player_name, AVG(dribbling) AS dribbling_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND dribbling > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;
`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBycurve(req,res){
    var query = `SELECT player_name, AVG(curve) AS curve_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND curve > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersByfree_kick_accuracy(req,res){
    var query = `SELECT player_name, AVG(free_kick_accuracy) AS free_kick_accuracy_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND free_kick_accuracy > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersBylong_passing(req,res){
    var query = `SELECT player_name, AVG(long_passing) AS long_passing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND long_passing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersByball_control(req,res){
    var query = `SELECT player_name, AVG(ball_control) AS ball_control_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND ball_control > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByacceleration(req,res){
    var query = `SELECT player_name, AVG(acceleration) AS acceleration_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND acceleration > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersBysprint_speed(req,res){
    var query = `SELECT player_name, AVG(sprint_speed) AS sprint_speed_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND sprint_speed > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByagility(req,res){
    var query = `SELECT player_name, AVG(agility) AS agility_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND agility > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByreactions(req,res){
    var query = `SELECT player_name, AVG(reactions) AS reactions_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND reactions > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;`
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersBybalance(req,res){
    var query = " SELECT player_name, AVG(balance) AS balance_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND balance > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByshot_power(req,res){
    var query = " SELECT player_name, AVG(shot_power) AS shot_power_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND shot_power > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByjumping(req,res){
    var query = " SELECT player_name, AVG(jumping) AS jumping_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND jumping > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBystamina(req,res){
    var query = " SELECT player_name, AVG(stamina) AS stamina_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND stamina > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBystrength(req,res){
    var query = " SELECT player_name, AVG(strength) AS strength_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND strength > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBylong_shots(req,res){
    var query = " SELECT player_name, AVG(long_shots) AS long_shots_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND long_shots > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersByaggression(req,res){
    var query = " SELECT player_name, AVG(aggression) AS aggression_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND aggression > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersByinterceptions(req,res){
    var query = " SELECT player_name, AVG(interceptions) AS interceptions_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND interceptions > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBypositioning(req,res){
    var query = " SELECT player_name, AVG(positioning) AS positioning_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND positioning > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersByvision(req,res){
    var query = " SELECT player_name, AVG(vision) AS vision_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND vision > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBypenalties(req,res){
    var query = " SELECT player_name, AVG(penalties) AS penalties_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND penalties > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBymarking(req,res){
    var query = " SELECT player_name, AVG(marking) AS marking_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND marking > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersBystanding_tackle(req,res){
    var query = " SELECT player_name, AVG(standing_tackle) AS standing_tackle_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND standing_tackle > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBysliding_tackle(req,res){
    var query = " SELECT player_name, AVG(sliding_tackle) AS sliding_tackle_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND sliding_tackle > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersBygk_diving(req,res){
    var query = " SELECT player_name, AVG(gk_diving) AS gk_diving_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_diving > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBygk_handling(req,res){
    var query = " SELECT player_name, AVG(gk_handling) AS gk_handling_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_handling > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBygk_kicking(req,res){
    var query = " SELECT player_name, AVG(gk_kicking) AS gk_kicking_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_kicking > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function topPlayersBygk_positioning(req,res){
    var query = " SELECT player_name, AVG(gk_positioning) AS gk_positioning_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_positioning > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    }) 
}


function topPlayersBygk_reflexes(req,res){
    var query = " SELECT player_name, AVG(gk_reflexes) AS gk_reflexes_avg\
FROM Player, Player_Attributes\
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_reflexes > 0\
GROUP BY 1\
ORDER BY 2 DESC\
LIMIT 10\
; "
    var obj =[];
    connection.query(query,(err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            obj.push({top:result.rows})
            res.json(obj);  
        }      
    })
}


function parseIt(rawData){
    rawData = JSON.stringify(rawData);
    rawData = JSON.parse(rawData);
    return rawData;
}