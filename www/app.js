var inputs = document.getElementsByClassName("form-group shiny-input-container");
var death_slide_input = inputs[inputs.length - 3];
var birth_slide_input = inputs[inputs.length - 1];

death_slide_input.style.display = "none";
birth_slide_input.style.display = "none";

document.getElementById("ran_death").onchange = function(){
  if (document.getElementById("ran_death").checked === true){
    death_slide_input.style.display = "block";
  }else{
    death_slide_input.style.display = "none";
  }
};

document.getElementById("ran_birth").onchange = function(){
  if (document.getElementById("ran_birth").checked === true){
    birth_slide_input.style.display = "block";
  }else{
    birth_slide_input.style.display = "none";
  }
}

