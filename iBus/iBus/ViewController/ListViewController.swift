//
//  ListViewController.swift
//  iBus
//
//  Created by Thinh Nguyen on 4/8/16.
//  Copyright © 2016 Thinh Nguyen. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var busList:[Int] = []
    override func viewWillAppear(animated: Bool) {
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(busList.count == 0){
            for index in 0...15 {
                busList.insert(index+1, atIndex: index)
            }
        }
        self.tableView.registerNib(UINib(nibName: "BusCell", bundle: nil), forCellReuseIdentifier: "BusCell")
        
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
        cell.lbBusNumber.text =  "\(busList[indexPath.row])"
        
//        cell.lbBusTrip = 
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tripVC = TripViewController(nibName: "TripViewController", bundle: nil)
        self.navigationController?.pushViewController(tripVC, animated: true)
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