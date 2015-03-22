//
//  ViewController.swift
//  Elevator-to-Space-v2
//
//  Created by Soohyun Christine Park on 2015. 3. 7..
//  Copyright (c) 2015년 SP. All rights reserved.
//TESTTEST22222

import UIKit
import CoreMotion

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var longView: UIView!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myLabel_floor: UILabel!
    @IBOutlet weak var myLabel_feet: UILabel!
    @IBOutlet weak var desc_label: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var ETimg: UIImageView!
    @IBOutlet weak var DOGGIEimg: UIImageView!
    
    let altimeter = CMAltimeter()
    
    var total_altitude: Float = 0.0
    var current_altitude: Float = 0.0
    var max_altitude: Float = 1650.0
    var current_feet : Float = 0.0
    
    var total_floor: Int = 0
    var current_floor: Int = 0
    var max_floor: Int = 0
    
    let floor_feet : Float = 3.3
    
    let rotateVertical = CGFloat(-(M_PI / 2))
    let rotateVertical2 = CGFloat((M_PI / 2))
    let backgroundFilename = "ToSpace_img.jpg"
    
    
    var label: [UILabel] = []
    var label_floor: [UILabel] = []
    var label_feet: [UILabel] = []
    var labeled_bt: [UIButton] = []
    var labeled_date: [UILabel] = []
    var labeled_time: [UILabel] = []
    var labeled_date_line: [UILabel] = []
    
    var history_activate: [Boolean] = []
    
    var count = 0
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.setContentOffset(CGPointMake(0, longView.frame.height - self.view.frame.height + 70), animated: true)
        scrollView.frame.size.width = self.view.frame.width
        scrollView.frame.size.height = self.view.frame.height * 0.9
        scrollView.transform.ty = 0
        
        longView.frame.size.width = self.view.frame.width
        longView.frame.size.height = 14011 / 2 //self.view.frame.height * 5
        longView.transform.tx = 0
        longView.transform.ty = 0
        
        backgroundImg.frame.size.width = self.longView.frame.width
        backgroundImg.frame.size.height = self.longView.frame.height
        backgroundImg.transform.tx = 0
        backgroundImg.transform.ty = 0
        
        ETimg.transform.tx = ETimg.frame.width - 40
        ETimg.transform.ty = 2500
        ETimg.alpha = 0.0
   
        DOGGIEimg.transform.tx = 0
        DOGGIEimg.transform.ty = 200.0
        DOGGIEimg.alpha = 0.0
        
      
        mySwitch.transform.tx = self.view.frame.width - mySwitch.frame.width * 1.5
        mySwitch.transform.ty = self.view.frame.height * 0.822
        
        desc_label.frame.size.width = self.view.frame.width
        desc_label.transform.tx = 0
        desc_label.transform.ty = self.view.frame.height * 0.9 - desc_label.frame.height
        
        
        mySlider.frame.size.width = self.view.frame.width * 0.85
        mySlider.transform.tx = (self.view.frame.width/2) - (self.mySlider.frame.width/2)
       
        
        scrollView.addSubview(longView)
        longView.addSubview(ETimg)
        longView.addSubview(DOGGIEimg)
        
        scrollView.contentSize = longView.frame.size
        
        lineLabel.frame.size.width = 1.8
        lineLabel.frame.size.height = longView.frame.size.height
        lineLabel.transform.ty = 0
        lineLabel.transform.tx = self.view.frame.width/2
        myLabel.layer.shadowOffset = CGSize(width:2, height:2)
        myLabel.layer.shadowOpacity = 0.4
        myLabel.layer.shadowRadius = 2
        myLabel.layer.shadowOffset = CGSize(width:2, height:2)
        myLabel.layer.shadowOpacity = 0.2
        myLabel.layer.shadowRadius = 2
        myLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        myLabel_floor.textColor = UIColor.blackColor()
        myLabel_feet.textColor = UIColor.blackColor()
        myLabel.alpha = 0.8
        myLabel_floor.alpha = 0.8
        myLabel_feet.alpha = 0.8
        myLabel.layer.zPosition = 1000
        myLabel_floor.layer.zPosition = 1001
        myLabel_feet.layer.zPosition = 1001
