//
//  CheckoutViewController.swift
//  Assignment3
//
//  Created by Alex Morneau on 2/17/21.
//

import UIKit

class CheckoutViewController: UITableViewController {
    
    // var coffeeListFromMainView : [Coffee] = []
    var coffeeListFromMainView : [Order] = [Order]()
    private let orderController = OrderController.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchAllOrders()
        
        self.setUpLongPressGesture()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //=========================================================
    // TABLE MANAGER FUNCTIONS
    
    private func fetchAllOrders() {
        if (self.orderController.getAllOrders() != nil) {
            self.coffeeListFromMainView = self.orderController.getAllOrders()!
            self.tableView.reloadData()
        }
        else {
            print(#function, "fetchAllOrders returned no data")
        }
    }
    
    private func deleteOrderFromList(indexPath: IndexPath) {
        self.orderController.deleteOrder(orderId: self.coffeeListFromMainView[indexPath.row].id!)
        self.fetchAllOrders()
    }
    
    
    private func updateOrderInList(indexPath: IndexPath, type: String, size: String, num: String) {
        self.coffeeListFromMainView[indexPath.row].coffee_type = type
        self.coffeeListFromMainView[indexPath.row].coffee_size = size
        self.coffeeListFromMainView[indexPath.row].coffee_num = num
        
        self.orderController.updateOrder(editedOrder: self.coffeeListFromMainView[indexPath.row])
        self.fetchAllOrders()
    }
    
    
    //==========================================================
    // USER INTERACTION
    
    private func displayCustomAlert(indexPath: IndexPath?, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.text = self.coffeeListFromMainView[indexPath!.row].coffee_type
            textField.keyboardType = .default
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.text = self.coffeeListFromMainView[indexPath!.row].coffee_size
            textField.keyboardType = .default
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.text = self.coffeeListFromMainView[indexPath!.row].coffee_num
            textField.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction((UIAlertAction(title: "Submit", style: .default, handler: {_ in
            if let typeText = alert.textFields?[0].text,
               let sizeText = alert.textFields?[1].text,
               let numText = alert.textFields?[2].text {
                    self.updateOrderInList(indexPath: indexPath!, type: typeText, size: sizeText, num: numText)
            }
        })))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // reference notes
    
    @objc
    private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state == .ended) {
            let touchPoint = gestureRecognizer.location(in: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: touchPoint) {
                self.displayCustomAlert(indexPath: indexPath, title: "Edit Order", message: "Please make adjustments as needed.")
            }
        }
    }
    
    private func setUpLongPressGesture() {
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 1.0
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteOrderFromList(indexPath: indexPath)
    }

    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.coffeeListFromMainView.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "idcell", for: indexPath) as! CheckoutCell

        // Configure the cell...
        if (indexPath.row < coffeeListFromMainView.count) {
            let order = coffeeListFromMainView[indexPath.row]
            cell.label_type.text = coffeeListFromMainView[indexPath.row].coffee_type
            cell.label_size.text = coffeeListFromMainView[indexPath.row].coffee_size
            cell.label_num.text = coffeeListFromMainView[indexPath.row].coffee_num
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
