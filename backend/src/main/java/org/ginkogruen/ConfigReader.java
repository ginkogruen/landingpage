package org.ginkogruen;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class ConfigReader {

    /**
     * Get JSON String when given path to '.json' file.
     *
     * @param filepath
     * @return
     * @throws IOException
     */
    private String readConfigFile(String filepath) throws IOException {
        return new String(Files.readAllBytes(Path.of(filepath)));
    }

    /**
     * Convert JSON Array to List of Service objects.
     *
     * @param jsonString
     * @return
     */
    private List<Service> convertJSONtoList(String jsonString) {
        Gson gson = new Gson();
        return gson.fromJson(jsonString, new TypeToken<List<Service>>() {
        }.getType());
    }

    /**
     * Get List of Service objects from '.json' configuration file.
     * Consists of two helper functions.
     *
     * @param filepath
     * @return
     * @throws IOException
     */
    public List<Service> getServiceList(String filepath) throws IOException {
        return this.convertJSONtoList(this.readConfigFile(filepath));
    }

}