//        lineLabel.alpha = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        max_floor = Int(max_altitude / floor_feet)
        println(max_floor)
        
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "doSomething")
        //tapGestureRecognizer.numberOfTapsRequired = 1
        //longView.addGestureRecognizer(tapGestureRecognizer)
        let rotate = CGAffineTransformMakeRotation(rotateVertical)
        let scale = CGAffineTransformMakeScale(1.0, 2.0)
        let translate = CGAffineTransformMakeTranslation(0, self.view.frame.width/2)
        
        //self.presentViewController(self, animated: true, completion: nil)
        
        progressBar.transform = CGAffineTransformConcat(rotate, scale)
        progressBar.alpha = 0
//        backgroundImg.alpha = 0.5
        
        
        

        
        myButton.showsTouchWhenHighlighted = true
   
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { data, error in
                if (error == nil) {
                    //self.altitudeLabel.text = "\(data.relativeAltitude)"
                    
                    self.current_feet = Float(data.relativeAltitude) * 3.28084
                //    self.total_altitude = self.current_feet
                    
                    UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
                        self.myLabel.alpha = 1.0
                        }, completion: nil)
                    UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
                        self.myLabel_feet.alpha = 1.0
                        }, completion: nil)
                    UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
                        self.myLabel_floor.alpha = 1.0
                        }, completion: nil)
                    
//                    UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
//                        self.myButton.transform.tx = self.myLabel.frame.width + 20
//                        }, completion: nil)
                    
                    self.animateView(self.current_feet)
                    
                    println("Relative Altitude: \(data.relativeAltitude)")
                    println("Pressure: \(data.pressure)")
                }
            })
        }
        
    
    }
    
    
    @IBAction func tapTap(sender: UIButton) {
        println("tap tap")
        saveRecord()
    }
    
    func saveRecord() {
        
        var total_feet_label = ""
        label.append(UILabel(frame: CGRectMake(26, CGFloat(Float(self.myLabel.frame.origin.y)), 107, 65)))
        label_floor.append(UILabel(frame: CGRectMake(26, CGFloat(Float(self.myLabel_floor.frame.origin.y)), 107, 65)))
        label_feet.append(UILabel(frame: CGRectMake(26, CGFloat(Float(self.myLabel_feet.frame.origin.y)), 107, 65)))
        
        labeled_bt.append(UIButton(frame:CGRectMake(lineLabel.frame.origin.x - 25 / 2, label[count].frame.origin.y + 20 , 25, 25)))
        labeled_date.append(UILabel(frame: CGRectMake(lineLabel.frame.origin.x - self.view.frame.width / 2.5 - 25 / 2, labeled_bt[count].frame.origin.y - 4, self.view.frame.width / 2.5, 14)))
        labeled_time.append(UILabel(frame: CGRectMake(lineLabel.frame.origin.x - self.view.frame.width / 2.5 - 25 / 2, labeled_bt[count].frame.origin.y + 17, self.view.frame.width / 2.5, 14)))
        labeled_date_line.append(UILabel(frame: CGRectMake(lineLabel.frame.origin.x - self.view.frame.width / 2.5 - 25 / 2, labeled_bt[count].frame.origin.y + 25 / 2, self.view.frame.width / 2.5, 1.1)))
        
        labeled_bt[count].layer.cornerRadius = labeled_bt[count].bounds.size.height / 2
        labeled_bt[count].layer.opacity = 1.0
        labeled_bt[count].backgroundColor = UIColor.whiteColor()
        labeled_bt[count].tintColor = UIColor.grayColor()
        labeled_bt[count].titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size:10.0)
        labeled_bt[count].setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        labeled_bt[count].setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        labeled_bt[count].titleLabel?.textAlignment = NSTextAlignment.Center
        labeled_bt[count].setTitle("\(current_floor)", forState: UIControlState.Normal)
        labeled_bt[count].layer.shadowRadius = 2
        labeled_bt[count].layer.shadowOffset = CGSize(width:2, height:2)
        labeled_bt[count].layer.shadowOpacity = 0.2
        labeled_bt[count].alpha = 0.0
        labeled_bt[count].showsTouchWhenHighlighted = true
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.labeled_bt[self.count].alpha = 1.0
        }, completion: nil)

