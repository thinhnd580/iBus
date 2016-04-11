//
//  TripViewController.swift
//  iBus
//
//  Created by Thinh Nguyen on 4/8/16.
//  Copyright © 2016 Thinh Nguyen. All rights reserved.
//

import UIKit
import Foundation;
import GoogleMaps
import Alamofire

class TripViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnReverse: UIButton!
    @IBOutlet weak var mapView: UIView!
    
    var addressList:[String] = ["so 1","so2","so3"]
    var addressListReverse:[String] = []
    var googlemap:(GMSMapView) = GMSMapView()
    
    override func viewWillAppear(animated: Bool) {
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "DirectionCell", bundle: nil), forCellReuseIdentifier: "DirectionCell")
        
        
        
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
                                                          longitude: 151.20, zoom: 12)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        self.googlemap = GMSMapView.mapWithFrame(CGRect.init(x: 0.0, y: 0.0, width:screenSize.width, height: screenSize.height/3), camera: camera)
//        let mapView = GMSMapView.mapWithFrame(self.mapView.frame, camera: camera)
        self.googlemap.myLocationEnabled = true
        self.mapView.addSubview(self.googlemap)
//        self.mapView = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.googlemap
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnChangeDirectionClicked(sender: AnyObject) {
        
        let startLat = 21.0235698
        let startLong = 105.7858399
        let endLat = 21.0471598
        let endLong = 105.8769112
        let url = "https://maps.googleapis.com/maps/api/directions/json"
        
        let urlString = "\(url)?origin=\(startLat),\(startLong)&destination=\(endLat),\(endLong)&sensor=true&key=AIzaSyDXTt4b08jKB6Wbvyup_pPtt97GWPfTBGs"

        Alamofire.request(.GET, urlString)
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                
                
                
                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(response.data! , options: []) as! [String:AnyObject]
                        
                        print(json["routes"])
                        let route = json["routes"] as? NSDictionary
//                        let path = GMSPath(fromEncodedPath: route[0]["overview_polyline"]["points"])
//                        let singleLine = GMSPolyline(polylineWithPath:path)
                        
                        // use anyObj here
                    } catch let error {
                        print("json error: \(error)")
                    }
                    
                    
                }
        }
       
//        NSURL *directionsURL = [NSURL URLWithString:urlString];
//        
//        
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:directionsURL];
//        [request startSynchronous];
//        NSError *error = [request error];
//        if (!error) {
//            NSString *response = [request responseString];
//            NSLog(@"%@",response);
//            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:&error];
//            GMSPath *path =[GMSPath pathFromEncodedPath:json[@"routes"][0][@"overview_polyline"][@"points"]];
//            GMSPolyline *singleLine = [GMSPolyline polylineWithPath:path];
//            singleLine.strokeWidth = 7;
//            singleLine.strokeColor = [UIColor greenColor];
//            singleLine.map = self.mapView;
//        }
//        else NSLog(@"%@",[request error]);
        
        
        
        
        
        self.addressListReverse = self.addressList.reverse()
        self.btnReverse.selected = !self.btnReverse.selected
        self.tableView.reloadData()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("DirectionCell", forIndexPath: indexPath) as! DirectionCell
        if self.btnReverse.selected {
            cell.lbAddress.text = self.addressListReverse[indexPath.row]
        }
        else{
            cell.lbAddress.text = self.addressList[indexPath.row]
        }
        
        
        return cell
        
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
