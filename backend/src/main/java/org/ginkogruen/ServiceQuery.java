package org.ginkogruen;

// Class for sending commands to services via Service objects
// In this case its just a dummy service
public class ServiceQuery {

    // Get status of Service object
    // Duplicated for unifying interaction through ServiceQuery
    public boolean getServiceStatus(Service service) {
        System.out.println("Service running: " + service.getServiceStatus());
        return service.getServiceStatus();
    }

    // Send start command to Service objects service
    public void startService(Service service) {
        service.setServiceStatus(true);
        System.out.println("Dummy service started");
    }

    // Send stop command to Service objects service
    public void stopService(Service service) {
        service.setServiceStatus(false);
        System.out.println("Dummy service stopped");
    }

}
