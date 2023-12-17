import * as d3 from 'd3';
import c3 from "c3";

document.addEventListener('DOMContentLoaded', function() {
  if (document.getElementById('chart')) {
    c3.generate({
      bindto: '#chart',
      data: chartData,
      axis: {
        x: {
            type: 'timeseries',
            tick: {format: '%Y-%m-%d'}
        }
      }
    });
  } else {
    console.error("Element #chart not found");
  }
});
