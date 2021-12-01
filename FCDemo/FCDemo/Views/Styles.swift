//
//  Styles.swift
//  FCDemo
//
//  Created by Charlie Hu on 30/11/21.
//

import Foundation
import UIKit

// TODO: Add dark mode colors

extension UIColor {
    static var viewBg: UIColor {
        return UIColor(red: 0.83, green: 0.01, blue: 0.10, alpha: 1)
    }
    
    static var shadow: UIColor {
        return .lightGray
    }
    
    // Header
    
    static var headerText: UIColor {
        return .white
    }
    
    // Content
    
    static var contentBg: UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
    }
    
    static var dayGroup: UIColor {
        return UIColor(red: 0.71, green: 0.71, blue: 0.71, alpha: 1)
    }
    
    // Flight Card
    
    static var flightBg: UIColor {
        return .white
    }
    
    static var flightCity: UIColor {
        return .gray
    }
    
    static var flightDuration: UIColor {
        return .dayGroup
    }
    
    static var flightTime: UIColor {
        return UIColor(red: 0, green: 0.29, blue: 0.72, alpha: 1)
    }
    
    static var separator: UIColor {
        return UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
    }
    
    // Ticket
    
    static var ticketBg: UIColor {
        return .white
    }
    
    static var ticketHeaderBg: UIColor {
        return .flightTime
    }
    
    static var ticketHeaderText: UIColor {
        return .white
    }
    
    static var ticketHeaderCity: UIColor {
        return UIColor(red: 0.66, green: 0.75, blue: 0.89, alpha: 1)
    }
    
    static var ticketLabel: UIColor {
        return .black
    }
    
    static var ticketValue: UIColor {
        return .flightTime
    }
    
    static var ticketDashedLine: UIColor {
        return UIColor(red: 0.86, green: 0.87, blue: 0.88, alpha: 1)
    }
    
}

extension UIFont {
    static func fcText(ofSize size: CGFloat, weight: Weight = .regular) -> UIFont {
        return .systemFont(ofSize: size, weight: weight)
    }
}
