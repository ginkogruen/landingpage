package org.ginkogruen;

// Class storing information about services.
// Interaction with services is done through these objects.
public class Service {

    // Variable representing the services status (true = active)
    private boolean serviceStatus;

    // Variables populated through reading the 'services.json' file
    public String name;
    public String type;
    public String webadress;

    // TODO: Implement fields for systemd service

    public boolean getServiceStatus() {
        return this.serviceStatus;
    }

    public void setServiceStatus(boolean serviceStatus) {
        this.serviceStatus = serviceStatus;
    }

}
