//
//  ActivityGuageChart.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import SwiftUI
import Highcharts

struct ActivityGaugeChart: UIViewRepresentable {
    let precipitation: Double
    let humidity: Double
    let cloudCover: Double
    
    func makeUIView(context: Context) -> HIChartView {
        let chartView = HIChartView(frame: .zero)
        chartView.plugins = ["solid-gauge"]
        
        let options = HIOptions()
        
        // Chart configuration
        let chart = HIChart()
        chart.type = "solidgauge"
        chart.height = "110%"
        options.chart = chart
        
        // Configure tooltip
        let tooltip = HITooltip()
        tooltip.enabled = true
        tooltip.valueSuffix = "%"
        options.tooltip = tooltip
        
        // Configure pane
        let pane = HIPane()
        pane.startAngle = NSNumber(value: 0)
        pane.endAngle = NSNumber(value: 360)
        
        // Configure backgrounds
        let background1 = HIBackground()
        background1.backgroundColor = HIColor(rgba: 135, green: 206, blue: 235, alpha: 0.35)
        background1.outerRadius = "112%"
        background1.innerRadius = "88%"
        
        let background2 = HIBackground()
        background2.backgroundColor = HIColor(rgba: 255, green: 182, blue: 193, alpha: 0.35)
        background2.outerRadius = "87%"
        background2.innerRadius = "63%"
        
        let background3 = HIBackground()
        background3.backgroundColor = HIColor(rgba: 144, green: 238, blue: 144, alpha: 0.35)
        background3.outerRadius = "62%"
        background3.innerRadius = "38%"
        
        pane.background = [background1, background2, background3]
        options.pane = pane
        
        // Configure Y axis
        let yAxis = HIYAxis()
        yAxis.min = NSNumber(value: 0)
        yAxis.max = NSNumber(value: 100)
        yAxis.lineWidth = NSNumber(value: 0)
        yAxis.tickPositions = []
        options.yAxis = [yAxis]
        
        // Configure plot options
        let plotOptions = HIPlotOptions()
        plotOptions.solidgauge = HISolidgauge()
        plotOptions.solidgauge.dataLabels = [HIDataLabels()]
        plotOptions.solidgauge.dataLabels[0].enabled = false
        plotOptions.solidgauge.linecap = "round"
        plotOptions.solidgauge.rounded = true
        options.plotOptions = plotOptions
        
        // Create series for each metric
        let precipitationSeries = HISolidgauge()
        precipitationSeries.name = "Precipitation"
        let precipitationData = HIData()
        precipitationData.color = HIColor(rgba: 135, green: 206, blue: 235, alpha: 1)
        precipitationData.radius = "112%"
        precipitationData.innerRadius = "88%"
        precipitationData.y = NSNumber(value: precipitation)
        precipitationSeries.data = [precipitationData]
        
        let humiditySeries = HISolidgauge()
        humiditySeries.name = "Humidity"
        let humidityData = HIData()
        humidityData.color = HIColor(rgba: 255, green: 182, blue: 193, alpha: 1)
        humidityData.radius = "87%"
        humidityData.innerRadius = "63%"
        humidityData.y = NSNumber(value: humidity)
        humiditySeries.data = [humidityData]
        
        let cloudCoverSeries = HISolidgauge()
        cloudCoverSeries.name = "Cloud Cover"
        let cloudCoverData = HIData()
        cloudCoverData.color = HIColor(rgba: 144, green: 238, blue: 144, alpha: 1)
        cloudCoverData.radius = "62%"
        cloudCoverData.innerRadius = "38%"
        cloudCoverData.y = NSNumber(value: cloudCover)
        cloudCoverSeries.data = [cloudCoverData]
        
        options.series = [precipitationSeries, humiditySeries, cloudCoverSeries]
        
        chartView.options = options
        
        return chartView
    }
    
    func updateUIView(_ uiView: HIChartView, context: Context) {
        // Updates will be handled through the initial setup
    }
}
