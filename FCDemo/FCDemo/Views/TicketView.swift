//
//  TicketView.swift
//  FCDemo
//
//  Flight ticket details view
//
//  Created by Charlie Hu on 30/11/21.
//

import Foundation
import UIKit

class TicketView: UIView {
    let flight: Flight
    
    private lazy var header = UIView()
    private var shapeLayer: CAShapeLayer?
    private var shadowLayer: CAShapeLayer?
    private var dashedLayer: CAShapeLayer?
    
    init(flight: Flight, frame: CGRect = .zero) {
        self.flight = flight
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .ticketHeaderBg
        addSubview(header)
        
        // Departure
        
        let departureAirport = UILabel()
        departureAirport.translatesAutoresizingMaskIntoConstraints = false
        departureAirport.text = flight.departureAirport.uppercased()
        departureAirport.font = .fcText(ofSize: 40, weight: .bold)
        departureAirport.textColor = .ticketHeaderText
        header.addSubview(departureAirport)
        
        let departureCity = UILabel()
        departureCity.translatesAutoresizingMaskIntoConstraints = false
        departureCity.text = flight.departureCity
        departureCity.font = .fcText(ofSize: 14)
        departureCity.textColor = .ticketHeaderCity
        header.addSubview(departureCity)
        
        let departureDate = UILabel()
        departureDate.translatesAutoresizingMaskIntoConstraints = false
        departureDate.text = flight.departureDate.day
        departureDate.font = .fcText(ofSize: 16)
        departureDate.textColor = .ticketHeaderText
        header.addSubview(departureDate)
        
        let departureTime = UILabel()
        departureTime.translatesAutoresizingMaskIntoConstraints = false
        departureTime.text = flight.departureDate.time12
        departureTime.font = .fcText(ofSize: 16)
        departureTime.textColor = .ticketHeaderText
        header.addSubview(departureTime)
        
        // Arrival
        
        let arrivalAirport = UILabel()
        arrivalAirport.translatesAutoresizingMaskIntoConstraints = false
        arrivalAirport.text = flight.arrivalAirport.uppercased()
        arrivalAirport.font = .fcText(ofSize: 40, weight: .bold)
        arrivalAirport.textColor = .ticketHeaderText
        header.addSubview(arrivalAirport)
        
        let arrivalCity = UILabel()
        arrivalCity.translatesAutoresizingMaskIntoConstraints = false
        arrivalCity.text = flight.arrivalCity
        arrivalCity.font = .fcText(ofSize: 14)
        arrivalCity.textColor = .ticketHeaderCity
        header.addSubview(arrivalCity)
        
        let arrivalDate = UILabel()
        arrivalDate.translatesAutoresizingMaskIntoConstraints = false
        arrivalDate.text = flight.arrivalDate.day
        arrivalDate.font = .fcText(ofSize: 16)
        arrivalDate.textColor = .ticketHeaderText
        header.addSubview(arrivalDate)
        
        let arrivalTime = UILabel()
        arrivalTime.translatesAutoresizingMaskIntoConstraints = false
        arrivalTime.text = flight.arrivalDate.time12
        arrivalTime.font = .fcText(ofSize: 16)
        arrivalTime.textColor = .ticketHeaderText
        header.addSubview(arrivalTime)
        
        let planeImage = UIImage(systemName: "airplane")?.withTintColor(.ticketHeaderText,
                                                                        renderingMode: .alwaysOriginal)
        let plane = UIImageView(image: planeImage)
        plane.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(plane)
        
        // Details
        
        let detailsView = UIView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailsView)
        
        let flightNumber = UILabel()
        flightNumber.translatesAutoresizingMaskIntoConstraints = false
        flightNumber.attributedText = attributedFlightText(label: "Flight :  ", value: flight.fullFlightNumber)
        detailsView.addSubview(flightNumber)
        
        let gate = UILabel()
        gate.translatesAutoresizingMaskIntoConstraints = false
        gate.attributedText = attributedFlightText(label: "Gate :  ", value: "- -")
        detailsView.addSubview(gate)
        
        let terminal = UILabel()
        terminal.translatesAutoresizingMaskIntoConstraints = false
        terminal.attributedText = attributedFlightText(label: "Terminal :  ", value: "D")
        detailsView.addSubview(terminal)
        
