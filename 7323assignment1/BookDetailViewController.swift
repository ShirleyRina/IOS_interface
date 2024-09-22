import UIKit

class BookDetailViewController: UIViewController {

    // Define the UI elements for displaying book description
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

            // Display book description
            titleLabel.text = bookTitle
            authorLabel.text = bookAuthor
            bookImageView.image = bookImage
            descriptionLabel.text = bookDescription

            // Add swipe down gesture
            let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
            swipeDownGesture.direction = .down
            view.addGestureRecognizer(swipeDownGesture)
        }

        // Handle swipe down gesture
    @objc func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
            if gesture.state == .ended {
                self.dismiss(animated: true, completion: nil)
            }
    }
}

