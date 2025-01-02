Microsoft Azure AD Sync service getting the following error.

Windows could not start the Microsoft Azure AD Sync Service on Local Computer.
Error 1068: The dependency service or group failed to start.

The service needs to do WMI queries which needs Windows Mangement Instrumentation running.
Sometimes the service will be disabled, Normally this happens after an update but other things can cause this problem.

Windows Management Instrumentation:
Provides a common interface and object model to access management information about operating system, devices, applications and services. If this service is stopped, most Windows-based software will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start.

FIX: 

1. Open "Services" as an Administrator
2. Locate Windows Management Instrumentation
3. Right click and select propteries 
4. Change "Startup Type" to Automatic
5. Click start the service is not already running

You should not be able to start the Microsoft Azure AD Sync service.