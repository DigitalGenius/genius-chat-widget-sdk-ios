#if canImport(SwiftUI)
import SwiftUI

/// Entry point for interaction with ``DGChatSDK`` in SwiftUI project.
public struct GeniusChatView: UIViewRepresentable {
    /// Client identifier (Widget Identifier) provided by vendor company.
    public let widgetId: String
    /// 'env' value provided by vendor company.
    public let env: String
    /// Version of the scipt, provided by the vendor company.
    public let scriptVersion: String
    /// Struct with 2 parameters 'platform' & 'version' , optional
    public let crmCredentials: DGChatCRMCredentials?
    /// Metadata for configuration, provided by Vendor. Optional.
    public let metadata: String
    /// Comes when user taps on URL inside Chat View e.g. when taps on orger tracking url.
    /// So it's up to your app to decide on how to behave in this case - open in Safari, ignore or use internal browser.
    public var onURLTap: ((_ url: URL) -> Void)?
    /// Reports actoins, taken by user with Chat View.
    public var onChatAction: ((_ action: DGChatAction) -> Void)?
    /// Reports internal runtime errors if some.
    public var onFailure: ((_ error: Error) -> Void)?
    
    public init(widgetId: String,
                env: String,
                scriptVersion: String,
                crmCredenrials: DGChatCRMCredentials? = nil,
                metadata: String = "",
                onURLTap: ((_: URL) -> Void)? = nil,
                onChatAction: ((_: DGChatAction) -> Void)? = nil,
                onFailure: ((_: Error) -> Void)? = nil) {
        self.widgetId = widgetId
        self.env = env
        self.scriptVersion = scriptVersion
        self.crmCredentials = crmCredenrials
        self.onURLTap = onURLTap
        self.onChatAction = onChatAction
        self.onFailure = onFailure
        self.metadata = metadata
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = DGChatView(delegate: context.coordinator, fullScreenLayout: false)
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        guard let view = (uiView as? DGChatView) else { return }
        Task { await view.load() }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public final class Coordinator: NSObject, DGChatDelegate {
        
        let parent: GeniusChatView
        
        init(parent: GeniusChatView) {
            self.parent = parent
        }
        
        public func didTrack(action: DGChatAction) {
            parent.onChatAction?(action)
        }
        
        public func didAttemptToOpen(url: URL) {
            parent.onURLTap?(url)
        }
        
        public func didFailWith(error: Error) {
            parent.onFailure?(error)
        }
        
        public var widgetId: String {
            parent.widgetId
        }
        
        public var env: String {
            parent.env
        }
        
        public var scriptVersion: String {
            parent.scriptVersion
        }

        public var crmCredentials: DGChatCRMCredentials? {
            parent.crmCredentials
        }
        
        public var metadata: String {
            parent.metadata
        }
    }
}
#endif
