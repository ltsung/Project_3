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
    
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    
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
                    self.leftAction.alpha = 0
                    self.rightAction.alpha = 0
                    
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
                    
                }
                
                
                if (dragDifference >= 20 && dragDifference <= 60) {
                    println("Background is gray")
                    self.messageContainer.backgroundColor = UIColor.lightGrayColor()
                    self.rightAction.alpha = 1
                    
                    UIView.animateWithDuration(0.4, animations: {
                        self.rightAction.frame.origin = CGPoint(x: 280, y: self.rightAction.frame.origin.y)
                    })

                    state = ""
                }

                
                if (dragDifference > 60 && dragDifference < 259) {
                    println("Background should change to yellow")

                    UIView.animateWithDuration(0.2, animations: {
                        self.messageContainer.backgroundColor = UIColor.yellowColor()
                    })


                    println("Icon is later icon")
                    rightAction.image = UIImage(named: "later_icon.png")
                    
                    println("Later icon should start moving")
                    self.rightAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x + self.messageView.frame.width + 10, y: self.rightAction.frame.origin.y)
                    
                    
                    state = "reschedule"
                }
                
                if (dragDifference >= 260) {
                    println("Background should change to brown")
                    
                    UIView.animateWithDuration(0.2, animations: {
                        self.messageContainer.backgroundColor = UIColor.brownColor()
                    })

                    self.rightAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x + self.messageView.frame.width + 10, y: self.rightAction.frame.origin.y)

                    println("List icon is swapped")
                    rightAction.image = UIImage(named: "list_icon.png")
    

                    state = "list"
                }
                
                println("state \(state)")
            }
            
            if (translation.x > 0.0) {
                println("Panning right")

                dragDifference = -dragDifference
                
                if (dragDifference < 20) {
                    self.leftAction.alpha = 0
                    self.rightAction.alpha = 0
                    
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
                    
                }
                

                
                if (dragDifference > 20 && dragDifference <= 60) {
                    println("Background is gray")
                    self.messageContainer.backgroundColor = UIColor.lightGrayColor()
                    self.leftAction.alpha = 1
                    
                    UIView.animateWithDuration(0.4, animations: {
                        self.leftAction.frame.origin = CGPoint(x: 15, y: self.leftAction.frame.origin.y)
                    })
                    
                    state = ""
                }
                
                if (dragDifference > 60 && dragDifference < 259) {
                    println("Background should change to green")
                    
                    UIView.animateWithDuration(0.2, animations: {
                        self.messageContainer.backgroundColor = UIColor.greenColor()
                    })
                    println("Icon is archive icon")
                    leftAction.image = UIImage(named: "archive_icon.png")

                    println("Archive icon should start moving")
                    self.leftAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x - 35, y: self.leftAction.frame.origin.y)

                    state = "archive"
                }
                
                if (dragDifference >= 260) {
                    println("Background should change to red")

                    UIView.animateWithDuration(0.2, animations: {
                        self.messageContainer.backgroundColor = UIColor.redColor()
                    })

                    self.leftAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x - 35, y: self.leftAction.frame.origin.y)

                    println("Delete icon is swapped")
                    leftAction.image = UIImage(named: "delete_icon.png")
                    
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
                self.leftAction.alpha = 0
                println("Continue to reveal yellow background")
                

                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.frame.origin = CGPoint(x: -320, y: self.messageView.frame.origin.y)
                    self.rightAction.frame.origin = CGPoint(x: 15, y: self.rightAction.frame.origin.y)
                }){ (finished: Bool) -> Void in
                    println("On animation complete, show resched options")
                 
                    UIView.animateWithDuration(0.2, delay: 0.2, options: nil, animations: {
                        self.rescheduleView.alpha = 1
                    }, completion: nil)
                }
                
                // Reset
                //messageView.center = CGPoint(x: originalImageCenter.x, y: originalImageCenter.y)
            }
            
            if (state == "list") {
                self.leftAction.alpha = 0
                
                println("Continue to reveal brown background")
                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.frame.origin = CGPoint(x: -320, y: self.messageView.frame.origin.y)
                    self.rightAction.frame.origin = CGPoint(x: 15, y: self.rightAction.frame.origin.y)
                }){ (finished: Bool) -> Void in
                    println("On animation complete, show list options")
                        
                    UIView.animateWithDuration(0.2, delay: 0.2, options: nil, animations: {
                        self.listView.alpha = 1
                    }, completion: nil)
                }
                
                // Reset
                //messageView.center = CGPoint(x: originalImageCenter.x, y: originalImageCenter.y)
            
            }
            
            if (state == "archive") {
                self.rightAction.alpha = 0
                
                println("Continue to reveal green background")
                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.frame.origin = CGPoint(x: 320, y: self.messageView.frame.origin.y)
                    self.leftAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x - 35, y: self.leftAction.frame.origin.y)
                }){ (finished: Bool) -> Void in
                    println("On animation complete, hide message")
                    UIView.animateWithDuration(0.2, delay: 0.2, options: nil, animations: {
                        self.feedView.center = CGPoint(x: self.feedView.center.x, y: self.feedView.center.y - self.messageView.image!.size.height)
                    }, completion: nil)
                }
            }
            
            if (state == "delete") {
                self.rightAction.alpha = 0
                
                println("Continue to reveal red background")
                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.frame.origin = CGPoint(x: 320, y: self.messageView.frame.origin.y)
                    self.leftAction.frame.origin = CGPoint(x: self.messageView.frame.origin.x - 35, y: self.leftAction.frame.origin.y)
                }){ (finished: Bool) -> Void in
                    println("On animation complete, hide message")
                    UIView.animateWithDuration(0.2, delay: 0.2, options: nil, animations: {
                        self.feedView.center = CGPoint(x: self.feedView.center.x, y: self.feedView.center.y - self.messageView.image!.size.height)
                    }, completion: nil)
                }
            }
            
            // Reset
            state = ""
        }
    

    }
}

