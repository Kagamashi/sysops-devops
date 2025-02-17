
# Install OpenTelemetry Java Agent
wget https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar

# Run Java application with OpenTelemetry
java -javaagent:opentelemetry-javaagent.jar -jar myapp.jar
