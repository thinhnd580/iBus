//
//  ListViewController.swift
//  iBus
//
//  Created by Thinh Nguyen on 4/8/16.
//  Copyright © 2016 Thinh Nguyen. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import MagicalRecord

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var busList:[AnyObject] = []
    override func viewWillAppear(animated: Bool) {
        self.edgesForExtendedLayout = UIRectEdge.None
        let btnCity = UIBarButtonItem(title: "HN", style: UIBarButtonItemStyle.Plain, target: self, action:#selector(self.btnCityClicked(_:)));
//        btnCity.title = "HCM"
        self.navigationItem.leftBarButtonItem = btnCity
//        self.preloadData()
        self.loadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "BusCell", bundle: nil), forCellReuseIdentifier: "BusCell")
        self.loadData()
        // Do any additional setup after loading the view.
        
        
        
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = self.tableView.dequeueReusableCellWithIdentifier("BusCell", forIndexPath: indexPath) as! BusCell
        let bus = busList[indexPath.row] as! Route
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.lbBusNumber.text =  "\(bus.busNumber!)"
        cell.lbBusTrip.text = "\(bus.routeTrip!)"
        
        
//        cell.lbBusTrip = 
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tripVC = TripViewController(nibName: "TripViewController", bundle: nil)
        let routeSelected = self.busList[indexPath.row] as! Route
        tripVC.pointList = routeSelected.getGoPointArray()
        self.navigationController?.pushViewController(tripVC, animated: true)
    }
    
    func btnCityClicked(sender:UIButton){
        let list = ["HN","HP","DN","HCM"]
        
        
        ActionSheetStringPicker.showPickerWithTitle("City", rows: list, initialSelection: 1, doneBlock: {
            picker, value, index in
            
            print("value = \(value)")
            
            self.navigationItem.leftBarButtonItem?.title = "\(index)"
            
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
        

    }
    
    func loadData(){
        self.busList = Route.MR_findAll()
//        if(self.busList.count == 0){
//            self.initEntity()
            self.preloadData()
            self.busList = Route.MR_findAll()
//        }
        self.tableView.reloadData()
    }
    
    func initEntity(){
        
        
        
        
        let route = Route.MR_createEntity() as! Route
        
        route.busNumber = "01"
        route.tripDetail = "Lộ trình xe 01"
        route.routeTrip = "BX Gia Lâm - BX Yên Nghĩa"
        
        
        let point1 = Point.MR_createEntity() as! Point
        point1.lat = 21.0471598
        point1.long = 105.8769165
        point1.name = "BX Gia Lâm"
        point1.addRouteObject(route)
        
        let point2 = Point.MR_createEntity() as! Point
        point2.lat = 20.9502109
        point2.long = 105.7450316
        point2.name = "Điểm giữa"
        point2.addRouteObject(route)
        
        let point3 = Point.MR_createEntity() as! Point
        point3.lat = 20.9502109
        point3.long = 105.7450316
        point3.name = "BX Yên Nghĩa"
        point3.addRouteObject(route)
        
        route.addGoPointObject(point1)
        route.addGoPointObject(point2)
        route.addGoPointObject(point3)
        
        
        
        
        
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    
    func parseTxtToPoint (contentsOfURL: NSURL, encoding: NSStringEncoding, error: NSErrorPointer) -> [(lat:String, long:String, name: String)]? {
    // Load the CSV file and parse it
        var items:[(lat:String, long:String, name: String)]?
    
        let content = String(contentsOfURL: contentsOfURL, encoding: encoding, error: error)
        items = []
        let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
    
        for line in lines {
            if line != "" {
                // For a line with double quotes
                // we use NSScanner to perform the parsing
            
                let values =  line.componentsSeparatedByString(",")
//                var range = values[0].rangeOfString("\"")
                
                let item = (lat: values[0], long: values[1], name: values[2])
                items?.append(item)
            }
        }
    
        return items
    }
    
    func parseTxtToRoute (path: String, encoding: NSStringEncoding, error: NSErrorPointer) -> [(busNumber:String, routeTrip:String, tripDetail: String)]? {
        // Load the CSV file and parse it
        
        
        var items:[(busNumber:String, routeTrip:String, tripDetail: String)]?
        items = []
        
        do {
            let mytext = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            print(mytext)   // "some text\n"
            let lines:[String] = mytext.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
            
            for line in lines {
                if line != "" {
                    // For a line with double quotes
                    // we use NSScanner to perform the parsing
                    
                    let values =  line.componentsSeparatedByString(",")
                    //                var range = values[0].rangeOfString("\"")
                    
                    let item = (busNumber: values[0], routeTrip: values[1], tripDetail: values[2])
                    items?.append(item)
                }
            }

            
        } catch let error as NSError {
            print("error loading from url \(path)")
            print(error.localizedDescription)
        }
//        print("this is content $$$$$$$$$$$$$$$ \(content)")
        
        return items
    }
    
    func preloadData () {
    // Retrieve data from the source file
        if let contentsOfURL = NSBundle.mainBundle().pathForResource("routes", ofType: "txt") {
            
            // Remove all the menu items before preloading
            removeData()
            
            var error:NSError?
            if let items = parseTxtToRoute(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error) {
                // Preload the menu items
                
                for item in items{
                    let route = Route.MR_createEntity() as! Route
                    route.busNumber = item.busNumber
                    route.routeTrip = item.routeTrip
                    route.tripDetail = item.tripDetail
                    NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                }
                
            }
        }

    }
    
    func removeData () {
        // Remove the existing items
        let routes = Route.MR_findAll()
        for route in routes {
            route as! Route
            route.MR_deleteEntity()
        }
    }
    @IBAction func btnSearchClicked(sender: AnyObject) {
        self.preloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
