//
//  ViewController.swift
//  Project_3
//
//  Created by Lauren Tsung on 9/16/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\ltsung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var leftAction: UIImageView!
    @IBOutlet weak var rightAction: UIImageView!
    
    
    var originalImageCenter: CGPoint!
    var originalLocation: CGPoint!
    var state = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var contentSize = CGSizeMake(320, feedView.image!.size.height + messageView.image!.size.height)
        
        scrollView.contentSize = contentSize
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onPan(gestureRecognizer: UIPanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        var translation = gestureRecognizer.translationInView(view)
        


        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            println("Pan began")
            originalImageCenter = messageView.center
            originalLocation = location

            println("originalImageCenter.center: \(originalImageCenter)")
            println("original location: \(location)")

        
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Changed) {
            println("Pan changed")
            var dragDifference: CGFloat!
            
            messageView.center = CGPoint(x: originalImageCenter.x + translation.x, y: originalImageCenter.y)
            
            dragDifference = originalLocation.x - location.x
            
            
            // Do some math with this for icon to follow it
            println("location.x \(location.x)")
            
            println("dragDifference: \(dragDifference)")
            
          
            
            if (translation.x < 0.0) {
                println("Panning left")
                
                // A point at which the later icon is translucent again?
                
                if (dragDifference < 20) {
                    self.leftAction.alpha = 0;
                    self.rightAction.alpha = 0;
                    
                    println("Make later icon transition from translucent")
                    
                    if (self.rightAction.alpha == 0) {
                        UIView.animateWithDuration(0.4, animations: {
                            self.rightAction.alpha = 1
                        })
                    }
                    else {
                        UIView.animateWithDuration(0.4, animations: {
                            self.rightAction.alpha = 0
                        })
                    }
                    self.rightAction.frame.origin = CGPoint(x: 280, y: self.rightAction.frame.origin.y)
                    
                }
                
                
                if (dragDifference >= 20 && dragDifference < 60) {
                    println("Background is gray")
                    self.messageContainer.backgroundColor = UIColor.lightGrayColor()
                    self.rightAction.alpha = 1
                    state = ""
                }

                
                if (dragDifference >= 60 && dragDifference < 249) {
                    println("Background should change to yellow")
                    self.messageContainer.backgroundColor = UIColor.yellowColor()

                    println("Icon is later icon")
                    println("Later icon should start moving")
                    self.rightAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x + self.messageView.frame.width + 5, y: self.rightAction.frame.origin.y)
                    
                    
                    state = "reschedule"
                }
                
                if (dragDifference >= 260) {
                    println("Background should change to brown")
                    self.messageContainer.backgroundColor = UIColor.brownColor()
                    self.rightAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x + self.messageView.frame.width + 5, y: self.rightAction.frame.origin.y)

                    println("List icon is swapped")
                    state = "list"
                }
                
                println("state \(state)")
            }
            
            if (translation.x > 0.0) {
                println("Panning right")

                dragDifference = -dragDifference
                
                if (dragDifference < 20) {
                    self.leftAction.alpha = 0;
                    self.rightAction.alpha = 0;
                    
                    println("Make later icon transition from translucent")
                    
                    if (self.leftAction.alpha == 0) {
                        UIView.animateWithDuration(0.4, animations: {
                            self.leftAction.alpha = 1
                        })
                    }
                    else {
                        UIView.animateWithDuration(0.4, animations: {
                            self.leftAction.alpha = 0
                        })
                    }
                    self.leftAction.frame.origin = CGPoint(x: 15, y: self.leftAction.frame.origin.y)
                    
                }
                

                
                if (dragDifference > 20 && dragDifference < 60) {
                    println("Background is gray")
                    self.messageContainer.backgroundColor = UIColor.lightGrayColor()
                    self.leftAction.alpha = 1
         
                    state = ""
                }
                
                if (dragDifference >= 60 && dragDifference < 249) {
                    println("Background should change to green")
                    self.messageContainer.backgroundColor = UIColor.greenColor()
                    println("Icon is archive icon")
                    println("Archive icon should start moving")
                    
                    self.leftAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x - 35, y: self.leftAction.frame.origin.y)

                    state = "archive"
                }
                
                if (dragDifference >= 260) {
                    println("Background should change to red")
                    self.messageContainer.backgroundColor = UIColor.redColor()
                    self.leftAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x - 35, y: self.leftAction.frame.origin.y)

                    println("Delete icon is swapped")
                    state = "delete"
                }
                
                println("state \(state)")
            }
            
            
            
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            println("Pan ended")
            
            println("state \(state)")
            
            if (state == "") {
                messageView.center = CGPoint(x: originalImageCenter.x, y: originalImageCenter.y)
            }
            
            
            if (state == "reschedule") {
                println("Continue to reveal yellow background")
                println("On animation complete, show resched options")
                messageView.center = CGPoint(x: originalImageCenter.x, y: originalImageCenter.y)
            }
            
            if (state == "list") {
                println("Continue to reveal brown background")
                println("On animation complete, show list options")
                messageView.center = CGPoint(x: originalImageCenter.x, y: originalImageCenter.y)
            }
            
            if (state == "archive") {
                println("Continue to reveal green background")
                println("On animation complete, hide message")
            
                feedView.center = CGPoint(x: feedView.center.x, y: feedView.center.y - messageView.image!.size.height)
            }
            
            if (state == "delete") {
                println("Continue to reveal red background")
                println("On animation complete, hide message")

                feedView.center = CGPoint(x: feedView.center.x, y: feedView.center.y - messageView.image!.size.height)
            }
            
            // Reset
            state = ""
        }
    

    }
    
    
    /*
    
    @IBAction func onGoButton(sender: AnyObject) {
    UIView.animateWithDuration(0.2, animations: { () -> Void in
    // Animating the downward move + 3X scale
    self.imageView.frame.origin.y = self.imageView.frame.origin.y + 250
    self.imageView.transform = CGAffineTransformMakeScale(3, 3)
    }) { (finished: Bool) -> Void in
    // After the animation completes, rotate to the left 10 degrees with no animation.
    var rotation = CGFloat(-10 * M_PI / 180)
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation)
    
    // Animate the rocking head of 20 degrees, repeated infinitely.
    UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
    var rotation = CGFloat(20 * M_PI / 180)
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation)
    }, completion: nil)
    }
    }

    
    class NavigationBar: UINavigationBar {
    
    init(frame: CGRect) {
    super.init(frame: frame)
    initialise()
    }
    
    init(coder aDecoder: NSCoder!){
    super.init(coder: aDecoder)
    initialise()
    }
    
    func initialise(){
    
    let logo = UIImage(named: "logo");
    let imageView = UIImageView(image:logo)
    imageView.frame.size.width = 145;
    imageView.frame.size.height = 33;
    imageView.frame.origin = CGPoint(x: 2, y: 8)
    
    addSubview(imageView)
    }
    }
    
    */
    
}