        let seat = UILabel()
        seat.translatesAutoresizingMaskIntoConstraints = false
        seat.attributedText = attributedFlightText(label: "Seat :  ", value: "- -")
        detailsView.addSubview(seat)
        
        // QR code
        
        let qrcodeArea = UIView()
        qrcodeArea.translatesAutoresizingMaskIntoConstraints = false
        addSubview(qrcodeArea)
        
        let qrcode = UIImageView(image: UIImage(systemName: "qrcode"))
        qrcode.translatesAutoresizingMaskIntoConstraints = false
        qrcodeArea.addSubview(qrcode)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.38),
            header.leftAnchor.constraint(equalTo: leftAnchor),
            header.rightAnchor.constraint(equalTo: rightAnchor),
            
            departureAirport.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 30),
            departureAirport.bottomAnchor.constraint(equalTo: departureCity.topAnchor, constant: -5),
            
            departureCity.leftAnchor.constraint(equalTo: departureAirport.leftAnchor),
            departureCity.bottomAnchor.constraint(equalTo: header.centerYAnchor),
            
            departureDate.leftAnchor.constraint(equalTo: departureAirport.leftAnchor),
            departureDate.topAnchor.constraint(equalTo: header.centerYAnchor, constant: 15),
            
            departureTime.leftAnchor.constraint(equalTo: departureAirport.leftAnchor),
            departureTime.topAnchor.constraint(equalTo: departureDate.bottomAnchor, constant: 5),
            
            plane.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            plane.centerYAnchor.constraint(equalTo: departureAirport.centerYAnchor),
            plane.widthAnchor.constraint(equalToConstant: 30),
            plane.heightAnchor.constraint(equalToConstant: 30),
            
            arrivalAirport.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -30),
            arrivalAirport.centerYAnchor.constraint(equalTo: departureAirport.centerYAnchor),
            
            arrivalCity.rightAnchor.constraint(equalTo: arrivalAirport.rightAnchor),
            arrivalCity.centerYAnchor.constraint(equalTo: departureCity.centerYAnchor),
            
            arrivalDate.rightAnchor.constraint(equalTo: arrivalAirport.rightAnchor),
            arrivalDate.centerYAnchor.constraint(equalTo: departureDate.centerYAnchor),
            
            arrivalTime.rightAnchor.constraint(equalTo: arrivalAirport.rightAnchor),
            arrivalTime.centerYAnchor.constraint(equalTo: departureTime.centerYAnchor),
            
            detailsView.topAnchor.constraint(equalTo: header.bottomAnchor),
            detailsView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.24),
            detailsView.leftAnchor.constraint(equalTo: leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: rightAnchor),
            
            flightNumber.leftAnchor.constraint(equalTo: departureAirport.leftAnchor),
            flightNumber.bottomAnchor.constraint(equalTo: detailsView.centerYAnchor, constant: -15),
            
            gate.rightAnchor.constraint(equalTo: arrivalAirport.rightAnchor),
            gate.centerYAnchor.constraint(equalTo: flightNumber.centerYAnchor),
            
            terminal.leftAnchor.constraint(equalTo: flightNumber.leftAnchor),
            terminal.topAnchor.constraint(equalTo: detailsView.centerYAnchor, constant: 15),
            
            seat.rightAnchor.constraint(equalTo: gate.rightAnchor),
            seat.centerYAnchor.constraint(equalTo: terminal.centerYAnchor),
            
            qrcodeArea.topAnchor.constraint(equalTo: detailsView.bottomAnchor),
            qrcodeArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            qrcodeArea.leftAnchor.constraint(equalTo: leftAnchor),
            qrcodeArea.rightAnchor.constraint(equalTo: rightAnchor),
            
            qrcode.heightAnchor.constraint(equalTo: qrcodeArea.heightAnchor, multiplier: 0.5),
            qrcode.widthAnchor.constraint(equalTo: qrcode.heightAnchor),
            qrcode.centerXAnchor.constraint(equalTo: qrcodeArea.centerXAnchor),
            qrcode.centerYAnchor.constraint(equalTo: qrcodeArea.centerYAnchor)
        ])
    }
    
    private func attributedFlightText(label: String, value: String) -> NSAttributedString {
        let text = NSMutableAttributedString(string: label,
                                             attributes: [.foregroundColor: UIColor.ticketLabel,
                                                          .font: UIFont.fcText(ofSize: 16, weight: .semibold)])
        text.append(NSAttributedString(string: value,
                                       attributes: [.foregroundColor: UIColor.ticketValue,
                                                    .font: UIFont.fcText(ofSize: 16, weight: .semibold)]))
        return text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let headerCornerLayer = CAShapeLayer()
        headerCornerLayer.frame = header.bounds
        headerCornerLayer.path = UIBezierPath(roundedRect: header.layer.bounds,
                                              byRoundingCorners: [.topLeft, .topRight],
                                              cornerRadii: CGSize(width: 5, height: 5)).cgPath
        header.layer.mask = headerCornerLayer
        
        // Create the path for the border and shadow
        let size = layer.bounds.size
        let cornerRadius: CGFloat = 5
        let arcY = layer.bounds.height * 0.6 // The origin Y of the two arcs
        let arcRadius: CGFloat = 20
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        path.addLine(to: CGPoint(x: 0, y: arcY))
        path.addArc(withCenter: CGPoint(x: 0, y: arcY + arcRadius),
                    radius: arcRadius,
                    startAngle: CGFloat.pi * 1.5,
                    endAngle: CGFloat.pi * 0.5,
                    clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: size.height - cornerRadius))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: size.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: CGFloat.pi,
                    endAngle: CGFloat.pi * 0.5,
                    clockwise: false)
        path.addLine(to: CGPoint(x: size.width - cornerRadius, y: size.height))
        path.addArc(withCenter: CGPoint(x: size.width - cornerRadius, y: size.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: CGFloat.pi * 0.5,
                    endAngle: 0,
                    clockwise: false)
        path.addLine(to: CGPoint(x: size.width, y: arcY + arcRadius * 2))
        path.addArc(withCenter: CGPoint(x: size.width, y: arcY + arcRadius),
                    radius: arcRadius,
                    startAngle: CGFloat.pi * 0.5,
                    endAngle: CGFloat.pi * 1.5,
                    clockwise: true)
        path.addLine(to: CGPoint(x: size.width, y: cornerRadius))
        path.addArc(withCenter: CGPoint(x: size.width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 1.5,
                    clockwise: false)
        path.addLine(to: CGPoint(x: cornerRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: CGFloat.pi * 1.5,
                    endAngle: CGFloat.pi,
                    clockwise: false)
        path.close()
        
        shapeLayer?.removeFromSuperlayer()
        shapeLayer = CAShapeLayer()
        shapeLayer?.frame = layer.bounds
        shapeLayer?.path = path.cgPath
        shapeLayer?.fillColor = UIColor.ticketBg.cgColor
        
        shadowLayer?.removeFromSuperlayer()
        shadowLayer = CAShapeLayer()
        shadowLayer?.frame = layer.bounds
        shadowLayer?.path = path.cgPath
        shadowLayer?.shadowColor = UIColor.shadow.cgColor
        shadowLayer?.shadowOffset = CGSize(width: 0, height: 1)
        shadowLayer?.shadowOpacity = 1
        shadowLayer?.shadowRadius = 2
        shadowLayer?.shadowPath = path.cgPath
        
        // The dashed line
        dashedLayer?.removeFromSuperlayer()
        dashedLayer = CAShapeLayer()
        dashedLayer?.frame = CGRect(x: arcRadius + 5,
                                    y: arcY + arcRadius + 5,
                                    width: layer.bounds.width - (arcRadius + 5) * 2,
                                    height: 2)
        
        let dashedLine = UIBezierPath()
        dashedLine.move(to: CGPoint(x: 0, y: 1))
        dashedLine.addLine(to: CGPoint(x: dashedLayer!.frame.width, y: 1))
        dashedLayer?.path = dashedLine.cgPath
        dashedLayer?.strokeColor = UIColor.ticketDashedLine.cgColor
        dashedLayer?.lineDashPattern = [8, 8]
        dashedLayer?.lineWidth = 2
        
        layer.insertSublayer(shapeLayer!, at: 0)
        layer.insertSublayer(shadowLayer!, below: shapeLayer!)
        layer.insertSublayer(dashedLayer!, above: shapeLayer!)
    }
}
