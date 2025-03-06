If there is just one or a few accounts showing up as an SSID it could be that account has just been deleated on the doman controller. 

If this is not the case the next thing it could be is the 'Netlogon service' This should be set to manual on all domain servers and machines and can cause a number of issues if its not running.









Open command prompt as admin 'nltest /dsgetcd:[Domain Name Here]'