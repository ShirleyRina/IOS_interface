import UIKit

class BookDetailViewController: UIViewController {

    // 定义用于显示书籍详细信息的 UI 元素
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var bookTitle: String?
    var bookAuthor: String?
    var bookImage: UIImage?
    var bookDescription: String?

    override func viewDidLoad() {
            super.viewDidLoad()

            // 显示书籍的详细信息
            titleLabel.text = bookTitle
            authorLabel.text = bookAuthor
            bookImageView.image = bookImage
            descriptionLabel.text = bookDescription

            // 添加下拉手势
            let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
            swipeDownGesture.direction = .down
            view.addGestureRecognizer(swipeDownGesture)
        }

        // 处理下拉手势
    @objc func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
            if gesture.state == .ended {
                self.dismiss(animated: true, completion: nil)
            }
    }
}

