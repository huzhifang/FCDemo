//
//  ViewController.swift
//  FCDemo
//
//  Created by Charlie Hu on 29/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var flightList = FlightList()
    private lazy var loadingIcon = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBg
        
        // Header
        let trips = UILabel()
        trips.translatesAutoresizingMaskIntoConstraints = false
        trips.text = "Trips"
        trips.font = .fcText(ofSize: 18)
        trips.textColor = .headerText
        trips.textAlignment = .center
        view.addSubview(trips)
        
        let flightsView = UIView()
        flightsView.translatesAutoresizingMaskIntoConstraints = false
        flightsView.backgroundColor = .contentBg
        view.addSubview(flightsView)
        
        flightList.translatesAutoresizingMaskIntoConstraints = false
        flightsView.addSubview(flightList)
        
        loadingIcon.translatesAutoresizingMaskIntoConstraints = false
        flightsView.addSubview(loadingIcon)
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(leftEdgeSwiped(_:)))
        edgeGesture.edges = [.left]
        view.addGestureRecognizer(edgeGesture)
        
        NSLayoutConstraint.activate([
            trips.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            trips.heightAnchor.constraint(equalToConstant: 40),
            trips.leftAnchor.constraint(equalTo: view.leftAnchor),
            trips.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            flightsView.topAnchor.constraint(equalTo: trips.bottomAnchor),
            flightsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            flightsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            flightsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            flightList.topAnchor.constraint(equalTo: flightsView.topAnchor),
            flightList.bottomAnchor.constraint(equalTo: flightsView.safeAreaLayoutGuide.bottomAnchor),
            flightList.leftAnchor.constraint(equalTo: flightsView.leftAnchor),
            flightList.rightAnchor.constraint(equalTo: flightsView.rightAnchor),
            
            loadingIcon.centerXAnchor.constraint(equalTo: flightsView.centerXAnchor),
            loadingIcon.centerYAnchor.constraint(equalTo: flightsView.centerYAnchor),
            loadingIcon.widthAnchor.constraint(equalToConstant: 40),
            loadingIcon.heightAnchor.constraint(equalTo: loadingIcon.widthAnchor),
        ])
        
        if let flightsURL = URL(string: "https://bit.ly/2MBaibj") {
            loadingIcon.startAnimating()
            
            URLSession.shared.dataTask(with: flightsURL) { [weak self] data, response, error in
                if error == nil, let data = data {
                    do {
                        let flights = try JSONDecoder().decode([Flight].self, from: data)
                        DispatchQueue.main.async {
                            self?.refreshFlightList(with: flights)
                        }
                    } catch {
                        print("Error loading flights: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func refreshFlightList(with flights: [Flight]) {
        flightList.refresh(with: flights)
        loadingIcon.stopAnimating()
        loadingIcon.isHidden = true
    }
    
    @objc private func leftEdgeSwiped(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            flightList.leftEdgeSwiped()
        }
    }
}

