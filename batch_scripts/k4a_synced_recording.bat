@echo off
setlocal EnableDelayedExpansion
set k4arecorder_path="C:\Program Files\Azure Kinect SDK v1.4.1\tools"
set subordinate_ids=1 2 3 4 5
set master_id=0
set output_path=C:\Users\Administrator6G-life\Documents\recordings
set output_name=sync_test
set record_length=30
set exposure=-2
set master_start_delay=5
:: /c to close cmd after task finished, /k to keep it open
set subordinate_start_mode=/k

cd %k4arecorder_path%
echo Starting subordinate devices...
for %%a in (%subordinate_ids%) do (
    set command=k4arecorder.exe --device %%a -l %record_length% --external-sync subordinate -e %exposure% %output_path%\%output_name%_subordinate_%%a.mkv
    start cmd %subordinate_start_mode% !command!
)

timeout %master_start_delay%
echo Starting master device...
set command=k4arecorder.exe --device %master_id% -l %record_length% --external-sync master -e %exposure% %output_path%\%output_name%_master_%master_id%.mkv
start cmd /k %command%

