//
//  ViewController.swift
//  manageTask2
//
//  Created by Karmine on 2018/12/15.
//  Copyright © 2018 kamiyama. All rights reserved.
//

import UIKit
import UserNotifications
import NotificationCenter
import Foundation

var notificationDate = Array(repeating: Date(), count: 100)
var questionnaireDate = Array(repeating: Date(), count: 100)
var notificationTime = Array(repeating: DateComponents(), count: 100)
var questionnaireTime = Array(repeating: DateComponents(), count: 100)
var h = Array(repeating: 0, count: 100)
var m = Array(repeating: 0, count: 100)

var userDefaults = UserDefaults.standard
var notificationContent = Array(repeating: UNMutableNotificationContent(), count: 100)
var questionnaireContent = Array(repeating: UNMutableNotificationContent(), count: 100)
var notificationCenter = Array(repeating: UNUserNotificationCenter.current(), count: 100)
var questionnaireCenter = Array(repeating: UNUserNotificationCenter.current(), count: 100)
//let contentBody = ["mikan", "StudyNow", "Brain Wars", "Flow Free", "謎解き母ちゃん", "基本情報", "GIGAZINE", "フィットネス"]
let contentBody = ["mikanで英単語を15分間テストする", "部屋の掃除を15分間する", "GIGAZINEで記事を15分間閲覧する", "スクワットを15分間する"]
//let contentPoint = ["20", "30", "60", "80"]

var nType = [0,0,0,0,0,0,0,
             1,2,3,4,5,6,7]

enum ActionIdentifier: String {
    case CHECK_0
    case CHECK_1
    case CHECK_2
    case CHECK_3
    case CHECK_4
    case CHECK_5
    case CHECK_6
    case CHECK_7
    case YES0
    case YES1
    case LATE
    case NO
}
let Check_0 = UNNotificationAction(identifier: ActionIdentifier.CHECK_0.rawValue, title: "確認", options: [])
let Check_1 = UNNotificationAction(identifier: ActionIdentifier.CHECK_1.rawValue, title: "確認", options: [])
let Check_2 = UNNotificationAction(identifier: ActionIdentifier.CHECK_2.rawValue, title: "確認", options: [])
let Check_3 = UNNotificationAction(identifier: ActionIdentifier.CHECK_3.rawValue, title: "確認", options: [])
let Check_4 = UNNotificationAction(identifier: ActionIdentifier.CHECK_4.rawValue, title: "確認", options: [])
let Check_5 = UNNotificationAction(identifier: ActionIdentifier.CHECK_5.rawValue, title: "確認", options: [])
let Check_6 = UNNotificationAction(identifier: ActionIdentifier.CHECK_6.rawValue, title: "確認", options: [])
let Check_7 = UNNotificationAction(identifier: ActionIdentifier.CHECK_7.rawValue, title: "確認", options: [])
let Did0 = UNNotificationAction(identifier: ActionIdentifier.YES0.rawValue, title: "すぐ取り組んだ",options: [])
let Did1 = UNNotificationAction(identifier: ActionIdentifier.YES1.rawValue, title: "少し経ってから取り組んだ",options: [])
let WillDo = UNNotificationAction(identifier: ActionIdentifier.LATE.rawValue, title: "あとでやる",options: [])
let DidNot = UNNotificationAction(identifier: ActionIdentifier.NO.rawValue, title: "今日はやらない", options: [])


