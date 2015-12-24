//
//  ViewController.swift
//  AEXMLExample
//
//  Created by jin peng on 12/25/15.
//  Copyright (c) 2015 jin peng. All rights reserved.
//

import UIKit


class XmlParseViewController:NSObject, NSXMLParserDelegate
{
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var element = NSString()
    var tbdataone=UICollectionViewController()
    
    
    //XMLParser Methods
    
    func beginParsing(tbData:UICollectionViewController)
    {
        
        tbdataone=tbData
        
        posts = []
        
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=4cba999f343e0eb30035b1eaf37c6076&format=rest&extras=url_m"))!)!
        
        parser.delegate = self
        parser.parse()
        
        tbData.collectionView!.reloadData()
        
    }
    
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        
        element = elementName
        
        var elements = NSMutableDictionary()
        
        if (element == "photo"){
            
            elements.setObject( (attributeDict ["url_m"] as? NSString)!, forKey: "url_m")
            elements.setObject( (attributeDict ["title"] as? NSString)!, forKey: "title")
            elements.setObject( (attributeDict ["height_m"] as? NSString)!, forKey: "height_m")
            elements.setObject( (attributeDict ["width_m"] as? NSString)!, forKey: "width_m")
            
            
            
            var img = UIImage(named:"white1.jpg")//=nil

            var url =  attributeDict ["url_m"] as? NSString as! String
         
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            var keyid=posts.count
            dispatch_async(queue) {
                
                 var image = self.getImgFromUrl(url)
                 self.posts.objectAtIndex(keyid).setObject(image, forKey: "img")

//               dispatch_async(dispatch_get_main_queue()){
//                
//                }
                
            }
            
//            elements.setObject(img!, forKey: "img")
//            elements.setObject(nil , forKey: "img")
            
            posts.addObject(elements)
            
            print(elements)
            
         }
        
    }
    
    
    func getImgFromUrl(url:String, var img:UIImage  ){
        
        let data = NSData(contentsOfURL: NSURL(string: url)!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        img = UIImage(data: data!)!
        
        print("getImgFromUrl")
    }
    
    
    func getImgFromUrl(url:String  )->UIImage{
        
        //                    var url =  attributeDict ["url_m"] as? NSString as! String
        let data = NSData(contentsOfURL: NSURL(string: url)!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        var img = UIImage(data: data!)!
        
        print("getImgFromUrl  return")
        ////            elements.setObject(img!, forKey: "img")
        
        return img
    }

    
}
