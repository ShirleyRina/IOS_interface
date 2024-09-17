//
//  BookTableViewController.swift
//  7323assignment1
//
//  Created by shirley on 9/16/24.
//

import UIKit

class BookTableViewController: UITableViewController {
    // 模拟书籍数据
//        let books = [
//            ["title": "The Catcher in the Rye", "author": "J.D. Salinger"],
//            ["title": "To Kill a Mockingbird", "author": "Harper Lee"]
//        ]
    var books: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // 从 Objective-C 文件中获取书籍数据
        books = BookData.getBooks() as! [[String : String]]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return books.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

  
    // 配置每一行的数据
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let book = books[indexPath.section]
                    
                    if indexPath.row == 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
                        cell.textLabel?.text = book["title"]
                        return cell
                    } else if indexPath.row == 1 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell", for: indexPath)
                        cell.textLabel?.text = "Author: \(book["author"]!)"
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
                        cell.imageView?.image = UIImage(named: book["image"]!)
                        return cell
                    }
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if let indexPath = tableView.indexPathForSelectedRow {
//                    let selectedBook = books[indexPath.section]
//                    let detailVC = segue.destination as! DetailViewController
//                    detailVC.bookDetail = selectedBook
//                }
    }



