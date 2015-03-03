//
//  MasterViewController.swift
//  Receipts++
//
//  Created by Daniel Mathews on 2015-03-01.
//  Copyright (c) 2015 com.theplayapp. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate {

    var managedObjectContext: NSManagedObjectContext? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        loadDataHome()
        loadDataWork()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadDataHome() {
        
        let context = self.fetchedResultsController.managedObjectContext
        
        let receiptEntity = NSEntityDescription.entityForName("Receipts", inManagedObjectContext: context)!
        let newManagedObject1 = NSEntityDescription.insertNewObjectForEntityForName(receiptEntity.name!, inManagedObjectContext: context) as NSManagedObject
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject1.setValue(NSDecimalNumber(double: 10.99), forKey: "amount")
        newManagedObject1.setValue("Headphones", forKey: "desc")
        newManagedObject1.setValue(NSDate(), forKey: "timeStamp")
        
        let labelEntity = NSEntityDescription.entityForName("Labels", inManagedObjectContext: context)!
        let labelManagedObject1 = NSEntityDescription.insertNewObjectForEntityForName(labelEntity.name!, inManagedObjectContext: context) as NSManagedObject
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        labelManagedObject1.setValue("Home", forKey: "label")
        labelManagedObject1.setValue(NSDate(), forKey: "photoDate")
        
        newManagedObject1.setValue(NSSet(object: labelManagedObject1), forKey: "labels")
        
        // Save the context.
        var error: NSError? = nil
        if !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    func loadDataWork() {
        
        let context = self.fetchedResultsController.managedObjectContext
        
        let receiptEntity = NSEntityDescription.entityForName("Receipts", inManagedObjectContext: context)!
        let newManagedObject1 = NSEntityDescription.insertNewObjectForEntityForName(receiptEntity.name!, inManagedObjectContext: context) as NSManagedObject
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject1.setValue(NSDecimalNumber(double: 5.99), forKey: "amount")
        newManagedObject1.setValue("HootSuite Pro", forKey: "desc")
        newManagedObject1.setValue(NSDate(), forKey: "timeStamp")
        
        let labelEntity = NSEntityDescription.entityForName("Labels", inManagedObjectContext: context)!
        let labelManagedObject1 = NSEntityDescription.insertNewObjectForEntityForName(labelEntity.name!, inManagedObjectContext: context) as NSManagedObject
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        labelManagedObject1.setValue("Work", forKey: "label")
        labelManagedObject1.setValue(NSDate(), forKey: "photoDate")
        
        let labelManagedObject2 = NSEntityDescription.insertNewObjectForEntityForName(labelEntity.name!, inManagedObjectContext: context) as NSManagedObject
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        labelManagedObject2.setValue("Home", forKey: "label")
        labelManagedObject2.setValue(NSDate(), forKey: "photoDate")
        
        newManagedObject1.setValue(NSSet(objects: labelManagedObject1,labelManagedObject2), forKey: "labels")
        
        // Save the context.
        var error: NSError? = nil
        if !context.save(&error) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //println("Unresolved error \(error), \(error.userInfo)")
        abort()
        }
    }
    
    
    func insertNewObject(sender: AnyObject) {
        
        let actionSheet = UIActionSheet(title: "Choose Photo", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Photo Library")
        actionSheet.showInView(self.view)
        
        /*let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as NSManagedObject
             
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject.setValue(NSDate(), forKey: "timeStamp")
             
        // Save the context.
        var error: NSError? = nil
        if !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }*/
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        var imagePicker:UIImagePickerController? = UIImagePickerController()
        
        switch (buttonIndex){
        case 0:
            println("cancel")
        case 1:
            //Camera
            if UIImagePickerController.isSourceTypeAvailable(.Camera){
                imagePicker!.delegate = self
                imagePicker!.sourceType = .Camera
                presentViewController(imagePicker!, animated: true, completion: nil)
            }
        case 2:
            //PhotoLibrary
            imagePicker!.delegate = self
            imagePicker!.sourceType = .PhotoLibrary
            presentViewController(imagePicker!, animated: true, completion: nil)
        default:
            println("Default")
        }
    }

    // MARK: - ImagePicker
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //
        println("in imagePickerController")
    }
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
                (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject

        
        let receiptsDescSet = object.valueForKeyPath("Receipts.desc") as NSSet
        for receiptsDesc in receiptsDescSet {
            if let desc = receiptsDesc as? String {
                cell.textLabel!.text = desc
            }
        }
        
        let receiptsAmountSet = object.valueForKeyPath("Receipts.amount") as NSSet
        for receiptsAmount in receiptsAmountSet {
            if let amount = receiptsAmount as? NSDecimalNumber {
                cell.detailTextLabel!.text = amount.stringValue
            }
        }
        
        //println("receiptsList is \(receiptsList)")
        //cell.textLabel!.text = object.valueForKey("label") as String!
        //var amount = object.valueForKey("amount") as NSDecimalNumber!
        //cell.detailTextLabel!.text = amount.stringValue
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        //return [sectionInfo title];
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.name
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
                
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Labels", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: "label", cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
    	var error: NSError? = nil
    	if !_fetchedResultsController!.performFetch(&error) {
    	     // Replace this implementation with code to handle the error appropriately.
    	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //println("Unresolved error \(error), \(error.userInfo)")
    	     abort()
    	}
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

