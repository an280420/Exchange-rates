import * as d3 from 'd3';
import c3 from "c3";

document.addEventListener('DOMContentLoaded', function() {
  const chartData = {
    columns: [
      ['data1', 30, 200, 100, 400, 150, 250],
      ['data2', 50, 20, 10, 40, 15, 25]
    ]
  };

  if (document.getElementById('chart')) {
    c3.generate({
      bindto: '#chart',
      data: chartData
    });
  } else {
    console.error("Element #chart not found");
  }
});
