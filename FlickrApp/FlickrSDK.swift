//
//  FlickrSDK.swift
//  FlickrApp
//
//  Created by Michael Modvig on 30/11/2016.
//  Copyright © 2016 Michael Modvig. All rights reserved.
//

import Foundation

class FlickrSDK {
    
    static let sharedInstance : FlickrSDK = FlickrSDK()
    
    var appID : String?
    var appSecret : String?
    
    func getPublicImages(responseHandler: @escaping (NSError?, [[String: Any]]?) -> Void) {
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")!
        
        //dataTask -> Serialize JSON
        let t = URLSession.shared.dataTask(with: url){(data,response,error) in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print(jsonData)
                
                let items = jsonData["items"] as! [[String: Any]]
                responseHandler(nil,items)
            }
            catch {
                print(error)
                responseHandler(error as NSError?,nil)
                
            }
        }
        
        t.resume()
        
    }
}

