package org.ginkogruen;

/**
 * Class representing a service configured in 'services.json'.
 * Can hold information for different types of services (dummy, systemd etc.).
 */
public class Service {
    private boolean serviceStatus;

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
