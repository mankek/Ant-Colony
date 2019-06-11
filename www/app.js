var inputs = document.getElementsByClassName("form-group shiny-input-container");
var slide_input = inputs[inputs.length - 1];
slide_input.style.display = "none";
document.getElementById("ran_death").onchange = function(){
  if (document.getElementById("ran_death").checked === true){
    slide_input.style.display = "block";
  }else{
    slide_input.style.display = "none";
  }
};

