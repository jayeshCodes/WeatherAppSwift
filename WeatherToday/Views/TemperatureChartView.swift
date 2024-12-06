//
//  TemperatureChartView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI
import Highcharts

struct TemperatureChartView: UIViewRepresentable {
    let forecast: TemperatureForecastResponse
    
    func makeUIView(context: Context) -> HIChartView {
        let chartView = HIChartView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        chartView.plugins = ["series-label"]
        
        let options = HIOptions()
        
        // Chart configuration
        let chart = HIChart()
        chart.type = "line"
        chart.backgroundColor = HIColor(name: "rgb(255, 255, 255)")  // White background
        options.chart = chart
        
        // Title
        let title = HITitle()
        title.text = "Temperature Variation by Day"
        options.title = title
        
        // X Axis
        let xAxis = HIXAxis()
        xAxis.categories = forecast.timelines.map { formatDate($0.time) }
        xAxis.gridLineWidth = 0  // Remove vertical grid lines
        xAxis.lineWidth = 0      // Remove x-axis line
        xAxis.tickWidth = 0      // Remove tick marks
        options.xAxis = [xAxis]
        
        // Y Axis
        let yAxis = HIYAxis()
        yAxis.title = HITitle()
        yAxis.title.text = "Temperatures"
        yAxis.gridLineWidth = 0  // Remove horizontal grid lines
        yAxis.lineWidth = 0      // Remove y-axis line
        options.yAxis = [yAxis]
        
        // Plot Options
        let plotOptions = HIPlotOptions()
        plotOptions.series = HISeries()
        plotOptions.series.marker = HIMarker()
        plotOptions.series.marker.lineWidth = 1
        plotOptions.series.marker.radius = 4
        options.plotOptions = plotOptions
        
        // Max Temperature Series
        let maxTemp = HILine()
        maxTemp.name = "Max Temperature"
        maxTemp.data = forecast.timelines.map { $0.values.temperatureMax }
        maxTemp.lineWidth = 2
        maxTemp.color = HIColor(name: "rgb(135, 206, 235)")  // Light blue
        
        // Min Temperature Series
        let minTemp = HILine()
        minTemp.name = "Min Temperature"
        minTemp.data = forecast.timelines.map { $0.values.temperatureMin }
        minTemp.lineWidth = 2
        minTemp.color = HIColor(name: "rgb(64, 64, 64)")  // Dark gray
        
        options.series = [maxTemp, minTemp]
        
        // Legend
        let legend = HILegend()
        legend.align = "center"
        legend.verticalAlign = "bottom"
        legend.layout = "horizontal"
        legend.borderWidth = 0
        options.legend = legend
        
        // Tooltip
        let tooltip = HITooltip()
        tooltip.shared = true
        options.tooltip = tooltip
        
        chartView.options = options
        
        return chartView
    }
    
    func updateUIView(_ uiView: HIChartView, context: Context) {
        // Not needed for this implementation
    }
}

struct StyledTemperatureChartView: View {
    let forecast: TemperatureForecastResponse
    
    var body: some View {
        TemperatureChartView(forecast: forecast)
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color.white)  // White background for the container
            .cornerRadius(12)
            .padding()
    }
}
