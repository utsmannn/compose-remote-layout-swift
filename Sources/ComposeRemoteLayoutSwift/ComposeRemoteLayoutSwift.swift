// The Swift Programming Language
// https://docs.swift.org/swift-book

@preconcurrency import ComposeRemoteLayoutCore
import SwiftUI

@available(iOS 14.0, *)
@MainActor
class HostingWrapper<Content: View>: UIView {
    let hostingController: UIHostingController<Content>
    
    var naturalWidth: CGFloat = 0
    var naturalHeight: CGFloat = 0

    init(rootView: Content) {
        hostingController = UIHostingController(rootView: rootView)
        super.init(frame: .zero)
        
        let naturalSize = hostingController.sizeThatFits(in: CGSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        ))
        naturalWidth = naturalSize.width
        naturalHeight = naturalSize.height
    
        addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        DispatchQueue.main.async {
            self.hostingController.view.layoutIfNeeded()
            self.invalidateIntrinsicContentSize()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return hostingController.sizeThatFits(in: UIView.layoutFittingExpandedSize)
    }
}

// MARK: - Hosting Wrapper ViewController
@available(iOS 14.0, *)
class HostingWrapperViewController<Content: View>: UIViewController {
    var hostingWrapper: HostingWrapper<Content>!
    private var content: Content
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(hostingWrapper: HostingWrapper<Content>?, content: Content) {
        self.hostingWrapper = hostingWrapper
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hostingWrapper = HostingWrapper(rootView: self.content)
        view.addSubview(hostingWrapper)
        hostingWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingWrapper.topAnchor.constraint(equalTo: view.topAnchor),
            hostingWrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - Remote Layout View
@available(iOS 14.0, *)
public struct RemoteLayoutView: UIViewControllerRepresentable {
    private let remoteViewControllerAdapter = RemoteLayoutDeps.remoteVierwControllerAdapter
    let jsonLayout: String  // property yang selalu mendapatkan nilai terbaru

    public func makeUIViewController(context: Context) -> some UIViewController {
        let vc = remoteViewControllerAdapter.viewController()
        remoteViewControllerAdapter.setJsonString(jsonString: jsonLayout)
        return vc
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        remoteViewControllerAdapter.setJsonString(jsonString: jsonLayout)
        uiViewController.view.setNeedsLayout()
    }
}

// MARK: - Remote Layout Dependencies
@available(iOS 14.0, *)
class RemoteLayoutDeps {
class RemoteLayoutDeps {
    static let remoteVierwControllerAdapter = RemoteViewControllerAdapter()
}

@available(iOS 14.0, *)
public class BindsValue {
    private let adapter = RemoteLayoutDeps.remoteVierwControllerAdapter
    
    public func setValue(key: String, value: Any) {
        adapter.setBindValue(key: key, value: value)
    }
}

typealias Param = [String: String]

@available(iOS 14.0, *)
@MainActor
public class CustomNodes {
    static func register<Content: View>(
        type: String,
        viewDataBuilder: @escaping (Param) -> Content
    ) {
        let adapter = RemoteLayoutDeps.remoteVierwControllerAdapter
        
        adapter.registerUiView(type: type) { data in
            let uiView = viewDataBuilder(data)
            let viewWrapper = HostingWrapper(rootView: uiView)
            let viewData = UIViewData(
                uiView: viewWrapper,
                widthDp: viewWrapper.naturalWidth,
                heightDp: viewWrapper.naturalHeight
            )
            return viewData
        }
    }
}

// MARK: - Layout Component (Optional)
@available(iOS 14.0, *)
public class LayoutComponent {
    @Published var jsonLayout: String
    
    init(jsonLayout: String) {
        self.jsonLayout = jsonLayout
    }
    
    public func updateJsonLayout(jsonLayout: String) {
        self.jsonLayout = jsonLayout
    }
}

@available(iOS 14.0, *)
public func createLayoutComponent(_ jsonLayout: String) -> LayoutComponent {
    .init(jsonLayout: jsonLayout)
}

// MARK: - Dynamic Layout View
@available(iOS 14.0, *)
public struct DynamicLayoutView: View {
    @Binding var jsonLayout: String
    private var bindsValue: BindsValue

    init(jsonLayout: Binding<String>, bindsValue: BindsValue) {
        self._jsonLayout = jsonLayout
        self.bindsValue = bindsValue
    }
    
    public var body: some View {
        RemoteLayoutView(jsonLayout: jsonLayout)
    }
}

