//
//  ArticlePresenter.swift
//  MVPTEST
//
//  Created by Eang Pheara on 12/27/16.
//  Copyright © 2016 Eang Pheara. All rights reserved.
//

import Foundation

protocol ArticlePresenterProtocol {
    func didResponseArticleFromGet(articles: [Article])
    func didResponseDataFromPost(articles: Article)
    
}

extension ArticlePresenterProtocol{
    func didResponseArticleFromGet(articles: [Article]) {}
    
    func didResponseDataFromPost(articles: Article) {}
}

class ArticlePresenter {
    
    //
    
    var service: ArticleService?
    
    var delegate: ArticlePresenterProtocol?
    
    
    init() {
        service = ArticleService()
        service?.delegate = self
    }
    
    func getData(page: Int, limit: Int) {
        service?.getData(page: page, limit: limit)
    }
    
    func postData(data: [String:Any]){
        service?.postData(data: data)
    
    }
    func deletData(articleId: Int, complition:
        @escaping (_ status: Bool)  ->Void){
        self.service?.deletData(articleId: articleId, complition: { (status) in
            complition(status)
        })
    }
}
extension ArticlePresenter: ArticleServiceProtocol{
    func didResponseDataFromGet(articles: [Article]) {
        self.delegate?.didResponseArticleFromGet(articles: articles)

    }
    func didResponseDataFromPost(articles: Article) {
        self.delegate?.didResponseDataFromPost(articles: articles)
    }
    
}