let category = [UNNotificationCategory(identifier: "messageC0",actions: [Check_0], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageC1",actions: [Check_1], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageC2",actions: [Check_2], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageC3",actions: [Check_3], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageC4",actions: [Check_4], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageC5",actions: [Check_5], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageC6",actions: [Check_6], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageC7",actions: [Check_7], intentIdentifiers: [], options: []),
                UNNotificationCategory(identifier: "messageQ",actions: [Did0, Did1, WillDo, DidNot], intentIdentifiers: [], options: [])]


var notificationTrigger = [UNCalendarNotificationTrigger(dateMatching: notificationTime[0], repeats: false),
                           UNCalendarNotificationTrigger(dateMatching: notificationTime[1], repeats: false),
                           UNCalendarNotificationTrigger(dateMatching: notificationTime[2], repeats: false),
                           UNCalendarNotificationTrigger(dateMatching: notificationTime[3], repeats: false),
                           UNCalendarNotificationTrigger(dateMatching: notificationTime[4], repeats: false),
                           UNCalendarNotificationTrigger(dateMatching: notificationTime[5], repeats: false),
                           UNCalendarNotificationTrigger(dateMatching: notificationTime[6], repeats: false),
                           UNCalendarNotificationTrigger(dateMatching: notificationTime[7], repeats: false)]
var notificationRequest = [UNNotificationRequest(identifier: "message0", content: notificationContent[0], trigger: notificationTrigger[0]),
                           UNNotificationRequest(identifier: "message1", content: notificationContent[1], trigger: notificationTrigger[1]),
                           UNNotificationRequest(identifier: "message2", content: notificationContent[2], trigger: notificationTrigger[2]),
                           UNNotificationRequest(identifier: "message3", content: notificationContent[3], trigger: notificationTrigger[3]),
                           UNNotificationRequest(identifier: "message4", content: notificationContent[4], trigger: notificationTrigger[4]),
                           UNNotificationRequest(identifier: "message5", content: notificationContent[5], trigger: notificationTrigger[5]),
                           UNNotificationRequest(identifier: "message6", content: notificationContent[6], trigger: notificationTrigger[6]),
                           UNNotificationRequest(identifier: "message7", content: notificationContent[7], trigger: notificationTrigger[7]),]
var questionnaireTrigger = [UNCalendarNotificationTrigger(dateMatching: questionnaireTime[0], repeats: false),
                            UNCalendarNotificationTrigger(dateMatching: questionnaireTime[1], repeats: false),
                            UNCalendarNotificationTrigger(dateMatching: questionnaireTime[2], repeats: false),
                            UNCalendarNotificationTrigger(dateMatching: questionnaireTime[3], repeats: false),
                            UNCalendarNotificationTrigger(dateMatching: questionnaireTime[4], repeats: false),
                            UNCalendarNotificationTrigger(dateMatching: questionnaireTime[5], repeats: false),
                            UNCalendarNotificationTrigger(dateMatching: questionnaireTime[6], repeats: false),
                            UNCalendarNotificationTrigger(dateMatching: questionnaireTime[7], repeats: false)]
var questionnaireRequest = [UNNotificationRequest(identifier: "messageQ0", content: notificationContent[0], trigger: questionnaireTrigger[0]),
                            UNNotificationRequest(identifier: "messageQ1", content: questionnaireContent[1], trigger: questionnaireTrigger[1]),
                            UNNotificationRequest(identifier: "messageQ2", content: questionnaireContent[2], trigger: questionnaireTrigger[2]),
                            UNNotificationRequest(identifier: "messageQ3", content: questionnaireContent[3], trigger: questionnaireTrigger[3]),
                            UNNotificationRequest(identifier: "messageQ4", content: questionnaireContent[4], trigger: questionnaireTrigger[4]),
                            UNNotificationRequest(identifier: "messageQ5", content: questionnaireContent[5], trigger: questionnaireTrigger[5]),
                            UNNotificationRequest(identifier: "messageQ6", content: questionnaireContent[6], trigger: questionnaireTrigger[6]),
                            UNNotificationRequest(identifier: "messageQ7", content: questionnaireContent[7], trigger: questionnaireTrigger[7])]
let format = DateFormatter()


class ViewController: UIViewController, UNUserNotificationCenterDelegate{
    
    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        format.dateFormat = "HH:mm"
        //print(nType)
        
        for i in 0..<100 {
            notificationCenter[i].delegate = self
            questionnaireCenter[i].delegate = self
        }
    }
    
    @IBAction func PushButton(_ sender: Any) {
        if UserDefaults.standard.object(forKey: "notification \(4*14-1)") == nil {
            for i in 0..<4{
                //print("setTask"+String(i))
                nType.shuffle()
                setNotificationTime(index: i)
            }
            notificationCenter[99].getPendingNotificationRequests { pend in
                print("pending request")
                print(pend)
            }
            label.text = "Complete!"
        }
        else {
            label.text = "Not Done!"
        }
        
    }
    
    
    func setNotificationTime(index i:Int){
        for j in 0..<14{
            let x = i*14+j
            //h[x] = Int.random(in: i*2+8...i*2+9)
            h[x] = i*2+16
            //h[x] = i+10
            //h[x] = 1
            m[x] = Int.random(in: 0...59)
            //m[x] = 55
            //m[x] = i+6
            let date = Date()
            //let month = Calendar.current.component(.month, from: date)
            let month = 2
            //let day = Calendar.current.component(.day, from: date)
            let day = 1
            notificationDate[x] = Calendar.current.date(from: DateComponents(month: month, day: day, hour: h[x], minute: m[x]))!
            //notificationDate[x] = Calendar.current.date(byAdding: DateComponents(day: j+1), to: notificationDate[x])!
            notificationDate[x] = Calendar.current.date(byAdding: DateComponents(day: j), to: notificationDate[x])!
            notificationTime[x] = Calendar.current.dateComponents([.hour, .minute], from: notificationDate[x])
            notificationTime[x].month = Calendar.current.component(.month, from: notificationDate[x])
            notificationTime[x].day = Calendar.current.component(.day, from: notificationDate[x])
            setNotification(index: i, subIndex: j, type: nType[j])
            
            print( "x:" + String(x) + " j:" + String(j) + " nType[j]:" + String(nType[j]) )
        }
        //print("\n")
        //format.dateFormat = "HH:mm"
        //userDefaults.set(format.string(from: notificationDate[i]), forKey: "date \(i)")
    }
    
    func setNotification(index i: Int, subIndex j: Int, type t: Int) {
        //アクション通知
        let x = i*14+j
        let b = contentBody[i]
        //let b_1 = contentPoint[i]
        // 通知内容の設定
        notificationContent[x].title = "お知らせ"
        notificationContent[x].sound = UNNotificationSound.default
        notificationContent[x].threadIdentifier = "Notification"
        
        if t == 0 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！"
            notificationCenter[x].setNotificationCategories([category[1], category[2], category[3], category[4], category[5], category[6], category[7], category[8], category[0]])
            notificationContent[x].categoryIdentifier = "messageC0"
        } else if t == 1 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！\n"+"このタスクは「"+"基本情報技術者試験の過去問を15分間解く"+"」よりも負荷の小さいタスクです．"
            notificationCenter[x].setNotificationCategories([category[2], category[3], category[4], category[5], category[6], category[7], category[8], category[0], category[1]])
            notificationContent[x].categoryIdentifier = "messageC1"
        } else if t == 2 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！\n"+"このタスクは「"+"食器洗いを15分間行う"+"」よりも負荷の小さいタスクです．"
            notificationCenter[x].setNotificationCategories([category[3], category[4], category[5], category[6], category[7], category[8], category[0], category[1], category[2]])
            notificationContent[x].categoryIdentifier = "messageC2"
       } else if t == 3 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！\n"+"このタスクは「"+"トイレ掃除を15分間行う"+"」よりも負荷の小さいタスクです．"
            notificationCenter[x].setNotificationCategories([category[4], category[5], category[6], category[7], category[8], category[0], category[1], category[2], category[3]])
            notificationContent[x].categoryIdentifier = "messageC3"
       } else if t == 4 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！\n"+"このタスクは「"+"ジャックナイフ（V字腹筋）を15分間する"+"」よりも負荷の小さいタスクです．"
            notificationCenter[x].setNotificationCategories([category[5], category[6], category[7], category[8], category[0], category[1], category[2], category[3], category[4]])
            notificationContent[x].categoryIdentifier = "messageC4"
       } else if t == 5 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！\n"+"このタスクは「"+"ジョギングを15分間行う"+"」よりも負荷の小さいタスクです．"
            notificationCenter[x].setNotificationCategories([category[6], category[7], category[8], category[0], category[1], category[2], category[3], category[4], category[5]])
            notificationContent[x].categoryIdentifier = "messageC5"
       } else if t == 6 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！\n"+"このタスクは「"+"日本経済新聞の記事を15分間閲覧する"+"」よりも負荷の小さいタスクです．"
            notificationCenter[x].setNotificationCategories([category[7], category[8], category[0], category[1], category[2], category[3], category[4], category[5], category[6]])
            notificationContent[x].categoryIdentifier = "messageC6"
       } else if t == 7 {
            notificationContent[x].body = "「"+b+"」を取り組む時間です！\n"+"このタスクは「"+"英語の関連研究を15分間探す"+"」よりも負荷の小さいタスクです．"
            notificationCenter[x].setNotificationCategories([category[8], category[0], category[1], category[2], category[3], category[4], category[5], category[6], category[7]])
            notificationContent[x].categoryIdentifier = "messageC7"
       }
        // トリガー設定
        notificationTrigger[i] = UNCalendarNotificationTrigger(dateMatching: notificationTime[x], repeats: false)
        // 通知スタイルを指定
        notificationRequest[i] = UNNotificationRequest(identifier:String(x), content: notificationContent[x], trigger: notificationTrigger[i])
        //通知をセット
        //notificationCenter[x].add(notificationRequest[i], withCompletionHandler: nil)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.add(notificationRequest[i]) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        //print("x="+String(x)+", i="+String(x/14)+", _i="+String(i)+", j="+String(x%14)+", _j="+String(j))
        userDefaults.set(x, forKey: "notification \(x)")
    }
    
    func setQuestionnaire(index ij: String, date d: Date) {
        //アンケート通知
        let i = userDefaults.integer(forKey: "notification \(ij)")
        let b = contentBody[i/14]
        questionnaireDate[i] = Calendar.current.date(byAdding: DateComponents(minute: 30), to: d)!
        questionnaireTime[i] = Calendar.current.dateComponents([.hour, .minute], from: questionnaireDate[i])
        questionnaireContent[i].title = "アンケート"
        questionnaireContent[i].sound = UNNotificationSound.default
        questionnaireContent[i].body = "「"+b+"」を取り組みましたか？"
        questionnaireContent[i].threadIdentifier = "Questionnaire"
        questionnaireCenter[i].setNotificationCategories([category[0], category[1], category[2], category[3], category[4], category[5], category[6], category[7], category[8]])
        // トリガー設定
        questionnaireTrigger[i/14] = UNCalendarNotificationTrigger(dateMatching: questionnaireTime[i], repeats: false)
        questionnaireContent[i].categoryIdentifier = "messageQ"
        // 通知スタイルを指定
        questionnaireRequest[i/14] = UNNotificationRequest(identifier: String(i+100), content: questionnaireContent[i], trigger: questionnaireTrigger[i/14])
        //通知をセット
        questionnaireCenter[i].add(questionnaireRequest[i/14], withCompletionHandler: nil)
        userDefaults.set(i, forKey: "questionnaire \(i+100)")
        
        print( "i:" + String(i) + " ij:" + String(ij) + " b:" + String(b) )
    }
    
    func reSetNotificaiton(index ij: String, date d: Date) {
        //通知をリセット
        let i = userDefaults.integer(forKey: "notification \(ij)")
        notificationDate[i] = Calendar.current.date(byAdding: DateComponents(minute: 1), to: d)!
        notificationTime[i] = Calendar.current.dateComponents([.hour, .minute], from: notificationDate[i])
        // トリガー設定
        notificationTrigger[i/14] = UNCalendarNotificationTrigger(dateMatching: notificationTime[i], repeats: false)
        // 通知スタイルを指定
        notificationRequest[i/14] = UNNotificationRequest(identifier: String(i), content: notificationContent[i], trigger: notificationTrigger[i/14])
        //通知をセット
        notificationCenter[i].add(notificationRequest[i/14], withCompletionHandler: nil)
        userDefaults.set(i, forKey: "notification \(i)")
    }
    
    func reSetQuestionnaire(index ij: String, date d: Date) {
        //通知をリセット
        let i = userDefaults.integer(forKey: "quesionnaire \(ij)") - 100
        questionnaireDate[i] = Calendar.current.date(byAdding: DateComponents(minute: 1), to: d)!
        questionnaireTime[i] = Calendar.current.dateComponents([.hour, .minute], from: questionnaireDate[i])
        // トリガー設定
        questionnaireTrigger[i/14] = UNCalendarNotificationTrigger(dateMatching: questionnaireTime[i], repeats: false)
        // 通知スタイルを指定
        questionnaireRequest[i/14] = UNNotificationRequest(identifier: String(i+100), content: questionnaireContent[i], trigger: questionnaireTrigger[i/14])
        //通知をセット
        questionnaireCenter[i].add(notificationRequest[i], withCompletionHandler: nil)
        userDefaults.set(i, forKey: "questionnaire \(i+100)")
    }
    
    //function: data save
    func createTextFromString(nD _a: String, sD _b: String, id _c: String, ans _d: String) {
        let data = _a + "," + _b + "," + _c + "," + _d
        let fileName = _c
        if let documentDirectoryFileURL = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last {
            // 書き込むファイルのパス
            let targetTextFilePath = documentDirectoryFileURL + "/" + fileName + ".csv"
            do {
                try data.write(toFile: targetTextFilePath, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("failed to write: \(error)")
            }
        }
        print("filename:" + String(_c) )
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let formatDate = DateFormatter()
        formatDate.dateFormat = "HH:mm"
        if response.notification.request.content.threadIdentifier == "Notification" {
            switch response.actionIdentifier {
            case ActionIdentifier.CHECK_0.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: formatDate.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            case ActionIdentifier.CHECK_1.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: formatDate.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            case ActionIdentifier.CHECK_2.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: format.string(from: Date()),
                                     id:  String(response.notification.request.identifier),
                                     ans:  response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            case ActionIdentifier.CHECK_3.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: formatDate.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            case ActionIdentifier.CHECK_4.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: formatDate.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            case ActionIdentifier.CHECK_5.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: formatDate.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            case ActionIdentifier.CHECK_6.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: formatDate.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            case ActionIdentifier.CHECK_7.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: formatDate.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
                setQuestionnaire(index: response.notification.request.identifier, date: Date())
                /*print(response.notification.request.identifier)
                 print(response.notification.date)
                 print(response.actionIdentifier)*/
            // アクションではなく通知自体をタップしたときは UNNotificationDefaultActionIdentifier が渡ってくる
            case UNNotificationDefaultActionIdentifier:
                reSetNotificaiton(index: response.notification.request.identifier,
                                  date: Date())
            default:
                reSetNotificaiton(index: response.notification.request.identifier,
                                  date: Date())
                //print(Int(response.notification.request.identifier)!)
            }
        }
        else {
            switch response.actionIdentifier {
            case ActionIdentifier.YES0.rawValue:
                createTextFromString(nD: format.string(from: response.notification.date),
                                     sD: format.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
            case ActionIdentifier.YES1.rawValue:
                createTextFromString(nD: format.string(from: response.notification.date),
                                     sD: format.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
            case ActionIdentifier.LATE.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: format.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
            case ActionIdentifier.NO.rawValue:
                createTextFromString(nD:format.string(from: response.notification.date),
                                     sD: format.string(from: Date()),
                                     id: String(response.notification.request.identifier),
                                     ans: response.actionIdentifier)
            // アクションではなく通知自体をタップしたときは UNNotificationDefaultActionIdentifier が渡ってくる
            case UNNotificationDefaultActionIdentifier:
                reSetQuestionnaire(index: response.notification.request.identifier,
                                   date: Date())
            default:
                reSetQuestionnaire(index: response.notification.request.identifier,
                                   date: Date())
                //print(Int(response.notification.request.identifier)!)
                //print(response.notification.date)
                //print(response.actionIdentifier)
            }
        }
        completionHandler()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension Array {
    mutating func shuffle() {
        for i in 0..<self.count {
            let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    var shuffled: Array {
        var copied = Array<Element>(self)
        copied.shuffle()
        return copied
    }
}
