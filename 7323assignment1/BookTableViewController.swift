import UIKit

class BookTableViewController: UITableViewController {

    var books: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load book data from Objective-C file
        books = BookData.getBooks() as! [[String : String]]
        // Add Observer for Dark mode changing
        NotificationCenter.default.addObserver(self, selector: #selector(updateDarkMode), name: NSNotification.Name("DarkModeChanged"), object: nil)
        
        // Use current display style when initiate
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        
        // Create and set up Table Header View
        setupTableHeaderView()
    }
    
    func setupTableHeaderView() {
        // Create UIView as Header View
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))

        // Create UILabel
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 10, width: 200, height: 40))
        titleLabel.text = "My Book App"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerView.addSubview(titleLabel)

        // Create setting button
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false // Disable frame layout，enable Auto Layout
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        headerView.addSubview(settingsButton)

        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            settingsButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
            settingsButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40)
        ])


        // Set it up for Table Header View
        tableView.tableHeaderView = headerView
    }

    // The operation when click the setting button
    @objc func settingsButtonTapped() {
        // Navigate to a new view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc func updateDarkMode() {
        // Change view style when receive dark mode chenges
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    // Set up content for each cell, lazy initiation
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
            
            // Asynchronous loading pictures
            if let imageName = book["image"] {
                DispatchQueue.global().async {
                    if let image = UIImage(named: imageName) {
                        DispatchQueue.main.async {
                            if let currentCell = tableView.cellForRow(at: indexPath) {
                                currentCell.imageView?.image = image
                                currentCell.setNeedsLayout()  // Force layout update
                            }
                        }
                    }
                }
            }

            // Enable user interact and add gesture recognition
            cell.imageView?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            cell.imageView?.addGestureRecognizer(tapGesture)
            cell.imageView?.tag = indexPath.section // Use tag to label which picture belongs to which book

            return cell
        }
    }


    // Action when click picture
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView, let image = imageView.image {
            // Create Image Zoom View Controller
            let zoomVC = ImageZoomViewController()
            zoomVC.image = image
            zoomVC.modalPresentationStyle = .overFullScreen
            present(zoomVC, animated: true, completion: nil)
        }
    }
    
    // Handle navigation after click book name
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                // Get book data when select a book
                let selectedBook = books[indexPath.section]

                // From storyboard, load BookDetailViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailVC = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController

                // Pass book data to BookDetailViewController
                detailVC.bookTitle = selectedBook["title"]
                detailVC.bookAuthor = selectedBook["author"]
                detailVC.bookImage = UIImage(named: selectedBook["image"]!)
                detailVC.bookDescription = selectedBook["description"]
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check if current segue is the one we created
        if segue.identifier == "showBookDetail" {
            // Get target view controller
            if let detailVC = segue.destination as? BookDetailViewController {
                // Confirm the selected book(when it's clicked)
                if let indexPath = tableView.indexPathForSelectedRow {
                    let selectedBook = books[indexPath.section]

                    // Pass book data to BookDetailViewController
                    detailVC.bookTitle = selectedBook["title"]
                    detailVC.bookAuthor = selectedBook["author"]
                    detailVC.bookImage = UIImage(named: selectedBook["image"]!)
                    detailVC.bookDescription = selectedBook["description"] // description need to be stored in book data
                }
            }
        }
    }

}

