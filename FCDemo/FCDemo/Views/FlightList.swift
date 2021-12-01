//
//  FlightList.swift
//  FCDemo
//
//  Flight list view
//
//  Created by Charlie Hu on 1/12/21.
//

import Foundation
import UIKit

class FlightList: UIScrollView {
    var flights: [Flight] = []
    var ticketView: TicketView?
    
    func refresh(with newFlights: [Flight]) {
        for subview in subviews {
            if let flightCard = subview as? FlightCard {
                flightCard.removeFromSuperview()
            }
        }
        
        guard let flightsView = self.superview, newFlights.count > 0 else {
            return
        }
        
        flights = newFlights.sorted(by: { $0.departureDate < $1.departureDate })
        
        var constraints: [NSLayoutConstraint] = []
        var cardAbove: FlightCard?
        var lastDayString = ""
        
        for (i, flight) in flights.enumerated() {
            let flightCard = FlightCard(flight: flight) { [weak self] aFlight in
                self?.showDetails(of: aFlight)
            }
            flightCard.translatesAutoresizingMaskIntoConstraints = false
            addSubview(flightCard)
            
            let currentDayString = flight.departureDate.dayLong
            if currentDayString != lastDayString {
                // Add a day group label
                let dayLabel = UILabel()
                dayLabel.translatesAutoresizingMaskIntoConstraints = false
                dayLabel.text = currentDayString.uppercased()
                dayLabel.textColor = .dayGroup
                dayLabel.font = .fcText(ofSize: 15)
                addSubview(dayLabel)
                
                constraints.append(dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15))
                constraints.append(flightCard.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 10))
                if i == 0 {
                    constraints.append(dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20))
                } else if let above = cardAbove {
                    constraints.append(dayLabel.topAnchor.constraint(equalTo: above.bottomAnchor, constant: 30))
                }
            } else if let above = cardAbove {
                constraints.append(flightCard.topAnchor.constraint(equalTo: above.bottomAnchor, constant: 15))
            }
            
            if i == flights.count - 1 {
                constraints.append(flightCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5))
            }
            
            constraints.append(contentsOf: [
                flightCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                flightCard.widthAnchor.constraint(equalTo: flightsView.widthAnchor, constant: -30),
                flightCard.heightAnchor.constraint(equalToConstant: 150)
            ])
            
            cardAbove = flightCard
            lastDayString = currentDayString
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func leftEdgeSwiped() {
        ticketView?.removeFromSuperview()
        ticketView = nil
        self.isHidden = false
    }
    
    private func showDetails(of flight: Flight) {
        if let flightsView = superview {
            self.isHidden = true
            
            ticketView = TicketView(flight: flight)
            ticketView!.translatesAutoresizingMaskIntoConstraints = false
            flightsView.addSubview(ticketView!)
            
            NSLayoutConstraint.activate([
                ticketView!.topAnchor.constraint(equalTo: flightsView.topAnchor, constant: 20),
                ticketView!.bottomAnchor.constraint(equalTo: flightsView.bottomAnchor, constant: -150),
                ticketView!.leftAnchor.constraint(equalTo: flightsView.leftAnchor, constant: 15),
                ticketView!.rightAnchor.constraint(equalTo: flightsView.rightAnchor, constant: -15),
            ])
        }
    }
}
