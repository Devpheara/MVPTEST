//
//  AddEditViewController.swift
//  MVPTEST
//
//  Created by Eang Pheara on 12/28/16.
//  Copyright © 2016 Eang Pheara. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
   
    @IBOutlet weak var thumnailImage: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var presenter : ArticlePresenter?
    
    var imagePickerView : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ArticlePresenter()
        presenter?.delegate = self
        
        imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveData(_ sender: AnyObject) {
            let article = Article()
            article.title = titleTextField.text!
            article.description = descriptionTextView.text!
        
            let image = thumnailImage.image!
            let data = ["article": article,
                        "image": image] as [String : Any]
            presenter?.postData(data: data)
    }
    @IBAction func imagePicker(_ sender: AnyObject) {
        present(imagePickerView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumnailImage.image = img
            
        }
        
        //let imageData = UIImageJPEGRepresentation(thumnailImage.image!, 5)
        //uploadFile(image: imageData!)
        //print(imageUrl)
        imagePickerView.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddEditViewController: ArticlePresenterProtocol {
    func didResponseDataFromPost(articles: Article) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
