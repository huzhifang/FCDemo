//
//  FlightCard.swift
//  FCDemo
//
//  Flight card view in a list
//
//  Created by Charlie Hu on 30/11/21.
//

import Foundation
import UIKit

class FlightCard: UIView {
    let flight: Flight
    private let onTap: ((Flight) -> Void)
    
    init(flight: Flight, frame: CGRect = .zero, onTap: @escaping ((Flight) -> Void)) {
        self.flight = flight
        self.onTap = onTap
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .flightBg
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Flight to " + flight.arrivalCity
        headerLabel.textColor = .flightCity
        headerLabel.font = .fcText(ofSize: 16, weight: .semibold)
        addSubview(headerLabel)
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        addSubview(separator)
        
        // Departure
        
        let departureAirport = UILabel()
        departureAirport.translatesAutoresizingMaskIntoConstraints = false
        departureAirport.text = flight.departureAirport.uppercased()
        departureAirport.textColor = .flightCity
        departureAirport.font = .fcText(ofSize: 14)
        addSubview(departureAirport)
        
        let departureTime = UILabel()
        departureTime.translatesAutoresizingMaskIntoConstraints = false
        departureTime.text = flight.departureDate.time24
        departureTime.textColor = .flightTime
        departureTime.font = .fcText(ofSize: 20, weight: .semibold)
        addSubview(departureTime)
        
        let departureCity = UILabel()
        departureCity.translatesAutoresizingMaskIntoConstraints = false
        departureCity.text = flight.departureCity
        departureCity.textColor = .flightCity
        departureCity.font = .fcText(ofSize: 13)
        addSubview(departureCity)
        
        // Arrival
        
        let arrivalAirport = UILabel()
        arrivalAirport.translatesAutoresizingMaskIntoConstraints = false
        arrivalAirport.text = flight.arrivalAirport.uppercased()
        arrivalAirport.textColor = .flightCity
        arrivalAirport.font = .fcText(ofSize: 14)
        addSubview(arrivalAirport)
        
        let arrivalTime = UILabel()
        arrivalTime.translatesAutoresizingMaskIntoConstraints = false
        arrivalTime.text = flight.arrivalDate.time24
        arrivalTime.textColor = .flightTime
        arrivalTime.font = .fcText(ofSize: 20, weight: .semibold)
        addSubview(arrivalTime)
        
        let arrivalCity = UILabel()
        arrivalCity.translatesAutoresizingMaskIntoConstraints = false
        arrivalCity.text = flight.arrivalCity
        arrivalCity.textColor = .flightCity
        arrivalCity.font = .fcText(ofSize: 13)
        addSubview(arrivalCity)
        
        // Duration
        
        let duration = UILabel()
        duration.translatesAutoresizingMaskIntoConstraints = false
        duration.text = "\(flight.scheduledHours) hr \(flight.scheduledMinutes) min"
        duration.textColor = .flightDuration
        duration.font = .fcText(ofSize: 12)
        addSubview(duration)
        
        let nonStop = UILabel()
        nonStop.translatesAutoresizingMaskIntoConstraints = false
        nonStop.text = "Non-Stop"
        nonStop.textColor = .flightDuration
        nonStop.font = .fcText(ofSize: 12)
        addSubview(nonStop)
        
        let planePath = PlanePath(color: .flightTime)
        planePath.translatesAutoresizingMaskIntoConstraints = false
        addSubview(planePath)
        
        NSLayoutConstraint.activate([
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            separator.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            separator.leftAnchor.constraint(equalTo: leftAnchor),
            separator.rightAnchor.constraint(equalTo: rightAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            departureAirport.leftAnchor.constraint(equalTo: headerLabel.leftAnchor),
            departureAirport.bottomAnchor.constraint(equalTo: planePath.centerYAnchor, constant: -5),
            
            departureTime.leftAnchor.constraint(equalTo: departureAirport.leftAnchor),
            departureTime.topAnchor.constraint(equalTo: planePath.centerYAnchor),
            
            departureCity.leftAnchor.constraint(equalTo: departureAirport.leftAnchor),
            departureCity.topAnchor.constraint(equalTo: departureTime.bottomAnchor, constant: 5),
            
            arrivalAirport.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            arrivalAirport.bottomAnchor.constraint(equalTo: departureAirport.bottomAnchor),
            
            arrivalTime.rightAnchor.constraint(equalTo: arrivalAirport.rightAnchor),
            arrivalTime.topAnchor.constraint(equalTo: departureTime.topAnchor),
            
            arrivalCity.rightAnchor.constraint(equalTo: arrivalAirport.rightAnchor),
            arrivalCity.topAnchor.constraint(equalTo: departureCity.topAnchor),
            
            planePath.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            planePath.centerXAnchor.constraint(equalTo: centerXAnchor),
            planePath.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            
            duration.centerXAnchor.constraint(equalTo: planePath.centerXAnchor),
            duration.bottomAnchor.constraint(equalTo: planePath.topAnchor, constant: -5),
            
            nonStop.centerXAnchor.constraint(equalTo: planePath.centerXAnchor),
            nonStop.topAnchor.constraint(equalTo: planePath.bottomAnchor, constant: 5)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            onTap(flight)
        }
    }
}

class PlanePath: UIView {
    let dotRadius: CGFloat = 5
    let planeSize = CGSize(width: 20, height: 20)
    let color: UIColor
    
    init(color: UIColor, frame: CGRect = .zero) {
        self.color = color
        super.init(frame: frame)
        
        self.backgroundColor = .flightBg
        
        let planeImage = UIImage(systemName: "airplane")?.withTintColor(color, renderingMode: .alwaysOriginal)
        let plane = UIImageView(image: planeImage)
        plane.translatesAutoresizingMaskIntoConstraints = false
        addSubview(plane)
        
        NSLayoutConstraint.activate([
            plane.widthAnchor.constraint(equalToConstant: planeSize.width),
            plane.heightAnchor.constraint(equalToConstant: planeSize.height),
            plane.centerXAnchor.constraint(equalTo: centerXAnchor),
            plane.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            plane.topAnchor.constraint(equalTo: topAnchor),
            plane.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard !rect.isEmpty else { return }
        
        let leftDot = UIBezierPath(ovalIn: CGRect(x: 0,
                                                  y: rect.size.height/2 - dotRadius,
                                                  width: dotRadius*2,
                                                  height: dotRadius*2))
        color.setFill()
        leftDot.fill()
        
        let rightDot = UIBezierPath(ovalIn: CGRect(x: rect.size.width - dotRadius*2,
                                                   y: rect.size.height/2 - dotRadius,
                                                   width: dotRadius*2,
                                                   height: dotRadius*2))
        rightDot.fill()
        
        let dashPattern: [CGFloat] = [3, 3]
        
        let leftDashedLine = UIBezierPath()
        leftDashedLine.move(to: CGPoint(x: dotRadius*2, y: rect.size.height/2))
        leftDashedLine.addLine(to: CGPoint(x: rect.size.width/2 - planeSize.width/2, y: rect.size.height/2))
        leftDashedLine.lineWidth = 1
        leftDashedLine.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        color.setStroke()
        leftDashedLine.stroke()
        
        let rightDashedLine = UIBezierPath()
        rightDashedLine.move(to: CGPoint(x: rect.size.width - dotRadius*2, y: rect.size.height/2))
        rightDashedLine.addLine(to: CGPoint(x: rect.size.width/2 + planeSize.width/2, y: rect.size.height/2))
        rightDashedLine.lineWidth = 1
        rightDashedLine.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        color.setStroke()
        rightDashedLine.stroke()
    }
}
