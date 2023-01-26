//
//  ViewController.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import UIKit

class MachineViewController: UIViewController {
    
    @IBOutlet weak var machineImg: UIImageView!
    
    let coffeeService = CoffeeService()
    var coffees: CoffeeServiceDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGesture(to: machineImg)
        getAvailibleCoffees()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MachineToStyles" {
            if let destination = segue.destination as? CoffeeStylesViewController {
                destination.coffees = coffees!
            }
        }
    }
    
    //MARK: - Funcs
    private func addTapGesture(to view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(machineTapped))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func machineTapped() {
        if coffees != nil {
            performSegue(withIdentifier: "MachineToStyles", sender: nil)
        }
    }
    
    private func getAvailibleCoffees() {
        coffeeService.getAvailibleItems() { [weak self] response in
            if response.error == false {
                if let coffeeReponse = response.result as? CoffeeServiceDataModel {
                    self?.coffees = coffeeReponse
                }
            } else {
                switch response.errorType {
                case .parseJson:
                    print("Couldn't ")
                case .connectToServer:
                    print("Couldn't connect to server, Check your Internet.")
                case .nilResponse:
                    print("No coffes availible at the moment. Try Again later.")
                case .none:
                    print("-")
                }
            }
        }
    }
}

