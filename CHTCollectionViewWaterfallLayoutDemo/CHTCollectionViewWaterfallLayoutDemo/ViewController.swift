import UIKit

// MARK: - シンプルなレイアウトクラス
class SimpleLayout: UICollectionViewLayout {
    private var cache: [UICollectionViewLayoutAttributes] = []
    private let itemSize = CGSize(width: 80, height: 80)
    private let spacing: CGFloat = 10

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        cache.removeAll()
        var x: CGFloat = spacing
        var y: CGFloat = spacing

        let totalWidth = collectionView.bounds.width

        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                if x + itemSize.width + spacing > totalWidth {
                    // 折り返し
                    x = spacing
                    y += itemSize.height + spacing
                }

                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                cache.append(attributes)

                x += itemSize.width + spacing
            }
        }
    }

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let lastFrame = cache.last?.frame ?? .zero
        return CGSize(width: collectionView.bounds.width, height: lastFrame.maxY + spacing)
    }

    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
        return cache.first { $0.indexPath == indexPath }
    }
}

// MARK: - ViewController
class ViewController: UIViewController, UICollectionViewDataSource {
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let layout = SimpleLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        view.addSubview(collectionView)
    }

    // MARK: - DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
}
