//
//  DetailViewController.swift
//  PinterestLayout
//
//  Created by jin peng on 12/25/15.
//  Copyright (c) 2015 jin peng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    var currImage: UIImage?
    var textHeading: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Detail view controller")
        myLabel.text = textHeading
        myImageView.image = currImage
        
        saveImgButton()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    func saveImgButton() {
        
        //        var doneButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker")
        
        var doneButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Bordered, target: self, action: "onSave:")
        
        self.navigationItem.rightBarButtonItem=doneButton;
        
    }
    
    
    @IBAction func onSave(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(myImageView.image!, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>) {
        dispatch_async(dispatch_get_main_queue(), {
            UIAlertView(title: "Success", message: "This image has been saved to your Camera Roll successfully", delegate: nil, cancelButtonTitle: "Close").show()
        })
    }

}