//        labeled_bt.insertSubview(longView, atIndex: <#Int#>)
    
        
        labeled_date_line[count].backgroundColor = UIColor.whiteColor()
        labeled_date_line[count].tintColor = UIColor.grayColor()
        labeled_date_line[count].font = UIFont(name: "HelveticaNeue-Thin", size:10.0)
        labeled_date_line[count].textColor = UIColor.blackColor()
        labeled_date_line[count].textAlignment = NSTextAlignment.Left
        labeled_date_line[count].text = " "
        labeled_date_line[count].layer.shadowRadius = 2
        labeled_date_line[count].layer.shadowOffset = CGSize(width:2, height:2)
        labeled_date_line[count].layer.shadowOpacity = 0.2
        labeled_date_line[count].alpha = 0.0
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.labeled_date_line[self.count].alpha = 1.0
            }, completion: nil)

        
        var date = NSDate()
        var dateFormatter = NSDateFormatter()
        var dateFormatter1 = NSDateFormatter()
        var timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter1.dateStyle = NSDateFormatterStyle.MediumStyle
//        dateFormatter.timeZone = timeZone
//        dateFormatter1.timeZone = timeZone
        
        var localDate = dateFormatter.stringFromDate(date)
        var localDate1 = dateFormatter1.stringFromDate(date)
        
        labeled_date[count].tintColor = UIColor.grayColor()
        labeled_date[count].font = UIFont(name: "HelveticaNeue-Medium", size:12.0)
        labeled_date[count].textColor = UIColor.whiteColor()
        labeled_date[count].textAlignment = NSTextAlignment.Left
        labeled_date[count].text = "\(localDate1)"
        labeled_date[count].layer.shadowRadius = 2
        labeled_date[count].layer.shadowOffset = CGSize(width:2, height:2)
        labeled_date[count].layer.shadowOpacity = 0.2
        labeled_date[count].alpha = 0.0
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.labeled_date[self.count].alpha = 1.0
            }, completion: nil)

        
        labeled_time[count].tintColor = UIColor.grayColor()
        labeled_time[count].font = UIFont(name: "HelveticaNeue-Medium", size:12.0)
        labeled_time[count].textColor = UIColor.whiteColor()
        labeled_time[count].textAlignment = NSTextAlignment.Left
        labeled_time[count].text = "\(localDate)"
        labeled_time[count].layer.shadowRadius = 2
        labeled_time[count].layer.shadowOffset = CGSize(width:2, height:2)
        labeled_time[count].layer.shadowOpacity = 0.2
        labeled_time[count].alpha = 0.0
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.labeled_time[self.count].alpha = 1.0
            }, completion: nil)


        
        label[count].backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        label_floor[count].textColor = UIColor.blackColor()
        label[count].layer.shadowOffset = CGSize(width:2, height:2)
        label[count].layer.shadowOpacity = 0.2
        label[count].layer.shadowRadius = 2
        label_floor[count].textAlignment = NSTextAlignment.Center
        label_floor[count].font = UIFont(name: "HelveticaNeue-Thin", size:25.0)
        label_floor[count].text = "\(current_floor) floor"
        
        total_feet_label = (NSString(format:"%.3f",total_altitude))
        
        label_feet[count].textColor = UIColor.blackColor()
        label_feet[count].textAlignment = NSTextAlignment.Center
        label_feet[count].font = UIFont(name: "HelveticaNeue-Thin", size:14.0)
        label_feet[count].text = "\(total_feet_label) feet"
        
        label[count].alpha = 0.0
        label_floor[count].alpha = 0.0
        label_feet[count].alpha = 0.0
        
        self.longView.addSubview(labeled_bt[count])
        self.longView.addSubview(labeled_date[count])
        self.longView.addSubview(labeled_time[count])
        self.longView.addSubview(labeled_date_line[count])
        self.longView.addSubview(label[count])
        self.longView.addSubview(label_floor[count])
        self.longView.addSubview(label_feet[count])
        
        history_activate.append(Boolean(0))
        labeled_bt[count].addTarget(self, action:"history_buttons:", forControlEvents: UIControlEvents.TouchUpInside)
        
        count++
    }
    
    @IBAction func history_buttons(sender: UIButton){
        //println("hello")
        
        var index = find(labeled_bt, sender)//indexOfAccessibilityElement(sender)
        
         println("\(index)")
        
        if history_activate[index!] == Boolean(0) {
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.label[index!].alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.label_floor[index!].alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.label_feet[index!].alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.labeled_date[index!].alpha = 0.0
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.labeled_time[index!].alpha = 0.0
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.labeled_date_line[index!].alpha = 0.0
            }, completion: nil)
            
            history_activate[index!] = Boolean(1)
            
        } else if history_activate[index!] == Boolean(1) {
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.label[index!].alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.label_floor[index!].alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.label_feet[index!].alpha = 0.0
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.labeled_date[index!].alpha = 1.0
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.labeled_time[index!].alpha = 1.0
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.labeled_date_line[index!].alpha = 1.0
                }, completion: nil)
            
            history_activate[index!] = Boolean(0)
        }
        
    }
    
    //contentOffset
    @IBAction func on_off_switch(sender: UISwitch) {
        
        
        if sender.on {
            sender.setOn(true, animated: true)
            
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.myLabel.transform.tx =  0.0 + 30
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.myLabel_feet.transform.tx =  0.0 + 30
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.myLabel_floor.transform.tx =  0.0 + 30
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.myButton.transform.tx = 0.0 + 30
            }, completion: nil)
            
            
            if CMAltimeter.isRelativeAltitudeAvailable() {
                altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { data, error in
                    if (error == nil) {
                        //self.altitudeLabel.text = "\(data.relativeAltitude)"
                        
                        self.current_feet = Float(data.relativeAltitude) * 3.28084
//                        self.total_altitude = self.current_feet
                        
                        
                        self.animateView(self.current_feet)
                        
                        println("Relative Altitude: \(data.relativeAltitude)")
                        println("Pressure: \(data.pressure)")
                    }
                })
            }
            
            println("start")
            
        }else {
            sender.setOn(false, animated: true)
            if self.current_feet < 0 {
                current_feet = 0.0
            }
            self.total_altitude = self.total_altitude + self.current_feet
            total_floor = Int((total_altitude + current_altitude) / floor_feet)
            println("stopped!! \(Int((total_altitude) / floor_feet))")
            altimeter.stopRelativeAltitudeUpdates()
            println("stop")
//            mySlider.enabled = false
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.myLabel.transform.tx = self.myLabel.frame.width + 20
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.myLabel_feet.transform.tx = self.myLabel.frame.width + 20


                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.myLabel_floor.transform.tx = self.myLabel.frame.width + 20


                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.myButton.transform.tx = self.myLabel.frame.width + 20
                
                
                }, completion: nil)

            
            
        }
    }
    
    func animateView(current_feet: Float) -> Float{
        
        var position: Float = 0.0
        var current_feet_label = ""
        
        current_altitude = current_feet
        current_floor = Int(current_altitude / floor_feet)
        
        if(Int((total_altitude + current_altitude) / floor_feet) == 0 && current_altitude < 0){
            position = (Float(longView.frame.height) - Float(self.view.frame.height)) - (0 * (Float(longView.frame.size.height) - Float(self.view.frame.height)) / max_altitude) + 52
            
            current_feet_label = (NSString(format:"%.3f","0"))
            
            myLabel_floor.text = "\(current_floor) floor"
            myLabel_feet.text = "You're @ bottom!"
            myLabel.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            myLabel_floor.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            myLabel_feet.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            myButton.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            mySlider.setValue(0, animated: true)
            
        }else {
            
            position = (Float(longView.frame.height) - Float(self.view.frame.height)) - ((total_altitude + current_altitude) * (Float(longView.frame.size.height) - Float(self.view.frame.height)) / max_altitude) + 52
            
            if (total_altitude + current_altitude) > 50 && position <= (Float(longView.frame.height) - Float(self.view.frame.height)) - ((total_altitude + current_altitude) * (Float(longView.frame.size.height) - Float(self.view.frame.height)) / max_altitude) {
                scrollView.setContentOffset(CGPointMake(0, CGFloat(position)), animated: true)
            }
            
            current_feet_label = (NSString(format:"%.3f",(total_altitude + current_altitude)))
            
            myLabel_floor.text = "\(Int((total_altitude + current_altitude) / floor_feet)) floor"
            myLabel_feet.text = "\(current_feet_label) feet"
            myLabel.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            myLabel_floor.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            myLabel_feet.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            myButton.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
            mySlider.setValue(self.total_altitude + self.current_feet, animated: true)
            
        }
        
        if Int(total_altitude / floor_feet) > 300 {
            appearET()
        }
        if Int(total_altitude / floor_feet) >= 500 {
            appearDog()
            //mySwitch.setOn(false, animated: true)
            altimeter.stopRelativeAltitudeUpdates()
            println("stop")
            mySlider.enabled = false
        }
        
        println("animation-ing : \(Int((total_altitude + current_altitude) / floor_feet))")
        
        return position
    }
    
    @IBAction func altitudeSlider(sender: UISlider){
        var position: Float = 0.0
        var label_pos: Float = 0.0
        var current_feet_label = ""
        
        current_feet = sender.value
        total_altitude = current_feet
        current_floor = Int(total_altitude / floor_feet)

        println(current_feet)
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
            self.myLabel.alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
            self.myLabel_feet.alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
            self.myLabel_floor.alpha = 1.0
            }, completion: nil)
        
        
        position = (Float(longView.frame.height) - Float(self.view.frame.height)) - (total_altitude * (Float(longView.frame.size.height) - Float(self.view.frame.height)) / max_altitude) + 52
        
               label_pos = position + Float(self.view.frame.height) - 65
        
        
        if total_altitude > 50 && position >= (Float(longView.frame.height) - Float(self.view.frame.height)) - (total_altitude * (Float(longView.frame.size.height) - Float(self.view.frame.height)) / max_altitude) {
            scrollView.setContentOffset(CGPointMake(0, CGFloat(position + Float(self.view.frame.height) / 2 - 65)), animated: true)
        }
        
        current_feet_label = (NSString(format:"%.3f",total_altitude))
        
        myLabel_floor.text = "\(current_floor) floor"
        myLabel_feet.text = "\(current_feet_label) feet"
        myLabel.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
        myLabel_floor.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
        myLabel_feet.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
        myButton.transform = CGAffineTransformMakeTranslation(30, CGFloat(position + Float(self.view.frame.height) / 3))
        
        
        if Int(total_altitude / floor_feet) == 300 {
            appearET()
        }
        if Int(total_altitude / floor_feet) == 500 {
            appearDog()
            mySwitch.setOn(false, animated: true)
            altimeter.stopRelativeAltitudeUpdates()
            println("stop")
            //mySlider.enabled = false
            scrollView.setContentOffset(CGPointMake(0, CGFloat(50.0)), animated: true)
        }
        
    }
    
    @IBAction func endSlide(sender: UISlider) {
        //self.total_altitude = self.total_altitude + self.current_feet
        //total_floor = Int((total_altitude + current_altitude) / floor_feet)
        
    }
    
    @IBAction func endOutSlide(sender: UISlider) {
        //self.total_altitude = self.total_altitude + self.current_feet
        //total_floor = Int((total_altitude + current_altitude) / floor_feet)
        
    }
    
