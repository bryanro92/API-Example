//
//  ViewController.swift
//  API-Example
//
//  Created by Ross Bryan on 9/26/16.
//  Copyright © 2016 Ross Bryan Designs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var objects = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        grabVids()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func grab2Vids(){
        //searches for channels using search term
        let url = NSURL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=30&q=YOUR+SEARCH+HERE&type=channel&key=YOURAPIKEYHERE")
        
        
        
        //
        /*
        let url = NSURL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=30&q=michigan+football&type=video&key=MyApiKey")
        */
    }
    
    
    
    func grabVids(){
        //api request
        let url = NSURL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=30&q=michigan+football&type=video&key=AIzaSyCRONSh1St96OARUlZSJiWfi6EAhaFEPZw")
        //prepare for data download, and catch any errors
        let session = NSURLSession.sharedSession()
        let task = session.downloadTaskWithURL(url!) {
            (loc:NSURL?, response:NSURLResponse?, error:NSError?) in
            if error != nil {
                print(error)
                return
            }
            //results are stored in variable 'd'
            let d = NSData(contentsOfURL: loc!)!
            print("got data")
            //prints results
            let datastring = NSString(data: d, encoding: NSUTF8StringEncoding)
            print(datastring)
            
            //now lets store this data!
            let parsedObject: AnyObject?
            do {
                parsedObject = try NSJSONSerialization.JSONObjectWithData(d,
                    options: NSJSONReadingOptions.AllowFragments)
            } catch let error as NSError {
                print(error)
                return
            } catch {
                fatalError()
            }
            
            if let topLevelObj = parsedObject as? Dictionary<String,AnyObject> {
                //"items" is a dict reference in the JSON object
                //referencing dict headers is how you extract the data you
                //are looking for from the results
                if let items = topLevelObj["items"] as? Array<Dictionary<String,AnyObject>> {
                    for i in items {
                        self.objects.append(i)
                    }
                    //used for refreshing data in a table
                    //not currently implemented on this app
                    //self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    
    
}























