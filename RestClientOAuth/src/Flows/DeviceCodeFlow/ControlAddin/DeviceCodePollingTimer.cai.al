controladdin "Device Code Polling Timer KFM"
{
    StartupScript = 'src/Flows/DeviceCodeFlow/ControlAddin/startup.js';
    Scripts = 'src/Flows/DeviceCodeFlow/ControlAddin/script.js';

    MinimumHeight = 1;
    MaximumHeight = 1;
    RequestedHeight = 1;
    MinimumWidth = 1;
    MaximumWidth = 1;
    RequestedWidth = 1;

    event ControlAddInReady();
    event PollingTick();
    procedure StartPolling(PollIntervalSeconds: Integer);
    procedure StopPolling();
}