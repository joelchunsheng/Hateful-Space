//
//  ImportCrop.swift
//  HatefulSpace
//
//  Created by Yeo Chun Sheng Joel on 7/1/19.
//  Copyright © 2019 Yeo Chun Sheng Joel. All rights reserved.
//

import UIKit
import CropViewController

var globalAlienimg: UIImage?
var globalAlienimg2: UIImage?
var globalAlienimg3: UIImage?



class ImportCrop: UIViewController, CropViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgAlien1: UIImageView!
    @IBOutlet weak var imgAlien2: UIImageView!
    @IBOutlet weak var imgAlien3: UIImageView!
    
    var btn1 = false
    var btn2 = false
    var btn3 = false
    
    
    
    private var image: UIImage?
    private var croppingStyle = CropViewCroppingStyle.default
    
    private var croppedRect = CGRect.zero
    private var croppedAngle = 0
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        
        let cropController = CropViewController(croppingStyle: croppingStyle, image: image)
        cropController.delegate = self
        

        self.image = image
        
        //If profile picture, push onto the same navigation stack
        if croppingStyle == .circular {
            if picker.sourceType == .camera {
                picker.dismiss(animated: true, completion: {
                    self.present(cropController, animated: true, completion: nil)
                })
            } else {
                picker.pushViewController(cropController, animated: true)
            }
        }
        else { //otherwise dismiss, and then present from the main controller
            picker.dismiss(animated: true, completion: {
                self.present(cropController, animated: true, completion: nil)
                //self.navigationController!.pushViewController(cropController, animated: true)
            })
        }
    }
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.croppedRect = cropRect
        self.croppedAngle = angle
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.croppedRect = cropRect
        self.croppedAngle = angle
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        
        if btn1 == true{
            imgAlien1.image = image
            globalAlienimg = resizeImage(image: image, newWidthHeight: 120)
            btn1 = false
        }
        
        else if btn2 == true{
            imgAlien2.image = image
            globalAlienimg2 = resizeImage(image: image, newWidthHeight: 120)
            btn2 = false
        }
        else if btn3 == true{
            imgAlien3.image = image
            globalAlienimg3 = resizeImage(image: image, newWidthHeight: 120)
            btn3 = false
        }
        
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newWidthHeight: CGFloat) -> UIImage {

        UIGraphicsBeginImageContext(CGSize(width: newWidthHeight, height: newWidthHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidthHeight, height: newWidthHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc public func addButtonTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        
        let profileAction = UIAlertAction(title: "Add Alien", style: .default) { (action) in
            self.croppingStyle = .circular
            
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
            imagePicker.preferredContentSize = CGSize(width: 320, height: 568)
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        

        alertController.addAction(profileAction)
        alertController.modalPresentationStyle = .popover
        
        let presentationController = alertController.popoverPresentationController
        presentationController?.barButtonItem = (sender as! UIBarButtonItem)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnAddAlien1(_ sender: Any) {
        btn1 = true
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let profileAction = UIAlertAction(title: "Add Alien", style: .default) { (action) in
            self.croppingStyle = .circular
            
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .popover
//            imagePicker.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
            imagePicker.preferredContentSize = CGSize(width: 320, height: 568)
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
        alertController.addAction(profileAction)
        alertController.modalPresentationStyle = .popover
        
        let presentationController = alertController.popoverPresentationController
        presentationController?.barButtonItem = (sender as! UIBarButtonItem)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnAddAlien2(_ sender: Any) {
        btn2 = true
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let profileAction = UIAlertAction(title: "Add Alien", style: .default) { (action) in
            self.croppingStyle = .circular
            
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .popover
            //            imagePicker.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
            imagePicker.preferredContentSize = CGSize(width: 320, height: 568)
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
        alertController.addAction(profileAction)
        alertController.modalPresentationStyle = .popover
        
        let presentationController = alertController.popoverPresentationController
        presentationController?.barButtonItem = (sender as! UIBarButtonItem)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func BtnAddAlien3(_ sender: Any) {
        btn3 = true
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let profileAction = UIAlertAction(title: "Add Alien", style: .default) { (action) in
            self.croppingStyle = .circular
            
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .popover
            //            imagePicker.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
            imagePicker.preferredContentSize = CGSize(width: 320, height: 568)
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
        alertController.addAction(profileAction)
        alertController.modalPresentationStyle = .popover
        
        let presentationController = alertController.popoverPresentationController
        presentationController?.barButtonItem = (sender as! UIBarButtonItem)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnPlay(_ sender: Any) {
        checkForImg()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "game")
        present(vc!, animated: false, completion: nil)
        
    }
    
    func checkForImg(){
        
        if globalAlienimg == nil{
            globalAlienimg = imgAlien1.image
        }
        if globalAlienimg2 == nil{
            globalAlienimg2 = imgAlien2.image
        }
        if globalAlienimg3 == nil{
            globalAlienimg3 = imgAlien3.image
        }
    }
    
    @IBAction func btnExit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
        present(vc!, animated: false, completion: nil)
    }
    
    
//    @objc public func didTapImageView() {
//        // When tapping the image view, restore the image to the previous cropping state
//        let cropViewController = CropViewController(croppingStyle: self.croppingStyle, image: self.image!)
//        cropViewController.delegate = self
//        let viewFrame = view.convert(imageView.frame, to: navigationController!.view)
//
//        cropViewController.presentAnimatedFrom(self,
//                                               fromImage: self.imageView.image,
//                                               fromView: nil,
//                                               fromFrame: viewFrame,
//                                               angle: self.croppedAngle,
//                                               toImageFrame: self.croppedRect,
//                                               setup: { self.imageView.isHidden = true },
//                                               completion: nil)
//    }
    
//    public override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        layoutImageView()
//    }
    
//    public func layoutImageView() {
//        guard imageView.image != nil else { return }
//
//        let padding: CGFloat = 20.0
//
//        var viewFrame = self.view.bounds
//        viewFrame.size.width -= (padding * 2.0)
//        viewFrame.size.height -= ((padding * 2.0))
//
//        var imageFrame = CGRect.zero
//        imageFrame.size = imageView.image!.size;
//
//        if imageView.image!.size.width > viewFrame.size.width || imageView.image!.size.height > viewFrame.size.height {
//            let scale = min(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height)
//            imageFrame.size.width *= scale
//            imageFrame.size.height *= scale
//            imageFrame.origin.x = (self.view.bounds.size.width - imageFrame.size.width) * 0.5
//            imageFrame.origin.y = (self.view.bounds.size.height - imageFrame.size.height) * 0.5
//            imageView.frame = imageFrame
//        }
//        else {
//            self.imageView.frame = imageFrame;
//            self.imageView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
//        }
//    }
    


}
