//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Miro on 2/26/22.
//

import UIKit

import AlamofireImage

import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        //create posts class in back4app backend
        
        let post = PFObject(className: "Posts")
        
        //create caption
        
        post["caption"] = commentField.text!
        
        post["author"] = PFUser.current()!
        
        //get image data as PNG file
        
        let imgData = imageView.image!.pngData()
        
        let file = PFFileObject(name: "img.png", data: imgData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            
            if success {
                
                self.dismiss(animated: true, completion: nil)
                
                print("Saved!")
                
            } else {
                
                print("Error! D:")
                
            }
            
        }
        
    }
    

    //launch camera
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            picker.sourceType = .camera
            
        } else {
            
            picker.sourceType = .photoLibrary
            
        }
        
        //show photo album
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //get image + scale to fit screen
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = image.af.imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
