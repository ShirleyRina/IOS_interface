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

        // 设置传递来的书籍信息
        titleLabel.text = bookTitle
        authorLabel.text = bookAuthor
        bookImageView.image = bookImage
        descriptionLabel.text = bookDescription
    }
}

