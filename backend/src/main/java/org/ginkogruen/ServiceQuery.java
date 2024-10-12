package org.ginkogruen;

/**
 * This class implements interaction with the actual services through 'Service' objects.
 * It can start, stop and get the status of services.
 * Currently only works for Services of the type: 'dummy'.
 * TODO: Implement Query for other types.
 */
public class ServiceQuery {

    public boolean getServiceStatus(Service service) {
        System.out.println("Service running: " + service.getServiceStatus());
        return service.getServiceStatus();
    }

    public void startService(Service service) {
        service.setServiceStatus(true);
        System.out.println("Dummy service started");
    }

    public void stopService(Service service) {
        service.setServiceStatus(false);
        System.out.println("Dummy service stopped");
    }
}
