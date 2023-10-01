import UIKit

class ImageController: UIViewController, UIScrollViewDelegate {
    
    let image: UIImage

    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    
    private var visibleWidth: CGFloat {
        scrollView.bounds.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right
    }

    private var visibleHeight: CGFloat {
        scrollView.bounds.size.height - view.directionalLayoutMargins.top - view.directionalLayoutMargins.bottom
    }

    init(image: UIImage) {
        self.image = image
        
        super.init(nibName: nil, bundle: nil)

        scrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        scrollView.contentInsetAdjustmentBehavior = .always
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 8.0
        scrollView.zoomScale = 1.0

        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        scrollView.decelerationRate = .fast
        scrollView.isScrollEnabled = true
        scrollView.bouncesZoom = true
        scrollView.bounces = true

        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        imageView.contentMode = .scaleToFill
        imageView.image = image

        scrollView.addSubview(imageView)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scale = min(visibleWidth / image.size.width, visibleHeight / image.size.height)
        
        imageView.frame = CGRect(
            x: 0,
            y: 0,
            width: image.size.width * scale * scrollView.zoomScale,
            height: image.size.height * scale * scrollView.zoomScale
        )
        
        scrollView.contentSize = imageView.frame.size

        centerImage()
    }
    
    private func centerImage() {
        let contentWidth = scrollView.contentSize.width
        let contentHeight = scrollView.contentSize.height

        let left = contentWidth < visibleWidth ? (visibleWidth - contentWidth) / 2 : 0
        let top = contentHeight < visibleHeight ? (visibleHeight - contentHeight) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
    }
    
    // MARK: - Scroll view delegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
    
    // MARK: - Actions
    
    @objc func doubleTapped(_ sender: UIScrollView) {
        scrollView.setZoomScale(scrollView.zoomScale == 1 ? 3 : 1, animated: true)
    }
    
}
