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
        let bus = busList[indexPath.row] as! Bus
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.lbBusNumber.text =  "\(indexPath.row + 1)"
        var orderNumberInt : Int?
        if bus.id != nil {
            orderNumberInt = Int(bus.id!)
        } else {
            orderNumberInt = nil
        }
        cell.lbBusTrip.text = "\(bus.route!.detail!)"
        
        
//        cell.lbBusTrip = 
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tripVC = TripViewController(nibName: "TripViewController", bundle: nil)
        let routeSelected = Route.MR_findFirstByAttribute("id", withValue: indexPath.row) as! Route
        tripVC.points = routeSelected.points
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
        self.busList = Bus.MR_findAll()
        if(self.busList.count == 0){
            self.initEntity()
            self.busList = Bus.MR_findAll()
        }
        self.tableView.reloadData()
    }
    
    func initEntity(){
        
        let bus = Bus.MR_createEntity() as! Bus
        
        bus.id = 0
        bus.number = 1
        
        
        let route = Route.MR_createEntity() as! Route
        route.id = 0
        route.detail = "Lộ trình xe 01"
        route.bus = bus
        bus.route = route
//        route.points
        
        
        let point1 = Point.MR_createEntity() as! Point
        point1.id = 0
        point1.lat = 21.0471598
        point1.long = 105.8769165
        point1.name = "BX Gia Lâm"
        point1.addRouteObject(route)
        
        
        let point2 = Point.MR_createEntity() as! Point
        point2.id = 0
        point2.lat = 20.9502109
        point2.long = 105.7450316
        point2.name = "BX Yên Nghĩa"
        point2.addRouteObject(route)
        
        route.addPointObject(point1)
        route.addPointObject(point2)
        
        
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
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
