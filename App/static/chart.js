var width = 500;
var height = 320;

if (hist === "None"){
    var data = [10, 15, 20, 25, 30]
    console.log(hist)
} else {
    var data = [5, 10, 15, 20, 25]
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
        return i*100 + 50;
    })
    .attr("cy", function(d, i) {
        return 100;
    })
    .attr("r", function(d) {
        return d*1.5;
    })
    .attr("fill", function(d, i) {
        return colors[i];
    })
    .on("mouseover", function() {
        var cir = d3.select(this)
        cir.transition()
            .ease(d3.easeLinear)
            .duration(2000)
            .attr("cy", 200)
    });


g.append("text")
    .attr("x", function(d, i) {
        return i * 100 + 40;
    })
    .attr("y", 105)
    .attr("stroke", "teal")
    .attr("font-size", "12px")
    .attr("font-family", "sans-serif")
    .text(function(d) {
        return d;
    });

