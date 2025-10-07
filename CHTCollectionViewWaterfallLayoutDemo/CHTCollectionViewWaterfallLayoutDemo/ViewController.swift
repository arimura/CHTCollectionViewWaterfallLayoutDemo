import UIKit
#if canImport(CHTCollectionViewWaterfallLayout)
import CHTCollectionViewWaterfallLayout
#endif

final class ViewController: UIViewController,
                            UICollectionViewDataSource,
                            CHTCollectionViewDelegateWaterfallLayout {

    private var collectionView: UICollectionView!
    private let itemHeights: [CGFloat] = [80, 120, 90, 160, 110]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Waterfall レイアウト
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // CollectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        collectionView.dataSource = self
        collectionView.delegate = self   // ✅ これだけでOK

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }

    // MARK: - DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        itemHeights.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 8
        return cell
    }

    // MARK: - Waterfall Delegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 幅は任意（比率だけ使用）
        let height = itemHeights[indexPath.item]
        return CGSize(width: 100, height: height)
    }
}
