//
//  ViewController.swift
//  MapTaskTradeo
//
//  Created by Angel Kukushev on 1/8/16.
//  Copyright © 2016 Angel Kukushev. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var compareHour = String()
    
    var compareDay = String()
    
    var compareMonth = String()
    
    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.title = "Earthquake Map"
    
        let latitude:CLLocationDegrees = 43.095181
        
        let longitude:CLLocationDegrees = -79.006424
        
        let latDelta:CLLocationDegrees = 30
        
        let lonDelta:CLLocationDegrees = 30
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: false)

    
        getData()
        
    }

    func getData() {
     
        let url = NSURL(string: "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    //print(jsonResult["features"])
                    var count = 1
                    
                    
                    if let level = jsonResult["features"] as? [AnyObject]{
                        for levels in level{
                            
                            let magnitude = levels["properties"]!!["mag"]! as! Float
                            
                            if magnitude > 1 {
                                
                                
                                // Working with time
                                
                                let time = NSDate(timeIntervalSince1970: levels["properties"]!!["time"]! as! NSTimeInterval / 1000)
                                
                                let dateFormatter = NSDateFormatter()
                                
                                dateFormatter.dateFormat = "YYYY-MM-DD hh:mm:ss"
                                
                                let dateString = dateFormatter.stringFromDate(time)
                                
                                dateFormatter.dateFormat = "DD"
                                
                                let day = dateFormatter.stringFromDate(time)
                                
                                dateFormatter.dateFormat = "MM"
                                
                                let month = dateFormatter.stringFromDate(time)
                                
                                dateFormatter.dateFormat = "hh"
                                
                                let hour = dateFormatter.stringFromDate(time)
                                
                                // Time Checking
                                
                                
                                if day != self.compareDay{
                                    continue;
                                }
                                if month != self.compareMonth{
                                    continue;
                                }
                                if hour != self.compareHour{
                                    continue;
                                }
                                
                                //
                                
                                
                                
                                print("Earthquake \(count)")
                                
                                let title: String = levels["properties"]!!["title"]! as! String
                                
                                print("Title:", title)
                            
                                print("Time:", dateString)
                                
                                print("Magnitude:", levels["properties"]!!["mag"]! as! Float)
                                
                                print("Coordinates:", levels["geometry"]!!["coordinates"]! as! [AnyObject])
                                let coord: String = "\(levels["geometry"]!!["coordinates"]! as! [AnyObject])"
                                
                                
                                let parts = String(coord.characters.dropFirst()) .componentsSeparatedByString(",")
                            
                                //dealing with string conversions
                                
                                let stringLat = String(parts[1].characters.dropFirst())
                                
                                let stringLong = parts[0]
                                
                                let tempLatitude = CLLocationDegrees(stringLat);
                                
                                let tempLongitude = CLLocationDegrees(stringLong);
                                
                                //end string conversions
                                
                                //Adding the pin
                                
                                let newCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(tempLatitude!, tempLongitude!)
                                
                                let annotation = MKPointAnnotation()
                                
                                annotation.coordinate = newCoordinate
                                
                                annotation.title = String(title.characters.dropFirst(8))
                                
                                annotation.subtitle = "Mag: \(magnitude), Time: \(dateString)"
                                
                                self.map.addAnnotation(annotation)
                                
                                print("\n")
                                
                                count++
                                
                            }
                        }
                        
                        
                    }
                    
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
         task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
}



//leftovers



// print("Time:", levels["properties"]!!["time"]! as! NSInteger)
/* let epocTime = NSTimeInterval(1429162809359) / 1000

let myDate = NSDate(timeIntervalSince1970:  epocTime)

print("Converted Time \(myDate)")


//  print((levels.objectForKey("properties"))!.objectForKey("time"))
//print(levels.objectForKey("properties"))

*/
