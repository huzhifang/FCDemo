//
//  FCDemoTests.swift
//  FCDemoTests
//
//  Created by Charlie Hu on 29/11/21.
//

import XCTest
@testable import FCDemo

class FCDemoTests: XCTestCase {
    
    private let flightString = """
    {
        "id": 1,
        "departure_date": "2019-11-15T06:05:00.000",
        "airline_code": "AA",
        "flight_number": "6036",
        "departure_city": "Portland, United States",
        "departure_airport": "PDX",
        "arrival_city": "Los Angeles, United States",
        "arrival_airport": "LAX",
        "scheduled_duration": "2hr39min",
        "arrival_date": "2019-11-15T08:44:00.000"
    }
    """
    
    private let flight = Flight(id: 1,
                                airlineCode: "AA",
                                flightNumber: "6036",
                                departureDateString: "2019-11-15T06:05:00.000",
                                departureCityLong: "Portland, United States",
                                departureAirport: "PDX",
                                arrivalDateString: "2019-11-15T08:44:00.000",
                                arrivalCityLong: "Los Angeles, United States",
                                arrivalAirport: "LAX",
                                scheduledDurationString: "2hr39min")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlightDecoding() throws {
        let data = flightString.data(using: .utf8)!
        let newFlight = try? JSONDecoder().decode(Flight.self, from: data)
        XCTAssertEqual(newFlight, flight)
    }
    
    func testScheduledHours() throws {
        let hours = flight.scheduledHours
        XCTAssertEqual(hours, 2)
    }
    
    func testScheduledMinutes() throws {
        let minutes = flight.scheduledMinutes
        XCTAssertEqual(minutes, 39)
    }
}
