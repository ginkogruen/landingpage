package org.ginkogruen;

import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException {

        ConfigReader configReader = new ConfigReader();

        ServiceQuery query = new ServiceQuery();

        List<Service> services = configReader.getServiceList("backend/src/main/resources/dev/services.json");

        HttpServer server = Server.createServer(8000);

        server.start();
        System.out.println("Server is running on http://localhost:8000/");
    }
}
