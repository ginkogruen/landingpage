package org.ginkogruen;

import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.net.InetSocketAddress;

public class Server {

    // Create HTTP server and set contexts
    public static HttpServer createServer(int port) throws IOException {
        // Create server instance
        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);

        server.createContext("/hello", new HelloHandler());
        server.setExecutor(null); // Default single-threaded

        return server;
    }

}
