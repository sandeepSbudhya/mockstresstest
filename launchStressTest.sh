#!/bin/bash


durationOfTestInSeconds=$1
if [ $durationOfTestInSeconds -lt 180 ]
then
    echo "error: the duration of the test must be atleast 3 minutes (or 180 seconds)"
    exit 1
fi

# calculate a random wait before firing a job until test duration is reached then stop all jobs
minJobDurationInSeconds=180
maxJobDurationInSeconds=600

#
minWaitBeforeNextJobInSeconds=10
maxWaitBeforeNextJobInSeconds=30
endTime=$(($SECONDS+$durationOfTestInSeconds))
while [ $SECONDS -lt $endTime ]
do
    # generate a wait before next job
    generatedWaitBeforeNextJob=$(($RANDOM%($maxWaitBeforeNextJobInSeconds - $minWaitBeforeNextJobInSeconds + 1) + $minWaitBeforeNextJobInSeconds))

    #generate a job duration in seconds
    generatedJobDuration=$(($RANDOM%($maxJobDurationInSeconds - $minJobDurationInSeconds + 1) + $minJobDurationInSeconds))
    
    # request a job to run for the generated duration of time and wait for generated wait time before firing another job
    echo "requesting a job of duration ${generatedJobDuration} seconds"
    message="{\"durationInSeconds\":${generatedJobDuration}}"
    curl -X POST -H 'Content-Type: application/json' -d  $message "localhost:8088/launchstresstestjob"
    # wait for generated time before generating another job
    echo "waiting for ${generatedWaitBeforeNextJob} seconds before launching next job..."
    sleep $generatedWaitBeforeNextJob
done
curl -X POST "localhost:8088/stopallstresstestjobs"

