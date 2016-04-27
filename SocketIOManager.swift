//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by JerryMAc on 2016/4/27.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.107:3000")!)
    //By doing this we can simplt write SocketIOManager.shareInstance anywhere around the code and have access to all public properties and methods of the above class
    
    override init(){
        super.init()
    }
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func connectToServerWithNickName(nickname: String, completionHandler: (userList: [[String: AnyObject]]!) -> Void){
        socket.emit("connectUser", nickname)
        // The emit() method of the socket object is what we need for sending any message to the server using the Socket.IO client library
        
        // socket.on means the iOs app listening to the server
        
        socket.on("userList"){
            // first paramenter is a NSArray object, where the number of the contained elements depends on the number of results sent by the server. The second parameter is an acknowledge message that can be used to notify the server that the message has been received
            (dataArray, ack) -> Void in
            completionHandler(userList: dataArray[0] as! [[String: AnyObject]])
            // When the user list is received from the server, we call our own method's completion handler passing as an argument that list.
            
        }
    }
    
    
    func getChatMessage(completionHander: (messageInfo: [String:AnyObject])->Void) {
        socket.on("newChatMessage"){
            (dataArray,socketAck) -> Void in
            var messageDictionary = [String:AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as! String
            messageDictionary["message"]  =  dataArray[1] as! String
            messageDictionary["date"] = dataArray[2] as! String
            completionHander(messageInfo: messageDictionary)
        }
    }

    
    
    func sendMessage(message: String, withNickname nickname:String){
        socket.emit("chatMessage",nickname,message)
    }
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
}

