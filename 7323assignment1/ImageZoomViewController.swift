import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView!
    var scrollView: UIScrollView!
    var image: UIImage? // 存储要放大的图片

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置背景为半透明黑色
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        // 创建 UIScrollView 用于支持缩放
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0  // 最小缩放比例
        scrollView.maximumZoomScale = 3.0  // 最大缩放比例
        scrollView.contentSize = view.bounds.size
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

        // 创建 UIImageView 用来显示放大的图片
        imageView = UIImageView(frame: scrollView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        scrollView.addSubview(imageView)

        // 添加点击手势，点击空白区域关闭视图
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissZoomView))
        view.addGestureRecognizer(tapGesture)
    }

    // 点击空白区域关闭放大视图
    @objc func dismissZoomView() {
        self.dismiss(animated: true, completion: nil)
    }

    // UIScrollViewDelegate 方法，指定要缩放的视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
