var width = 500;
var height = 500;

if (hist === "None"){
    var data = [10, 15, 20, 25, 30]
    console.log(hist)
} else {
    var data = [];
    for (i in hist["0"]){
        data.push(parseInt(i))
    }
    console.log(hist)
};

var colors = ['#ffffcc','#c2e699','#78c679','#31a354','#006837'];

var svg = d3.select("#chart")
    .append("svg")
    .attr("width", width)
    .attr("height", height);

var g = svg.selectAll("g")
    .data(data)
    .enter()
    .append("g")
    .attr("transform", function(d, i) {
        return "translate(0,0)";
    })

g.append("circle")
    .attr("cx", function(d, i) {
        return 50;
    })
    .attr("cy", function(d, i) {
        return i * 100 + 50;
    })
    .attr("r", 20)
    .attr("fill", function(d, i) {
        return colors[i];
    })
    .attr("id", function(d, i) {
        return i;
    })


svg
    .on("click", function() {
        if (hist === "None") {
            for (t=1; t < 4; t++){
                var cir = d3.selectAll("circle")
                cir.transition()
                    .ease(d3.easeLinear)
                    .duration(2000)
                    .attr("cx", 100 * t)
            }
        } else {
            for (s in hist) {
                var t = setTimeout(Animate(s), 100*(parseInt(s) + 1));
            };
        }
    });

function Animate(cycle){
    d3.selectAll("circle").each(function(d, i) {
        d3.select(this).transition()
            .delay(2000)
            .ease(d3.easeLinear)
            .duration(2000)
            .attr("cx", 50 + 50 * hist[cycle][i])
    })
}


//g.append("text")
//    .attr("x", function(d, i) {
//        return 100;
//    })
//    .attr("y", function(d, i) {
//        return i * 105 + 40
//    })
//    .attr("stroke", "teal")
//    .attr("font-size", "12px")
//    .attr("font-family", "sans-serif")
//    .text(function(d) {
//        return d;
//    });

