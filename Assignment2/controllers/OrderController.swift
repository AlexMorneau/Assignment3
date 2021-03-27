//
//  OrderController.swift
//  Assignment2
//
//  Created by Alex Morneau on 3/20/21.
//  Edited on 3/21/21

import Foundation
import CoreData
import UIKit

class OrderController {
    
    //===========================================================
    // INSTANCE MANAGER - (Single Instance)
    
    private static var shared : OrderController?
    
    static func getInstance() -> OrderController {
        if (shared != nil) {
            return shared!
        }
        else {
            return OrderController(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
    }
    
    
    //===========================================================
    // CONTEXT INITIALIZER
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "Order"
    
    private init(context: NSManagedObjectContext) {
        self.moc = context
    }
    
    
    //===========================================================
    // DATABASE OPERATIONS
    
    func getAllOrders() -> [Order]? {
        let fetchRequest = NSFetchRequest<Order>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "order_date", ascending: true)]
        
        do {
            let res = try self.moc.fetch(fetchRequest)
            print(#function, "fetched data: \(res as [Order])") // comment out
            return res as [Order]
        }
        catch let error as NSError {
            print(#function, "Data could not be fetched: \(error)")
        }
        return nil
    }
    
    
    func insertOrder(newOrder: Coffee) {
        do {
            let orderAdded = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! Order
            
            orderAdded.id = UUID()
            orderAdded.coffee_type = newOrder.coffee_type
            orderAdded.coffee_size = newOrder.coffee_size
            orderAdded.coffee_num = newOrder.coffee_num
            orderAdded.order_date = Date()
            
            if (self.moc.hasChanges) {
                try self.moc.save()
                print(#function, "Data saved successfully")
            }
            else {
                print(#function, "Save unsuccessful")
            }
        }
        catch let error as NSError {
            print(#function, "Object could not be added: \(error)")
        }
    }
    
    
    func searchOrder(orderId: UUID) -> Order? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateId = NSPredicate(format: "id == %@", orderId as CVarArg)
        fetchRequest.predicate = predicateId
        
        do {
            let result = try self.moc.fetch(fetchRequest)
            if (result.count > 0) {
                return result.first as? Order
            }
        }
        catch let error as NSError {
            print(#function, "Order not found: \(error)")
        }
        return nil
    }
    
    
    
    func updateOrder(editedOrder: Order) {
        let searchResult = self.searchOrder(orderId: editedOrder.id! as UUID)
        
        if (searchResult != nil) {
            do {
                let ord = searchResult!
                ord.coffee_type = editedOrder.coffee_type
                ord.coffee_size = editedOrder.coffee_size
                ord.coffee_num = editedOrder.coffee_num
                
                try self.moc.save()
                print(#function, "Order update successful")
            }
            catch let error as NSError {
                print(#function, "Order not found: \(error)")
            }
        }
    }
    
    
    
    func deleteOrder(orderId: UUID) {
        let searchResult = self.searchOrder(orderId: orderId)
        
        if (searchResult != nil) {
            do {
                self.moc.delete(searchResult!)
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.saveContext()
                print(#function, "Order deleted")
            }
            catch let error as NSError {
                print(#function, "Order was not deleted: \(error)")
            }
        }
    }
}
