//
//  Flight.swift
//  FCDemo
//
//  Created by Charlie Hu on 29/11/21.
//

import Foundation

struct Flight: Decodable, Equatable {
    var id: Int
    var airlineCode: String
    var flightNumber: String
    
    var fullFlightNumber: String {
        return airlineCode + flightNumber
    }
    
    var departureDateString: String
    var departureCityLong: String
    var departureAirport: String
    
    var departureDate: Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter.date(from: departureDateString)!
    }
    var departureCity: String {
        let components = departureCityLong.components(separatedBy: ",")
        return components.first ?? ""
    }
    
    var arrivalDateString: String
    var arrivalCityLong: String
    var arrivalAirport: String
    
    var arrivalDate: Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter.date(from: arrivalDateString)!
    }
    var arrivalCity: String {
        let components = arrivalCityLong.components(separatedBy: ",")
        return components.first ?? ""
    }
    
    var scheduledDurationString: String
    
    var scheduledHours: Int {
        let components = scheduledDurationString.components(separatedBy: .decimalDigits.inverted).filter{ !$0.isEmpty }
        return Int(components.first ?? "0") ?? 0
    }
    
    var scheduledMinutes: Int {
        let components = scheduledDurationString.components(separatedBy: .decimalDigits.inverted).filter{ !$0.isEmpty }
        return Int(components.last ?? "0") ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case airlineCode = "airline_code"
        case flightNumber = "flight_number"
        
        case departureDateString = "departure_date"
        case departureCityLong = "departure_city"
        case departureAirport = "departure_airport"
        
        case arrivalDateString = "arrival_date"
        case arrivalCityLong = "arrival_city"
        case arrivalAirport = "arrival_airport"
        
        case scheduledDurationString = "scheduled_duration"
    }
}

extension Date {
    var time24: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm"
        return formatter.string(from: self)
    }
    
    var time12: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh':'mm a"
        return formatter.string(from: self)
    }
    
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E',' dd MMM"
        return formatter.string(from: self)
    }
    
    var dayLong: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E',' dd MMMM"
        return formatter.string(from: self)
    }
}
