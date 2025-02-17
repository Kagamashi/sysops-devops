
wget https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar

java -javaagent:opentelemetry-javaagent.jar \
     -Dotel.service.name=my-java-app \
     -Dotel.exporter.otlp.endpoint=http://otel-collector:4317 \
     -jar myapp.jar
