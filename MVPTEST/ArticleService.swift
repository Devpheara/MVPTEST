//
//  ArticleService.swift
//  MVPTEST
//
//  Created by Eang Pheara on 12/22/16.
//  Copyright © 2016 Eang Pheara. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol ArticleServiceProtocol{
    func didResponseDataFromGet(articles: [Article])
    func didResponseDataFromPost(articles: Article)
}
class ArticleService{
    
    var delegate: ArticleServiceProtocol?
    
    let header = ["Authorization" : "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
    
    func getData(page: Int, limit: Int){

        
        Alamofire.request("http://120.136.24.174:1301/v1/api/articles?page=\(page)&limit=\(limit)", method: .get, headers: header).responseJSON(completionHandler: { response in
           // print(response.result.value!)
            
            let responseJson = JSON(data: response.data!)
           // print(responseJson["DATA"])
            
            let pagination = responseJson["PAGINATION"]
            Pagination.shared.currentPage = pagination["PAGE"].int!
            Pagination.shared.totalPage = pagination["TOTAL_PAGES"].int!
            
            
            var articles  = [Article]()
            
            for art in responseJson["DATA"].array! {
                articles.append(Article(article: art))
            }
            self.delegate?.didResponseDataFromGet(articles: articles)
        
        })
    
    }
    func postData(data: [String: Any]){
        let image = data["image"] as! UIImage
        let article = data["article"] as! Article
        uploadFile(image: image) {(url) in
            article.imageUrl = url
            self.uploadData(article: article, complition:{(response) in
                let responseJson = JSON(data: response.data!)
                let article = Article(article: responseJson["DATA"])
                self.delegate?.didResponseDataFromPost(articles: article)
            
            })
        }
        
    }
    
    private func uploadFile(image: UIImage, complition:
        @escaping (_ result: String)  ->Void) {
            Alamofire.upload(multipartFormData: { (multipartFormData) in
            
                multipartFormData.append(UIImageJPEGRepresentation(image, 0.5)!, withName: "FILE", fileName: ".jpg", mimeType: "image/jpeg")
                
                
                }, to: "http://120.136.24.174:1301/v1/api/uploadfile/single", method: .post) { (dataEncodingResult) in
                    switch dataEncodingResult{
                        case .success(let upload,_ ,_ ):
                            upload.responseJSON(completionHandler: { (response) in
                                print(response)
                                
                                let responseData = response.result.value as? [String: Any]

                                let url = responseData?["DATA"] as! String
                                complition(url)
                        })
                    case .failure(let encodingError):
                            print(encodingError)
                    }
            }

    }
    private func uploadData(article: Article, complition:
        @escaping   (_ result: DataResponse<Any>) -> Void){
        Alamofire.request("http://120.136.24.174:1301/v1/api/articles", method: .post, parameters: article.convertToObjecct(), encoding: JSONEncoding.default, headers: header).responseJSON{ (response) in
            complition(response)
            
        }
    }
    
    func deletData(articleId: Int,complition:
        @escaping (_ status: Bool)  ->Void){
        Alamofire.request("http://120.136.24.174:1301/v1/api/articles/\(articleId)", method: .delete).responseJSON { (response) in
            print("\(response)")
            
            
            let responseJson = JSON(data: response.data!)
            let code = responseJson["CODE"].string
            if code == "0000" {
                complition(true)
            }
            else{
                complition(false)
            }

            
        }
        
        
    }
    
    
}
