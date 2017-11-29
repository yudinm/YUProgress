//
//  YUProgressView.swift
//  YUProgress
//
//  Created by Michael Yudin on 29.11.2017.
//  Copyright © 2017 Michael Yudin. All rights reserved.
//

import UIKit

public class YUProgressView: UIView {
    
    struct Progress {
        enum State {
            case notStarted
            case inProgress
            case done
            case complited
        }
        
        struct Colors {
            let foreground = UIColor.red
            let background = UIColor.blue
            let done = UIColor.green
        }
        
        let height:CGFloat = 4.0
        var state:State = .notStarted
        var value:CGFloat = 0.0 /* from 0 to 1 */
        let colors:Colors = Colors()
    }
    
    var progress:Progress = Progress()
    var progressBarView = UIView()
    
    public var complition: (() -> ())?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(progressBarView)
    }
    
    public func updateProgress(value:CGFloat) {
        guard self.progress.state != .complited else { return }
        guard self.progress.state != .done else { if let complition = self.complition { complition(); self.progress.state = .complited }; return }
        
        var newValue = value
        if newValue >= 1.0 {
            newValue = 1.0
            self.progress.state = .done
        }
        else if newValue <= 0.0 {
            newValue = 0.0
            self.progress.state = .notStarted
        } else {
            self.progress.state = .inProgress
        }
        
        self.progress.value = newValue
        self.redraw()
    }
    
    public func resetProgress() {
        self.progress.state = .notStarted
        self.updateProgress(value: 0.0)
    }
    
    func redraw() {
        let newWidth = self.progress.value * CGFloat(self.bounds.width)
        let newFrame:CGRect = CGRect(x: 0, y: 0, width: newWidth, height: self.progress.height)
        self.progressBarView.frame = newFrame
        
        self.backgroundColor = self.progress.colors.background
        UIView.animate(withDuration: 0.3) {
            if (self.progress.state == .done || self.progress.state == .complited) {
                self.progressBarView.backgroundColor = self.progress.colors.done
            } else {
                self.progressBarView.backgroundColor = self.progress.colors.foreground
            }
        }
    }
    
    override public func draw(_ rect: CGRect) {
        self.redraw()
    }
    
}