//    ETimg.transform.tx = ETimg.frame.width - 5
//    ETimg.transform.ty = 2900
//    
//    DOGGIEimg.transform.tx = 0
//    DOGGIEimg.transform.ty = 110.0
    
    
    func appearET(){
        let fullRotation = CGFloat(M_PI)
        
        var rotate = CGAffineTransformMakeRotation(fullRotation)
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn , animations: {
            self.ETimg.alpha = 1.0
            }, completion: { finished in
                UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn , animations: {
                    self.ETimg.transform = CGAffineTransformMakeTranslation(self.ETimg.frame.width - 5, 2900)
                    }, completion: { finished in
                        UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
                            self.ETimg.transform = CGAffineTransformMakeTranslation(self.ETimg.frame.width - 20, 2905)
                            }, completion: nil)
                    }
            
                ) } )
        
    }
    
    func appearDog(){
        
        var translate = CGAffineTransformMakeTranslation(5.0, 5.0)
        
        UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations:{
            self.DOGGIEimg.alpha = 1.0
            }, completion: { finished in
                UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
        //                self.DOGGIEimg.transform = CGAffineTransformConcat(rotate, translate)
                        self.DOGGIEimg.transform = CGAffineTransformMakeTranslation(5.0, 50.0)
                    }, completion: nil)
                }
            )
    }
    
    
    func doSomething(recognizer: UITapGestureRecognizer){
        
        //mySlider.value = 100
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}

