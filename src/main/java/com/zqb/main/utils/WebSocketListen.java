package com.zqb.main.utils;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author zqb
 * @decription
 * @create 2017/9/12
 */
@ServerEndpoint("/webSocket/{code}")
public class WebSocketListen {

    //用于记录接入的websocket连接
    private static ConcurrentHashMap<String,WebSocketDto> webSocketMap = new ConcurrentHashMap<String,WebSocketDto>();
    /**
     * 收到客户端消息后调用的方法
     *
     * @param message
     * 客户端发送过来的消息
     * @param session
     * 可选的参数
     */
    @OnMessage
    public void onMessage(String message, Session session)
            throws IOException, InterruptedException
    {
        // Print the client message for testing purposes
        System.out.println("Received: " + message);
        // Send the first message to the client
        //sendMessage(session,"receive client message");
    }

    @OnOpen
    public void onOpen(@PathParam("code") String code,Session session) {
        WebSocketDto websocketDto = new WebSocketDto();
        websocketDto.setCode(code);
        websocketDto.setSession(session);
        webSocketMap.put(code, websocketDto);
        System.out.println("Client connected");
    }

    @OnClose
    public void onClose(@PathParam("code") String code)
    {
        webSocketMap.remove(code);
    }


    /**
     * 发生错误时调用
     *
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error)
    {
        error.printStackTrace();
    }


    //发送string消息
    public static void sendStrMessage(String code,String message) throws IOException
    {
        Session session = webSocketMap.get(code).getSession();
        session.getBasicRemote().sendText(message);
    }

    //发送object消息
    public static void sendObjMessage(String code,Object msg) throws IOException, EncodeException {
        Session session = webSocketMap.get(code).getSession();
        session.getBasicRemote().sendObject(msg);
    }

    public static ConcurrentHashMap<String, WebSocketDto> getWebsocketMap()
    {
        return webSocketMap;
    }

    public static void setWebsocketMap(ConcurrentHashMap<String, WebSocketDto> websocketMap)
    {
        WebSocketListen.webSocketMap = websocketMap;
    }
}
