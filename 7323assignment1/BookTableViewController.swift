import UIKit

class BookTableViewController: UITableViewController {

    var books: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // 从 Objective-C 文件获取书籍数据
        books = BookData.getBooks() as! [[String : String]]
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    // 配置每个单元格的显示内容
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
            // 设置图片
            if let imageName = book["image"] {
                cell.imageView?.image = UIImage(named: imageName)
            }

            // 为图片添加点击手势
            cell.imageView?.isUserInteractionEnabled = true // 启用用户交互
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            cell.imageView?.addGestureRecognizer(tapGesture)
            cell.imageView?.tag = indexPath.section // 用 tag 来标记是哪本书的图片

            return cell
        }
    }

    // 点击图片时的动作
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView, let image = imageView.image {
            // 创建并展示放大图片的视图控制器
            let zoomVC = ImageZoomViewController()
            zoomVC.image = image
            zoomVC.modalPresentationStyle = .overFullScreen
            present(zoomVC, animated: true, completion: nil)
        }
    }
    
    // 处理点击书名后的跳转
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                // 获取选中的书籍信息
                let selectedBook = books[indexPath.section]

                // 从 storyboard 加载 BookDetailViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailVC = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController

                // 传递书籍信息给 BookDetailViewController
                detailVC.bookTitle = selectedBook["title"]
                detailVC.bookAuthor = selectedBook["author"]
                detailVC.bookImage = UIImage(named: selectedBook["image"]!)
                detailVC.bookDescription = selectedBook["description"] // 书籍简介可以存储在数据源中

                // 使用导航控制器跳转到书籍详细页面
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 检查是否是我们创建的 segue
        if segue.identifier == "showBookDetail" {
            // 获取目标视图控制器
            if let detailVC = segue.destination as? BookDetailViewController {
                // 确定选中的书籍（书名单元格被点击时）
                if let indexPath = tableView.indexPathForSelectedRow {
                    let selectedBook = books[indexPath.section]

                    // 传递书籍信息给 BookDetailViewController
                    detailVC.bookTitle = selectedBook["title"]
                    detailVC.bookAuthor = selectedBook["author"]
                    detailVC.bookImage = UIImage(named: selectedBook["image"]!)
                    detailVC.bookDescription = selectedBook["description"] // 简介需要存储在 books 数据中
                }
            }
        }
    }

}

