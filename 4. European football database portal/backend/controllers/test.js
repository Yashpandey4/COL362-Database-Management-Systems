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
        topPlayersByfinishingr(req,res);
    }else if(code ==5){
        topPlayersByheading_accuracy(req,res)
    }else if(code =7){
        topPlayersByshort_passing(req,res)
    }else if(code =8){
        topPlayersByshort_passing(req,res)
    }else if(code =9){
        topPlayersBydribbling(req,res)
    }else if(code =10){
        topPlayersBycurve(req,res)
    }else if(code =11){
        topPlayersByfree_kick_accuracy(req,res)
    }else if(code =12){
        topPlayersBylong_passing(req,res)
    }else if(code =13){
        topPlayersByball_control(req,res)
    }else if(code =14){
        topPlayersByacceleration(req,res)
    }else if(code =15){
        topPlayersBysprint_speed(req,res)
    }else if(code =16){
        topPlayersByagility(req,res)
    }else if(code =17){
        topPlayersByreactions(req,res)
    }else if(code =6){
        
    }else if(code =6){
        
    }else if(code =6){
        
    }else if(code =6){
        
    }else if(code =6){
        
    }else if(code =6){
        
    }else if(code =6){
        
    }else if(code =6){
        
    }else if(code =6){
        
    }