//
//  ViewController.swift
//  Assignment3
//
//  Created by Alex Morneau on 2/15/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var coffee_type: UIPickerView!
    @IBOutlet var coffee_size: UISegmentedControl!
    @IBOutlet var coffee_num: UITextField!
    
    let coffee_list = [
        "Dark Roast",
        "Light Roast",
        "Blonde",
        "Vanilla",
        "Original",
        "Decaffeinated"]
    
    var newCoffee = Coffee()            // instance
    // var coffeeOrderList : [Coffee] = [] // list of objects
    var coffeeOrderList : [Order] = [Order]()
    private let orderController = OrderController.getInstance()
    
    
    //====================================================================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coffee_type.dataSource = self
        self.coffee_type.delegate = self
        
        let checkoutBtn = UIBarButtonItem(title: "Checkout", style: .plain, target: self, action: #selector(goToCheckout))
        self.navigationItem.setRightBarButton(checkoutBtn, animated: true)
    }
    
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init()
    }
    
    // ADD TO ORDER BUTTON - Validate and create Coffee object:
    @IBAction func addToOrder() {
        if (!self.coffee_num.text!.isEmpty) {
            let tempNum = self.coffee_num.text!
            let tempSize = self.coffee_size.titleForSegment(at:
                                    self.coffee_size.selectedSegmentIndex)!
            let tempType = self.coffee_list[self.coffee_type.selectedRow(inComponent: 0)]
            
            let newCoffeeOrder = Coffee(type: tempType, size: tempSize, num: tempNum)
            self.orderController.insertOrder(newOrder: newCoffeeOrder)

            // Add object to array:
            // print(#function, "Coffee Object added:")
            // print(#function, "Num: \(newCoffee.coffee_num), Size: \(newCoffee.coffee_size), Type: \(newCoffee.coffee_type)")
            // coffeeOrderList.append(newCoffee)
            
        } else {
            self.errorAlert(message: "Number of coffees must be specified.")
        }
    }
    
    
    // Reusable custom error alert
    func errorAlert(message : String) {
        let error_alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        error_alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(error_alert, animated: true, completion: nil)
    }
    
    
    // Navigation function, brings us to Checkout (table) view
    @objc func goToCheckout() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let checkoutView = storyboard.instantiateViewController(identifier: "CheckoutPage") as! CheckoutViewController

        //checkoutView.coffeeListFromMainView = self.coffeeOrderList
        navigationController?.pushViewController(checkoutView, animated: true)
    }


}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coffee_list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coffee_list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function, "Coffee Selected: \(self.coffee_list[row])")
    }
}
