//
//  OPViewPayments.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 24/10/24.
//

import Foundation
import UIKit
@preconcurrency import WebKit

@IBDesignable public class OPViewPayments: UIView {
    // MARK: - Variables privadas
    internal var webView: WKWebView!
    internal var objApp = ObjApplication()
    
    // MARK: - Variables públicas
    public var credentials = ObjCredentials()
    public var order = ObjOrden()

    // MARK: - IBOutlets
    @IBOutlet private var containerView: UIView!
    
    // MARK: - Funciones Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        self.initWebView()
    }
    
    //MARK: - Funciones View
    private func initWebView(){
        self.addSubview(self.loadViewFromNib())
        self.containerView.frame = self.bounds
        self.containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.webView = WKWebView()
        self.webView.frame = self.containerView.bounds
        self.webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.webView.backgroundColor = UIColor.clear
        self.webView.isHidden = false
        self.webView.scrollView.bounces = false
//        self.webView.navigationDelegate = self
        // inject JS to capture console.log output and send to iOS
        let source = Constants.Script.captureLog
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        self.webView.configuration.userContentController.addUserScript(script)
        // register the bridge script that listens for the output
//        webView.configuration.userContentController.add(self, name: "logHandler")
        self.containerView.addSubview(self.webView)
    }
    
    internal func loadViewFromNib() -> UIView {
        let bundle = Bundle.mySwiftPackageBundle
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    //MARK: - Propiedades IBInspectables
    @IBInspectable @objc public var returnDelay: Int = 5 {
        didSet{
            self.objApp.returnDelay = returnDelay
        }
    }
    
    @IBInspectable
    public var returnText: String {
        get {
            return self.objApp.returnText
        }
        set {
            self.objApp.returnText = newValue
        }
    }
    
    @IBInspectable
    public var redirectText: String {
        get {
            return self.objApp.redirectText
        }
        set {
            self.objApp.redirectText = newValue
        }
    }
    
    @IBInspectable
    public var storeName: String {
        get {
            return self.objApp.storeName
        }
        set {
            self.objApp.storeName = newValue
        }
    }
    
    @IBInspectable
    public var storeImageUrl: String {
        get {
            return self.objApp.storeImage
        }
        set {
            self.objApp.storeImage = newValue
        }
    }
    
    @IBInspectable
    public var showReturnArrow: Bool {
        get {
            return false
        }
        set {
            self.objApp.hideReturnArrow = !newValue
        }
    }
    
    @IBInspectable
    public var showReturnButton: Bool {
        get {
            return false
        }
        set {
            self.objApp.showReturnButton = newValue
        }
    }
}
