import UIKit

class ImageZoomViewController: UIViewController {

    var imageView: UIImageView!
    var image: UIImage? // 存储要放大的图片

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置背景为半透明黑色
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        // 创建 UIImageView 用来显示放大的图片
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        view.addSubview(imageView)

        // 添加点击手势，点击空白区域关闭视图
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissZoomView))
        view.addGestureRecognizer(tapGesture)
    }

    // 点击空白区域关闭放大视图
    @objc func dismissZoomView() {
        self.dismiss(animated: true, completion: nil)
    }
}

