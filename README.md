# Mocking a stress test for kafka consumer
Clone the consumer and run flaskserverStressTest:<br/>
https://github.com/sandeepSbudhya/consumer<br/><br/>
Clone the producer and set it up by creating **utilization-message** topic:<br/>
https://github.com/sandeepSbudhya/producer<br/><br/>
Clone the mocktraining job and run:<br/>
`sh sendUtilizationMessageToKafka.sh <your_spring_kafka_producer>`<br/><br/>
Run the following command to launch a stress test:<br/><br/>
`sh launchStressTest.sh <duration_of_test_in_seconds>`<br/><br/>
For example to run the test for 1 hour:<br/><br/>
`sh launchStressTest.sh 3600`
