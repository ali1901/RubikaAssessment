//
//  CoffeeService.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import Foundation

class CoffeeService {
    private static let baseUrlString = "https://mocki.io/v1/683f421b-0687-43a0-9552-b007ffa73920"
    private static let orderUrl = ""
    private let diskCareTaker = DiskCareTaker()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
        
    public func getAvailibleItems(compelition: @escaping (_ response: Response)->Void) {
        if let coffeeItems = loadSavedCoffees() {
            compelition(Response(result: coffeeItems, error: false, errorType: nil))
        } else {
            guard let url = URL(string: CoffeeService.baseUrlString) else {return}
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { [weak self] (data, response, error) in
                if let jsonData = data {
                    do {
                        let parsedResponse = try JSONDecoder().decode(CoffeeServiceDataModel.self, from: jsonData)
                        self?.saveCoffeeServiceResponse(response: parsedResponse)
                        compelition(Response(result: parsedResponse, error: false, errorType: nil))
                    } catch {
                        compelition(Response(result: nil, error: true, errorType: .parseJson))
                    }
                } else if let error = error {
                    compelition(Response(result: nil, error: true, errorType: .connectToServer))
                    print("Error fetching data from server: \(error)")
                } else if data == nil {
                    compelition(Response(result: nil, error: true, errorType: .nilResponse))
                }
            }
            task.resume()
        }
    }
    
    public func orderCoffee(order: CoffeeOrder, compelition: @escaping (_ response: Response)->Void) {
        //TODO: to be implemented with real url and service method.
        guard let url = URL(string: CoffeeService.orderUrl) else {return}
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do {
                    let parsedResponse = try JSONDecoder().decode(CoffeeServiceDataModel.self, from: jsonData)
                    compelition(Response(result: parsedResponse, error: false, errorType: nil))
                } catch {
                    compelition(Response(result: nil, error: true, errorType: .parseJson))
                }
            } else if let error = error {
                compelition(Response(result: nil, error: true, errorType: .connectToServer))
                print("Error fetching data from server: \(error)")
            } else if data == nil {
                compelition(Response(result: nil, error: true, errorType: .nilResponse))
            }
        }
        task.resume()
    }
    
    private func saveCoffeeServiceResponse(response: CoffeeServiceDataModel) {
        do {
            try diskCareTaker.save(theObject: response, withName: "AvailibleCoffees")
        } catch let er {
            print("Couldn't save the data: \(er)")
        }
    }
    
    private func loadSavedCoffees() -> CoffeeServiceDataModel? {
        var loadedCoffees: CoffeeServiceDataModel?
        do {
            loadedCoffees = try diskCareTaker.load(toObject: CoffeeServiceDataModel.self, withName: "AvailibleCoffees")
        } catch let er {
            print("Couldn't load the data: \(er)")
        }
        return loadedCoffees
    }
}
