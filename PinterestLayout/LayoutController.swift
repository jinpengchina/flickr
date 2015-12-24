//
//  LayoutController.swift
//  PinterestLayout
//
//  Created by jin peng on 12/25/15.
//  Copyright (c) 2015 jin peng. All rights reserved.
//

import UIKit

let reuseIdentifier = "collCell"

class LayoutController: UICollectionViewController, UICollectionViewDelegateFlowLayout,NSXMLParserDelegate {
    
    @IBOutlet var tbData : UICollectionView?
    
    var xmlParse = XmlParseViewController()
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        xmlParse.beginParsing(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return xmlParse.posts.count

    }


    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        
        var newimg=xmlParse.posts.objectAtIndex((indexPath.row)).valueForKey("img")
        if((newimg) != nil){
         cell.pinImage.image =  xmlParse.posts.objectAtIndex((indexPath.row)).valueForKey("img") as! UIImage
        }
        
        return cell
        
    }
    

   
    func collectionView(collectionView: UICollectionView!,
       
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
    {
            
        
        
        var imgWStr=xmlParse.posts.objectAtIndex((indexPath?.row)!).valueForKey("width_m") as! NSString as String
        


        var imgHStr=xmlParse.posts.objectAtIndex((indexPath?.row)!).valueForKey("height_m") as! NSString as String
        
        
        var imgW: CGFloat=CGFloat((imgWStr as NSString).floatValue)
        
        
        var imgH: CGFloat=CGFloat((imgHStr as NSString).floatValue)

 

        var screenW: CGFloat=self.view.frame.width

        var screenH: CGFloat=self.view.frame.height
    
//        if(indexPath.row%5==0){
//            imgW=300.0;
//        }

        if(imgW<imgH){

            return CGSize(width: screenW/414*170/1.0, height:screenH/736*300/1.0)
            
        }
        else{
            
            return CGSize(width: screenW, height:  imgH/imgW*screenW)
            
        }
        
            
            

    }
    


    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
            return sectionInsets
            
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "detail"){
            
            let cell = sender as! CollectionViewCell
            let indexPath = collectionView?.indexPathForCell(cell)
            var vc = segue.destinationViewController as! DetailViewController
            
            vc.textHeading = xmlParse.posts.objectAtIndex((indexPath?.row)!).valueForKey("title") as! NSString as String
            
            
            
            vc.currImage =  xmlParse.posts.objectAtIndex((indexPath?.row)!).valueForKey("img") as! UIImage
            
        }
    }


    
    func imgAnimation()-> UIImageView{
        
        var imageView = UIImageView( image: UIImage(named:"a1"))
        imageView.frame=CGRectMake( 20, 20, 100,100 ); // set new position exactly
        
        var imgListArray :NSMutableArray = []
        
        for countValue in 1...4
        {
            
            var strImageName : String = "a\(countValue).png"
            var image  = UIImage(named:strImageName)
            imgListArray.addObject(image!)
        }
        
        imageView.animationImages = NSArray(array: imgListArray) as? [UIImage]// imgListArray.get as Array as? [String];
        imageView.animationDuration = 1.0
        imageView.startAnimating()
        
        return imageView
    }

}
