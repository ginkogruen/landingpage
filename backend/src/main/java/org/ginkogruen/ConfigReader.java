package org.ginkogruen;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

// Class for reading 'services.json' config file and creating Service objects from it
public class ConfigReader {

    // Read JSON file into String
    private String readConfigFile(String filepath) throws IOException {
        return new String(Files.readAllBytes(Path.of(filepath)));
    }

    // Convert JSON String into List of Service objects
    private List<Service> convertJSONtoList(String jsonString) {
        Gson gson = new Gson();
        return gson.fromJson(jsonString, new TypeToken<List<Service>>() {
        }.getType());
    }

    // Combination of methods to convert JSON file to List of Service objects
    public List<Service> getServiceList(String filepath) throws IOException {
        return this.convertJSONtoList(this.readConfigFile(filepath));
    }

}
