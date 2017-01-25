//
//  TableViewController.swift
//  MVPTEST
//
//  Created by Eang Pheara on 12/27/16.
//  Copyright © 2016 Eang Pheara. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var articles:  [Article]?
    
    var articlePresenter: ArticlePresenter?
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var footerIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        articles = [Article]()
//        articleService = ArticleService()
//        articleService?.delegate = self
//        articleService?.getData(page: 1, limit: 15)
        
        
        articlePresenter = ArticlePresenter()
        articlePresenter?.delegate = self
        articlePresenter?.getData(page: 1, limit: 15)
        
        //Add Action to resfresh
        
        self.refreshControl?.addTarget(self, action: #selector(self.refreshControlHander), for: .valueChanged)
        
        
    }
    
    func refreshControlHander(){
        self.articles?.removeAll()
        articlePresenter?.getData(page: 1, limit: 15)
    }

        // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.articles?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.configurCell(article: (self.articles?[indexPath.row])!)
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("\(Pagination.shared.currentPage) < \(Pagination.shared.totalPage)")
        if indexPath.row >= (articles?.count)! - 1 {
            if Pagination.shared.currentPage < Pagination.shared.totalPage{
                self.footerView.isHidden = false
                self.footerIndicator.startAnimating()
                Pagination.shared.currentPage += 1
                self.articlePresenter?.getData(page: Pagination.shared.currentPage, limit: 15)
            }
            
           
        }
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let moreRowAction = UITableViewRowAction(style: .normal, title: "More", handler: { (action, indexPath) in
            
        
        })
        moreRowAction.backgroundColor = UIColor(red: 0 , green: 255 , blue: 0 , alpha: 1)
        let deleteRowAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            self.articlePresenter?.deletData(articleId: (self.articles?[indexPath.row].id!)!, complition: { (status) in
                if status == true{
                    
                    self.articles?.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    
                }
            })
        
        })
        deleteRowAction.backgroundColor = UIColor(red:255 ,green:0, blue:0 ,alpha: 1)
        return [moreRowAction,deleteRowAction]
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TableViewController : ArticlePresenterProtocol{
    //Confirm ArticlePresenterProtocol
    
    func didResponseArticleFromGet(articles: [Article]) {
    
        self.articles! += articles
        //ending refreshControl before reload Data
        self.refreshControl?.endRefreshing()
        self.footerView.isHidden = true
        self.footerIndicator.stopAnimating()
        self.tableView.reloadData()
    }
    
}
